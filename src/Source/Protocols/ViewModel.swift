//
//  ViewModelProtocols.swift
//  GoodMeals
//
//  Created by Denis Efimov on 4/15/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import RxSwift

protocol ViewModel {
    
    /**
     Contain the logic on the view model for how to populate the view model of the destination segue. i.e you click on a table view cell and it navigates to a detail view
     
     - parameter for: the identifier of the triggered segue.
     - parameter sender: The view model of the sender view controller.
     
     - returns: The view model to be assigned in the destination view.
     **/
    func viewModel(for segueIdentifier: String?, sender: ViewModel?) -> ViewModel?
}

protocol ViewModelNavigation: ViewModel {
    
    /**
     Override this method to navigate to a different segue indentifier
     **/
    func navigate(to segueIdentifier: String?, sender: ViewModel?) -> String?
}

protocol ViewModelWithCollection: ViewModel {
    associatedtype CollectionType: ViewModel
    
    var collection: Observable<[CollectionType]> { get }
}

protocol BaseViewModel: class {
    var baseModel: ViewModel? { get set }
}

protocol TypedViewModel: class {
    associatedtype ViewModelType: ViewModel
    
    var model: ViewModelType? { get set }
    
    func bind()
}
