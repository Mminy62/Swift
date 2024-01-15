//
//  ContentView.swift
//  ARDemo
//
//  Created by 이민영 on 2024/01/10.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            ZStack {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                
                HStack {
                    VStack {
                        Spacer()
                        Button {
                            viewModel.isShowingView = true
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.blue)
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "scribble.variable")
                                    .imageScale(.large)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(50)
            }
            .sheet(
                isPresented: $viewModel.isShowingView,
                onDismiss: { viewModel.isShowingView = false})  {
                    
                DrawView().presentationDetents([.medium])
            }
        }
}

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var viewModel: ViewModel
    
    func makeUIView(context: Context) -> ARView {
        // 전체 프레임 없이 다 보이게 되어있음
        let arView = ARView(frame: .zero)
        //
        //        // Create a cube model
        //        // box size 1이면 왕큼, cornerRadius 0.05: 6각형
        //        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        //        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true) // metalic한 재질 true
        //        let model = ModelEntity(mesh: mesh, materials: [material])
        ////        model.transform.translation.y = 0.0
        //        model.transform.translation.x = 0.5
        //
        //        // Create a Sphere model
        //        let sphere_mesh = MeshResource.generateSphere(radius: 0.1)
        //        let sphere_material = SimpleMaterial(color: .blue, isMetallic: true)
        //        let sphere_model = ModelEntity(mesh: sphere_mesh, materials: [sphere_material])
        //
        //        // Create a plane model
        //        let plane_mesh = MeshResource.generatePlane(width: 0.2, depth: 0.3, cornerRadius: 0.05)
        //        let plane_material = SimpleMaterial(color: .white, isMetallic: true)
        //        let plane_model = ModelEntity(mesh: plane_mesh, materials: [plane_material])
        //
        //        // Create horizontal plane anchor for the content
        //        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        //        anchor.children.append(model)
        //        anchor.children.append(sphere_model)
        //        anchor.children.append(plane_model)
        //
        //        // Add the horizontal plane anchor to the scene
        //        // session -> scene -> anchors
        //        arView.scene.anchors.append(anchor)
        
        // 사용자 상호작용을 처리하기 위한 코디네이터 추가
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        context.coordinator.view = arView
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    // 추가로 확장해야하는 코디네이터
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
}

class Coordinator: NSObject {
    
    let viewModel: ViewModel
        
        init(viewModel: ViewModel) {
            self.viewModel = viewModel
        }
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        // AR 뷰가 사용 가능한지 확인
        guard let view = self.view else { return }
        
        // AR 보기에서 탭 위치를 가져옴
        let tapLocation = recognizer.location(in: view)
        // 탭 위치에서 레이캐스트를 수행
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        // 레이캐스트 결과를 사용
        if let result = results.first {
            // 레이캐스트 결과를 기반으로 앵커 엔터티를 생성
            let anchorEntity = AnchorEntity(raycastResult: result)
            // 상자 모양의 메시로 모델 개체를 생성
            let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
            let material = SimpleMaterial(color: .red, roughness: 0.15, isMetallic: true)
            let modelEntity = ModelEntity(mesh: mesh, materials: [material])
            // 모델 객체에 대한 충돌 모양 생성
            modelEntity.generateCollisionShapes(recursive: true)
            
            // 뷰 모델의 드로잉에서 생성된 텍스처를 모델 엔티티 재질에 적용
            modelEntity.model?.materials = [createTexture(drawing: viewModel.drawing?.cgImage)]
            
            // 모델 엔티티를 앵커 엔티티의 하위 추가
            anchorEntity.addChild(modelEntity)
            // AR 뷰 장면에 앵커 엔티티 추가
            view.scene.addAnchor(anchorEntity)
            
            // 모델 엔티티에 대한 제스처 설정
            view.installGestures(.all, for: modelEntity)
        }
    }
    
    // 글씨를 material로 변경
    func createTexture(drawing: CGImage?) -> SimpleMaterial {
            if let drawing = drawing {
                let texture = try! TextureResource.generate(from: drawing, options: .init(semantic: .normal))
                var material = SimpleMaterial()
                material.color = .init(texture: .init(texture))
                material.roughness = .float(0)
                material.metallic = .float(0)   // 텍스처를 사용하여 재료 색상을 설정

                return material
            }

            // 드로잉이 nil이면 간단한 머터리얼 반환
            return SimpleMaterial(color: .white, roughness: .float(0), isMetallic: false)
        }
}

#Preview {
    ContentView()
}
