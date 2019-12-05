//
//  dayViewController.swift
//  iRun
//
//  Created by akash on 25/10/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class dayViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(ViewController: "day1"),
                self.newViewController(ViewController: "day2"),
                self.newViewController(ViewController: "day3"),
                self.newViewController(ViewController: "day4"),
                self.newViewController(ViewController: "day5"),
                self.newViewController(ViewController: "day6"),
                self.newViewController(ViewController: "day7"),
                self.newViewController(ViewController: "day8"),
                self.newViewController(ViewController: "day9"),
                self.newViewController(ViewController: "day10"),
                self.newViewController(ViewController: "day11"),
                self.newViewController(ViewController: "day12"),
                self.newViewController(ViewController: "day13"),
                self.newViewController(ViewController: "day14"),
                self.newViewController(ViewController: "day15"),
                self.newViewController(ViewController: "day16"),
                self.newViewController(ViewController: "day17"),
                self.newViewController(ViewController: "day18"),
                self.newViewController(ViewController: "day19"),
                self.newViewController(ViewController: "day20"),
                self.newViewController(ViewController: "day21")
                ]
    }()
    
    
    var pageControl = UIPageControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
        }
        self.delegate = self
        configurePageControll()
        // Do any additional setup after loading the view.
    }
    
    
    func configurePageControll() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 100, width: UIScreen.main.bounds.width, height: 50))
        
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.view.addSubview(pageControl)
        
    }
    
    
    func newViewController(ViewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            //return orderedViewControllers.last
            return nil   //scroll kore abr jate surute na ase ba suru theke ses a na jai
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            //return orderedViewControllers.first
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    
    
    @IBAction func butt1(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(1, forKey:"dayNumber")
        performSegue(withIdentifier: "d1", sender: self)
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
