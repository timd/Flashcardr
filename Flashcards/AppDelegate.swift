//
//  AppDelegate.swift
//  Flashcards
//
//  Created by Tim on 22/07/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        // Notice setSchemaVersion is set to 1, this is always set manually. It must be
//        // higher than the previous version (oldSchemaVersion) or an RLMException is thrown
//        setSchemaVersion(2, Realm.defaultPath, { migration, oldSchemaVersion in
//            // We haven’t migrated anything yet, so oldSchemaVersion == 0
//            if oldSchemaVersion < 2 {
//                // Nothing to do!
//                // Realm will automatically detect new properties and removed properties
//                // And will update the schema on disk automatically
//            }
//        })
//        // now that we have called `setSchemaVersion(_:_:_:)`, opening an outdated
//        // Realm will automatically perform the migration and opening the Realm will succeed
//        // i.e. Realm()
        
        loadJson()
        
        
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func loadJson() {

        let realm = Realm()
        
        if let path = NSBundle.mainBundle().pathForResource("20", ofType: "json") {
            
            let pathURL = NSURL(fileURLWithPath: path)
            
            if let jsonData = NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMapped, error: nil) {
                
                // Delete existing cards
                realm.write({ () -> Void in
                    realm.deleteAll()
                })
            
                let json = JSON(data: jsonData, options: NSJSONReadingOptions.allZeros, error: nil)
                
                for result in json["words"].arrayValue {
                    
                    let newCard = Card()
                    
                    newCard.uid = result["rank"].intValue
                    newCard.sortOrder = newCard.uid
                    
                    newCard.englisch = result["englisch"].stringValue
                    newCard.deutsch = result["deutsch"].stringValue
                    newCard.geschlecht = result["geschlecht"].stringValue
                    newCard.teil = result["teil"].stringValue

                    // handle sections
                    
                    let sectionValue = result["section"].stringValue
                    
                    if let section = realm.objects(Section).filter("name='\(sectionValue)'").first {
                        newCard.sections.append(section)
                        
                        realm.write{
                            section.cards.append(newCard)
                        }

                    } else {
                        let section = Section()
                        section.name = sectionValue
                        newCard.sections.append(section)

                        realm.write{
                            section.cards.append(newCard)
                        }
                    }
                    
                    realm.write {
                        realm.add(newCard)
                    }

                    
                }
                    
            }
            
        }
        
    }


}

