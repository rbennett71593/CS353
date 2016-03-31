//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Foo {
    var x = 1
    var y = 2
    
    
    init?(a: Int, b: Int) {
        if a > 100 {
            return nil
        } else {
            x = a
            y = b
        }
    }
}

var t = Foo(a: 11, b: 12)
t?.x
t?.y



var m = Foo(a: 110, b: 120)
m?.x
m?.y


func check() -> Int? {
    guard let k = Foo(a: 110, b: 120) else {
        print("failed")
        return nil
    }
    return k.x
}
check()
