//
//  ViewController.swift
//  JewFeatures
//
//  Created by joaoGMPereira on 11/19/2019.
//  Copyright (c) 2019 joaoGMPereira. All rights reserved.
//

import UIKit
import JewFeatures

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let loadingView = LoadingView(frame: .zero)
               view.addSubview(loadingView)
               loadingView.setupConstraints(parent: view, top: 0, leading: 0, trailing: 0, useSafeLayout: true)
                loadingView.height = view.frame.height
               view.layoutIfNeeded()
               loadingView.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

