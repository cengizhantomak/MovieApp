//
//  TicketPageViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 20.07.2023.
//

import UIKit

class TicketPageViewController: UIPageViewController {
    
    let ticketsVC = TicketsViewController()
    let mapVC = MapViewController()
    
    var vcList = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        vcList = [ticketsVC, mapVC]
        if let vc = vcList.first {
            setViewControllers([vc], direction: .forward, animated: true)
        }
    }
}

extension TicketPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == ticketsVC {
            return nil
        } else if viewController == mapVC {
            return ticketsVC
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == mapVC {
            return nil
        } else if viewController == ticketsVC {
            return mapVC
        } else {
            return nil
        }
    }
}
