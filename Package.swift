// swift-tools-version:4.0
//  Package.swift
//  PGNParser
//
//  Created by Liam on 01/05/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/// A PGNParser Package Description for use with the Swift Package Manager

import PackageDescription

let package = Package(
    name: "PGNParser",
    products: [
        .library(name: "PGNParser", targets: ["PGNParser"])
    ],
    dependencies: [
        .package(url: "https://github.com/tigerpixel/Currier.git", from: "1.2.1"),
        .package(url: "https://github.com/tigerpixel/ParserCombinator.git", from: "2.0.1")
        ],
    targets: [
        .target(name: "PGNParser", dependencies: ["Currier", "ParserCombinator"]),
        .testTarget(name: "PGNParserTests", dependencies: ["PGNParser"])
    ]
)
