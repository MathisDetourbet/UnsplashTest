//
//  XCTestCase+Combine.swift
//  UnsplashTestTests
//
//  Created by Mathis DETOURBET on 20/05/2022.
//

import XCTest
import Combine

extension XCTestCase {

    /// Error throwed by Combine extension.
    enum CombineTestCaseError: Error, Equatable {
        /// Error occurs when you get a success instead a failure.
        case getSuccessWhenAwaitingFailure
    }

    ///
    /// Await next publisher value.
    ///
    /// - Parameters:
    ///     - publisher: The source you want to await.
    ///     - willComplete: True by default. You may set false when using Subject and never call `complete(.finished)`.
    ///     - timeout: Expectation timeout.
    ///     - file: Used to print file name when failure occurs.
    ///     - line: Used to print line number when failure occurs.
    /// - Returns: The next publisher value.
    ///
    func awaitValue<T: Publisher>(
        from publisher: T,
        willComplete: Bool = true,
        timeout: TimeInterval = 0.2,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
                if !willComplete {
                    expectation.fulfill()
                }
            }
        )

        self.wait(for: [expectation], timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        return try unwrappedResult.get()
    }

    ///
    /// Await next publisher value.
    ///
    /// - Parameters:
    ///     - publisher: The source you want to await.
    ///     - willComplete: True by default. You may set false when using Subject and never call `complete(.finished)`.
    ///     - timeout: Expectation timeout.
    ///     - file: Used to print file name when failure occurs.
    ///     - line: Used to print line number when failure occurs.
    /// - Returns: The next publisher value.
    ///
    func awaitNoValue<T: Publisher>(
        from publisher: T,
        willComplete: Bool = true,
        timeout: TimeInterval = 0.2,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Do not await value from publisher")
        expectation.isInverted = true

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
                if !willComplete {
                    expectation.fulfill()
                }
            }
        )

        self.wait(for: [expectation], timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        return try unwrappedResult.get()
    }

    ///
    /// Await publisher failure completion.
    ///
    /// - Parameters:
    ///     - publisher: The source you want to await.
    ///     - timeout: Expectation timeout.
    ///     - file: Used to print file name when failure occurs.
    ///     - line: Used to print line number when failure occurs.
    /// - Returns: The next publisher failure value.
    ///
    func awaitFailure<T: Publisher>(
        from publisher: T,
        timeout: TimeInterval = 0.2,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Failure {
        var result: Result<T.Output, T.Failure>?
        let expectation = self.expectation(description: "Awaiting publisher completion")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        self.wait(for: [expectation], timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any failure",
            file: file,
            line: line
        )
        switch unwrappedResult {
        case .success:
            throw CombineTestCaseError.getSuccessWhenAwaitingFailure
        case .failure(let error):
            return error
        }
    }
}
