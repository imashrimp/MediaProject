//
//  OnboardingViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/25.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    var vcList: [UIViewController] = [IntroOnboardingViewController()]
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        delegate = self
        dataSource = self
        
        guard let first = vcList.first else { return }
        setViewControllers([first], direction: .forward, animated: false)
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = vcList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : vcList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = vcList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= vcList.count ? nil : vcList[nextIndex]
    }
}
