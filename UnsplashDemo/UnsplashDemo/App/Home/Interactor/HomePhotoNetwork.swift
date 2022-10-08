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
        guard let apiObserver = URLSession.shared.apiObservation(.list(page: self.page, per_page: 10))
        else { return }
        apiObserver
            .map({ $0.data })
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
