//
//  ViewController.swift
//  Paperboard
//
//  Created by Andrey Tchernov on 16.08.2018.
//  Copyright © 2018 Ice Rock. All rights reserved.
//

import UIKit

class MainInputViewController: MainKeyboardViewController {
    
    @IBOutlet private weak var inputField: UITextView!
    
    @IBAction private func showSettings(_ sender: UIBarButtonItem!) {
        let settingsProcessor = SettingsProcessor(settings: settings)
        settingsProcessor.showSettings(onController: self, byBarButton: sender)
    }
    
    
    @IBAction func showShare(_ sender: Any) {
        guard let shareText = inputField.text else {
            return
        }
        let textToShare = [ shareText ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        if let popOver = activityViewController.popoverPresentationController {
            popOver.sourceView = self.view
            activityViewController.popoverPresentationController?.sourceRect = shareButton.frame
        }
        present(activityViewController, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        let statusBar =  UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = UIColor.white
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        
        clearButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8)
        clearButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
        talkButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8)
        talkButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
        inputField.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        inputProcessor = InputFieldProcessor(inputField: inputField)
        super.viewDidLoad()
        
        setColorScheme(.light)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputSource.reload()
        inputCollectionView.reloadData()
        inputCollectionProcessor.scrollsToMiddleSection(inputCollectionView)
        inputField.becomeFirstResponder()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let visibleIndex = inputCollectionView.indexPathsForVisibleItems.min()
        coordinator.animate(
            alongsideTransition: nil,
            completion: { [weak self] (context) in
                self?.inputLayout.prepare()
                guard let nIndexPath = visibleIndex else {
                    return
                }
                self?.inputCollectionView.reloadData()
                self?.inputCollectionView.scrollToItem(at: nIndexPath, at: .left, animated: false)
            })
    }
}
