//
//  FirstViewController.swift
//  StarWarsRx
//
//  Created by Pepdevils on 09/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//


import UIKit
import RxSwift

/*
struct AllPeople:Decodable {
    let allpeople: [String]
}*/

struct SWResult:Decodable {
    let results: [StarWarsPeople]
    let count: Int
    let next: String
    let previous: String?
    
    /*
    
    init(count: Int, results: [StarWarsPeople],next:String, previous:String) {
        self.count = count
        self.results = results
        self.next = next
        self.previous = previous
    }*/
    
}

struct StarWarsPeople:Decodable {
    let name:String
    let species:[String]
    let vehicles:[String]
    let gender:String
    let homeworld:String
    let skin_color:String
    
}

class FirstViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    

    @IBOutlet weak var tvstarwarspeople: UITableView!
    
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for table config
        tvstarwarspeople.delegate = self
        tvstarwarspeople.dataSource = self
        
        let jsonString = "https://swapi.co/api/people/"
        guard let url = URL(string:jsonString) else {return}
        
        URLSession.shared.dataTask(with:url){
            (data,response,err) in
            guard let data = data else {return}
    
            do {
                
                let starwarspeople = try JSONDecoder().decode(SWResult.self, from: data)
                print(starwarspeople)
                

            } catch let jsonErr{
                print(jsonErr)
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return starwarspeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tvstarwarspeople.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      //  cell.textLabel?.text  = starwarspeople.results[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //clique para entrar na detail view
        
        
    }
    



}

