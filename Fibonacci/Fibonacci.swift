//
//  Fibonacci.swift
//  Fibonacci
//
//  Created by 沙畫 on 16/6/20.
//  Copyright © 2016年 art. All rights reserved.
//

import UIKit


class Fibonacci: NSObject {

    ///Fibonacci数列
    private lazy var fibonacciQueen = [Int]()
    private lazy var fibonacci = Array<String>.init(count: 15, repeatedValue: "0")

    var result : Int = 0
    var number : Int = 0
    var pageNumber : Int = 1
    
    func  loadData(pageNo : Int) -> [String]  {
        
        pageNumber = pageNo

        for i in 0..<fibonacci.count{
            fibonacci[i] = fibonacciIteration(i)
        }
        
        return fibonacci
    }

    func fibonacciIteration( n : Int)  -> String        //迭代实现
    {
        var c : String = "0";
        if(n<=1)
        {
            if pageNumber <= 1 {
               return n == 0 ? "1" : "1";
            }
            else{
                let result = add(fibonacci[ ((fibonacci.count - 2)+n) % fibonacci.count ] ,str2: fibonacci[ ((fibonacci.count - 1)+n) % fibonacci.count ] )
                return result

            }
        }
        else{
            c = add(fibonacci[n-1] ,str2: fibonacci[n-2] )
        }
        return c;
    }
    
    
    
    func add( str1:String,  str2 : String) -> String
    {

        var aString = str1
        var bString = str2
        var resultString  = ""
        
        let  len_str1 = aString.characters.count;
        let  len_str2 = bString.characters.count;
        let  n = abs(len_str1-len_str2);

        if(len_str1 < len_str2){
            for _ in 0..<n {
                aString = "0" + aString
            }
        }
        else{
            for _ in 0..<n {
                bString = "0" + bString
            }
        }

        let aStringChars = aString.characters.reverse()
        let bStringChars = bString.characters.reverse()
        
        var carryNumber : Int = 0
        
        for index in aStringChars.indices
        {
            var temp = Int(String(aStringChars[index]))! - Int(0) + Int( String(bStringChars[index]))! - Int(0) + carryNumber
            carryNumber = temp/10;
            temp = temp%10;
            resultString = String(temp + 0)  + resultString;
        }
        
        if carryNumber != 0 {resultString =  String(carryNumber + 0) + resultString;}

        return resultString as String;
    }

}
