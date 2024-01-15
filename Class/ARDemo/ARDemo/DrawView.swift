//
//  DrawView.swift
//  ARDemo
//
//  Created by 이민영 on 2024/01/10.
//
import SwiftUI
import UIKit
import PencilKit

struct DrawView: View {

    @EnvironmentObject var viewModel: ViewModel
    @State var selectedColor: Color = .black
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 드로잉 캔버스 표시
                DrawingView(canvasView: $viewModel.canvasView, selectedColor: $selectedColor)

                // 추가 컨트롤 및 버튼
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        // 그리기 색상을 선택하는 색상 선택자
                        ColorPicker("Color", selection: $selectedColor)
                            .labelsHidden()

                        // 그리기를 지우는 버튼
                        Button("Clear") {
                            viewModel.canvasView.drawing = PKDrawing()
                        }

                        // 그림을 이미지로 변환하고 보기를 종료하는 버튼
                        Button("Done") {
                            convertPenciKitViewToImage()
                            viewModel.isShowingView = false
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.canvasView.drawing = PKDrawing()
        }

    }

    // PenciKit 뷰를 변환하는 함수
    func convertPenciKitViewToImage() {
        if let image = viewModel.canvasView.asImage() {
            viewModel.drawing = image
        }
    }
}

struct DrawingView: UIViewRepresentable {

    @Binding var canvasView: PKCanvasView
    @Binding var selectedColor: Color
    
    // PKCanvasView 생성 및 초기 구성 설정
    func makeUIView(context: Context) -> some PKCanvasView {
        // 캔버스에서 모든 입력을 허용
        canvasView.drawingPolicy = .anyInput
        // 초기 그리기 도구를 검정색, 두께 5.0 펜으로 설정
        canvasView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: .black, width: 5.0)
        return canvasView
    }

    // 선택한 색상으로 그리기 도구 업데이트
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.tool = PKInkingTool(PKInkingTool.InkType.pen, color: UIColor(selectedColor), width: 5.0)
    }
}
#Preview {
    DrawView()
}
