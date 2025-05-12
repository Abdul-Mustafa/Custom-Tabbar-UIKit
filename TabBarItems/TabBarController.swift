import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set tab bar width to 90% of screen width
        let tabBarWidth = view.frame.width * 0.87
        let tabBarHeight: CGFloat = 70 // Adjust height as needed
        let tabBarX = (view.frame.width - tabBarWidth) / 2
        let tabBarY = view.frame.height - tabBarHeight - view.safeAreaInsets.bottom - 10 // Slightly above bottom
        
        tabBar.frame = CGRect(x: tabBarX, y: tabBarY, width: tabBarWidth, height: tabBarHeight)

        // Apply corner radius
        tabBar.layer.cornerRadius = 35
        tabBar.layer.masksToBounds = true
        tabBar.layer.borderWidth = 0 // Remove border if needed
        tabBar.layer.borderColor = UIColor.clear.cgColor
        
        // Optional: Add shadow effect
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.masksToBounds = false
        hideTabBarForiPad()
    }
    private func hideTabBarForiPad() {
           if traitCollection.horizontalSizeClass == .regular {
               tabBar.isHidden = true
           }
       }
}
