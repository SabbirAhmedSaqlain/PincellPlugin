//
//  ViewController.swift
//  PincellPlugin
//
//  Created by BS348 on 24/11/19.
//  Copyright © 2019 BS348. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pinCode      = ""
    let passcode = Passcode()
    let pincode  = PinCell()
    var pincodeLength = 6
    
    @IBOutlet weak var pinTable: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinTable.delegate = self
        pinTable.dataSource = self
        pinTable.register(UINib(nibName: "PinCell", bundle: Bundle.main), forCellReuseIdentifier: "PinCell")
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.view.endEditing(true)
        print("Your Pincode: \(pinCode)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell") as? PinCell else {
            return UITableViewCell.init()
        }
        cell.selectionStyle = .none
        passcode.frame = CGRect(x: 65, y: 10, width: 200, height: 44)
        passcode.didEnterCode = {code in
            
            if   code != "" {
                self.pinCode = code
               // print(code)
            }
        }
        cell.delegate = self
        cell.pinTextField.delegate = self
        cell.pinTextField.tag = indexPath.row
        cell.pinTextField.text = self.pinCode
        cell.pinShowingView.addSubview(passcode)
        cell.pinTextField.textAlignment = .center
        cell.pinTextField.textColor = .red
        return cell
    }
}


extension ViewController: PinCellDelegate, UITextFieldDelegate {
    func optionClick(cell: PinCell) {
        pincode.pinFromCodeView(pin: pinCode)
        pinTable.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        pinCode = textField.text ?? ""
        passcode.pinFromField(pin: pinCode)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= pincodeLength
    }
    
    
    
}

