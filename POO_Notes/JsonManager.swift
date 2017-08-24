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
    //------------------------------------------------------------------------------------------------------------------------------------//
    var jsonParsed:NSMutableDictionary = [:]
    var urlToJsonFile: String = ""
    //-------------Constructeur-----------------------------------------------------------------------------------------------------------//
     init(urlToJsonFile: String) {
        self.urlToJsonFile = urlToJsonFile
    }
    //-------------Methode pour recuperer les informations du fichier json----------------------------------------------------------------//
    func parser(_ jsonFilePath: String) -> NSMutableDictionary {
        let data = try! Data(contentsOf: URL(string: jsonFilePath)!)
        return try! JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
    }
    //-------------Methode pour reçoir les informations recuperees-----------------------------------------------------------------------//
    func importJSON() {
        self.jsonParsed = self.parser(self.urlToJsonFile)
    }
    //------------Methode pour convertir les informations recuperer dans le fichier json dans un dictionnaire, keys et values-----------//
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
    //--------------- Methode pour sauvegarder les notes sur le serveur ----------------------------------------------------------------//
    func sauvegardeJson (objAdd: Add) {
        var urlToSend = urlToJsonFile
        var counter = 0
        let total = objAdd.dictionnary.count
        for (a, b) in objAdd.dictionnary {
            let noSpaces = replaceChars(originalStr: a, what: " ", byWhat: "_")
            counter += 1
            if counter < total {
                urlToSend += "/\(noSpaces)/,/\(b)/!"
            } else {
                urlToSend += "/\(noSpaces)/,/\(b)/"
            }
        }
        urlToSend += "]"
        
        let session = URLSession.shared
        let urlString = urlToSend
        let url = NSURL(string: urlString)
        let request = NSURLRequest(url: url! as URL)
        let dataTask = session.dataTask(with: request as URLRequest) {
            (data:Data?, response:URLResponse?, error:Error?) -> Void in
        }
        dataTask.resume()
    }
    //----------------Methode pour remplacer un caractere pour un autre ---------------------------------------------------------------//
    func replaceChars(originalStr: String, what: String, byWhat: String) -> String {
        return originalStr.replacingOccurrences(of: what, with: byWhat)
    }
    //==================================
}//fin de la class
//==================================















