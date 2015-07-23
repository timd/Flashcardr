//
//  LearnCollectionViewCell.swift
//  Flashcards
//
//  Created by Tim on 22/07/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class LearnCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainGeschlecht: UILabel!
    @IBOutlet weak var mainAntwort: UILabel!
    @IBOutlet weak var antwortGeschlect: UILabel!
    @IBOutlet weak var antwortWort: UILabel!
    
    var showEnglisch: Bool = false
    
    var card: Card? {
        didSet {
            updateUI()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    override func prepareForReuse() {
        mainGeschlecht.text = ""
        mainAntwort.text = ""
        antwortGeschlect.text = ""
        antwortWort.text = ""
        
        antwortGeschlect.hidden = true
        antwortWort.hidden = true
    }
    
    func didTapInCell() {
        antwortGeschlect.hidden = false
        antwortWort.hidden = false
    }
    
    func updateUI() {

        let doubleTap = UITapGestureRecognizer(target: self, action: "didTapInCell")
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        self.contentView.addGestureRecognizer(doubleTap)
        
        if showEnglisch {
            mainGeschlecht.text = ""
            mainAntwort.text = card?.englisch
            antwortGeschlect.text = card?.geschlecht
            antwortWort.text = card?.deutsch
        } else {
            mainGeschlecht.text = card?.geschlecht
            mainAntwort.text = card?.deutsch
            antwortGeschlect.text = ""
            antwortWort.text = card?.englisch
        }

        antwortWort.hidden = true
        antwortGeschlect.hidden = true
        
    }
    
}
