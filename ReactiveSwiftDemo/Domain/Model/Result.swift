import Foundation
public enum Loadable<T> {
    case Success(data: T)
    case Error(error: Error)
    case Loading
}
