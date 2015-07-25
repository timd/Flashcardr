//
//  LearnCollectionViewCell.swift
//  Flashcards
//
//  Created by Tim on 22/07/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class LearnCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: LearnCellDelegateProtocol?

    @IBOutlet weak var mainAntwort: UILabel!
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
        mainAntwort.text = ""
        antwortWort.text = ""
        antwortWort.hidden = true
    }
    
    func didTapInCell() {
        antwortWort.hidden = false
        delegate?.didRevealAnswerForCell(self)
    }
    
    func updateUI() {

        let doubleTap = UITapGestureRecognizer(target: self, action: "didTapInCell")
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        self.contentView.addGestureRecognizer(doubleTap)
        
        if showEnglisch {
            mainAntwort.text = card?.englisch
            antwortWort.text = card?.deutsch
        } else {
            mainAntwort.text = card?.deutsch
            antwortWort.text = card?.englisch
        }

        antwortWort.hidden = true
        
    }
    
}
