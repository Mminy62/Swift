//
//  TodoListViewModel.swift
//  voiceMemo
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo]
    // 현재 화면이 편집 모드인지 아닌지
    @Published var isEditTodoMode: Bool
    @Published var removeTodos: [Todo] // 삭제할 일들
    @Published var isDisplayRemoveTodoAlert: Bool // 실제로 삭제 할지 안할지 선택
    
    var removeTodosCount: Int {
        return removeTodos.count
    }
    
    // 버튼 보여주는 용도(label)
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditTodoMode ? .complete : .edit
    }
    
    init(
        todos: [Todo] = [],
        isEditModeTodoMode: Bool = false,
        removeTodos: [Todo] = [],
        isDisplayRemoveTodoAlert: Bool = false
    ) {
        self.todos = todos
        self.isEditTodoMode = isEditModeTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
    }
    
}

// 변수 외의 함수 선언
extension TodoListViewModel {
    func isSelectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0 == todo }) { // 선택한 todo가 있다면
            todos[index].selected.toggle()
        }
    }
    
    func addTodo(_ todo: Todo) {
        todos.append(todo)
    }
    
    // 버튼을 눌렀을때의 용도(action)
    func navigationRightBtnTapped() {
        if isEditTodoMode {
            if removeTodos.isEmpty {
                isEditTodoMode = false
            } else { // todos 삭제할 때
                // 알럿을 불러준다!
                setIsDisplayRemoveTodoAlert(true)
            }
        } else { // editmode가 아닐때 버튼을 눌렀으니, editmode로 전환
            isEditTodoMode = true
        }
    }
    
    // 상태값을 변경해주는 로직
    // Q: 왜 이것만 따로 set함수를 만들어 주는지?
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
        isDisplayRemoveTodoAlert = isDisplay
    }
    
    func todoRemoveSelectedBoxTapped(_ todo: Todo) {
        if let index = removeTodos.firstIndex(of: todo) { // 이미 removeTodos에 담겨있는 아이템이면, remove 체크를 해제했다고 생각하고 지운다.
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo) // removeTodos에 담기
        }
    }
    
    func removeBtnTapped() {
        // removeAll: 조건에 맞는 것을 삭제 / 조건이 없는 경우 전체 삭제
        todos.removeAll { todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
        isEditTodoMode = false
    }
}
