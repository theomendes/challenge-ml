//
//  LoadingView.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 02/02/25.
//

import UIKit

final class LoadingView: UIView {
    private var dotAnimationTimer: Timer?

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.mlBlue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let loadingImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("searching_offers_text", comment: "Text for loading screen while searching offers")
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override var isHidden: Bool {
        didSet {
            if isHidden {
                stopDotAnimation()
            } else {
                startDotAnimation()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)

        stackView.addArrangedSubview(loadingImage)
        stackView.addArrangedSubview(loadingLabel)
        backgroundColor = UIColor.mlYellow
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            loadingImage.heightAnchor.constraint(equalToConstant: 100),
            loadingImage.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    private func startDotAnimation() {
        dotAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self, var currentText = self.loadingLabel.text else { return }

            if currentText.hasSuffix("...") {
                currentText.removeLast(3)
            } else {
                currentText += "."
            }

            self.loadingLabel.text = currentText
        }
    }

    private func stopDotAnimation() {
        dotAnimationTimer?.invalidate()
        dotAnimationTimer = nil
    }

    deinit {
        stopDotAnimation()
    }

}

#Preview {
    LoadingView()
}
