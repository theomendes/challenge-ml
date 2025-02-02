//
//  ErrorView.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 02/02/25.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapRetry()
}

final class ErrorView: UIView {
    weak var delegate: ErrorViewDelegate?

    private let errorImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.icloud"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .blue
        return imageView
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var retryButton: UIButton = {
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.buttonSize = .large

        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.setTitle("Tentar novamente", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setError(_ error: SearchError) {
        errorLabel.text = error.localizedDescription

        if case .emptyResults = error {
            retryButton.isHidden = true
        } else {
            retryButton.isHidden = false
        }
    }

    @objc private func didTapRetry() {
        delegate?.didTapRetry()
    }

    private func setupUI() {
        addSubview(stackView)

        stackView.addArrangedSubview(errorImage)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(retryButton)
        backgroundColor = .white
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

            errorImage.heightAnchor.constraint(equalToConstant: 100),
            errorImage.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

#Preview {
    let view = ErrorView()
    view.setError(.emptyResults(query: "sdsadsadjasdkjasda"))
    return view
}
