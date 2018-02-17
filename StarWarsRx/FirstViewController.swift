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
        
        let re: Observable<SWResultsModel> = self.apiClient.getSWPeople()
        
        re.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { r in
                
                self.workSWdata(r: r)
                
                /*
                let people:[SWPeopleModel] = r.results
                
                let swresultobs:Observable<[SWPeopleModel]> = Observable
                    .just(people)
                    .observeOn(MainScheduler.instance)
 */
            
                },
                onError: { errors in
                    print(errors)
                }
            ).disposed(by: self.disposeBag)

    }
    
    func loadSWdata(){
        
    }
    
    func workSWdata(r:SWResultsModel){
        if(r.previous == nil){
            //first data
            print("first data")
            
            self.people.value = r.results
            
            /*
            
            let swresultobs:Observable<[SWPeopleModel?]> = Observable
                .just(self.people.value)
                .observeOn(MainScheduler.instance)
 */
            
            self.tvstarwarspeople.estimatedRowHeight = 90
            
            self.people.asObservable().bind(to: self.tvstarwarspeople.rx.items(cellIdentifier: "cell")) { index, person, cell in
                if let cellToUse = cell as? TableViewCell{
                    cellToUse.lbname.text = person!.name
                    //cellToUse.lbname.adjustsFontSizeToFitWidth = true
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
            print("more people to join")
            
            let reload: Observable<SWResultsModel> = self.apiClient.getSWPeople(urlString: r.next!)
            reload.asObservable().subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (response) in
                    let p = response.results as [SWPeopleModel?]
                    self.people.value += p
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
