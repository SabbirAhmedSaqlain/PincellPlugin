//
//  PinCell.swift
//  PincellPlugin
//
//  Created by BS348 on 24/11/19.
//  Copyright © 2019 BS348. All rights reserved.
//

import Foundation
import UIKit

protocol PinCellDelegate {
    func optionClick(cell: PinCell)
}

class PinCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var pinShowingView: UIView!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    var pincode  = ""
    var showHide = true
    var delegate: PinCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        pinShowView()
        pinTextField.text = pincode
        pinTextField.keyboardType = .numberPad
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func pinFromCodeView(pin Pin: String) {
        self.pincode = Pin
    }
    func pinShowView(){
        showHideButton.setImage(UIImage(named: "hide"), for: .normal)
        pinShowingView.isHidden = false
        pinTextField.isHidden = true
        lineView.isHidden = true
        borderView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        borderView.layer.borderWidth = 2.0
        showHide = false
    }
    func pinHideView(){
        showHideButton.setImage(UIImage(named: "view"), for: .normal)
        pinShowingView.isHidden = true
        pinTextField.isHidden = false
        lineView.isHidden = false
        borderView.layer.borderWidth = 0.0
        showHide = true
    }
    
    @IBAction func showHidePressed(_ sender: Any) {
        
        if showHide  {
            pinShowView()
            
        }else {
            pinHideView()
        }
        self.delegate?.optionClick(cell: self)
    }
}

