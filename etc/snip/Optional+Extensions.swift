import Foundation

extension Optional {
  /// Returns `Wrapped` value or traps with a fatal error `message` if
  /// `Wrapped` is `.none`.
  func expect(_ message: String) -> Wrapped {
    switch self {
    case let .some(wrapped):
      wrapped
    case .none:
      fatalError("expected \(message)")
    }
  }
}
