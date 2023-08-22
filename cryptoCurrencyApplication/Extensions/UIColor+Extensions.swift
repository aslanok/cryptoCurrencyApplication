//
//  UIColor+Extensions.swift
//  cryptoPosApp
//
//  Created by MacBook on 22.08.2023.
//

import UIKit

extension UIColor {
    
    struct Theme {
        static var viewBackgroundColor : UIColor {
            return UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        }
        static var navyBlueTextColor : UIColor {
            return UIColor(red: 3 / 255, green: 26 / 255, blue: 88 / 255, alpha: 1)
        }
        static var grayTextColor : UIColor {
            return UIColor(red: 150 / 255, green: 160 / 255, blue: 185 / 255, alpha: 1)
        }
        static var openPurple : UIColor {
            return UIColor(red: 232/255, green: 231/255, blue: 253/255, alpha: 1)
        }
        static var purpleTextColor : UIColor{
            return UIColor(red: 130/255, green: 123/255, blue: 245/255, alpha: 1)
        }
        static var successGreenColor : UIColor {
            return UIColor(red: 98/255, green: 218/255, blue: 175/255, alpha: 1)
        }
        static var failRedColor : UIColor {
            return UIColor(red: 238/255, green: 93/255, blue: 95/255, alpha: 1)
        }
    }
    
}
