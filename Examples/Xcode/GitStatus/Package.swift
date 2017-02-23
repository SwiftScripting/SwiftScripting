import PackageDescription

let package = Package(
    name: "GitStatus",
    dependencies: [
        .Package(url: "https://github.com/SwiftScripting/ScriptingSupport.git", majorVersion: 1),
        .Package(url: "https://github.com/SwiftScripting/Git.git", majorVersion: 1),
        .Package(url: "https://github.com/SwiftScripting/Xcode.git", majorVersion: 8),
    ]
)

