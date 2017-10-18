//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

// print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount: Int
    public var currency: String

    public func convert(_ to: String) -> Money {
        if (currency == to) {
            return self
        }
        var convertedAmount = Double(amount)
        switch currency {
        case "USD":
            convertedAmount = convertedAmount * 1
        case "CAN":
            convertedAmount = convertedAmount / 1.25
        case "GBP":
            convertedAmount = convertedAmount * 2
        case "EUR":
            convertedAmount = convertedAmount / 1.5
        default:
            print("Unknown currency")
        }
        switch to {
        case "CAN":
            convertedAmount = convertedAmount * 1.25
        case "USD":
            convertedAmount = convertedAmount * 1
        case "GBP":
            convertedAmount = convertedAmount / 2
        case "EUR":
            convertedAmount = convertedAmount * 1.5
        default:
            print("Unknown currency")
        }
        return Money(amount: Int(convertedAmount), currency: to)
    }

    public func add(_ to: Money) -> Money {
        if self.currency == to.currency {
            return Money(amount: self.amount + to.amount, currency: to.currency)
        } else {
            return to.add(_: self.convert(to.currency))
        }
    }


    public func subtract(_ from: Money) -> Money {
        if self.currency == from.currency {
            return Money(amount: from.amount - self.amount, currency: from.currency)
        } else {
            return self.convert(from.currency).subtract(_: from)
        }
    }

}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title: String
    fileprivate var type: JobType

    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }

    public init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }

    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let hourly):
            return Int(hourly * Double(hours))
        case .Salary(let salary):
            return salary
        }
    }

    open func raise(_ amt: Double) {
        switch self.type {
        case .Hourly(let hourly):
            self.type = JobType.Hourly(hourly + amt)
        case .Salary(let salary):
            self.type = JobType.Salary(salary + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName: String = ""
    open var lastName: String = ""
    open var age: Int = 0

    fileprivate var _job: Job? = nil

    open var job: Job? {
        get {
            return self._job
        }
        set(value) {
            if (age < 16) {
                self._job = nil
            } else {
                self._job = value
            }
        }
    }

    fileprivate var _spouse: Person? = nil
    open var spouse: Person? {
        get {
            return self._spouse
        }
        set(value) {
            if (self.age < 18) {
                self._spouse = nil
            } else {
                self._spouse = value
            }
        }
    }

    public init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members: [Person] = []

    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            members.append(spouse1)
            members.append(spouse2)
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
    }

    open func haveChild(_ child: Person) -> Bool {
        if (members[0].age < 21 && members[1].age < 21) {
            return false
        } else {
            members.append(child)
            child.age = 0
            return true
        }
    }

    open func householdIncome() -> Int {
        var income = 0
        for person in members {
            if (person.job != nil) {
                income += (person.job!.calculateIncome(2000))
            }
        }
        return income
    }
}