//
//  WorkLoadManager.swift
//  BankManagerConsoleApp
//
//  Created by jeremy, LJ on 2022/11/02.
//
import Foundation


struct WorkLoadManager {
    var taskQueue: CustomerQueue = CustomerQueue<(Int, Task, DispatchWorkItem)>()
    let banking = DispatchGroup()
    var queue1 = DispatchQueue(label: Task.deposit.rawValue, attributes: .concurrent)
    var queue2 = DispatchQueue(label: Task.credit.rawValue, attributes: .concurrent)
//    var operationQueue: OperationQueue = OperationQueue()
//    var creditQueue: OperationQueue = OperationQueue()
    
//    init(){
//        self.operationQueue.maxConcurrentOperationCount = 2
//        self.creditQueue.maxConcurrentOperationCount = 1
//    }
    
    mutating func work() {
        
        while taskQueue.isEmpty() != true {
            guard let (number, task, operation) = taskQueue.dequeue() else { return }

            switch task {
            case Task.deposit:
//                operationQueue.addOperation(operation)
                queue1.async(execute: operation)

            default:
                queue2.async(execute: operation)
            }
        }
//        banking.wait()
    }
}

