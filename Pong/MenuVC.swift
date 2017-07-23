//
//  MenuVC.swift
//  Pong
//
//  Created by Mehul Gupta on 7/22/17.
//  Copyright © 2017 Mehul Gupta. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Variable to keep track of user selected game mode
    var gameMode = gameType.easy
    
    @IBOutlet weak var gameModePickerView: UIPickerView!
    let gameModes = ["Easy" , "Medium", "Hard"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameModePickerView.dataSource = self
        gameModePickerView.delegate = self
    }
    
    // DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameModes.count
    }
    
    // Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = gameModes[row]
        //let gameModeTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "Georgia", size: 15.0)!, NSForegroundColorAttributeName: UIColor.white])
        
        return title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch gameModes[row] {
        case "Medium":
            gameMode = gameType.medium
            break
            
        case "Hard":
            gameMode = gameType.hard
            break
            
        default:
            gameMode = gameType.easy
        }
    }
    
    @IBAction func SinglePlayer(_ sender: UIButton) {
        moveToGame(game: gameMode)
        
    }
    
    @IBAction func Player2(_ sender: UIButton) {
        moveToGame(game: .player2)
    }
    
    
    
    func moveToGame(game: gameType){
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
