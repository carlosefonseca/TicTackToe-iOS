//
//  ContentView.swift
//  TicTacToe
//
//  Created by Carlos Fonseca on 28/09/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var model = Board()

    var body: some View {
        VStack {
            Spacer()
            Text(model.gameStatus)

            Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0 ... 2, id: \.self) { row in
                    GridRow {
                        ForEach(0 ... 2, id: \.self) { col in
                            HStack(spacing: 0) {
                                ExtractedView(model: model, row: row, col: col)
                                if col < 2 {
                                    Rectangle().frame(width: 2)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 130).contentShape(Rectangle())
                    .font(.largeTitle)
                    if row < 2 {
                        Rectangle().frame(height: 2)
                    }

                }
            }
            Spacer()
        }
        .padding()
        .background {
            if model.isVictory {
                model.currentPlay.color.opacity(0.5)
            } else {
                Color.clear
            }
        }.ignoresSafeArea()

    }
}

#Preview {
    ContentView(model: Board(boardData: [.circle, .cross, nil, nil, nil, nil, nil, nil, nil]))
}

struct ExtractedView: View {
    init(model: Board, row: Int, col: Int) {
        self.model = model
        self.row = row
        self.col = col
        self.cell = model.cell(row: row, col: col)
    }

    let model: Board
    let row: Int
    let col: Int
    let cell: Cell

    var body: some View {
        Button(action: {
            model.play(row: row, col: col)
        }, label: {
            Text(cell.text ?? "")
                .foregroundStyle(.regularMaterial)
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Rectangle().foregroundColor(cell.color)
                )
        }).disabled(cell.value != nil && model.isVictory == false)
    }
}
