//
//  FirstViewController.swift
//  StarWarsRx
//
//  Created by Pepdevils on 09/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//


import UIKit
import RxSwift

struct SWResult:Decodable {
    let results: [String]?
    let count: Int?
    let next: String?
    let previous: String?
    
    init (json:[String:Any]){
        results = json["results"] as? [String] ?? [""]
        count = json["count"] as? Int ?? 0
        next = json["next"] as? String ?? ""
        previous = json["previous"] as? String ?? ""
    }
    
}

struct StarWarsPeople:Decodable {
    let nome:String?
    let specie:[String]?
    let numVeic:[String]?
    
    let genero:String?
    let planeta:String?
    let cor:String?
    let listaCarros:[String]?
    
    init (json:[String:Any]){
        nome = json["name"] as? String ?? ""
        specie = json["species"] as?[String] ?? [""]
        numVeic = json["vehicles"] as? [String] ?? [""]
        
        genero = json["gender"] as? String ?? ""
        planeta = json["homeworld"] as? String ?? ""
        cor = json["skin_color"] as? String ?? ""
        listaCarros = json["vehicles"] as? [String] ?? [""]
    }
}

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let jsonString = "https://swapi.co/api/people/1"
        let jsonString = "https://swapi.co/api/people/"
        guard let url = URL(string:jsonString) else {return}
        
        URLSession.shared.dataTask(with:url){
            (data,response,err) in
            guard let data = data else {return}
            let dataString = String(data: data,encoding: .utf8)
    
            
            do {
                // let starwarspeople = try JSONDecoder.decode([StarWarsPeople].self, from: data)
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                print(json)
                //let people = StarWarsPeople(json:json)
                let people = SWResult(json:json)
                let charcareter = people.results
                print(people)
                print(charcareter )
                
            } catch let jsonErr{
                print(jsonErr)
            }
            
            
            
        }.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

