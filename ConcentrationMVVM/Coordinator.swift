//
//  Coordinator.swift
//  ConcentrationMVVM
//
//  Created by Ivan Tchernev on 25/01/2018.
//  Copyright © 2018 AND Digital. All rights reserved.
//

import Foundation

class Coordinator {
    
    let viewController: ViewController
    
    var game: Concentration!
    var gameTheme: GameTheme!
    
    init(_ viewController: ViewController) {
        self.viewController = viewController
        
        selectGameTheme()
        createNewGameUI()
    }
    
    private func createNewGameUI() {
        game = Concentration(numberOfCards: 12)
        updateView()
    }
    
    private func selectGameTheme() {
        let randomGameThemeInt = GameTheme.count.arc4random
        gameTheme = GameTheme(rawValue: randomGameThemeInt) ?? GameTheme.Halloween
        unusedEmojis = gameTheme.emojiChoices
    }
    
    private func startNewGame(){
        if(game.isGameComplete){
            selectGameTheme()
            createNewGameUI()
        }
    }
    
    private func flipCard(at index: Int) {
        game.chooseCard(at: index)
        updateView()
    }
    
    private func updateView() {
        var cards = [CardViewModel]()
        for card in game.cards {
            cards.append(CardViewModel(isMatched: card.isMatched, isFaceUp: card.isFaceUp, emoji: emoji(for: card)))
        }
        let appViewModel = ConcentrationViewModel(scoreLabel: "Score: \(game.score)",
            cards: cards,
            displayNewGame: game.isGameComplete,
            gameTheme: gameTheme,
            flipCardAtIndex: flipCard,
            startNewGame: startNewGame)
        
        viewController.update(appViewModel)
    }
    
    private var emoji = [Card:String]()
    private var unusedEmojis: String!
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil {
            let randomStringIndex = unusedEmojis.index(unusedEmojis.startIndex, offsetBy: unusedEmojis.count.arc4random)
            emoji[card] = String(unusedEmojis.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
