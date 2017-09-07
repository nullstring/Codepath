//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print("Hello world!")

// String interpolation using \(...) syntax
let name: String = "Harsh"
print("Hello \(name)!")


// let vs var
let numberOfContinents: Int = 7
var continentsVisited: Int = 2


// numbers
let minValue: Int = -42
let maxValue: Int = 55

let pi: Double = 3.14159
let billAmount: Double = 10.25

// Strings
let hello: String = "Hello"
let world: String = "World"

let helloWorld: String = "\(hello) \(world)"
let helloWorldConcat: String = hello + " " + world

// Booleans
let swiftIsCool: Bool = true
let iMissObjectiveC: Bool = false

// Arrays
var previousBillAmounts: [Double] = [10, 11, 12]
previousBillAmounts.append(13)
let count = previousBillAmounts.count
let firstBillAmount = previousBillAmounts[0]

// Dictionaries
var people: [String: Int] = [ "Bob": 32, "Cindy" : 25]
let bobsAge = people["Bob"]
people["Dan"] = 56

let bobName = "Bob"

// Optaionals
let input: String = "123"
let optionalConvertedInput: Int? = Int(input)

let input2: String = "Bob"
let optionalConvertedInput2: Int? = Int(input2)

if let convertedInput = optionalConvertedInput {
    print("I converted")
}

// Functions
func printHello() {
    print("Hello!")
}
printHello()

func sayHello(personName: String) -> String {
    return "Hello \(personName)"
}
sayHello(personName: "Harsh")

func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)"
}
sayHello(to: "Harsh", and: "Mehta")

// Control flow
let temperatureInFahrenheit: Int = 90

if temperatureInFahrenheit <= 32 {
    print("Its very cold")
} else if temperatureInFahrenheit >= 86 {
    print("Its really warn.")
} else {
    print("Wear a tshirt")
}


// Loops
for index in 0..<3 {
    print("Hello")
}

let names = ["Anna", "Alex", "Bob"]
for name in names {
    print("Hello, \(name)")
}

for (index, value) in names.enumerated() {
    print("Item \(index+1): \(value)")
}

// Classes
class Person {
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        
        Person.numberOfPeople += 1
    }
    
    /* properties */
    var firstName: String
    var lastName: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    static var numberOfPeople = 0
    
    func greet() {
        print ("Hello \(self.firstName)")
    }
    
    class func printNumberOfPeople() {
        print("Number of people = \(Person.numberOfPeople)")
    }
}
let bob = Person(firstName: "Bob", lastName: "Smith")
bob.greet()
Person.printNumberOfPeople()


// Protocol
protocol MyFriendlyGreeterProtocol {
    func sayHello()
    func sayBye()
}
class MyEnglishPerson: MyFriendlyGreeterProtocol {
    func sayHello() {
        print("Hello!")
    }
    func sayBye() {
        print("Bye")
    }
}


// Closures
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        print("10")
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
print("10")
print(incrementByTen())
print(incrementByTen())
print(incrementByTen())

// Type casting
let myFloat = 1 as Float
if let myFloatInt = myFloat as? Int {
    print("I casted")
} else {
    print("Nothing happened")
}
let myFloatIntForced = myFloat as! Int

// Understanding the question mark

