//
//  ViewController.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 10/21/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    var images = ["Top", "Pant"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.MyCollectionView.delegate = self
        self.MyCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! MyCollectionViewCell
        // Set images
        cell.myImageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
}

