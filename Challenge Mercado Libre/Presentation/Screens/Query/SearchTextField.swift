//
//  SearchTextField.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit

final class SearchTextField: UITextField {
    private let textPadding = UIEdgeInsets(top: 8, left: 40, bottom: 8, right: 12)

    private let iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        leftView = setupIconView()
        leftViewMode = .always
    }

    private func setupIconView() -> UIView {
        let padding: CGFloat = 12
        let iconSize: CGFloat = 20
        let view = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + padding * 2, height: iconSize))

        iconView.frame = CGRect(x: padding, y: 0, width: iconSize, height: iconSize)
        iconView.center.y = view.center.y
        view.addSubview(iconView)

        return view
    }

    // MARK: - Adjusting Text & Placeholder Padding

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}

#Preview {
    let field: SearchTextField = {
        let view = SearchTextField()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .white
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16)
        view.placeholder = "Search...."
        return view
    }()

    return field
}
