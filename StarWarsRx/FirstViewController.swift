//
//  FirstViewController.swift
//  StarWarsRx
//
//  Created by Pepdevils on 09/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

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
    
}

class FirstViewController: UIViewController   /*, UITableViewDelegate , UITableViewDataSource*/{
    
    var disposeBag = DisposeBag()

    @IBOutlet weak var tvstarwarspeople: UITableView!
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for table config
        /*
        tvstarwarspeople.delegate = self
        tvstarwarspeople.dataSource = self
        */
        let jsonString = "https://swapi.co/api/people/"
        guard let url = URL(string:jsonString) else {return}
        
        URLSession.shared.dataTask(with:url){
            (data,response,err) in
            guard let data = data else {return}
    
            do {
                //https://stackoverflow.com/questions/46545461/rxswift-in-swift-4-binding-data-to-a-tableview
                
                //self.tvstarwarspeople.estimatedRowHeight = 90
                
                let starwarspeople:SWResult = try JSONDecoder().decode(SWResult.self, from: data)
                print(starwarspeople)
                
                let people:[StarWarsPeople] = starwarspeople.results
                
                let swresultobs:Observable<[StarWarsPeople]> = Observable.just(people).observeOn(MainScheduler.instance)
                swresultobs.observeOn(MainScheduler.instance).bind(to: self.tvstarwarspeople.rx.items(cellIdentifier: "cell")) {
                    _, person, cell in
                    
                    if let cellToUse = cell as? TableViewCell{
                        cellToUse.lbname.text = person.name

                    }
                    
                    }.disposed(by: self.disposeBag)
                
            self.tvstarwarspeople.rx.modelSelected(StarWarsPeople.self).subscribe(onNext:{
                    person in
                    print(person.name)
                }).disposed(by: self.disposeBag)
                

            } catch let jsonErr{
                print(jsonErr)
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

