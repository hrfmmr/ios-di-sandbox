import Foundation

public protocol UseCaseType {
    associatedtype Parameters
    associatedtype Success
    associatedtype Failure: Error

    func execute(
        _ parameters: Parameters,
        completion: ((Result<Success, Failure>) -> Void)?
    )
}

public class UseCase<Parameters, Success, Failure: Error>: UseCaseType {
    private let box: AnyUseCaseBox<Parameters, Success, Failure>

    public init<T: UseCaseType>(_ base: T)
        where
        T.Parameters == Parameters,
        T.Success == Success,
        T.Failure == Failure
    {
        box = UseCaseBox<T>(base)
    }

    public func execute(_ parameters: Parameters, completion: ((Result<Success, Failure>) -> Void)?) {
        box.execute(parameters, completion: completion)
    }
}

private extension UseCase {
    class AnyUseCaseBox<Parameters, Success, Failure: Error> {
        func execute(_: Parameters, completion _: ((Result<Success, Failure>) -> Void)?) {
            fatalError()
        }
    }

    class UseCaseBox<T: UseCaseType>: AnyUseCaseBox<T.Parameters, T.Success, T.Failure> {
        private let base: T

        init(_ base: T) {
            self.base = base
        }

        override func execute(_ parameters: T.Parameters, completion: ((Result<T.Success, T.Failure>) -> Void)?) {
            base.execute(parameters, completion: completion)
        }
    }
}
