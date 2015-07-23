//
//  LearnViewController.swift
//  Flashcards
//
//  Created by Tim on 22/07/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit
import RealmSwift

class LearnViewController: UIViewController {
    
    @IBOutlet weak var cardCV: UICollectionView!
    @IBOutlet weak var sectionCV: UICollectionView!
    
    private let kCardCellIdentifier = "CardCell"
    private let kSectionCellIdentifier = "SectionCell"
    
    private var cardData: List<Card>!
    private var sectionData: Results<Section>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sectionData = Realm().objects(Section)
        
        cardData = sectionData[0].cards
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LearnViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == cardCV {
            return cardData.count
        }
        
        return sectionData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == cardCV {
            return cellForCardView(indexPath)
        }
        
        return cellForSectionsView(indexPath)
        
    }
    
    private func cellForCardView(indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = cardCV.dequeueReusableCellWithReuseIdentifier(kCardCellIdentifier, forIndexPath: indexPath) as! LearnCollectionViewCell
        
        let random = Int(arc4random_uniform(3))
        
        if (random % 2) == 0 {
            cell.showEnglisch = false
        } else {
            cell.showEnglisch = true
        }
        
        cell.card = cardData[indexPath.row]
        
        return cell

    }

    private func cellForSectionsView(indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = sectionCV.dequeueReusableCellWithReuseIdentifier(kSectionCellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        let section = sectionData[indexPath.row]

        let cellLabel = cell.viewWithTag(1000) as! UILabel
        cellLabel.text = section.name
        
        return cell
        
    }

}

extension LearnViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if collectionView != sectionCV {
            return
        }
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        if let cellTitle = cell?.viewWithTag(1000) as? UILabel {
            cellTitle.textColor = UIColor.redColor()
        }

        let selectedSection = sectionData[indexPath.row]
        
        cardData = selectedSection.cards
        
        self.cardCV.reloadData()
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        if collectionView != sectionCV {
            return
        }
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        if let cellTitle = cell?.viewWithTag(1000) as? UILabel {
            cellTitle.textColor = UIColor.blackColor()
        }
        
    }
    
}