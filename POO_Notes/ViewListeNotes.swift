//
//  ViewListeNotes.swift
//  POO_Notes - Adriana Reis de Sa Oliveira
//
//  Created by eleves on 2017-07-20.
//  Copyright © 2017 GrassetSucre. All rights reserved.
//
//==================================
import UIKit
//==================================
class ViewListeNotes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //---------------------
    var objAdd = Add()
    //---------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        objAdd.arrayTrue()
    }
    //---------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //----------Methode pour determiner la quantite de lignes dans la tableView-----------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return objAdd.keysTrue.count
    }
    //----------Methode pour ajouter les informations de chaque ligne dans la tableView-----------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        cell.textLabel!.text = objAdd.keysTrue[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //-----------Methode que selectionne les lignes----------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 0.125, green: 0.251, blue: 0.6, alpha: 1.0)
    }
    //----------Methode pour enlever la selections des objets-----------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            objAdd.removeKeyTrue(objAdd.keysTrue[indexPath.row], indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //---------------------
}//fin de la class
//==================================
