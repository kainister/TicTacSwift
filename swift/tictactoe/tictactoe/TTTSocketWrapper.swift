//
//  TTTSocketWrapper.swift
//  tictactoe
//
//  Created by SUP'Internet 09 on 26/06/2019.
//  Copyright © 2019 SUP'Internet 15. All rights reserved.
//

import Foundation
import SocketIO

class TTTSocketWrapper {
    
    static let shared = TTTSocketWrapper()
    
    var manager:SocketManager
    var socket:SocketIOClient
    
    init() {
        self.manager = SocketManager(socketURL: URL(string: "http://51.254.112.146:5666")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
    }
    
    func connect() {
        self.socket.connect()
    }
    
    func disconnect() {
        self.socket.disconnect()
    }
}

