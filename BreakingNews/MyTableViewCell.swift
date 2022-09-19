//
//  MyTableViewCell.swift
//  BreakingNews
//
//  Created by Mayank Yadav on 19/07/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    //static let identifier = "MyTableViewCell"
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    
    
    
    func configureCell( lb1: String, lb2: String) {
    
        self.lb1.text = lb1
        self.lb2.text = lb2
    }
   
    
}
