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
    
    var items = ["Top", "Pant"]
    //var items = [Items]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.MyCollectionView.delegate = self
        self.MyCollectionView.dataSource = self
        
        //loadSampleItems()
    }
    
    //private func loadSampleMeals() {
        
        //let photo1 = UIImage(named: "Top")
        //let photo2 = UIImage(named: "Pant")
        
        //guard let item1 = Items(name: "Hoodies", detail: "A gift from a friend!",photo: photo1) else {
         //   fatalError("Unable to instantiate meal1")
       // }
        
       // guard let item2 = Items(name: "Jean", detail: "Love it!", photo: photo2) else {
        //    fatalError("Unable to instantiate meal2")
       // }
        
       // items += [item1, item2]
    //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! MyCollectionViewCell
        // Set images
        cell.myImageView.image = UIImage(named: items[indexPath.row])
        return cell
    }
}

