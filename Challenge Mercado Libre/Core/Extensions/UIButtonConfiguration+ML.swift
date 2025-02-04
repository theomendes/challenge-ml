//
//  UIButtonConfiguration+ML.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit

extension UIButton.Configuration {
    public static func mercadoLibre() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.cornerRadius = 3
        style.background = background

        return style
    }
}
