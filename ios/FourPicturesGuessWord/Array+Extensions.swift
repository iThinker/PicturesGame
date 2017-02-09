//
//  Array+Extensions.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-02-07.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func remove(at indicies: IndexSet) {
        indicies.reversed().forEach({ self.remove(at: $0) })
    }
    
    mutating func removeAll(where predicate: (Element) throws -> Bool) rethrows -> Void {
        var indiciesToRemove = IndexSet()
        for (index, item) in self.enumerated() {
            if try predicate(item) {
                indiciesToRemove.insert(index)
            }
        }
        
        self.remove(at: indiciesToRemove)
    }
    
}

extension Array where Element: AnyObject {
    
    mutating func removeAll(of element: Element) {
        self.removeAll(where: { $0 === element })
    }
    
}

extension Array where Element: Equatable {
    
    mutating func removeAll(of element: Element) {
        self.removeAll(where: { $0 == element })
    }
    
}
