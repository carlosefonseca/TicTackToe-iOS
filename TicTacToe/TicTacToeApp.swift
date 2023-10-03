//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Carlos Fonseca on 28/09/2023.
//

import SwiftData
import SwiftUI

@main
struct TicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

enum Player: Int, Codable {
    case cross = 0
    case circle = 1

    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .cross
        case 1: self = .circle
        default: fatalError("Trying to initialize Player with value \(rawValue) is unsupported!")
        }
    }

    var color: Color {
        switch self {
        case .circle: Color.red
        case .cross: Color.green
        }
    }
}

@Observable
public class Board {
    enum Constants {
        static let rows = 3
        static let size = rows * rows

        static let victoryLines: [[[Int]]] = {
            var lines = [[[Int]]]()

            // Horizontals
            for row in 0 ..< rows {
                lines.append(Array(0 ..< rows).map { [row, $0] })
            }

            // Verticals
            for col in 0 ..< rows {
                lines.append(Array(0 ..< rows).map { [$0, col] })
            }

            // Diagonals
            lines.append(Array(0 ..< rows).map { [$0, $0] })
            lines.append(Array(0 ..< rows).map { [$0, rows - 1 - $0] })

            return lines
        }()
    }

    @Transient
    var boardData: [Player?] = Array(repeating: nil, count: Constants.size)

//    var boardRawData = [Int?](repeating: nil, count: Constants.size)

    var gameStatus = "Hello!"
    var isVictory = false

    @Transient
    var currentPlay = Player.cross

    init(boardData: [Player?] = Array(repeating: nil, count: Constants.size)) {
        self.boardData = boardData
//        self.boardRawData = boardData
//        self.boardData = boardRawData.map {
//            guard let i = $0 else { return nil }
//            return Player(rawValue: i)
//        }
    }

    func board(row: Int, col: Int) -> Player? {
        let index = row * 3 + col
        assert(index < Constants.size)
        return boardData[index]
    }

    func setBoard(row: Int, col: Int, newValue: Player) {
        let index = row * 3 + col
        assert(index < Constants.size)
        boardData[index] = newValue
    }

    /// Record a play from a player in a specified row and column.
    /// Values for row and column are [0,1,2]
    func play(player: Player, row: Int, col: Int) {
        self.setBoard(row: row, col: col, newValue: player)
    }

    func play(row: Int, col: Int) {
        guard !isVictory else {
            reset()
            return
        }
        guard self.board(row: row, col: col) == nil else {
            return
        }
        self.setBoard(row: row, col: col, newValue: currentPlay)
        let victor = checkVictory()
        if victor != nil {
            gameStatus = "Victory for \(victor == .circle ? "Circle" : "Cross")!"
            isVictory = true
        } else {
            currentPlay = currentPlay == .cross ? .circle : .cross
            gameStatus = "It's \(currentPlay == .circle ? "Circle" : "Cross")'s turn…"
        }
    }

    func reset() {
        isVictory = false
        boardData = Array(repeating: nil, count: Constants.size)
        gameStatus = "Hello! It's \(currentPlay == .circle ? "Circle" : "Cross")'s turn…"
        currentPlay = Player.cross
    }

    func status(row: Int, col: Int) -> String {
        let cell = board(row: row, col: col)
        switch cell {
        case .circle: return "O"
        case .cross: return "X"
        default: return " "
        }
    }

    func cell(row: Int, col: Int) -> Cell {
        Cell(value: board(row: row, col: col))
    }

    func checkVictory() -> Player? {
        for line in Constants.victoryLines {
            var values = line.map { coords in
                let (row, col) = (coords[0], coords[1])
                return board(row: row, col: col)
            }
            let startingPlayer = values.removeFirst()

            guard startingPlayer != nil,
                  values.allSatisfy({ cell in startingPlayer == cell })
            else { continue }

            return startingPlayer
        }

        return nil
    }
}

struct Cell {
    init(value: Player? = nil) {
        self.value = value
        self.text = value.flatMap { value in
            switch value {
            case .circle: return "O"
            case .cross: return "X"
            }
        }
        self.color = value.map(\.color) ?? Color.clear
    }

    var value: Player?
    var text: String?
    var color: Color
}
