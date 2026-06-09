//
//  ProductListViewModel.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

protocol ProductListViewModelDelegate: AnyObject{
    func didUpdateProducts()
    func didFail(withError: AppError, type: ProductListViewModel.ErrorType)
    func showLoader(_ show: Bool, type: ProductListViewModel.LoaderType?)
}

class ProductListViewModel{
    
    enum LoaderType{
        case fullScreen
        case footer
    }
    
    enum ErrorType{
        case fullScreen
        case footer
    }
    
    private lazy var listRepository: ProductListAPIRepository = {
        return ProductListAPIRepository()
    }()
    
    weak var delegate: ProductListViewModelDelegate?
    
    private(set) var products: [Product] = []{
        didSet{
            delegate?.didUpdateProducts()
        }
    }
    
    func fetchFirstPage(){

        self.delegate?.showLoader(true, type: .fullScreen)
        listRepository.fetchFirstPage { [weak self] response in
            
            //NOTE:  This dispatch queue with deadline is just to show loader to evaluator because there's no delay to fetch data from server, this is not ideal in realtime projects. In realtime we will have to directly use DispatchQueue.main.async{ }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self?.delegate?.showLoader(false, type: .fullScreen)
                self?.handleProducts(response: response, existing: [], type: .fullScreen)
            }
           
        }
    }
    
    func fetchNextPage(){
        
        guard listRepository.hasMorePages else { return }
        
        self.delegate?.showLoader(true, type: .footer)
        listRepository.fetchNextPage { [weak self] response in
            
            //NOTE:  This dispatch queue with deadline is just to show loader to evaluator because there's no delay to fetch data from server, this is not ideal in realtime projects. In realtime we will have to directly use DispatchQueue.main.async{ }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self?.delegate?.showLoader(false, type: .footer)
                self?.handleProducts(response: response, existing: self?.products ?? [], type: .footer)
            }
            
        }
    }
    
    private func handleProducts(response: APIResponse<ProductListResponse>, existing: [Product], type: ErrorType){
        
        switch response {
        case .success(let data):
            var new = existing
            new.append(contentsOf: data.data ?? [])
            self.products = new
        case .failure(let error):
            self.delegate?.didFail(withError: error, type: type)
        }
    }
    
}
