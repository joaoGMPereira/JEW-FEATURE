//
//  JEWDeviceInfo.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/04/20.
//

import Foundation

public enum JEWDeviceInfoHeight: CGFloat {
    case iPhone4Height = 480
    case iPhone5Height = 568
    case iPhone6Height = 667
    case iPhone6plusHeight = 736
    case iPhoneXHeight = 812
}

public class JEWDeviceInfo: NSObject {
    static func isIphone4() -> Bool {
        return self.validateDeviceHeight(height: JEWDeviceInfoHeight.iPhone4Height.rawValue)
    }
    static func isIphone5() -> Bool {
        return self.validateDeviceHeight(height: JEWDeviceInfoHeight.iPhone5Height.rawValue)
    }
    static func isIphone6() -> Bool {
        return self.validateDeviceHeight(height: JEWDeviceInfoHeight.iPhone6Height.rawValue)
    }
    static func isIphone6Plus() -> Bool {
        return self.validateDeviceHeight(height: JEWDeviceInfoHeight.iPhone6plusHeight.rawValue)
    }
    static func isIphoneX() -> Bool {
        return self.validateDeviceHeight(height: JEWDeviceInfoHeight.iPhoneXHeight.rawValue)
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static func validateDeviceHeight(height: CGFloat) ->  Bool {
        if UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height >= height {
            return true
        }
        return false
    }

}
