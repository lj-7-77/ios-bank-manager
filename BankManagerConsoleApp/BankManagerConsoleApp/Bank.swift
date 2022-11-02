//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by jeremy, LJ on 2022/11/02.
//

struct Bank {
    private var bankManagers: [BankManager]  = []
    private var workLoadManager: WorkLoadManager = WorkLoadManager()

    mutating func openBank() {
        print("openBank")
        let randomIntNumber = Int.random(in: 10...30)
        let customerCount = Array<Int>(1...randomIntNumber)
        customerCount.forEach {
            workLoadManager.taskQueue.enqueue(data: $0)
        }
        
        while workLoadManager.taskQueue.isEmpty() == true {
            workLoadManager.checkManagers(managers: bankManagers)
        }
        
        closeBank(with: randomIntNumber)
    }
}

