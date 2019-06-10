//
//  AppDelegate.swift
//  DynamicLoaderExampleApp
//
// Created by Nishant Sharma
// Copyright © 2019 . All rights reserved.
//

import UIKit
import DynamicLoader

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var count: Int = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if #available(iOS 10.0, *) {
            if self.count < 50 {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (Timer) in
                    self.testMethod()
                    self.count = self.count + 1
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }
    func testMethod() {
        var aClass: DynamicLoadableClass.Type?
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() ) {
            aClass = DynamicClassLoader.loadDynamic(classNamed: "DynamicFramework.DynamicClassExample", fromFrameworkNamed: "DynamicFramework")
            if let somethingDone = aClass?.doSomethingElse() {
                print("\(somethingDone)")
            }
            else {
                print("Class wasn't loaded")
            }
            aClass = nil
            
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            if let result = DynamicClassLoader.unloadDynamic(classNamed:  "DynamicFramework.DynamicClassExample", fromFrameworkNamed: "DynamicFramework") {
                print( (result ? "Unloaded Successfully": "Unable to unload"))
            }
            
        }
    }
    
}
