//  iOSProject
 //
 //  Created by Ainur on 18/10/17.
 //  Copyright © 2017 Ainur. All rights reserved.

import UIKit
import Firebase
class ViewController: UIViewController {
    

    @IBOutlet weak var nameField: UITextField!
   // @IBOutlet weak var bottomLayoutGuideConstraint: NSLayoutConstraint!
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func loginDidTouch(_ sender: Any) {
        if nameField?.text != "" {
            Auth.auth().signInAnonymously(completion: { (user, error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "LoginToChat", sender: nil) 
            })
        }
        else{
            print("no name")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let channelVc = segue.destination as! ChannelListViewController 
        channelVc.senderDisplayName = nameField?.text
    }
    
}

