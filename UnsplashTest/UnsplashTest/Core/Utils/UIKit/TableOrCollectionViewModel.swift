//
//  TableOrCollectionViewModel.swift
//  UnsplashTest
//
//  Created by Mathis DETOURBET on 19/05/2022.
//

import Foundation

protocol TableOrCollectionViewModel {
    associatedtype List: Sequence
    var viewableList: List { get }

    var numberOfSections: Int { get }

    func numberOfItemsIn(_ section: Int) -> Int
    func elementAt(_ indexPath: IndexPath) -> List.Element
}

extension TableOrCollectionViewModel where List: Collection {
    var numberOfSections: Int { return 1 }

    func numberOfItemsIn(_ section: Int) -> Int {
        return viewableList.count
    }

    func elementAt(_ indexPath: IndexPath) -> List.Element {
        guard case 0...viewableList.count = indexPath.row else {
            fatalError("model object cannot be found at row: \(indexPath.row)!")
        }
        let index = viewableList.index(viewableList.startIndex, offsetBy: indexPath.row)
        return viewableList[index]
    }
}
