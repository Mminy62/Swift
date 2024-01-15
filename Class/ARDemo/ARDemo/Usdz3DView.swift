//
//  Usdz3DView.swift
//  ARDemo
//
//  Created by 이민영 on 2024/01/11.
//


import SwiftUI
import RealityKit

struct Usdz3DView: View {
    
    let modelNames = ["teapot", "toy_car", "pancakes", "toy_biplane_idle", "toy_drummer_idle"]
    // 선택된 모델 인덱스의 상태 변수
    @State private var selectedModelIndex = 0
    
    var body: some View {
        VStack {
            // 선택된 모델이 포함된 AR 뷰 컨테이너
            Usdz3DARViewContainer(modelName: modelNames[selectedModelIndex])
                .edgesIgnoringSafeArea(.all)
            
            // 모델 선택을 위한 선택기
            Picker("Select Model", selection: $selectedModelIndex) {
                ForEach(0..<modelNames.count, id: \.self) { index in
                    Image(modelNames[index])
                        .resizable()
                        .frame(width: 50, height: 50)
                        .tag(index)
                }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct Usdz3DARViewContainer: UIViewRepresentable {
    
    let modelName: String
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // 기존 앵커를 제거(초기화)
        uiView.scene.anchors.removeAll()
        
        // 애셋 폴더에서 모델 로드
        let modelEntity = try! ModelEntity.loadModel(named: modelName + ".usdz")
        // 앵커 엔티티를 생성하고 모델을 추가
        let anchorEntity = AnchorEntity()
        anchorEntity.addChild(modelEntity)
        
        // 앵커 엔티티의 위치를 카메라 앞 0.5미터로 설정
        anchorEntity.position = [0, 0, -0.5]
        
        // 장면에 앵커 엔티티 추가
        uiView.scene.addAnchor(anchorEntity)
        
    }
    
}
#Preview {
    Usdz3DView()
}
