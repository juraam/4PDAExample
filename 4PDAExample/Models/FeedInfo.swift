//
//  FeedInfo.swift
//  4PDAExample
//
//  Created by Admin on 19.12.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import RealmSwift

class FeedInfo: Object {
    dynamic var title: String?
    dynamic var link: String?
    dynamic var date: Date?
    dynamic var summary: String?
    dynamic var author: String?
}
