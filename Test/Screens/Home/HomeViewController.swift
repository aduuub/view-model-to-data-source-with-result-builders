//
//  HomeViewController.swift
//  Test
//
//  Created by Adam Wareing on 11/8/2023.
//

import UIKit

// MARK: View protocol

protocol HomeViewProtocol: AnyObject {
    func apply(viewModel: ViewModel<HomeViewSection, HomeViewItem>)
}

// MARK: View controller

class HomeViewController: UIViewController, HomeViewProtocol {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    lazy var dataSource: UICollectionViewDiffableDataSource<HomeViewSection, HomeViewItem> = createDataSource()
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        collectionView.register(BannerCollectionView.self)
        collectionView.dataSource = dataSource
        view.addSubview(collectionView)
    }
    
    func apply(viewModel: ViewModel<HomeViewSection, HomeViewItem>) {
        dataSource.apply(viewModel.snapshot(), animatingDifferences: true)
    }
}

// MARK: Private functions

extension HomeViewController {
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<HomeViewSection, HomeViewItem> {
        .init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .banner(let string):
                let cell: BannerCollectionView = collectionView.dequeueCell(for: indexPath)
                return cell.setup(string)
                
            case .imageContent(let image):
                let cell: BannerCollectionView = collectionView.dequeueCell(for: indexPath)
                return cell.setup(image)
                
            case .videoContent(let video):
                let cell: BannerCollectionView = collectionView.dequeueCell(for: indexPath)
                return cell.setup(video)
            }
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}
