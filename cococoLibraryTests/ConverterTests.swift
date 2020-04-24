//
//  ConverterTests.swift
//  cococoKitTests
//
//  Created by Michael Heinzl on 14.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import XCTest
@testable import cococoLibrary

class ConverterTests: XCTestCase {

	var sut: Converter!
	
    override func setUp() {
		super.setUp()
		
		sut = Converter()
    }
	
	func testExample() throws {
        let result = try sut.convert([XCResultExamples.example], excludedFileExtensions: nil, ignoredPaths: nil, legacyMode: nil)
		let expectedResult = try String(contentsOf: XCResultExamples.exampleResult)
		XCTAssertEqual(result, expectedResult)
	}

    func testLegacyExample() throws {
        let result = try sut.convert([XCResultExamples.legacyExample], excludedFileExtensions: nil, ignoredPaths: nil, legacyMode: true)
        let expectedResult = try String(contentsOf: XCResultExamples.exampleResult)
        XCTAssertEqual(result, expectedResult)
    }
	
	func testExcludeSingleFileExtension() {
		let filePaths = [
			"foo/bar/file1.swift",
			"asdf/foo.h",
			"asdf/foo.m",
			"asdf/bar.m",
			"file2.swift"
		]
		let excludedFileExtensions = [".swift"]
		let expectedPaths = [
			"asdf/foo.h",
			"asdf/foo.m",
			"asdf/bar.m"
		]
		let resultingPaths = sut.filterFileExtensions(filePaths, excludedFileExtensions: excludedFileExtensions)
		XCTAssertEqual(resultingPaths, expectedPaths)
	}
	
	func testExcludeMultipleFileExtensions() {
		let filePaths = [
			"foo/bar/file1.swift",
			"asdf/foo.h",
			"asdf/foo.m",
			"asdf/bar.m",
			"file2.swift"
		]
		let excludedFileExtensions = [".m", ".h"]
		let expectedPaths = [
			"foo/bar/file1.swift",
			"file2.swift",
		]
		let resultingPaths = sut.filterFileExtensions(filePaths, excludedFileExtensions: excludedFileExtensions)
		XCTAssertEqual(resultingPaths, expectedPaths)
	}

    func testExcludeSingleFilePaths() {
        let filePaths = [
            "foo/bar/file1.swift",
            "asdf/foo.h",
            "asdf/foo.m",
            "asdf/bar.m",
            "file2.swift"
        ]
        let excludedPaths = ["asdf/"]
        let expectedPaths = [
            "foo/bar/file1.swift",
            "file2.swift"
        ]
        let resultingPaths = sut.filterFilePaths(filePaths, ignoredPaths: excludedPaths)
        XCTAssertEqual(resultingPaths, expectedPaths)
    }

    func testExcludeMultipleFilePaths() {
        let filePaths = [
            "foo/bar/file1.swift",
            "asdf/foo.h",
            "asdf/foo.m",
            "asdf/bar.m",
            "file2.swift"
        ]
        let excludedPaths = ["asdf/","foo/bar"]
        let expectedPaths = [
            "file2.swift"
        ]
        let resultingPaths = sut.filterFilePaths(filePaths, ignoredPaths: excludedPaths)
        XCTAssertEqual(resultingPaths, expectedPaths)
    }

}
