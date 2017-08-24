//
//  ViewController.swift
//  POO_Notes - Adriana Reis de Sa Oliveira
//
//  Created by eleves on 2017-07-20.
//  Copyright © 2017 GrassetSucre. All rights reserved.
//
//==================================
import UIKit
//==================================
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //--------------------------------------------------------------------------------------------------------------//
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var objAdd = Add()
    //let jsonManager = JsonManager(urlToJsonFile: "http://localhost/dashboard/programmationOO2_Adriana/json_php/data.json")
    //let jsonManagerSauvegarde = JsonManager(urlToJsonFile: "http://localhost/dashboard/programmationOO2_Adriana/json_php/add.php?json=[")
    let jsonManager = JsonManager(urlToJsonFile: "http://localhost/dashboard/geneau/poo2/data.json")
    let jsonManagerSauvegarde = JsonManager(urlToJsonFile: "http://localhost/dashboard/geneau/poo2/add.php?json=[")
    //---------------Methode predefinies du UIViewController---------------------------------------------------------//
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //---------------Methode predefinies du UIViewController---------------------------------------------------------//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //----------Methode pour determiner la quantite de lignes dans la tableView-------------------------------------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return objAdd.dictionnary.count
    }
    //----------Methode pour ajouter les informations de chaque ligne dans la tableView-----------------------------//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        cell.textLabel!.text = objAdd.keys[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //-----------Methode qui modifie l'arriere-plan des lignes selectionnees------------------------------------//
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if Array(objAdd.dictionnary.values)[indexPath.row] {
            cell.backgroundColor = UIColor(red: 0.125, green: 0.251, blue: 0.6, alpha: 1.0)
        }
    }
    //-----------Methode qui change les valeurs (true or false) quand on selectionne ou deselectionne sa ligne----//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.yellow
        if !Array(objAdd.dictionnary.values)[indexPath.row] {
            objAdd.dictionnary[Array(objAdd.dictionnary.keys)[indexPath.row]] = true
        } else {
            objAdd.dictionnary[Array(objAdd.dictionnary.keys)[indexPath.row]] = false
        }
        objAdd.saveData()
        tableView.reloadData()
    }
    //-----------Methode pour effacer une element de la tableView---------------------------------------------------//
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            objAdd.removeValue(keyToRemove: objAdd.keys[indexPath.row])
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //--------------- Bouton pour ajouter une note à la tableView -------------------------------------------------//
    @IBAction func ajouterNote(_ sender: UIButton) {
        
        if !(textField.text?.isEmpty)!{
            objAdd.addValue(keyToAdd: textField.text!)
            tableView.reloadData()
            textField.text?.removeAll()
            alerte("Note ajoutée !!")
        }
    }
    //--------------- Bouton qui appelle la methode pour sauvegarder les informations dans le fichier json ----------//
    @IBAction func sauvegarderServeur(_ sender: UIButton) {
        jsonManagerSauvegarde.sauvegardeJson(objAdd: objAdd)
        alerte("Données sauvegardées \n dans le serveur !!")
    }
    //--------------- Bouton qui montre des alertes pour confirmer le telechargement des notes sauvegardées---------//
    @IBAction func telechargerNotes(_ sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "Notes...", message: "Vous voulez vraiment importer vos notes du serveur?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { (action: UIAlertAction!) in
            self.telecharger()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Non", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    //--------------- Appele des autres methodes pour telecharger les notes sauvegardées sur le serveur ------------//
    func telecharger() {
        objAdd.removeALL()
        jsonManager.importJSON()
        jsonManager.parseJsonDict(objAdd: objAdd)
        objAdd.saveData()
        tableView.reloadData()
    }
    //----------------Bouton pour deselectionner les elements dans la liste----------------------------------------//
    @IBAction func deselectionner(_ sender: UIButton) {
        
        for i in 0 ..< objAdd.dictionnary.count    {
            if Array( objAdd.dictionnary.values)[i] {
                objAdd.dictionnary[Array( objAdd.dictionnary.keys)[i]] = false
            }
        }
        tableView.reloadData()
    }
    //----------------Methode pour faire des alertes au utilisateur------------------------------------------------//
    func alerte(_ theMessage: String) {
        let alertController = UIAlertController(title: "Notes...", message:
            theMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    //==================================
}//fin de la class
//==================================
