//
//  Ex_Generic.swift
//  Class
//
//  Created by 이민영 on 2023/11/07.
//

import Foundation



// 예제 4번

// 예시 코드:
// value type은 기본적으로 내부에서 인스턴스 메서드를 통해 내부 값을 변경할 수 없다. -> mutating을 사용하여 변경해준다.
// value type: 기본자료형, struct, enum 등
struct Queue<T>{
    var q: [T] = []
    
    mutating func enqueue(_ item: T){
        q.append(item)
    }
    mutating func dequeue() -> T?{
        return q.isEmpty ? nil : q.removeFirst()
    }
    
    func front() -> T? {
            return q.first
        }

    var isEmpty: Bool {
        return q.isEmpty
    }
    
    
    
}
var queue = Queue<String>()
queue.enqueue("A")
queue.enqueue("B")
queue.enqueue("C")
print(queue.dequeue()) // A
print(queue.front()) // B
print(queue.isEmpty) // false

// 예제 5번
// 예시 코드:

//printType(3) // The type of 3 is Int
//printType("Hello") // The type of Hello is String
//printType(true) // The type of true is Bool


// 예제 7번
// 동등연산자를 쓸땐 Equtable이 필요하다. 없으면 error
// Referencing operator function '==' on 'Equatable' requires that 'T' conform to 'Equatable'
func isEqual<T: Equatable>(_ a: T, _ b:T) -> Bool{
    return a == b ? true : false
}

// where?
//func isEqual<T>(_ value1: T, _ value2: T) -> Bool where T: Equatable {
//    return value1 == value2
//}

print(isEqual(1, 1)) // true
print(isEqual("Hello", "World")) // false
print(isEqual(true, false)) // false


// 예제 8번
func isInt<T: Equatable>(_ item: T) -> Bool{
    return type(of: item) == Int.self ? true : false
}

/**
## Int로만 하면 안되는 이유는, myArray.append(String) 이 안되는 이유랑 같아요.
## String 은 type의 이름이지 값(value)가 아니잖아요? metatype의 값을 얻기 위해선 type의 이름 뒤에 .self를 붙여야 한답니다.
 */

print(isInt(3)) // true
print(isInt("Hello")) // false
print(isInt(true)) // false


// 예제 9번

// 예시 코드:

func castToInt<T>(_ item: T) -> Int?{
    if let value = item as? Int {
            return value
        }
        return nil
}
print(castToInt(3)) // 3
print(castToInt("Hello")) // nil
print(castToInt(true)) // nil

// 예제 10번


func swapFirstAndLast<T>(_ array: inout [T]){
//    let first = array[0]
//    array[0] = array[array.count-1]
//    array[array.count-1] = first
//    
    array.swapAt(0, array.count-1)
}

// 예시 코드:

var array1 = [1, 2, 3, 4, 5]
swapFirstAndLast(&array1)
print(array1) // [5, 2, 3, 4, 1]

var array0 = ["A", "B", "C", "D"]
swapFirstAndLast(&array0)
print(array0) // ["D", "B", "C", "A"]



// 예제 11번

// 예시 코드:

func printReverse<T>(_ array: [T]){
    for i in (0...array.count-1).reversed(){
        print(array[i])
    }
}

let array11 = [1, 2, 3, 4, 5]
printReverse(array11)
// 5
// 4
// 3
// 2
// 1

let array112 = ["A", "B", "C", "D"]
printReverse(array112)
// D
// C
// B
// A

// 예제 12번

class Node<T> {
    var value: T
    var next: Node?

    init(value: T) {
        self.value = value
    }
}

struct LinkedList<T>{
    private var head: Node<T>?
    var array: [T] = []
    
    
    mutating func append(_ item: T){
        let newNode = Node(value: item)
        if head == nil{
            head = newNode
            return
        }
        
        var current = head
        while current?.next != nil{
            current = current?.next
        }
        current?.next = newNode
    }
    
    mutating func insert(_ item: T, at index: Int){
        
        let newNode = Node(value: item)
        if index == 0{
            newNode.next  = head
            head = newNode
            return
        }
        
        var i = 0
        var prev = head
        var current = head
        while current?.next != nil && i < index{
            prev = current
            current = current?.next
            i += 1
        }
        
        prev?.next = newNode
        newNode.next = current
        
    }
    mutating func remove(at index: Int) -> T?{
        
        if index == 0{
            let value = head?.value
            head = head?.next
            return value
        }
    
        var i = 0
        var prev = head
        var current = head
        while current?.next != nil && i < index{
            prev = current
            current = current?.next
            i += 1
        }
        
        prev?.next = current?.next
        return current?.value
        
    }
    
    func nodeAt(_ index: Int) -> Node<T>? {
            var current = head
            var i = 0
            while current?.next != nil && i < index {
                current = current?.next
                i += 1
            }
            return current
        }
}

// 예시 코드:
var list = LinkedList<Int>()
list.append(1)
list.append(2)
list.append(3)

list.insert(4, at: 1)
list.remove(at: 2)
print(list.nodeAt(0)?.value) // 1
print(list.nodeAt(1)?.value) // 4
print(list.nodeAt(2)?.value) // 3
