//
//  Task.swift
//  BankManagerConsoleApp
//
//  Created by 유제민 on 2022/11/08.
//
import Foundation

enum Task: String {
    case deposit = "예금"
    case credit = "대출"
    
    static func getTask(by: Int) -> Self {
        switch by {
        case 1:
            return Self.deposit
        default:
            return Self.credit
        }
    }
    
    var workingTime: Void {
        switch self {
        case .deposit:
            sleep(2)
        case .credit:
            sleep(1)
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
