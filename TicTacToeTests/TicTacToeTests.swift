//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Carlos Fonseca on 28/09/2023.
//

@testable import TicTacToe
import XCTest

final class TicTacToeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    func test_Given_circle_played_all_first_horizontal_row_WHEN_checkVictory_called_THEN_circle_is_returned() {
        let board = Board()
        board.play(player: Player.circle, row: 0, col: 0)
        board.play(player: Player.circle, row: 0, col: 1)
        board.play(player: Player.circle, row: 0, col: 2)
        XCTAssertEqual(board.checkVictory(), Player.circle)
    }

    func test_GIVEN_board_game_where_circle_wins_WHEN_checkVictory_is_called_THEN_return_circle() {

        let initialBoard: [Player?] =
            [.circle, .cross, .circle,
             .cross, .circle, .cross,
             .circle, .cross, nil]

        let board = Board(boardData: initialBoard)
        XCTAssertEqual(board.checkVictory(), Player.circle)
    }

    func test_GIVEN_circle_played_all_of_column_1_WHEN_checkVictory_called_THEN_circle_is_returned() {
        let board = Board()
        board.play(player: Player.circle, row: 0, col: 1)
        board.play(player: Player.circle, row: 1, col: 1)
        board.play(player: Player.circle, row: 2, col: 1)
        XCTAssertEqual(board.checkVictory(), Player.circle)
    }

    func test_GIVEN_cross_played_the_top_left_diagonal_WHEN_checkVictory_is_called_THEN_cross_is_returned() {
        let board = Board()
        board.play(player: Player.cross, row: 0, col: 0)
        board.play(player: Player.cross, row: 1, col: 1)
        board.play(player: Player.cross, row: 2, col: 2)
        XCTAssertEqual(board.checkVictory(), Player.cross)
    }

    func test_GIVEN_empty_board_WHEN_checkVictory_is_called_THEN_return_nil() {
        let board = Board()
        XCTAssertEqual(board.checkVictory(), nil)
    }
}
