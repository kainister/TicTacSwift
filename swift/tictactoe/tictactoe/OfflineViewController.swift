//
//  OfflineViewController.swift
//  tictactoe
//
//  Created by SUP'Internet 15 on 18/06/2019.
//  Copyright © 2019 SUP'Internet 15. All rights reserved.
//

import UIKit

class OfflineViewController: UIViewController {
    
    @IBOutlet weak var A1: UIButton!
    @IBOutlet weak var A2: UIButton!
    @IBOutlet weak var A3: UIButton!
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var C1: UIButton!
    @IBOutlet weak var C2: UIButton!
    @IBOutlet weak var C3: UIButton!
    @IBOutlet weak var PlayerTurn: UITextField!
    
    private var Player = "P1"
    var AreaPalyed = [Int:String]()
    private var WinCombinaison = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
    ]
    
    @IBAction func clicked(_ sender: UIButton) {
        play(sender)
        checkVictory()
    }
    
    
    func updatePlayer() {
        if (Player == "P1") {
            Player = "P2"
            PlayerTurn.text = "P2 Turn / Play O"
        } else if (Player == "P2") {
            Player = "P1"
            PlayerTurn.text = "P1 Turn / Play X"
        }
    }
    
    func play( _ area: UIButton ) {
        if (AreaPalyed[area.tag] != nil) {
            return
        } else {
            AreaPalyed[area.tag] = Player
        }
        
        if (Player == "P1") {
            area.setTitle("X", for: .normal)
        } else if (Player == "P2") {
            area.setTitle("O", for: .normal)
        }
        updatePlayer()
    }
    
    func checkVictory() {
        var P1Area = [Int]()
        var P2Area = [Int]()
        for (key, item) in AreaPalyed {
            if item == "P1" {
                P1Area.append(key)
            } else if item == "P2" {
                P2Area.append(key)
            }
        }

        for (key, _) in WinCombinaison.enumerated() {
            var win = 0
            var win2 = 0
            for (_, element2) in WinCombinaison[key].enumerated() {
                if (P1Area.contains(element2)) {
                    win += 1
                    print(win)
                    if win == 3 {
                        playerWin(player: "P1")
                        victoryLogs(player: "P1")
                        return
                    }
                } else if(P2Area.contains(element2)) {
                    win2 += 1
                    print(win2)
                    if win2 == 3 {
                        playerWin(player: "P2")
                        victoryLogs(player: "P2")
                        return
                    }
                }
            }
        }
        if AreaPalyed.count == 9 {
            let ud = UserDefaults.standard
            
            var victories = ud.array(forKey: "victories")
            
            if (victories == nil) {
                victories = []
            }
            
            victories?.append("d")
            
            ud.set(victories, forKey: "victories")
            
            popupResult(status: "DRAW")
        }
    }
    
    
    func playerWin(player: String) {
        let ud = UserDefaults.standard
        
        var victories = ud.array(forKey: "victories")
        
        if (victories == nil) {
            victories = []
        }
        
        victories?.append(player)
        
        ud.set(victories, forKey: "victories")
        popupResult(status: player + " VICTORY")
    }
    
    func victoryLogs(player: String) {
        UserDefaults.standard.set("", forKey: "P1_WIN")
    }

    func popupResult(status: String) {
        let alert = UIAlertController(title: "END GAME !", message: status, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
            self.AreaPalyed.removeAll()
            self.clearData()
        }))
        alert.addAction(UIAlertAction(title: "Quit", style: .cancel, handler: {action in
            self.reload()
        }))
        
        self.present(alert, animated: true)
    }
    
    func reload() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clearData() {
        A1.setTitle("-",for: .normal)
        A2.setTitle("-",for: .normal)
        A3.setTitle("-",for: .normal)
        B1.setTitle("-",for: .normal)
        B2.setTitle("-",for: .normal)
        B3.setTitle("-",for: .normal)
        C1.setTitle("-",for: .normal)
        C2.setTitle("-",for: .normal)
        C3.setTitle("-",for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
