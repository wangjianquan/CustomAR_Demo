//
//  ScrollViewButton.swift
//  CustomAR_Demo
//
//  Created by landixing on 2017/7/20.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit


protocol btnClickDelegate: NSObjectProtocol {
    func btnClick(btn: UIButton)
}
class ScrollViewButton: UIView {

    
    var delegate: btnClickDelegate?
    fileprivate var currentBtn: UIButton? 
    
    
    
    lazy var scrollview : UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = true
        scroll.isScrollEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        self.addSubview(scroll)
        scroll.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        return scroll
    }()
    
    var btnNames : [String]{
        
        didSet{
            
           
            let btnHeight = Int(self.bounds.height)
            let btnWidth: Int = btnHeight * 2
            for i in 0..<btnNames.count
            {
                let btn: UIButton = UIButton()
                btn.frame = CGRect(x: i * btnWidth, y: 0, width: btnWidth, height: Int(btnHeight))
                btn.tag = i
                btn.setTitle(btnNames[i], for: .normal)
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.setTitleColor(UIColor.white, for: .selected)
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                scrollview.addSubview(btn)
                
            }
            scrollview.contentSize = CGSize(width: btnWidth * self.btnNames.count, height: 0)//滚动范围
        }
    }
    
    
    @objc fileprivate func btnClick(_ sender: UIButton){
        sender.isSelected = !sender.isSelected

        if (self.currentBtn == nil) {
            sender.isSelected = true
            sender.backgroundColor = UIColor.black
            self.currentBtn = sender
        }else if(self.currentBtn == sender){
            self.currentBtn = sender
            sender.isSelected = true
        }else if(self.currentBtn != sender){
            self.currentBtn?.isSelected = false
             self.currentBtn?.backgroundColor = UIColor.white
            sender.isSelected = true
            
            self.currentBtn = sender
            self.currentBtn?.backgroundColor = UIColor.black
        }

        delegate?.btnClick(btn: sender)
    }
    
    override init(frame: CGRect) {
        self.btnNames = [String]()
//        self.currentBtn = UIButton()
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
