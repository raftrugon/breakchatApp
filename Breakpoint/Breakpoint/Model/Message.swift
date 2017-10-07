//
//  Message.swift
//  Breakpoint
//
//  Created by rafa on 26/8/17.
//  Copyright © 2017 rafa trujillo. All rights reserved.
//

import Foundation

class Message {
    
    private var  _content: String
    private var  _senderId: String
    
    var content: String{
        return _content
    }
    var senderId: String{
        return _senderId
    }
    
    init(content: String, senderId: String) {
        self._senderId = senderId
        self._content = content
    }
}
