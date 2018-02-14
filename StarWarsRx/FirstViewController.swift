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
    
    var disposeBag = DisposeBag()
    private let apiClient = APIClient()

    @IBOutlet weak var tvstarwarspeople: UITableView!
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let re: Observable<SWResultsModel> = self.apiClient.send()
        
        re.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { r in
                let people:[SWPeopleModel] = r.results
                
                let swresultobs:Observable<[SWPeopleModel]> = Observable
                    .just(people)
                    .observeOn(MainScheduler.instance)
                
                self.tvstarwarspeople.estimatedRowHeight = 90
                
                swresultobs.bind(to: self.tvstarwarspeople.rx.items(cellIdentifier: "cell")) { index, person, cell in
                        if let cellToUse = cell as? TableViewCell{
                            cellToUse.lbname.text = person.name
                            //cellToUse.lbname.adjustsFontSizeToFitWidth = true
                        }
                    }
                    .disposed(by: self.disposeBag)
            
                },
                onError: { errors in
                    print(errors)
                }
            )

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

