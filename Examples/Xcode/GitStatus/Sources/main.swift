import Foundation
import Git
import ScriptingBridge
import ScriptingSupport
import Xcode

let xcode = application(name: "Xcode") as! XcodeApplication

let project = xcode.activeWorkspaceDocument?.file?.deletingPathExtension().lastPathComponent ?? "(unknown)"

if let rootDir = xcode.activeWorkspaceDocument?.file?.deletingLastPathComponent()
{
    let branch = Git(in: rootDir, command: "rev-parse", arguments: ["--abbrev-ref", "HEAD"])
    let branchName = branch.standardOutput ?? "(unknown)"

    let diff = Git(in: rootDir, command: "diff", arguments: ["--no-ext-diff", "--quiet", "--exit-code"])
    let modified = diff.terminationStatus != 0

    let diffIndex = Git(in: rootDir, command: "diff-index", arguments: ["--cached", "--quiet", "HEAD", "--"])
    let added = diffIndex.terminationStatus != 0

    let message: String
    switch (modified, added) {
    case (false, false):
        message = "Working directory is clean"
    case (true, false):
        message = "Files modified"
    case (false, true):
        message = "Files added to index"
    case (true, true):
        message = "Files modified and added to index"
    }

    print("\(project)\n⎇ \(branchName)\(message)")
    ShowNotification(title: "\(project)", subtitle: "⎇ \(branchName)", message: message)
}

