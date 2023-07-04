//
//  Package.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/07/05.
//

// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_11)],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.49.0"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
