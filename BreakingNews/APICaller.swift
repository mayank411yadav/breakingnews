//
//  APICaller.swift
//  BreakingNews
//
//  Created by Mayank Yadav on 19/07/22.
//

import Foundation


// Models

struct APIResponse: Codable {
    let articles: [Article]
}
struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
struct Source: Codable {
    let name: String
}
