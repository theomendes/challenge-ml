//
//  MLButton.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit

final class MLButton: UIButton {
    override func updateConfiguration() {
        guard let configuration = configuration else {
            return
        }

        var updatedConfiguration = configuration

        var background = UIButton.Configuration.plain().background

        background.cornerRadius = 3

        let foregroundColor: UIColor
        let backgroundColor: UIColor
        let baseColor = updatedConfiguration.baseForegroundColor ?? UIColor.tintColor

        switch self.state {
        case .normal:
            foregroundColor = baseColor
            backgroundColor = UIColor.mlBlue
        case [.highlighted]:
            foregroundColor = baseColor
            backgroundColor = UIColor.mlBlue.withAlphaComponent(0.3)
        case .selected:
            foregroundColor = .white
            backgroundColor = baseColor
        case [.selected, .highlighted]:
            foregroundColor = .white
            backgroundColor = UIColor.mlBlue.withAlphaComponent(0.3)
        case .disabled:
            foregroundColor = .white
            backgroundColor = UIColor.mlBlue.withAlphaComponent(0.3)
        default:
            foregroundColor = baseColor
            backgroundColor = UIColor.mlBlue
        }

        background.backgroundColor = backgroundColor

        updatedConfiguration.baseForegroundColor = foregroundColor
        updatedConfiguration.background = background

        self.configuration = updatedConfiguration
    }
}
