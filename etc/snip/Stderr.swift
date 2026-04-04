import Foundation

/// Output stream that directs data to standard error.
///
/// - SeeAlso: [Standard library's internal `_Stdout`](https://github.com/swiftlang/swift/blob/b866471e8c03512f81ff71abc97729130f035a25/stdlib/public/core/OutputStream.swift#L559-L578)
struct Stderr: TextOutputStream {
  /// ``TextOutputStream`` conformance.
  func write(_ string: String) {
    FileHandle.standardError.write(Data(string.utf8))
  }
}

/// Writes the textual representations of the given items to standard
/// error.
func eprint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
  var to = Stderr()

  // Swift cannot splat a [Any] array into a variadic parameter, so we
  // manually mirror what `Swift.print` does: stringify each item and
  // join.
  let message = items.map({ "\($0)" }).joined(separator: separator)

  print(message, terminator: terminator, to: &to)
}
