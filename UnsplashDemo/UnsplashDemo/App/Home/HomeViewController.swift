//
//  HomeViewController.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit
import XHBFoundationSwiftLib

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        setupSubviews()
        
        FutureObservable<Data, Error> { promise in
            guard let request = API.list().toRequest else { return }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    print("data = \(String(data: data, encoding: .utf8).printedString)")
                    promise(.success(data))
                } else if let error = error {
                    promise(.failure(error))
                }
            }.resume()
        }
        .decode(type: Photo.self, decoder: JSONDecoder())
        .receive(on: DispatchScheduler.main)
        .sink(receiveValue: {
            print("photo = \($0)")
        },
              completion: {
            print("error = \($0)")
        })
        .store(in: &customCancellableSet)
    }
    
    func setupSubviews() {
        
    }
}
