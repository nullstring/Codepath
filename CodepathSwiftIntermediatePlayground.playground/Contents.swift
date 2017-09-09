//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Types and type casting
var myArray: [Any] = Array()
myArray.append(String())
myArray.append(Int())

// Check object type by "if object is String {}"

// Use as to downcast
// let object = parent as child

// safer to use as? to downcast
// if let object = parent as? childType {}

// Optional chaining
var myValue: Int? = nil
if object != nil && object.childObject != nil {
    myValue = object!.childObject!.method()
}
// equivalent to
var myValue: Int? = object?.childObject?.method()

// a ?? b

// Extensions
extension Int {
    func even() -> Bool {
        return self % 2 == 0
    }
}
2.even()

