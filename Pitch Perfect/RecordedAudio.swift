//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Terrell Robinson on 2/19/17.
//  Copyright © 2017 FlyGoody. All rights reserved.
//

import Foundation

// NOTE: Created a Faux Model (Kind of)

class RecordedAudio: NSObject {
    
    // MARK: Class Properties
    
    var filePathURL: NSURL!
    
    var title: String! {
        
        get {
            
            return filePathURL.lastPathComponent
            
        }
    }
    
    // MARK: Initializer
    
    init(filePathURL: NSURL) {
        
        self.filePathURL = filePathURL
        
    }

}
