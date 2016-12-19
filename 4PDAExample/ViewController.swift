//
//  ViewController.swift
//  4PDAExample
//
//  Created by Admin on 19.12.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import MWFeedParser
import SafariServices
import ESPullToRefresh

class ViewController: UITableViewController, RSSParserDelegate {

    var items: [FeedInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Новости"
        self.tableView.register(UINib(nibName: "RSSCell", bundle: nil), forCellReuseIdentifier: "RSSCell")
        items = [FeedInfo]()
        RSSParser.sharedInstance.delegate = self
        loadWithClear(clearItems: true)
        self.tableView.es_addPullToRefresh {
            [weak self] in
            self?.loadWithClear(clearItems: true)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadWithClear(clearItems: Bool) {
        if clearItems {
            items!.removeAll()
            self.tableView.reloadData()
        }
        RSSParser.sharedInstance.load(deleteOld: clearItems)
    }
    
    func loadedComplete(_ info: MWFeedInfo?, _ items: [FeedInfo]?) {
        self.tableView.es_stopPullToRefresh(completion: true)
        if items != nil {
            self.items!.append(contentsOf: items!)
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = (self.items![indexPath.row]) as FeedInfo
        return RSSCell.heightForText(text: item.summary!)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RSSCell = tableView.dequeueReusableCell(withIdentifier: "RSSCell")! as! RSSCell
        let item = (self.items![indexPath.row]) as FeedInfo
        cell.titleLabel.text = item.title
        cell.descriptionTextView.text = item.summary
        cell.creatorDateLabel.text = item.author! + ", " + DateFormatter.localizedString(from: item.date!, dateStyle: .short, timeStyle: .short)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items![indexPath.row] as FeedInfo
        let svc = SFSafariViewController(url: URL(string: item.link!)!)
        self.navigationController!.pushViewController(svc, animated: true)
    }
}

