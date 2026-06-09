//
//  ProductDetailsViewController.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import UIKit

class ProductDetailsViewController: BaseUIViewController{
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentVStack)
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = product.title
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = product.description
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = product.price == nil ? "-" : "$\(product.price ?? 0.0)"
        return label
    }()
    
    
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray6
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.load(fromURL: product.image)
        return image
    }()
    
    private lazy var additionalDetailsVStack: UIStackView = {
        
        var views = [UIView]()
        
        let additionalDetailsLabel = UILabel()
        additionalDetailsLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        additionalDetailsLabel.textColor = .label
        additionalDetailsLabel.numberOfLines = 0
        additionalDetailsLabel.text = "Additional Details"
        additionalDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        views.append(additionalDetailsLabel)
        
        product.getAdditionalDetails().forEach { detail in
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            label.text = detail
            label.translatesAutoresizingMaskIntoConstraints = false
            views.append(label)
        }
        
        let vStack = UIStackView(arrangedSubviews: views)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        return vStack
    }()
    
    private lazy var contentVStack: UIStackView = {
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let vStack = UIStackView(arrangedSubviews: [productImageView, titleLabel, descriptionLabel, priceLabel, separatorView, additionalDetailsVStack])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        return vStack
    }()
    
    private var product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }
    
    private func addViews(){
        self.view.addSubview(scrollView)
    }
    
    private func addConstraints(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            productImageView.heightAnchor.constraint(equalToConstant: view.bounds.height - 250),
           
            contentVStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentVStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentVStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentVStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentVStack.widthAnchor.constraint(equalToConstant: view.bounds.width - 32)
        ])
    }
}
