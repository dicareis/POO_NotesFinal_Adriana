//
//  ViewController.swift
//  POO_Notes - Adriana Reis de Sa Oliveira
//
//  Created by eleves on 2017-07-20.
//  Copyright © 2017 GrassetSucre. All rights reserved.
//
//==================================
import Foundation
//==================================
class JsonManager
{
    //---------------------
    var jsonParsed:NSMutableDictionary = [:]
    var urlToJsonFile: String = ""
    //---------------------
     init(urlToJsonFile: String)
    {
        self.urlToJsonFile = urlToJsonFile
    }
    //---------------------
    func parser(_ jsonFilePath: String) -> NSMutableDictionary
    {
        let data = try! Data(contentsOf: URL(string: jsonFilePath)!)
        return try! JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
    }
    //---------------------
    func importJSON()
    {
        self.jsonParsed = self.parser(self.urlToJsonFile)
    }
    
    //------------Methode pour convertir les informations recuperer dans le fichier json dans un dictionnaire---------
    func parseJsonDict(objAdd: Add) {
        
        var x : String
        objAdd.keys = []
        objAdd.values = []
        
        for (k, v) in self.jsonParsed {
            objAdd.keys.append(k as! String)
            x = v as! String
            
            if x == "false"{
                objAdd.values.append(false)
            }
            else {
                objAdd.values.append(true)
            }
        }
        
        for i in 0 ..< objAdd.keys.count{
            objAdd.dictionnary[objAdd.keys[i]] = objAdd.values[i]
        }
    }
}//fin de la class
//==================================















