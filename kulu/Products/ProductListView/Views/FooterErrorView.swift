//
//  FooterErrorView.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import UIKit

typealias RetryTapHandler = () -> Void

class FooterErrorView: UIView {
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = error
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("  Retry  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        button.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [retryButton, errorLabel])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .clear
        stackView.layoutMargins = .init(top: 8, left: 16, bottom: 24, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var error: String{
        didSet{
            errorLabel.text = error
        }
    }
    private var tapAction: RetryTapHandler
    
    init(frame: CGRect, error: String, tapAction: @escaping RetryTapHandler) {
        self.error = error
        self.tapAction = tapAction
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(vStack)
        vStack.center = self.center
        self.backgroundColor = .lightGray.withAlphaComponent(0.1)
        
        NSLayoutConstraint.activate([
            
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
    }
    
    @objc private func didTapRetry(){
        tapAction()
    }
    
    func set(text: String, showRetry: Bool = true){
        error = text
        retryButton.isHidden = !showRetry
    }
}

