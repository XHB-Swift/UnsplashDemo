//
//  HomePhotoNetwork.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/24.
//

import Foundation
import XHBFoundationSwiftLib

class HomePhotoNetwork {
    
    private var page = 1
    private var customCancellableSet: Set<XHBFoundationSwiftLib.AnyCancellable> = .init()
    
    func requestPhotoList(completion: @escaping ([Photo]) -> Void) {
        FutureObservable<Data, Error> { [weak self] promise in
            guard let strongSelf = self else { return }
            guard let request = API.list(page: strongSelf.page).toRequest else { return }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    promise(.success(data))
                } else if let error = error {
                    promise(.failure(error))
                }
            }.resume()
        }
        .decode(type: [Photo].self, decoder: JSONDecoder())
        .receive(on: DispatchScheduler.main)
        .sink(receiveValue: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.page += 1
            completion($0)
        },
              completion: {
            switch $0 {
            case .failure(let error):
                print("error = \(error)")
            case .finished:
                break
            }
        })
        .store(in: &customCancellableSet)
    }
}
