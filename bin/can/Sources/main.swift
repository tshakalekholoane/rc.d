import Darwin
import Foundation

let usage = "usage: can [--] file ..."

let arguments = CommandLine.arguments.dropFirst()

if arguments.isEmpty {
  eprint(usage)
  exit(64)
}

var filePaths: ArraySlice<String>

let argument = arguments.first.expect("at least one argument")
switch argument {
case "--":
  if arguments.count == 1 {
    eprint(usage)
    exit(64)
  }

  filePaths = arguments.dropFirst()
default:
  if argument.starts(with: "-"), argument.count > 1 {
    eprint("can: illegal option \"\(argument)\"\n\(usage)")
    exit(64)
  }

  filePaths = arguments
}

let forbidden: Set = [
  ".",
  "..",
  "./",
  "./.",
  "./..",
  "/",
  "/.",
  "/..",
  "/./.",
  "///",
]

for filePath in filePaths {
  if forbidden.contains(filePath) {
    eprint("can: \"/\", \".\", and \"..\" may not be removed.")
    exit(1)
  }
}

if let user = ProcessInfo.processInfo.environment["SUDO_USER"] {
  guard let entry = getpwnam(user), seteuid(entry.pointee.pw_uid) == 0 else {
    perror(nil)
    exit(1)
  }
}

var status: Int32 = 0

let manager = FileManager.default
for filePath in filePaths {
  do {
    try manager.trashItem(at: URL(filePath: filePath), resultingItemURL: nil)
  } catch {
    eprint("can: \(error.localizedDescription)")
    status = 66
  }
}

exit(status)
