//
//  OnlineViewController.swift
//  tictactoe
//
//  Created by SUP'Internet 08 on 02/07/2019.
//  Copyright © 2019 SUP'Internet 15. All rights reserved.
//

import UIKit

class OnlineViewController: UIViewController {
    let socketManager = TTTSocketWrapper.shared
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socketManager.socket.on("join_game", callback: { (data, ack) in
                self.performSegue(withIdentifier: "segueBattleOnline", sender: data)
            })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playOnline(_ sender: Any) {
        if (username.text == "") {
            errorLabel.text = "Met ton pseudo stp"
            return
        } else {
            socketManager.socket.emit("join_queue", username.text!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueBattleOnline") {
            let data = sender as! [[String: Any]]
            let OnlineBattleViewController = segue.destination as! OnlineBattleViewController
            OnlineBattleViewController.playerO = data[0]["playerO"] as! String
            OnlineBattleViewController.playerX = data[0]["playerX"] as! String
            OnlineBattleViewController.currentTurn = data[0]["currentTurn"] as! String
            OnlineBattleViewController.grid = data[0]["grid"] as! [Any]
        }
        
    }

}
