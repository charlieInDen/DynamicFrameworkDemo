//
//  DynamicLoader.swift
//  DynamicLoader
//
// Created by Nishant Sharma
// Copyright © 2019 . All rights reserved.
//

import Foundation

public class DynamicClassLoader {
    
    public static func loadDynamic(classNamed:String, fromFrameworkNamed framework: String) -> DynamicLoadableClass.Type? {
        guard let bundleURL = Bundle.url(forResource: framework, withExtension: "framework", subdirectory: "Frameworks", in: Bundle.main.bundleURL), let bundle = Bundle(url: bundleURL) else {
            return nil
        }
        
        return loadDynamic(classNamed: classNamed, fromBundle: bundle)
    }
    
    public static func loadDynamic(classNamed: String, fromBundle bundle: Bundle) -> DynamicLoadableClass.Type? {
        bundle.load()
        
        guard let aClass = NSClassFromString(classNamed) else {
            return nil
        }
        
        return loadDynamicClass(aClass: aClass)
    }
    
    private static func loadDynamicClass(aClass: AnyClass) -> DynamicLoadableClass.Type?  {
        guard let loadable = aClass as? DynamicLoadableClass.Type else {
            return nil
        }
        
        let _ = loadable.loadDynamic()
        
        return loadable
    }
    public static func unloadDynamic(classNamed:String, fromFrameworkNamed framework: String) -> Bool? {
        guard let bundleURL = Bundle.url(forResource: framework, withExtension: "framework", subdirectory: "Frameworks", in: Bundle.main.bundleURL), let bundle = Bundle(url: bundleURL) else {
            return nil
        }
        guard let aClass = NSClassFromString(classNamed) else {
            return nil
        }
        _ = unloadDynamicClass(aClass: aClass)
        let result = bundle.unload()
        print(bundle)
        return result
    }
    public static func unloadDynamicClass(aClass: AnyClass) -> DynamicLoadableClass.Type?  {
        guard let loadable = aClass as? DynamicLoadableClass.Type else {
            return nil
        }
        
        let _ = loadable.unloadDynamic()
        
        return loadable
    }
    
}

public protocol DynamicLoadableClass {
    static func loadDynamic()
    static func doSomethingElse() -> String
    static func unloadDynamic()

}
