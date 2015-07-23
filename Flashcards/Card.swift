//
//  Card.swift
//  Flashcards
//
//  Created by Tim on 22/07/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import RealmSwift

class Card: Object {
 
    dynamic var uid: Int = 0
    dynamic var sortOrder: Int = 0
    dynamic var deutsch: String = ""
    dynamic var englisch: String = ""
    dynamic var geschlecht: String = ""
    dynamic var teil: String = ""
    dynamic var score: Int = 0
    
    let sections = List<Section>()
    
}
