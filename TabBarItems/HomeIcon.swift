//
//  HomeIcon.swift
//  PDF Converter
//
//  Created by mac on 26/03/2025.
//

import UIKit

class HomeIcon: UITabBarItem {
    
    override init() {
        super.init()
        setupIcon()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupIcon()
    }
    
    private func setupIcon() {
        // Detect iPad
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        
        if isIpad {
            // Use system image for iPad (e.g., "house.fill" for selected, "house" for normal)
            self.image = UIImage(named: "red-home-icon")
            self.selectedImage = UIImage(named: "red-home-icon")
            print("HomeIcon - iPad detected, set system image: house")
        }
    }
}
