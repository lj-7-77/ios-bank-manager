//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by jeremy, LJ on 2022/11/02.
//
import Foundation
let semaphore = DispatchSemaphore(value: 2)
typealias App = Displayable & SelectableMenu & Runnable
struct Bank: App {
    private var workLoadManager: WorkLoadManager = WorkLoadManager()
    
    mutating func openBank() {

        customersEnetering()
        runBankingJobs()
    }
    
    mutating func runBankingJobs() {
        
        while workLoadManager.taskQueue.isEmpty() == false {
            workLoadManager.work()
        }
        closeBank(with: 70)
    }
    
    // MARK: Customers Entering
    private mutating func customersEnetering() {
        let maxCustomersNumber: Int = Int.random(in: 10...70)
        let overallCustomersCount = Array<Int>(1...maxCustomersNumber)
        
        for ticketNumber in overallCustomersCount {
            let data = makeOperation(number: ticketNumber)
            workLoadManager.taskQueue.enqueue(data: data)
        }
    }
    
    func getRandomTask() -> Int {
        return Int.random(in: 1...2)
    }
    
    
    // MARK: makeOperation
    func makeOperation(number: Int) -> (Int, Task, DispatchWorkItem) {
        let task = Task.getTask(by: getRandomTask())
        let semaphore = task.maxOperations
        
        let operation = DispatchWorkItem {
            semaphore.wait()
            print(" \(number)번쨰 고객, \(task.rawValue)업무 진행 🌀")
            task.workingTime
            semaphore.signal()
        }
        operation.notify(queue: .global()) {
            print(" \(number)번쨰 고객, \(task.rawValue)업무 완료 ✅")
        }
        
        let result = (number: number,
                      task: task,
                      op: operation)
        return result
    }
    
    private func closeBank(with workCount: Int) {
        let totalWorkingTime: Double = Double(workCount) * 0.7
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(workCount)명이며, 총 업무시간은 \(totalWorkingTime.formattedToString)초입니다.")
    }
}
