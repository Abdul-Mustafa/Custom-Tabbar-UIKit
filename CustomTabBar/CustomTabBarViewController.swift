import UIKit

class CustomTabBarViewController: UIViewController {

    private var currentVC: UIViewController?
    private let customTabBar = UIView()
    private let customTabBarBackground = UIView()
    private var buttons: [UIButton] = []
    private var selectedButton: UIButton?
    private let tabBarHeight: CGFloat = 60
    
    var viewControllers: [UINavigationController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Home Navigation Controller
        let homeVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage.homeUnselected,
            selectedImage: UIImage.homeSelected
        )
        let homeNavController = UINavigationController(rootViewController: homeVC)
        
        // Converted PDF Navigation Controller
        let conPDFVC = storyboard.instantiateViewController(withIdentifier: "ConvertedPDFVC") as! ConvertedPDFVC
        conPDFVC.tabBarItem = UITabBarItem(
            title: "Draft",
            image: UIImage.convertedUnselected,
            selectedImage: UIImage.convertedSelected
        )
        let conPDFNavController = UINavigationController(rootViewController: conPDFVC)
        
        // Settings Navigation Controller
        let settingVC = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        settingVC.tabBarItem = UITabBarItem(
            title: "Setting",
            image: UIImage.settingUnselected,
            selectedImage: UIImage.settingSelected
        )
        let settingNavController = UINavigationController(rootViewController: settingVC)
        
        return [homeNavController, conPDFNavController, settingNavController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar.layer.cornerRadius = 30
        view.backgroundColor = .white
        setupCustomTabBar()
        setupInitialViewController()
    }
    
    private func setupCustomTabBar() {
        customTabBar.clipsToBounds = true
        customTabBar.backgroundColor = .main
        customTabBarBackground.backgroundColor = .white
        customTabBarBackground.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(customTabBarBackground)
        view.addSubview(customTabBar)
        
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight)
        ])
        
        NSLayoutConstraint.activate([
            customTabBarBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBarBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBarBackground.bottomAnchor.constraint(equalTo: customTabBar.centerYAnchor),
            customTabBarBackground.heightAnchor.constraint(equalToConstant: tabBarHeight)
        ])
        
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: customTabBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: customTabBar.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: customTabBar.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: customTabBar.bottomAnchor, constant: -5)
        ])

        for (index, navController) in viewControllers.enumerated() {
            let button = UIButton()
            if let tabBarItem = navController.topViewController?.tabBarItem {
                button.setImage(tabBarItem.image, for: .normal)
                button.setImage(tabBarItem.selectedImage, for: .selected)
            }
            button.tintColor = .white
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }

        customTabBar.bringSubviewToFront(stackView)
        
        updateSelection(selectedIndex: 0)
    }

    private func setupInitialViewController() {
        guard !viewControllers.isEmpty else { return }
        switchToViewController(at: 0)
    }

    @objc private func tabTapped(_ sender: UIButton) {
        let index = sender.tag
        updateSelection(selectedIndex: index)
        switchToViewController(at: index)
    }

    private func updateSelection(selectedIndex: Int) {
        buttons.forEach { button in
            let isSelected = button.tag == selectedIndex
            button.isSelected = isSelected
            button.tintColor = isSelected ? .white : .gray
            button.isHidden = false
            if isSelected {
                selectedButton = button
            }
        }
    }

    func switchToViewController(at index: Int) {
        guard index < viewControllers.count else { return }
        let newNavController = viewControllers[index]

        if let currentVC = currentVC {
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }

        addChild(newNavController)
        newNavController.view.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(newNavController.view, belowSubview: customTabBar)
        
        NSLayoutConstraint.activate([
            newNavController.view.topAnchor.constraint(equalTo: view.topAnchor),
            newNavController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newNavController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newNavController.view.bottomAnchor.constraint(equalTo: customTabBar.topAnchor)
        ])
        
        newNavController.didMove(toParent: self)
        currentVC = newNavController
        
        updateSelection(selectedIndex: index)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        currentVC?.view.layoutIfNeeded()
    }
}

