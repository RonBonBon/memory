//
//  ViewController.swift
//  MemoryGame
//
//  Created by hackeru on 20 Elul 5777.
//  Copyright © 5777 com.arichafamily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let allImages = [#imageLiteral(resourceName: "animal1"), #imageLiteral(resourceName: "animal2"), #imageLiteral(resourceName: "animal3"), #imageLiteral(resourceName: "animal4"), #imageLiteral(resourceName: "animal5"), #imageLiteral(resourceName: "animal6")]

    var gameImages:[UIImage] = []

    func rand(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    @IBOutlet var cards: [UIButton]!

    var previousButton:UIButton?

    @IBAction func cardTapped(_ sender: UIButton) {
        sender.isEnabled = false
        if (previousButton == nil){
            previousButton = sender
        }else{
            if previousButton?.image(for: .disabled) == sender.image(for: .disabled){
                print("Good")
            }else{
                print("Bad")
                sender.isEnabled = true
                previousButton?.isEnabled = true
            }
            previousButton = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var gameSet:Set<UIImage> = []

        while gameSet.count < cards.count / 2 {
            gameSet.insert(allImages[rand(max: allImages.count)])
        }
        gameImages.append(contentsOf: gameSet)
        gameImages.append(contentsOf: gameSet)

        cards.sort { (_, _) -> Bool in
            return randBoolean()
        }

        for card in cards {
            let idx = rand(max: gameImages.count)
            card.setImage(gameImages.remove(at: idx), for: .disabled)
        }
    }

    func randBoolean() -> Bool {
        return rand(max: 2) == 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

