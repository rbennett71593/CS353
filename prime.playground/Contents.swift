//: Playground - noun: a place where people can play

import UIKit

func isPrime(n: Int) -> Bool {
    if n <= 3 {
        return true
    }
    for divisor in 2...n/2 {
        if n % divisor == 0 {
            return false
        }
    }
    return true
}
//var start = CACurrentMediaTime()
//var myPrimes = Array(count: 5000, repeatedValue: false)
//for i in 1..<myPrimes.count {
//    myPrimes[i] = isPrime(i)
//}
//var end = CACurrentMediaTime()
//end-start




var start2 = CACurrentMediaTime()
var end2 = CACurrentMediaTime()
var group = dispatch_group_create()
var myPrimes = Array(count: 50000, repeatedValue: false)

dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)) {
    for i in 1..<myPrimes.count/2 {
        myPrimes[i] = isPrime(i)
    }
}

dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)) {
    for i in myPrimes.count/2..<myPrimes.count {
        myPrimes[i] = isPrime(i)
    }
}

dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)) {
    print("done!")
    end2 = CACurrentMediaTime()
}
sleep(100)
myPrimes
end2-start2

