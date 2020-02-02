//
//  NewsH5Controller.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/14.
//  Copyright © 2020 xujiale. All rights reserved.
//

/**
 * 支持HTML5
 */

import Foundation
import WebKit

class WebController: UIViewController, DropBoxDelegate {
    
    var webView: WKWebView!
    var path: String!
    var moreBox: DropBoxView!
    
    convenience init(path: String) {
        self.init()
        self.path = path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtn = UIBarButtonItem(image: ImageUtil.resize(image: UIImage(named: "back")!, size: CGSize(width: 20, height: 20)),
                                       style: .plain, target: self, action: #selector(back))
        navigationItem.setLeftBarButton(backBtn, animated: true)
        
        let shareBtn = UIBarButtonItem(image: ImageUtil.resize(image: UIImage(named: "share")!, size: CGSize(width: 25, height: 25)),
                                       style: .plain, target: self, action: #selector(share))
        let moreBtn = UIBarButtonItem(image: ImageUtil.resize(image: UIImage(named: "more")!, size: CGSize(width: 20, height: 20)),
                                       style: .plain, target: self, action: #selector(more))
        navigationItem.setRightBarButtonItems([moreBtn, shareBtn], animated: true)
        
        let h = UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.height)!
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                           height: h)
        webView = WKWebView(frame: frame)
        webView.scrollView.bounces = false
        view.addSubview(webView!)
        
        let topRight = CGRect(x: UIScreen.main.bounds.width - 155, y: 5, width: 150, height: 0)
        moreBox = DropBoxMenu(frame: topRight, maxHeight: 200, delegate: self)
        view.addSubview(moreBox)
        view.bringSubviewToFront(moreBox)
        
        load(path)
    }
    
    func load(_ path: String?) {
        if (path == nil) {
            return
        }
        let url = URL(fileURLWithPath: path!)
        webView.load(URLRequest(url: url))
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func share() {
        
    }
    
    @objc func more() {
        if(moreBox.isDrop) {
            moreBox.drawUp()
        } else {
            moreBox.dropDwon()
        }
    }
    
    let moreItems = [
        ["text": "刷新", "img": UIImage(named: "reflesh")],
        ["text": "首页", "img": UIImage(named: "home")],
        ["text": "浏览器打开", "img": UIImage(named: "broswer")]
    ]
    
    func count() -> Int {
        return moreItems.count
    }
    
    func setItem(_ forItem: Int) -> [String : Any?] {
        return moreItems[forItem]
    }
    
    func didSelectItemAt(_ forItem: Int) {
        if(forItem == 0) {
            load(CommonUtil.getErrorPath())
        }
    }
    
    func heightForItem(_ forItem: Int) -> CGFloat {
        return 40
    }

    
}
