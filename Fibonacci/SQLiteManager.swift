//
//  SQLiteManager.swift
//  FMDB
//
//  Created by 沙畫 on 16/4/24.
//  Copyright © 2016年 art. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {

    var dbQueue : FMDatabaseQueue!
    private static let manager : SQLiteManager = SQLiteManager()
    class func shareManager() -> SQLiteManager {
        return manager
    }
    
    func openDatabase(databaseName : String)  {
        let  path = databaseName.docDir()
//        print("\(path)")
        // FMDatabaseQueue(path: ) 内部已经调用open方法
        // 所以不要再次调用
        dbQueue = FMDatabaseQueue(path: path)
        createTable()
    }
    

    
    private func createTable(){
        let sql = "CREATE TABLE IF NOT EXISTS T_Person( \n" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
        "name TEXT, \n" +
        "age INTEGER \n" +
        ");\n"

        dbQueue.inDatabase { (db) in
            if  db.executeUpdate(sql, withArgumentsInArray: nil) {
                print("创建成功")
            }
            else{
                print("创建失败")
            }
        }

    }
    
    
    
}
