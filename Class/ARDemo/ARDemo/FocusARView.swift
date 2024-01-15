//
//  PlacingView.swift
//  ARDemo
//
//  Created by 이민영 on 2024/01/11.
//

import SwiftUI
import RealityKit
import FocusEntity
import ARKit

struct FocusARView: View {
    // 클릭 변수
    @State private var isAddEntityAction = false
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            FocusARViewContainer(isAction: $isAddEntityAction).edgesIgnoringSafeArea(.all)
            
            Button {
                isAddEntityAction.toggle()
            } label: {
                 Text("Place 3D Model")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            .padding(.bottom, 50)
        }
       
    }
}


struct FocusARViewContainer: UIViewRepresentable {
    @Binding var isAction: Bool
    // 사용자 커스텀 ar view 생성 후 계속 화면 업데이트 가능
    func makeUIView(context: Context) -> FocusCustomARView {
        return FocusCustomARView()
    }
    
    func updateUIView(_ uiView: FocusCustomARView, context: Context) {
        isAction.toggle()
        print("updateUIView")
        uiView.place3DModel()
    }
    
}

// 사용자 정의 ARView
class FocusCustomARView: ARView {
    var focusEntity: FocusEntity?
    
    init() {
        super.init(frame: .zero)
        
        self.focusEntity = FocusEntity(on: self, focus: .classic)
        // ARKit에 존재 -> world tracking configuration
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // 평면 디텍션
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            print("====mesh With Classfication")
            config.sceneReconstruction = .meshWithClassification
            
            
        }
        
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            print("====person Semnentation")
            config.frameSemantics.insert(.personSegmentationWithDepth)
            
            
        }
      
        // occlusion
        self.environment.sceneUnderstanding.options.insert(.collision)
        
        self.session.run(config)
    }
    
    func place3DModel() {
        guard let focusEntity = self.focusEntity else { return }
        
        let modelEntity = try! ModelEntity.load(named: "toy_drummer_idle" + ".usdz")
        let anchorEntity = AnchorEntity(world: focusEntity.position)
        anchorEntity.addChild(modelEntity)
        self.scene.addAnchor(anchorEntity)
    }

    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

#Preview {
    FocusARView()
}
