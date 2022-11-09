//
//  WorkLoadManager.swift
//  BankManagerConsoleApp
//
//  Created by jeremy, LJ on 2022/11/02.
//
import Foundation


struct WorkLoadManager {
    var taskQueue: CustomerQueue = CustomerQueue<(Task, BlockOperation)>()
    var operationQueue: OperationQueue = OperationQueue()
    var creditQueue: OperationQueue = OperationQueue()
    
    init(){
        self.operationQueue.maxConcurrentOperationCount = 2
        self.creditQueue.maxConcurrentOperationCount = 1
    }
    
    mutating func work() {
        while taskQueue.isEmpty() != true {
            guard let (task, operation) = taskQueue.dequeue() else { return }
            
            switch task {
            case Task.deposit:
                operationQueue.addOperation(operation)
            default:
                creditQueue.addOperation(operation)
            }
        }
    }
}

