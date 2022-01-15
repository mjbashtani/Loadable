import XCTest
@testable import Loadable

final class LoadableTests: XCTestCase {
    func testPropertiesInIdleState() {
        let sut = makeSUT()
        XCTAssertNil(sut.value)
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testPropertiesInLoadingState() {
        var sut = makeSUT()
        sut = .isLoading
        XCTAssertNil(sut.value)
        XCTAssertNil(sut.error)
        XCTAssertTrue(sut.isLoading)
    }
    
    func testPropertiesInLoadedState() {
        var sut = makeSUT()
        sut = .loaded(.init())
        XCTAssertNotNil(sut.value)
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testPropertiesInFailedState() throws {
        var sut = makeSUT()
        let error = LoadableError()
        sut = .failed(error)
        XCTAssertNil(sut.value)
        XCTAssertFalse(sut.isLoading)
        let extractedError = try XCTUnwrap(sut.error as? LoadableError)
        XCTAssertEqual(extractedError.id, error.id)
        
    }
    
    private func makeSUT() -> Loadable<String> {
        .idle
    }
    
    private struct LoadableError: LocalizedError, Identifiable {
        let id: String = UUID().uuidString
    }
}
