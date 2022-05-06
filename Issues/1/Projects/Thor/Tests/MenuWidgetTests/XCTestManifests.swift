import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(MenuWidgetTests.allTests),
    ]
}
#endif
