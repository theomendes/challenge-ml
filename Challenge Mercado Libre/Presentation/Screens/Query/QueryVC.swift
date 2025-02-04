//
//  QueryVC.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit

final class QueryVC: BaseVC {
    let generator = UIImpactFeedbackGenerator(style: .medium)

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.mercadoLibreLogo)
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var searchField: SearchTextField = {
        let field = SearchTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 3
        field.layer.masksToBounds = false
        field.backgroundColor = .white
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 16)
        field.attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("search_placeholder", comment: "Search field placeholder text"),
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
        )
        field.layer.shadowColor = UIColor.black.cgColor
        field.layer.shadowOpacity = 0.2
        field.layer.shadowOffset = CGSize(width: 0, height: 1)
        field.layer.shadowRadius = 4
        return field
    }()

    lazy var searchButton: MLButton = {
        var configuration = UIButton.Configuration.mercadoLibre()
        configuration.buttonSize = .large

        let button = MLButton(configuration: configuration, primaryAction: nil)
        button.setTitle(NSLocalizedString("search_button", comment: "Search"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = UIColor.mlYellow

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(imageView)
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(searchField)
        stackView.addArrangedSubview(searchButton)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        searchField.delegate = self

        setupKeyboardHandling()
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}

#Preview {
    let vc = QueryVC()
    let nav = UINavigationController(rootViewController: vc)
    nav.title = "QueryVC"
    return nav
}
