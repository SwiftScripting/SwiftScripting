import PackageDescription

let package = Package(
    name: "qtrc",
    dependencies: [
        .Package(url: "https://github.com/SwiftScripting/ScriptingSupport.git", majorVersion: 1),
        .Package(url: "https://github.com/SwiftScripting/QuickTimePlayer.git", majorVersion: 10),
        .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0),
    ]
)
