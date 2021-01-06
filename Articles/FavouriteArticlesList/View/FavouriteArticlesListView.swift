//
//  FavouriteArticlesListView.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import UIKit

class FavouriteArticlesListView: UIViewController {
   
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    lazy var viewModel: FavouriteArticlesListViewModel = {
        let viewModel = FavouriteArticlesListViewModel(bind: self)
        return viewModel
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        manageTable()
        viewModel.retrieveArticlesFromDataBase()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }

    //MARK: - Methods
    private func manageTable() {
        tableView.delegate = viewModel as UITableViewDelegate
        tableView.dataSource = viewModel as UITableViewDataSource
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Actions
    
}

extension FavouriteArticlesListView: ArticlesViewModelDelegate {
  
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getChosenPage(for article: ArticleDetails) {
        guard let targetVC = UIStoryboard.init(name: "ArticleContent", bundle: nil).instantiateViewController(withIdentifier: "ArticleContextView") as? ArticleContextView else { return }
        targetVC.chosenArticle = article
        targetVC.isFavouriteArticle = true
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    var parentVC: UIViewController {
        return self as UIViewController
    }
}
