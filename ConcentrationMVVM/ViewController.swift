//
//  ViewController.swift
//  ConcentrationMVVM
//
//  Created by Ivan Tchernev on 25/01/2018.
//  Copyright © 2018 AND Digital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    var coordinator: Coordinator!
    var flipCardAtIndex: ((Int) -> Void)! //is making this implicitly unwrapped dangerous?
    var startNewGame: (() -> Void)!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let indexOfChosenCard = cardButtons.index(of: sender) {
            flipCardAtIndex(indexOfChosenCard)
        } else {
            assertionFailure("Chosen card not in cardButtons Array")
        }
    }
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        startNewGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator = Coordinator(self)
    }
    
    func update(_ viewModel: ConcentrationViewModel){
        flipCardAtIndex = viewModel.flipCardAtIndex
        startNewGame = viewModel.startNewGame
        
        self.view.backgroundColor = viewModel.gameTheme.secondaryColor
        scoreLabel.text = viewModel.scoreLabel
        scoreLabel.textColor = viewModel.gameTheme.primaryColor
        newGameLabel.textColor = viewModel.gameTheme.primaryColor
        newGameButton.backgroundColor = viewModel.gameTheme.primaryColor
        newGameButton.setTitleColor(viewModel.gameTheme.secondaryColor, for: UIControlState.normal)
        
        if viewModel.displayNewGame {
            newGameLabel.text = "Well done! Care to try again?"
            newGameButton.setTitle("New Game", for: UIControlState.normal)
            newGameButton.backgroundColor = viewModel.gameTheme.primaryColor
        } else {
            newGameLabel.text = ""
            newGameButton.setTitle("", for: UIControlState.normal)
            newGameButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
        
        for (index,card) in viewModel.cards.enumerated() {
            if(index < cardButtons.count){
                if card.isMatched {
                    cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    cardButtons[index].setTitle("", for: UIControlState.normal)
                } else if card.isFaceUp {
                    cardButtons[index].backgroundColor = UIColor.white
                    cardButtons[index].setTitle(card.emoji, for: UIControlState.normal)
                } else {
                    cardButtons[index].backgroundColor = viewModel.gameTheme.primaryColor
                    cardButtons[index].setTitle("", for: UIControlState.normal)
                }
            } else {
                assertionFailure("More cards have been created than the view can support")
            }
            
        }
    }

}

