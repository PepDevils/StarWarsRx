//
//  ApiClient.swift
//  StarWarsRx
//
//  Created by Pepdevils on 14/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//

import Foundation
import RxSwift

class APIClient {
    
    private let baseURL = URL(string: "https://swapi.co/api/people/")!
    //baseURL:URL = URL(string: "https://swapi.co/api/people/")!
  
    func getSWPeople<SWResultsModel: Decodable>() -> Observable<SWResultsModel> {
        return Observable<SWResultsModel>.create { [unowned self] observer in
            let task = URLSession.shared.dataTask(with: self.baseURL) { (data, response, error) in
                guard let data = data else {return}
                do {
                    let model: SWResultsModel = try JSONDecoder().decode(SWResultsModel.self, from: data)
                    observer.onNext(model)
                 
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func getSWPeople<SWResultsModel: Decodable>(urlString:String) -> Observable<SWResultsModel> {
        
        let url = URL(string: urlString)!
        
        return Observable<SWResultsModel>.create { observer in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                do {
                    let model: SWResultsModel = try JSONDecoder().decode(SWResultsModel.self, from: data)
                    observer.onNext(model)
                    
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
