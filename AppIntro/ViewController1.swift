//
//  ViewController1.swift
//  AppIntro
//
//  Created by Shantaram Kokate on 11/14/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var tutorial:Tutorial?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     init(item: Tutorial) {
        super.init(nibName: "ViewController1", bundle: nil)
        tutorial = item
        self.setData(item: item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(item: Tutorial) {
      //  self.item = item
        if self.titleLabel != nil {
            self.titleLabel.text = item.title!
            self.descriptionLabel.text = item.description!
            self.pictureView.image = item.picture!
        }
     
    }
  
}
