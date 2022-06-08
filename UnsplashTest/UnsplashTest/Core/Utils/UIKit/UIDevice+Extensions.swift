//
//  UIDevice+Extensions.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 09/06/2022.
//

import UIKit

extension UIDevice {

    static var hasNotch: Bool {
        let keyWindow = UIApplication.shared.windows.filter(\.isKeyWindow).first
        return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
    }
}
