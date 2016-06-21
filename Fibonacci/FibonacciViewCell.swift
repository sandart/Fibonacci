//
//  FibonacciViewCell.swift
//  Fibonacci
//
//  Created by 沙畫 on 16/6/20.
//  Copyright © 2016年 art. All rights reserved.
//

import UIKit

class FibonacciViewCell: UITableViewCell {

    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var fibonacciValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
            self.indexLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 30;
            self.fibonacciValueLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 30;
    }
    

    class func cellWithTableView(tableView: UITableView) -> FibonacciViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FibonacciViewCell.identifier) as! FibonacciViewCell
        
        return cell
    }
    
    class var identifier:String {
        get{
            return "FibonacciCellIdentifier"
        }
    }

}
