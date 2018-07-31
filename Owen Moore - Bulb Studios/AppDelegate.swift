//
//  AppDelegate.swift
//  Owen Moore - Bulb Studios
//
//  Created by Ashley Moore on 31/07/2018.
//  Copyright © 2018 Owen Moore. All rights reserved.
//

import UIKit
import Disk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let previouslyLaunched = UserDefaults.standard.bool(forKey: "launch")
        if previouslyLaunched  {
            print("Previously launch")
        } else {
            print("First launch")
            UserDefaults.standard.set(true, forKey: "launch")
            
            // Displays a how to use on initial statup.
            
            let createItems = ShoppingItems(item: "Tap add new item to create new items")
            items.append(createItems)
            let modifyItems = ShoppingItems(item: "Swipe left to delete items")
            items.append(modifyItems)
            let markItems = ShoppingItems(item: "Tap on items to mark the item")
            items.append(markItems)
            
            // Saves the array of items to the device memory.
            try! Disk.save(items, to: .caches, as: "items")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Saves the array of items to the device memory.
        try! Disk.save(items, to: .caches, as: "items")
    }
}

