//
//  tabBarController.swift
//  iRun
//
//  Created by akash on 24/10/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class tabBarController: UITabBarController {
    
    var TabBarItem = UITabBarItem()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.set(true, forKey: "loggedIn")
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        // Do any additional setup after loading the view.
        
        let selectedImage1 = UIImage(named: "trophy")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage1 = UIImage(named: "trophy")?.withRenderingMode(.alwaysOriginal)
        TabBarItem = self.tabBar.items![0]
        tabBarItem.image = deSelectedImage1
        tabBarItem.selectedImage = selectedImage1
        
        let selectedImage2 = UIImage(named: "rank")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage2 = UIImage(named: "rank")?.withRenderingMode(.alwaysOriginal)
        TabBarItem = self.tabBar.items![1]
        tabBarItem.image = deSelectedImage2
        tabBarItem.selectedImage = selectedImage2
        
        let selectedImage3 = UIImage(named: "man")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage3 = UIImage(named: "man")?.withRenderingMode(.alwaysOriginal)
        TabBarItem = self.tabBar.items![2]
        tabBarItem.image = deSelectedImage3
        tabBarItem.selectedImage = selectedImage3
        
        let selectedImage4 = UIImage(named: "spanner")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage4 = UIImage(named: "spanner")?.withRenderingMode(.alwaysOriginal)
        TabBarItem = self.tabBar.items![3]
        tabBarItem.image = deSelectedImage4
        tabBarItem.selectedImage = selectedImage4
        
        self.selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
