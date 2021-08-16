//
//  ViewController.swift
//  FBYBankCard
//
//  Created by fby on 2019/9/20.
//  Copyright © 2019 espressif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @objc var addCardViewButton: UIButton!
    @objc var walletHeaderView: UIView!
    @objc var walletView: WalletView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        let screenw = self.view.frame.width
        let screenh = self.view.frame.height
        
        walletView = WalletView(frame: CGRect(x: 10, y: 0, width: screenw - 20, height: screenh - 20))
        self.view.addSubview(walletView)
        walletHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.walletView.frame.width, height: 44))

        walletView.walletHeader = walletHeaderView
        walletView.useHeaderDistanceForStackedCards = true
        walletView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        addCardViewButton = UIButton(frame: CGRect(x: self.walletView.frame.width-44, y: 0, width: 44, height: 44))
        addCardViewButton.setImage(UIImage(named: "add"), for: .normal)
        addCardViewButton.addTarget(self, action: #selector(addCardButtonClick(addCardButton:)), for: .touchUpInside)
        walletHeaderView.addSubview(addCardViewButton)
        
        var coloredCardViews = [ColoredCardView]()
        let imageArr = ["招商", "建设", "农业"]
        
        for index in 1...3 {
            let cardView = ColoredCardView()
//            cardView.index = index
            cardView.cardImage = imageArr[index - 1]
            coloredCardViews.append(cardView)
        }
        
        walletView.reload(cardViews: coloredCardViews)
        
        walletView.didPresentCardViewBlock = { [weak self] (_) in
            self?.showAddCardViewButtonIfNeeded()
            //            self?.addCardViewButton.addTransitionFade()
        }
    }

    func showAddCardViewButtonIfNeeded() {
        addCardViewButton.alpha = walletView.presentedCardView == nil || walletView.insertedCardViews.count <= 1 ? 1.0 : 0.0
        
    }
    
    @objc func addCardButtonClick(addCardButton:UIButton) {
        walletView.insert(cardView: ColoredCardView(), animated: true, presented: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}

