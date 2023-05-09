//
//  ViewController.swift
//  YourSong
//
//  Created by Begum Unal on 8.05.2023.
//

import UIKit

class SplashViewController: UIViewController {

    let splashImage = CustomImageView(image: AppImages.appIconImage)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          
            let tabBar = UITabBarController()
            let vc1 = MusicCategoriesViewController()
            let vc2 = FavoritesViewController()
            
            vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "music.note.list"), tag: 0)
            
            vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "suit.heart"), tag: 1)
            
            tabBar.setViewControllers([vc1, vc2], animated: false)
            tabBar.modalPresentationStyle = .fullScreen
            tabBar.tabBar.backgroundColor = AppColors.secondaryPrimaryColor
            tabBar.tabBar.tintColor = AppColors.primaryTintColor
            self.present(tabBar, animated: true, completion: nil)
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

