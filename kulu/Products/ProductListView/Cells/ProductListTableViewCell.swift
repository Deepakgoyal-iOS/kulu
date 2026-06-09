//
//  ProductListTableViewCell.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    static let id = "ProductListTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, priceLabel])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray6
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.addSubview(productImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentHStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageContainer, vStack])
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(contentHStack)
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentHStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentHStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
        
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            
            productImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            productImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: imageContainer.bottomAnchor)
        
        ])
    }
    
    func setupUI(with product: Product) {
        titleLabel.text = product.title ?? "-"
        priceLabel.text = product.price == nil ? "-" : "$\(product.price ?? 0)"
        descriptionLabel.text = product.description ?? "-"
        productImageView.load(fromURL: product.image)
    }
}
