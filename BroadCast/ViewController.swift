//
//  ViewController.swift
//  BroadCast
//
//  Created by FreeBird on 3/31/21.
//

import UIKit
import Network
class ViewController: UIViewController {

    @IBOutlet weak var resultTV: UITextView!
    @IBOutlet weak var msgTF: UITextField!
    var group:NWConnectionGroup?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let multicast = try? NWMulticastGroup(for:
            [ .hostPort(host: "224.0.0.251", port: 5353) ])
            else { fatalError("erorr") }
        group = NWConnectionGroup(with: multicast, using: .udp)
        
        group?.setReceiveHandler(maximumMessageSize: 16384, rejectOversizedMessages: true) { (message, content, isComplete) in
            print("Received message from \(String(describing: message.remoteEndpoint))")
            
           
            let sendContent = Data("ack".utf8)
            message.reply(content: sendContent)
            guard let data = content else {return}
            self.resultTV.text = String(data: data, encoding: .utf8)
        }
        
        group?.stateUpdateHandler = { (newState) in
            print("Group entered state \(String(describing: newState))")
        }
        group?.start(queue: .main)
    }

    @IBAction func sendMsg(_ sender: Any) {
        let msg:String = msgTF.text ?? "test msg"
        let groupSendContent = Data(msg.utf8)
        group?.send(content: groupSendContent) { (error) in
            print("Send complete with error \(String(describing: error))")
        }
    }
    
}

