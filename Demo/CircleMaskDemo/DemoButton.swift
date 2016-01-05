//
//  DemoButton.swift
//  CircleMaskDemo
//
//  Created by Willow Bumby on 2016-01-04.
//  Copyright © 2016 Willow Bumby. All rights reserved.
//

import UIKit

class DemoButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    private func setup() {
        titleLabel?.font = UIFont(name: "Avenir Light", size: 20.0)
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setTitleColor(UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0), forState: .Highlighted)
        backgroundColor = UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        layer.cornerRadius = 5.0
    }
}
