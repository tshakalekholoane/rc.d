import Foundation

/// Output stream that directs data to standard error.
///
/// - SeeAlso: [Standard library's internal `_Stdout`](https://tshaka.dev/a/1TOJ1CJ).
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
