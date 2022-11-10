//
//  Task.swift
//  BankManagerConsoleApp
//
//  Created by 유제민 on 2022/11/08.
//
import Foundation

enum Task: Int {
    case deposit = 1
    case credit
    
    var name: String {
        switch self {
        case .deposit:
            return "예금"
        case .credit:
            return "대출"
        }
    }

    var workingTime: Void {
        switch self {
        case .deposit:
            usleep(700000)
        case .credit:
            usleep(1100000)
        }
    }
    
    var maxOperations: DispatchSemaphore {
        switch self {
        case .deposit:
            let result = DispatchSemaphore(value: 2)
            return result
        case .credit:
            let result = DispatchSemaphore(value: 1)
            return result
        }
    }
}
