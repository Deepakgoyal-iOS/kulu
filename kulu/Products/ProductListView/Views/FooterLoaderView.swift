//
//  FooterLoaderView.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import UIKit

class FooterLoaderView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.startAnimating()
        return indicator
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(activityIndicator)
        activityIndicator.center = self.center
    }
    
    func showLoader(_ show: Bool){
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
