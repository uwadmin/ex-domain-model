//
//  PersonTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class PersonTests: XCTestCase {

    func testPerson() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.toString() == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }

    func testAgeRestrictions() {
        let matt = Person(firstName: "Matthew", lastName: "Neward", age: 15)

        matt.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(matt.job == nil)

        matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(matt.spouse == nil)
    }

    func testAdultAgeRestrictions() {
        let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)

        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(mike.job != nil)

        mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(mike.spouse != nil)
    }

    func testDescription() {
        let a = Person(firstName: "Xinyue", lastName: "Chen", age: 10)
        let b = Person(firstName: "Yongxin", lastName: "Yang", age: 40)
        XCTAssert(a.description == "First Name: Xinyue, Last Name: Chen, Age: 10")
        XCTAssert(b.description == "First Name: Yongxin, Last Name: Yang, Age: 40")
    }

}

class FamilyTests: XCTestCase {

    func testFamily() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

        let family = Family(spouse1: ted, spouse2: charlotte)

        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 1000)
    }

    func testFamilyWithKids() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

        let family = Family(spouse1: ted, spouse2: charlotte)

        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))

        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)

        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 12000)
    }

    func testDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        let family = Family(spouse1: ted, spouse2: charlotte)
        XCTAssert(family.description == "Family members:\nFirst Name: Ted, Last Name: Neward, Age: 45\nFirst Name: Charlotte, Last Name: Neward, Age: 45\nHousehold Income: 1000")
    }

}
