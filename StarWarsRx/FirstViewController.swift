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

class FirstViewController: UIViewController {
    
    var people:Variable
    <[SWPeopleModel?]>=Variable([])
    
    var disposeBag = DisposeBag()
    private let apiClient = APIClient()

    @IBOutlet weak var tvstarwarspeople: UITableView!
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table
        self.tvstarwarspeople.layer.cornerRadius = 10
        //self.tvstarwarspeople.layer.masksToBounds = true
        
        let re: Observable<SWResultsModel> = self.apiClient.getSWPeople()
        
        re.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { r in
                self.workSWdata(r: r)
                },
                onError: { errors in
                    print(errors)
                }
            ).disposed(by: self.disposeBag)

    }
    
    
    func workSWdata(r:SWResultsModel){
        if(r.previous == nil){
            //first data
            self.people.value = r.results
            self.tvstarwarspeople.estimatedRowHeight = 400
            self.people.asObservable().bind(to: self.tvstarwarspeople.rx.items(cellIdentifier: "cell")) { index, person, cell in
                if let cellToUse = cell as? TableViewCell{
                    cellToUse.lbname.text = person!.name
                    //cellToUse.lbname.adjustsFontSizeToFitWidth = true
                    cellToUse.lbveic.text = String(person!.vehicles.count)
                    cellToUse.lbcolor.text = person!.skin_color
                    cellToUse.lbcolor.backgroundColor  = UIColor.red

                    cellToUse.lbgender.text = person!.gender
                    cellToUse.lbworld.text = person!.homeworld
                    cellToUse.lbspecies.text = person!.species[0]
                    }
                }
                .disposed(by: self.disposeBag)
            
            processrepeat(r: r)
            
        }else{
             processrepeat(r: r)
        }
    }
    
    func processrepeat(r:SWResultsModel){
        if(r.next != nil){
            //more people to join starwars
            
            let reload: Observable<SWResultsModel> = self.apiClient.getSWPeople(urlString: r.next!)
            reload.asObservable().subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (response) in
                    let p = response.results as [SWPeopleModel?]
                    self.people.value += p
                    if(response.next != nil) {
                        self.workSWdata(r: response)
                    }
                }, onError: { (error) in
                    print(error)
                })
            .disposed(by: self.disposeBag)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
