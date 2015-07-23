//
//  Section.swift
//  Flashcards
//
//  Created by Tim on 23/07/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import RealmSwift

class Section: Object {
    
    dynamic var name: String = ""
    
    let cards = List<Card>()
    
}
