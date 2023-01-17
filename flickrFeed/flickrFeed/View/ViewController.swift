//
//  ViewController.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/02.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        resetSearch()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
    }
    
    private func judgeKeyword(_ text: String) -> String? {
        // Remove space at the beginning and end of keyword, eg: "  abc  " -> "abc"
        // Guard empty string, eg: ""
        // Guard string that only has whitespace, eg: "   "
        // Do not search twice
        let keyword = text.trimmingCharacters(in: .whitespaces)
        guard !keyword.isEmpty,
              keyword != viewModel.lastSearchedText
        else { return nil }
        return keyword
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "Cell", bundle: .main), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    func resetSearch() {
        viewModel.getData { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.tableView.layoutIfNeeded()
            }
        }
    }
    
    func search(_ keyword: String) {
        viewModel.getData(keyword) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.viewModel.lastSearchedText = keyword
                self?.tableView.reloadData()
                self?.tableView.layoutIfNeeded()
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              let keyword = judgeKeyword(text)
        else { return }
        search(keyword)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetSearch()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.configure(viewModel.items[indexPath.row]) {
            cell.layoutIfNeeded()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: true, completion: nil)
        detailViewController.setup(viewModel.items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let image = UIImage(url: viewModel.items[indexPath.row].media.m)
        //let aspect = image.size.height / image.size.width
        //return (tableView.bounds.width - 16) * aspect + 16
        return UITableView.automaticDimension
        
        /* 拓展: 根据文字计算高度
        let attribute = [NSShadowAttributeName:UIFont.systemFont(ofSize: 15)]
        return textString.boundingRect(with: CGSize.init(width: 300, height: 0), options: .usesDeviceMetrics, attributes: attribute, context: nil).size.width+10
         */

    }
}
