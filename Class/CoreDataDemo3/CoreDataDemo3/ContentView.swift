//
//  ContentView.swift
//  CoreDataDemo3
//
//  Created by 이민영 on 2023/12/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - CoreDataDemo3App.swift 파일에 생성된 view context 환경 객체에 대한 접근 권한 얻음
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - product entity 저장된 데이터 가져오기, 선언될 당시엔 아직 "". 비어있는 상태
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var products: FetchedResults<Product>
    
    // MARK: - 앞으로 사용자가 입력할 제품 이름, 수량을 저장할 상태 변수
    @State var name: String = ""
    @State var quantity: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack {
                    Spacer()
                    Button("Add") {
                        addProduct()
                    }
                    Spacer()
                    NavigationLink(destination: ResultsView(name: name, viewContext: viewContext)) {
                        Text("Find")
                    }
                    Spacer()
                    Button("Clear") {
                        name = ""
                        quantity = ""
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List {
                    ForEach(products) { product in
                        HStack {
                            Text(product.name ?? "Not found")
                            Spacer()
                            Text(product.quantity ?? "Not found")
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
                .navigationTitle("Product Database")
            }
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    
    private func addProduct() {
        // MARK: - 데이터를 저장하게 되면 최신 데이터를 가져와서 products 데이터 변수에 할당한다. 이렇게 하면 list뷰가 최신 제품으로 업데이트 되므로 시각적으로 좋기 위해 animation 호출에 배치한다

        withAnimation {
            // MARK: - viewContext로 캐시상태 생성
            let product = Product(context: viewContext)
            product.name = name
            product.quantity = quantity
            
            saveContext()
        }
    }
    
    // MARK: - offsets: 선택한 List 항목의 위치 오프셋 세트 전달
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
        
    }
    
    private func saveContext() {
        do {
            // MARK: - viewcontext 를 영구 저장소에 저장한다
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
}


struct ResultsView: View {
    
    var name: String
    var viewContext: NSManagedObjectContext
    
    @State var matches: [Product]?
    
    var body: some View {
        
        return VStack {
            List {
                ForEach(matches ?? []) { match in
                    HStack {
                        Text(match.name ?? "Not found")
                        Spacer()
                        Text(match.quantity ?? "Not found")
                    }
                    
                }
            }
            .navigationTitle("Results")
        }
        .task {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            fetchRequest.entity = Product.entity()
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
            matches = try? viewContext.fetch(fetchRequest)
        }
        
    }
}

#Preview {
    ContentView()
}
