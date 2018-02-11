//
//  FirstViewController.swift
//  StarWarsRx
//
//  Created by Pepdevils on 09/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//


import UIKit
import RxSwift

struct StarWarsPeople:Decodable {
    let nome:String
    let specie:String
    let numVeic:String
    
    let genero:String
    let planeta:String
    let cor:String
    let listaCarros:String
}

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonString = "https://swapi.co/api/people"
        guard let url = URL(string:jsonString) else {return}
        
        URLSession.shared.dataTask(with:url){
            (data,response,err) in
            guard let data = data else {return}
            let dataString = String(data: data,encoding: .utf8)
            print(dataString ?? "nada")
            
        }.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

