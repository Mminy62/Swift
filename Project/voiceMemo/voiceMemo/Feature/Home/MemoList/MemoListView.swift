//
//  MemoListView.swift
//  voiceMemo
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    var body: some View {
        ZStack {
            VStack {
                if !memoListViewModel.memos.isEmpty { // memo가 있는 경우
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            memoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: memoListViewModel.navigationBarRightBtnMode
                    )
                } else { // 없는 경우
                    Spacer()
                        .frame(height: 30)
                }
                
                // 타이틀 뷰
                TitleView()
                    .padding(.top, 20)
                
                // 안내 뷰 혹은 메모리스트 컨텐츠 뷰
                if memoListViewModel.memos.isEmpty {
                    AnnouncementView()
                } else {
                    MemoListcontentView()
                        .padding(.top, 20)
                }
            }
            
            // 메모작성 플로팅 아이콘 버튼 뷰
            WriteMemoBtnView()
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        }
        .alert(
            "메모 \(memoListViewModel.removeMemoCount )개 삭제하시겠습니까?",
            isPresented: $memoListViewModel.isDisplayRemoveMemoAlert
        ) {
            Button("삭제", role: .destructive) {
                memoListViewModel.removeBtnTapped()
            }
            Button("취소", role: .cancel) {
               // dismiss
            }
        }
    }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    var body: some View {
        HStack {
            if !memoListViewModel.memos.isEmpty {
                Text("메모 \(memoListViewModel.memos.count)개가\n있습니다.")
            } else {
                Text("메모를\n추가해보세요")
            }
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: - 안내 뷰
private struct AnnouncementView: View {

    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image(systemName: "pencil")
                .renderingMode(.template)
            Text("\"퇴근 9시간 전 메모\"")
            Text("\"개발 끝낸 후 퇴근하기\"")
            Text("\"밀린 알고리즘 공부하기\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

// MARK: - 메모 리스트 컨텐츠 뷰
private struct MemoListcontentView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("메모 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)
                    
                    ForEach(memoListViewModel.memos, id: \.self) { memo in
                        // 메모 셀 뷰 호출
                        MemoCellView(memo: memo)
                        
                        
                    }
                }
            }
        }
    }
}

private struct MemoCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @State private var isRemoveSelected: Bool
    private var memo: Memo
    
    fileprivate init(
        isRemoveSelected: Bool = false,
        memo: Memo
    ) { _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button {
            // TODO: - path 관련 메모 구현 후 구현 필요 -> 눌렀을때 메모 본문으로 들어가게끔, 나오는 것과
        } label: {
            VStack(spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(memo.title)
                            .lineLimit(1)
                            .font(.system(size: 16))
                            .foregroundColor(.customBlack)
                        
                        Text(memo.convertedDate)
                            .font(.system(size: 12))
                            .foregroundColor(.customIconGray)
                    }
                    
                    Spacer()

                    if memoListViewModel.isEditMemoMode {
                        Button {
                            isRemoveSelected.toggle()
                        } label: {
                            Image(isRemoveSelected ? "selectedBox" : "unSelectedBox")
                                .font(.system(size: 25))
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                Rectangle()
                    .fill(Color.customGray0)
                    .frame(height: 1)
            }
        }
    }
    
}

private struct WriteMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    // TODO: path 구현 필요
                } label: {
                     Image("writeBtn")
                        .frame(width: 50, height: 50)

                }
            }
        }
    }
}


struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
            .environmentObject(PathModel())
            .environmentObject(MemoListViewModel())
    }
}
