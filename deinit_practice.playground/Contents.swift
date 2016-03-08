//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    let name : String
    weak var apartment: Apartment?
    
    init(name: String) {
        self.name = name
        print("\(name) is being init")
    }
    
    deinit {
        print("\(name) is being deinit")
    }
    
}

class Apartment {
    let unit: String
    weak var tenant: Person?
    
    init(unit: String) {
        self.unit = unit
        tenant = nil
        print("Apartment \(unit) is being built")
    }
    
    deinit {
        print("Apartment \(unit) is being destroyed")
    }
}

//var p1: Person?
var p2: Person?
var unit2: Apartment?

p2 = Person(name: "Mike")

var p3: Person?
var unit1: Apartment?



p3 = Person(name: "John")
unit1 = Apartment(unit: "12B")

p3!.apartment = unit1
unit1!.tenant = p3

p3 = nil
unit1 = nil





extension String {
    func split () -> [String] {
        
        let y = self.characters
        
        return y.split{$0 == " "}.map(String.init)
        
    }
}

"foo bar baz".split()













    

