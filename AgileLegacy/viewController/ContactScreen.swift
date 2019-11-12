//
//  ContactScreen.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 27/10/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//

import UIKit
import MessageUI

class ContactScreen: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var tfObject: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tfObject.delegate = self
        tvContent.delegate = self
        
    }
    
    @IBAction func onSendEmail(_ sender: UIButton) {
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        
        picker.setToRecipients(["kevin.desmay+agilelegacy@gmail.com"])
        if let subjectText = tfObject.text {
            picker.setSubject(subjectText)
        }
        
        picker.setMessageBody(tvContent.text, isHTML: true)
        
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
            return
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    // MFMailComposeViewControllerDelegate

    // 1
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
         dismiss(animated: true, completion: nil)
    }

    // UITextFieldDelegate
        
    // 2
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
            
        return true
    }
        
    // UITextViewDelegate
        
    // 3
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        tvContent.text = textView.text
            
        if text == "\n" {
            textView.resignFirstResponder()
                
            return false
        }
            
        return true
    }
    
}
