//
//  Task.swift
//  BankManagerConsoleApp
//
//  Created by 유제민 on 2022/11/08.
//

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
}
