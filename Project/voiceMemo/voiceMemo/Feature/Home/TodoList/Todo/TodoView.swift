//
//  TodoView.swift
//  voiceMemo
//

import SwiftUI

struct TodoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @StateObject private var todoViewModel = TodoViewModel()
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                leftBtnAction:  {
                    pathModel.paths.removeLast()
                },
                rightBtnAction: { // write 버튼 액션
                    todoListViewModel.addTodo(
                        .init(
                            title: todoViewModel.title,
                            time: todoViewModel.time,
                            day: todoViewModel.day,
                            selected: false
                        )
                    )
                    
                    pathModel.paths.removeLast() // 생성하는 건 굳이 안담아둠
                },
                rightBtnType: .create
            )
            
            // 타이틀 뷰
            TitleView()
                .padding(.top, 20)
            
            Spacer()
                .frame(height: 20)
            
            // 투두 타이틀 뷰 (텍스트 필드)
            TodoTitleView(todoViewModel: todoViewModel)
                .padding(.leading, 20)
            
            // 시간 선택
            SelectTimeView(todoViewModel: todoViewModel)
            
            // 날짜 선택
            SelectDayView(todoViewModel: todoViewModel)
         
            Spacer()
        }
    }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("To do list를\n추가해 보세요.")
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: - 투두 타이틀 뷰 (제목 입력 뷰)
private struct TodoTitleView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        TextField("제목을 입력하세요.", text: $todoViewModel.title)
    }
}

// MARK: - 시간 선택 뷰
private struct SelectTimeView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
            
            DatePicker(
                "",
                selection: $todoViewModel.time,
                displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
            .environment(\.locale, Locale.init(identifier: "ko"))
            .frame(maxWidth: .infinity, alignment: .center)
            
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
        }
    }
}


// MARK: - 날짜 선택 뷰
private struct SelectDayView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("날짜")
                    .foregroundStyle(Color.customIconGray)
                
                Spacer()
            }
            HStack {
                Button(
                    action: { todoViewModel.setIsDisplayCalendar(true)},
                    label: {
                        Text("\(todoViewModel.day.formattedDay)")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(Color.customGreen)
                    }
                )
                .popover(isPresented: $todoViewModel.isDisplayCalendar) {
                    DatePicker(
                    "", // 제목 없음
                    selection: $todoViewModel.day,
                    displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onChange(of: todoViewModel.day) { _ in
                        // todoViewModel.day가 바뀔 때마다 어떤 action을 취할건지
                        todoViewModel.setIsDisplayCalendar(false)
                        // 날짜 선택하면 캘린더 닫히기
                    }
                }
                
                Spacer()
            }
        }
        .padding(.leading, 20)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
