//
//  OnlineBattleViewController.swift
//  tictactoe
//
//  Created by SUP'Internet 13 on 05/07/2019.
//  Copyright © 2019 SUP'Internet 15. All rights reserved.
//

import UIKit

class OnlineBattleViewController: UIViewController {
    let socketManager = TTTSocketWrapper.shared

    @IBOutlet weak var PlayerNameX: UILabel!
    @IBOutlet weak var PlayerNameO: UILabel!
    @IBOutlet weak var PlayerTurn: UILabel!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    
    var playerX = ""
    var playerO = ""
    var currentTurn = ""
    var grid = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.PlayerNameO.text = self.playerO + " play O"
        self.PlayerNameX.text = self.playerX + " play X"
        self.PlayerTurn.text = "Player " + self.currentTurn + " turn"
        
        var board = [
            self.btn0,
            self.btn1,
            self.btn2,
            self.btn3,
            self.btn4,
            self.btn5,
            self.btn6,
            self.btn7,
            self.btn8
        ]
        
        socketManager.socket.on("movement", callback: { (data, ack) in
            let newdata = data as! [[String: Any]]
            print(newdata)
            if (newdata[0]["err"] is String) {
                let alert = UIAlertController(title: "Error", message: "Is not your turn. Please wait", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true)
            } else {
                self.currentTurn = newdata[0]["player_play"] as! String
                self.PlayerTurn.text = "Player " + self.currentTurn + " turn"
                
                let index = newdata[0]["index"] as! Int
                self.grid[index] = newdata[0]["player_played"] as! String
                board[index]?.setTitle(newdata[0]["player_played"] as? String, for: .normal)
                
                if (newdata[0]["win"] as! Bool) {
                    self.playerWin(playerWinner: newdata[0]["player_played"] as! String)
                }
                if self.grid.contains(where: { type(of: $0) == Int.self }) {
                    self.draw()
                }
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func play( _ area: UIButton ) {
        if (grid[area.tag] is Int) {
            grid[area.tag] = currentTurn
            socketManager.socket.emit("movement", area.tag)
        } else {
            return
        }
    }
    
    func playerWin(playerWinner:String) {
        var winnerName = ""
        
        if (playerWinner == "o") {
            winnerName = self.playerO
        } else if (playerWinner == "x") {
            winnerName = self.playerX
        }
        let alert = UIAlertController(title: "END GAME !", message: "Player " + playerWinner + " win (" + winnerName + ")" , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Quit", style: .cancel, handler: {action in
            self.reload()
        }))
        
        self.present(alert, animated: true)
    }
    
    func draw() {
        let alert = UIAlertController(title: "END GAME !", message: "It's a draw !!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Quit", style: .cancel, handler: {action in
            self.reload()
        }))
        self.present(alert, animated: true)
    }
    
    func reload() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clicked(_ sender: UIButton) {
        play(sender)
    }
}
