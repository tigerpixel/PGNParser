//
//  Package.swift
//  PGNParser
//
//  Created by Liam on 01/05/2017.
//  Copyright © 2017 Tigerpixel Ltd. All rights reserved.
//

/// A Currier Package Description for use with the Swift Package Manager

import PackageDescription

let package = Package(
    name: "PGNParser"
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/tigerpixel/Currier.git",
                 majorVersion: 1),
        .Package(url: "https://github.com/tigerpixel/ParserCombinator.git",
                 majorVersion: 1),
        ]
)
