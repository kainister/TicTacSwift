//
//  ViewController.swift
//  tictactoe
//
//  Created by SUP'Internet 15 on 18/06/2019.
//  Copyright © 2019 SUP'Internet 15. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    @IBOutlet weak var win: UITextField!
    @IBOutlet weak var lose: UITextField!
    @IBOutlet weak var draw: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ud = UserDefaults.standard
        let victories = ud.array(forKey: "victories") as? [String] ?? [String]()
        var p1Win = 0
        var p2Win = 0
        var pDraw = 0
        
        for win in victories {
            if win == "P1" {
                p1Win += 1
            } else if win == "P2" {
                p2Win += 1
            } else {
                pDraw += 1
            }
        }
        
        win.text = "Player 1 win : \(p1Win)"
        lose.text = "Player 1 lose : \(p2Win)"
        draw.text = "Draw : \(pDraw)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

