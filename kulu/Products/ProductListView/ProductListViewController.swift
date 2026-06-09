//
//  ProductListViewController.swift
//  kulu
//
//  Created by Deepak Goyal on 08/06/26.
//

import UIKit

class ProductListViewController: BaseUIViewController{
    

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: ProductListTableViewCell.id)
        return tableView
    }()
    
    private lazy var viewModel: ProductListViewModel = {
        let vm = ProductListViewModel()
        vm.delegate = self
        return vm
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var errorView: FooterErrorView = {
        
        let view = FooterErrorView(frame: .zero, error: "Something went wrong", tapAction: { [weak self] in
            self?.viewModel.fetchFirstPage()
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        addViews()
        addViewConstraints()
        viewModel.fetchFirstPage()
    }
    
    private func addViews(){
        view.addSubview(tableView)
        view.addSubview(loader)
        view.addSubview(errorView)
    }
    
    private func addViewConstraints(){
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
}
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.id, for: indexPath) as? ProductListTableViewCell, indexPath.row < viewModel.products.count else {
            return UITableViewCell()
        }
        cell.setupUI(with: viewModel.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.products.count - 4 {
            viewModel.fetchNextPage()
        }
    }
}
extension ProductListViewController: ProductListViewModelDelegate{
    
    func didUpdateProducts() {
        reloadTableView()
        self.tableView.tableFooterView = nil
        errorView.isHidden = true
    }
    
    func didFail(withError: any AppError, type: ProductListViewModel.ErrorType) {
        
        switch type {
        case .fullScreen:
            errorView.isHidden = false
            errorView.setErrorText(withError.message)
            break
        case .footer:
            self.tableView.tableFooterView = FooterErrorView(frame: .init(x: 0, y: 0, width: self.view.bounds.width, height: 100), error: withError.message){
                [weak self] in
                self?.viewModel.fetchNextPage()
            }
        }
        
    }
    
    func showLoader(_ show: Bool, type: ProductListViewModel.LoaderType?) {

        if show{
            switch type {
            case .fullScreen:
                self.loader.startAnimating()
            case .footer:
                self.tableView.tableFooterView = FooterLoaderView(frame: .init(x: 0, y: 0, width: self.view.bounds.width, height: 100))
            default:
                break
            }
        }
        else{
            self.loader.stopAnimating()
            self.tableView.tableFooterView = nil
        }
        
    }
    
    private func reloadTableView(){
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
