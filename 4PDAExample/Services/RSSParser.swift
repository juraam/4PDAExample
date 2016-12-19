//
//  RSSParser.swift
//  4PDAExample
//
//  Created by Admin on 19.12.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import MWFeedParser
import RealmSwift

protocol RSSParserDelegate {
    func loadedComplete(_ info: MWFeedInfo? ,_ items: [FeedInfo]?)
}

class RSSParser: NSObject, MWFeedParserDelegate {
    static let sharedInstance = RSSParser()
    var delegate: RSSParserDelegate?
    
    var feedParser: MWFeedParser?
    
    var items = [FeedInfo]()
    var info: MWFeedInfo?
    
    func load(deleteOld: Bool) {
        let realm = try! Realm()
        if !NetworkService.sharedInstance.internetAvailable {
            items = Array(realm.objects(FeedInfo))
            delegate?.loadedComplete(info, items)
            return
        }
        if deleteOld {
            try! realm.write {
                realm.deleteAll()
            }
        }
        let URL = Foundation.URL(string: "http://4pda.ru/feed/")
        feedParser = MWFeedParser(feedURL: URL)
        feedParser?.connectionType = ConnectionTypeAsynchronously
        feedParser!.delegate = self
        feedParser!.parse()
    }
    
    func feedParserDidStart(_ parser: MWFeedParser) {
        self.items = [FeedInfo]()
    }
    
    func feedParserDidFinish(_ parser: MWFeedParser) {
        delegate?.loadedComplete(info, items)
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
    }
    
    
    func feedParser(_ parser: MWFeedParser, didParseFeedInfo info: MWFeedInfo) {
        self.info = info
    }
    
    func feedParser(_ parser: MWFeedParser, didParseFeedItem item: MWFeedItem) {
        let info = FeedInfo()
        info.author = item.author
        info.link = item.link
        info.date = item.date
        info.title = item.title
        info.summary = item.summary
        self.items.append(info)
    }
}
