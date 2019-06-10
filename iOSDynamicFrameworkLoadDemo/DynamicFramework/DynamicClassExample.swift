//
//  DynamicClassExample.swift
//  DynamicLoader
//
// Created by Nishant Sharma
// Copyright © 2019 . All rights reserved.
//

import Foundation
import DynamicLoader
struct Node {
    let image: UIImage
}
public class DynamicClassExample : DynamicLoadableClass {
    
    static var imageArr:[Node?]?
    public class func loadDynamic() {
        print("loaded dynamic class")
        imageArr = []
        guard let path = Bundle.main.path(forResource: "EmploymentCertificate", ofType: "png") else {
            return
        }
        for _  in 0..<10000 {
            
            if let img = UIImage.init(contentsOfFile: path) {
                imageArr?.append(Node.init(image: img))
            }
        }
        print(imageArr?.count ?? 0)
    }
    public static func doSomethingElse() -> String {
        return "Hello, World!"
    }
    public class func unloadDynamic() {
        for i in 0..<(imageArr?.count ?? 0) {
            imageArr![i] = nil
        }
        imageArr?.removeAll()
        imageArr = nil
    }
    
}
