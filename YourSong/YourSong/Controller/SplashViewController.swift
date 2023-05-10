//
//  ViewController.swift
//  YourSong
//
//  Created by Begum Unal on 8.05.2023.
//

import UIKit

class SplashViewController: UIViewController {
    let tabBar = UITabBarController()
    let splashImage = CustomImageView(image: AppImages.appIconImage)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          
            
            let vc1 = MusicCategoriesViewController()
            let vc2 = FavoritesViewController()
            
            vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "music.note.list"), tag: 0)
            
            vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "suit.heart"), tag: 1)
            
            self.tabBar.setViewControllers([vc1, vc2], animated: false)
            self.tabBar.modalPresentationStyle = .fullScreen
            self.tabBar.tabBar.backgroundColor = AppColors.secondaryPrimaryColor
            self.tabBar.tabBar.tintColor = AppColors.secondaryTintColor
            
            self.navigationController?.setViewControllers([self.tabBar], animated: true)
        }
    }
    private func setup(){
        self.view.backgroundColor = AppColors.primaryColor
        
        self.splashImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.splashImage)
        
        NSLayoutConstraint.activate([
            self.splashImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.splashImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.splashImage.widthAnchor.constraint(equalToConstant: 200),
            self.splashImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

}

