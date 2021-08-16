//
//  ViewController.swift
//  Muvi
//
//  Created by HasanEkmob on 19.07.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MuviService.shared.getTopRatedMovies { result in
            switch result {
            case .success(let msg):
                break
            case .failure(let err):
                break
            }
        }
    }
}

