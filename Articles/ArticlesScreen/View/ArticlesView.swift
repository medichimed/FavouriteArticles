//
//  ArticlesView.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import UIKit

class ArticlesView: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var artecleSegmentedSwitcher: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Poperties
    lazy var viewModel: ArticlesViewModel = {
        let viewModel = ArticlesViewModel(bind: self)
        return viewModel
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        manageTable()
        viewModel.getArticles(for: .topEmailed)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Methods
    private func manageTable() {
        tableView.delegate = viewModel as UITableViewDelegate
        tableView.dataSource = viewModel as UITableViewDataSource
        tableView.tableFooterView = UIView()
    }

    //MARK: - Actions
    @IBAction func segmentedControllTapped(_ sender: UISegmentedControl) {
        let target = ApiPurpose.init(rawValue: sender.selectedSegmentIndex) ?? .topEmailed
        viewModel.getArticles(for: target)
    }
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        guard let targetVC = UIStoryboard.init(name: "FavouriteArticlesList", bundle: nil).instantiateViewController(withIdentifier: "FavouriteArticlesListView") as? FavouriteArticlesListView else { return }
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
}

//MARK: -ArticlesViewModelDelegate protocol conformance
extension ArticlesView: ArticlesViewModelDelegate {
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func getChosenPage(for article: ArticleDetails) {
        guard let targetVC = UIStoryboard.init(name: "ArticleContent", bundle: nil).instantiateViewController(withIdentifier: "ArticleContextView") as? ArticleContextView else { return }
        targetVC.chosenArticle = article
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    var parentVC: UIViewController {
        return self as UIViewController
    }
    
}
