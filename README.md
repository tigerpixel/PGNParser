# PGNParser

[![Build Status](https://travis-ci.org/tigerpixel/PGNParser.svg?branch=master)](https://travis-ci.org/tigerpixel/PGNParser)
[![Version](https://img.shields.io/cocoapods/v/PGNParser.svg?style=flat)](http://cocoapods.org/pods/PGNParser)
[![Platform](https://img.shields.io/cocoapods/p/PGNParser.svg?style=flat)](http://cocoapods.org/pods/PGNParser)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/PGNParser.svg?style=flat)](http://cocoapods.org/pods/PGNParser)

PGNParser is designed to parse [Portable Game Notation](https://en.wikipedia.org/wiki/Portable_Game_Notation) files describing Chess and Draughts moves into simple Swift structures.

Currently, only the draughts game strings have been implemented. Pull requests are welcome for further features.

Parsing can be enacted by simply making a single call on the draughts move objects.

A result type will be returned which will contain the resulting move array or details of any failure.

A failure contains an enumeration describing the reason for the failure and usually the token which failed.

The following will parse to on DraughtsMove structure containing a black and a white move.

```swift
let sinlgeMoveTwoPlayers = "1. 9-14 23-18"

switch DraughtsMove.parse(fromPortableGameNotation: sinlgeMoveTwoPlayers) {
case .success(let moves, let tail):
// moves - a list of the above moves and any comments parsed into DraughtsMove structs.
case .failure(let reason):


}
```

## Requirements

There are 2 external requirements for this project. Both by Tigerpixel, the same authors.

[Currier](https://github.com/tigerpixel/Currier.git) - A helper for currying functions and initializers which is used with the project.
[ParserCombinator](https://github.com/tigerpixel/ParserCombinator.git) - A General parser combinator which is extended to build PGNParser.

- iOS 8.0+ / macOS 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 11+
- Swift 5.1+

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager) is the official tool for managing the distribution of Swift code. It is currently available for all Apple platforms. It can also be used with Linux but this project does not fully support Linux at this point in time.

If you use it to manage your dependencies, simply add PGNParser to the dependencies value of your Package.swift file.

```swift
dependencies: [
.package(url: "https://github.com/Tigerpixel/PGNParser.git", from: "0.4.0"),
]
```

The Swift Package Manager can resolve sub-dependencies.

### Cocoapods

PGNParser is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "PGNParser"
```

### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage) to manage your dependencies, simply add the following lines to your Cartfile:

```ogdl
github "tigerpixel/PGNParser"
github "tigerpixel/Currier"
github "tigerpixel/ParserCombinator"
```

If you use Carthage to build your dependencies, make sure you have added `PGNParser.framework`, `Currier.framework` and `ParserCombinator.framework`  to the "_Linked Frameworks and Libraries_" section of your target, and have included them in your Carthage framework copying build phase.

### Git Submodule

1. Add the PGNParser repository as a [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) of your application’s repository.
1. Run `git submodule update --init --recursive` from within the PGNParser folder.
1. Drag and drop `PGNParser.xcodeproj` into your application’s Xcode project or workspace.
1. On the “General” tab of your application target’s settings, add `PGNParser.framework`. to the “Embedded Binaries” section.
1. If your application target does not contain Swift code at all, you should also set the `EMBEDDED_CONTENT_CONTAINS_SWIFT` build setting to “Yes”.

## MIT License

PGNParser is available under the MIT license. Details can be found within the LICENSE file.
