//
//  ViewController.swift
//  MVPSample
//
//  Created by Laurynas Letkauskas on 2022-04-21.
//

import UIKit
import Resolver

protocol BooksView: AnyObject {
    func onBooksRetrieved(names: [String])
}

class BooksViewController: UIViewController {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    enum Section {
        case first
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    @LazyInjected var presenter: BooksViewPresenter
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lord of the rings Books"
        tableView.dataSource = makeDataSource()
        $presenter.args = self
        presenter.viewDidLoad()
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, String> {
        UITableViewDiffableDataSource<Section, String>(tableView: tableView) { tableView, indexPath, bookName in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
            
            cell.textLabel?.text = bookName
            return cell
        }
    }
}

extension BooksViewController: BooksView {
    func onBooksRetrieved(names: [String]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.first])
        snapshot.appendItems(names, toSection: .first)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

