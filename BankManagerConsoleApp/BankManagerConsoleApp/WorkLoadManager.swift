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
    let queue1 = DispatchQueue(label: Task.deposit.name, attributes: .concurrent)
    let queue2 = DispatchQueue(label: Task.credit.name, attributes: .concurrent)
    let mySemaphore = DispatchSemaphore(value: 2)
    let mymySemaphore = DispatchSemaphore(value: 1)
    mutating func work() {
        
        while taskQueue.isEmpty() != true {
            guard let (number, task, operation) = taskQueue.dequeue() else { return }
            
            switch task {
            case Task.deposit:
                queue1.async(group: banking, execute: operation)
                
            default:
                queue2.async(group: banking, execute: operation)
            }
        }
        banking.wait()
    }
    
    func makeOperation(number: Int) -> (Int, Task, DispatchWorkItem)? {
        guard let task = Task(rawValue: getRandomTask()) else { return nil }
        switch task {
        case .deposit:
            let deposit = DispatchWorkItem {
                mySemaphore.wait()
                print(" \(number)번쨰 고객, \(task.name)업무 진행 🌀")
                task.workingTime
                mySemaphore.signal()
            }
            
            deposit.notify(queue: queue1) {
                print(" \(number)번쨰 고객, \(task.name)업무 완료 ✅")
            }
            return (number: number, task: task, op: deposit)
        case .credit:
            let credit = DispatchWorkItem {
                mymySemaphore.wait()
                print(" \(number)번쨰 고객, \(task.name)업무 진행 🌀")
                task.workingTime
                mymySemaphore.signal()
            }
            credit.notify(queue: queue2) {
                print(" \(number)번쨰 고객, \(task.name)업무 완료 ✅")
            }
            return (number: number, task: task, op: credit)
        }
    }
    
    func getRandomTask() -> Int {
        return Int.random(in: 1...2)
    }
}

