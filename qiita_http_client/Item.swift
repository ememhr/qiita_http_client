//
//  Item.swift
//  qiita_http_client
//
//  Created by Hiromichi Ema on 2017/03/24.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

struct Item: JSONDecodable{
    
    let renderedBody: String
    let body: String
    let id: String
    let tags: [Tag]
    let title: String
    let url: URL
    let user: User
    
    init(json: Any) throws {
        guard let dict = json as? [String: Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let renderedBody = dict["rendered_body"] as? String else {
            throw JSONDecodeError.missingValue(key: "renderedBody", actualValue: dict["rendered_body"])
        }
        
        guard let body = dict["body"] as? String else {
            throw JSONDecodeError.missingValue(key: "body", actualValue: dict["body"])
        }
        
        guard let id = dict["id"] as? String else {
            throw JSONDecodeError.missingValue(key: "id", actualValue: dict["id"])
        }
        
        guard let tagObjs = dict["tags"] as? [[String: Any]] else {
            throw JSONDecodeError.missingValue(key: "tags", actualValue: dict["tags"])
        }
        
        guard let title = dict["title"] as? String else {
            throw JSONDecodeError.missingValue(key: "title", actualValue: dict["title"])
        }
        
        guard let urlStr = dict["url"] as? String else {
            throw JSONDecodeError.missingValue(key: "url", actualValue: dict["url"])
        }
        
        guard let userObj = dict["user"] as? [String: Any] else {
            throw JSONDecodeError.missingValue(key: "user", actualValue: dict["user"])
        }
        
        self.renderedBody = renderedBody
        self.body = body
        self.id = id
        self.tags = try tagObjs.map {
            return try Tag(json: $0)
        }
        
        self.title = title
        self.url = URL(string: urlStr)!
        self.user = try User(json: userObj)
    }
}
