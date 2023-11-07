//
//  Generic.swift
//  Class
//
//  Created by 이민영 on 2023/11/07.
//

/**
 # 제너릭 (Generics)
 */

// 제너릭 함수
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
print( someInt, anotherInt )


// 제너릭 타입
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var myStack = Stack<String>()
myStack.push("Park")
myStack.push("Kim")
myStack.push("Lee")
print(myStack.items)
print(myStack.pop())

var anyStack = Stack<Any>()
anyStack.push("Hello")
anyStack.push(1.0)
anyStack.push(5)
print(anyStack.items)


// 제너릭 확장(익스텐션)
extension Stack {
    var topElement: Element? {
        return self.items.last
    }
}

print(myStack.topElement as Any)

// 제너릭 타입 제약 (프로토콜/클래스)
// Dictionary 참고
