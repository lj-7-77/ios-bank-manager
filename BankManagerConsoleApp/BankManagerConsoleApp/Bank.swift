//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by jeremy, LJ on 2022/11/02.
//
import Foundation
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
    
    private mutating func customersEnetering() {
        let maxCustomersNumber: Int = Int.random(in: 10...30)
        let overallCustomersCount = Array<Int>(1...maxCustomersNumber)
        
        for ticketNumber in overallCustomersCount {
            guard let data = workLoadManager.makeOperation(number: ticketNumber) else { return }
            workLoadManager.taskQueue.enqueue(data: data)
        }
    }
    
    private func closeBank(with workCount: Int) {
        let totalWorkingTime: Double = Double(workCount) * 0.7
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(workCount)명이며, 총 업무시간은 \(totalWorkingTime.formattedToString)초입니다.")
    }
}
