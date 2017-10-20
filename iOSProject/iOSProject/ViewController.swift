//
//  ViewController.swift
//  iOSProject
//
//  Created by Ainur on 10/18/17.
//  Copyright © 2017 Ainur. All rights reserved.
//

import UIKit
import JSQMessagesViewController


struct User {
    let id: String
    let name: String
}

class ViewController: JSQMessagesViewController {
    let user1 = User(id: "1", name: "Name1")
    let user2 = User(id: "2", name: "Name2")
    
    
    var currentUser: User {
        return user1
    }
    var messages = [JSQMessage]()
}

extension ViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        messages.append(message!)
        
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUsername = message.senderDisplayName
        
        return NSAttributedString(string: messageUsername!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let message = messages[indexPath.row]
        
        if currentUser.id == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        
        
        self.messages = getMessages()
    }
}

extension ViewController {
    func getMessages() -> [JSQMessage] {
        var messages = [JSQMessage]()
        
        let message = JSQMessage(senderId: "2", displayName: "Name2", text: "Hi!")
        
        messages.append(message!)
        
        return messages
    }
}

