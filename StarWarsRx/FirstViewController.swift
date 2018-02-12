//
//  FirstViewController.swift
//  StarWarsRx
//
//  Created by Pepdevils on 09/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//


import UIKit
import RxSwift

struct AllPeople:Decodable {
    let allpeople: [String]
}

struct SWResult:Decodable {
    let results: [StarWarsPeople]
    let count: Int
    let next: String
    let previous: String?
    
}

struct StarWarsPeople:Decodable {
    let name:String
    let species:[String]
    let vehicles:[String]
    let gender:String
    let homeworld:String
    let skin_color:String
    
    /*
    init (json:[String:Any]){
        nome = json["name"] as? String ?? ""
        specie = json["species"] as?[String] ?? [""]
        numVeic = json["vehicles"] as? [String] ?? [""]
        
        genero = json["gender"] as? String ?? ""
        planeta = json["homeworld"] as? String ?? ""
        cor = json["skin_color"] as? String ?? ""
        listaCarros = json["vehicles"] as? [String] ?? [""]
    }
 */
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
    
            do {
                 //let starwarspeople = try JSONDecoder.decode([StarWarsPeople].self, from: data)
                
                let starwarspeople = try JSONDecoder().decode(SWResult.self, from: data)
                print(starwarspeople)
                /*
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                print(json)
                //let people = StarWarsPeople(json:json)
                let people = SWResult(json:json)
                let charcareter = people.results
                print(people)
                //print(charcareter )
                */
            } catch let jsonErr{
                print(jsonErr)
            }
            
            
            
        }.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

