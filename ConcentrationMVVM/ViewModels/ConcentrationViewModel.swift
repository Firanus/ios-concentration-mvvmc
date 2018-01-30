//
//  ConcentrationViewModel.swift
//  ConcentrationMVVM
//
//  Created by Ivan Tchernev on 25/01/2018.
//  Copyright © 2018 AND Digital. All rights reserved.
//

import Foundation

struct ConcentrationViewModel {
    let scoreLabel: String
    let cards: [CardViewModel]
    let displayNewGame: Bool
    let gameTheme: GameTheme
    let flipCardAtIndex: (Int) -> Void
    let startNewGame: () -> Void
}
