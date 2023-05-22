//
//  Colors.swift
//  fireBaseChat
//
//  Created by Anton on 12.05.2023.
//

import Foundation
import UIKit

class Colors {
    
    static let shared = Colors()
    
    var gl:CAGradientLayer!
    
    init() {
        let colorBottom = UIColor(red: 0.0 / 255.0, green: 58.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0).cgColor
        let colorTop = UIColor(red: 219.0 / 255.0, green: 233.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
