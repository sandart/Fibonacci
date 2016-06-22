//
//  FibonacciViewController.swift
//  Fibonacci
//
//  Created by 沙畫 on 16/6/20.
//  Copyright © 2016年 art. All rights reserved.
//

import UIKit

class FibonacciViewController: UITableViewController {

    
    lazy var fibonacciSource = NSMutableArray()
    lazy var fibonacci = Fibonacci()
    var page : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        
        let header =  MJRefreshNormalHeader (refreshingTarget: self, refreshingAction: #selector(FibonacciViewController.loadNewData))
        header.autoChangeAlpha = true
        header.lastUpdatedTimeLabel!.hidden = true
        tableView!.header = header
        
        tableView!.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(FibonacciViewController.loadMoreData))
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
             self.fibonacciSource.addObjectsFromArray(self.fibonacci.loadData(1) as [AnyObject])
            print( self.fibonacciSource.count)
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }

    }
    
      // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fibonacciSource.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FibonacciViewCell.cellWithTableView(tableView)
        
        if fibonacciSource.count > 0 {
            cell.indexLabel.text = "第\(indexPath.row+1)项"
            cell.fibonacciValueLabel.text = "斐波那契数 - \(fibonacciSource[indexPath.row])"
        }


        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
     return UITableViewAutomaticDimension
    }

    
    
    func loadNewData(){
        fibonacciSource.removeAllObjects()
        page = 1
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.fibonacciSource.addObjectsFromArray(self.fibonacci.loadData(1) as [AnyObject])

            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView!.header.endRefreshing()
                self.tableView!.footer.endRefreshing()
            })
        }
        
    }
    
    func loadMoreData(){
        page += 1
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {

            self.fibonacciSource.addObjectsFromArray(self.fibonacci.loadData(self.page) as [AnyObject])
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView!.header.endRefreshing()
                self.tableView!.footer.endRefreshing()
            })
        }
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
