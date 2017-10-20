//
//  JobTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

class JobTests: XCTestCase {

    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
    }

    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
    }

    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)

        job.raise(1000)
        XCTAssert(job.calculateIncome(50) == 2000)
    }

    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)

        job.raise(1.0)
        XCTAssert(job.calculateIncome(10) == 160)
    }

    func testDescription() {
        let job = Job(title: "CEO", type: Job.JobType.Hourly(100.0))
        XCTAssert(job.description == "Job: CEO Hourly Wage: 100.0")
        let job2 = Job(title: "Professor", type: Job.JobType.Salary(5000))
        XCTAssert(job2.description == "Job: Professor Annual Salary: 5000")
    }

}
