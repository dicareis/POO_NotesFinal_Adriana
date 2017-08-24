//
//  Add.swift
//  POO_Notes - Adriana Reis de Sa Oliveira
//
//  Created by eleves on 2017-08-01.
//  Copyright © 2017 GrassetSucre. All rights reserved.
//
//==================================
import Foundation
//==================================
class Add {
    //------------------------------------------------------------------------------------//
    var dictionnary: [String: Bool]!
    var keys: [String] = []
    var values: [Bool] = []
    var keysTrue: [String] = []
    let userDefault = UserDefaults.standard
    //-----------Constructeur------------------------------------------------------------//
    init() {
        if userDefault.object(forKey: "data") ==  nil {
            dictionnary = [:]
            userDefault.setValue(dictionnary, forKey: "data")
        } else {
            dictionnary = userDefault.object(forKey: "data") as! [String : Bool]!
            parseDict()
        }
    }
    //----------Methode pour batir les 'keys' et values du dictionnaire------------------//
    func parseDict() {
        keys = []
        values = []
        for (k, v) in dictionnary {
            keys.append(k)
            values.append(v)
        }
    }
    //----------Methode pour ajouter un element dans le dictionnaire---------------------//
    func addValue(keyToAdd: String) {
        dictionnary[keyToAdd] = false
        saveData()
    }
    //----------Methode pour enlever un element dans le dictionnaire---------------------//
    func removeValue(keyToRemove: String) {
        dictionnary[keyToRemove] = nil
        saveData()
    }
    //-----------Methode pour sauvegarder le dictionnaire dans le 'userDefault'----------//
    func saveData() {
        parseDict()
        userDefault.setValue(dictionnary, forKey: "data")
    }
    //-----------Methode pour vider le dictionnaire--------------------------------------//
    func removeALL () {
        dictionnary = [:]
        self.parseDict()
    }
    //-----------Methode pour ajouter les elements ('value' = true) dans l'arrayList-----//
    func arrayTrue () {
      
        for (k, v) in dictionnary {
            
            if v == true{
                keysTrue.append(k)
            }
        }
        saveData()
    }
    //-----------Methode pour convertir un 'value' a false------------------------------//
    func removeKeyTrue(_ keyToRemove: String, _ indexToRemove: Int){
        dictionnary[keyToRemove] = false
        keysTrue.remove(at: indexToRemove)
        saveData()
    }
    //==================================
}//fin de la class Add
//==================================
