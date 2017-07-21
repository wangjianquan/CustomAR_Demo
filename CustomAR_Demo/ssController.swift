//
//  ssController.swift
//  CustomAR_Demo
//
//  Created by landixing on 2017/7/20.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class ssController: UIViewController , btnClickDelegate{

    lazy var scrollviewBtn : ScrollViewButton = {
        let scrollbtn = ScrollViewButton(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 40))
        scrollbtn.btnNames = ["candle","cup","cube","vase","chair","lamp"]
        scrollbtn.delegate = self
        return scrollbtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollviewBtn)
        
        // Do any additional setup after loading the view.
    }
    
    func btnClick(btn: UIButton) {
        print("\(btn.tag)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
