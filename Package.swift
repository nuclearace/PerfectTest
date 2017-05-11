// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "PerfectTest",
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2, minor: 0)
    ]
)
