//
//  GetProductList.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-25.
//  Copyright © 2017 Temkos. All rights reserved.
//

import Foundation
import PromiseKit

class GetProductList {
    
    var repository: ProductRepository!
    
    func get() -> Promise<[Product]> {
        return self.repository.getProductList()
    }
    
}
