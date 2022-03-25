import Foundation

public protocol UseCaseType {
    associatedtype Parameters
    associatedtype Success
    associatedtype Failure: Error

    func execute(_ parameters: Parameters) async -> Result<Success, Failure>
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

    public func execute(_ parameters: Parameters) async -> Result<Success, Failure> {
        await box.execute(parameters)
    }
}

private extension UseCase {
    class AnyUseCaseBox<Parameters, Success, Failure: Error> {
        func execute(_: Parameters) async -> Result<Success, Failure> {
            fatalError()
        }
    }

    class UseCaseBox<T: UseCaseType>: AnyUseCaseBox<T.Parameters, T.Success, T.Failure> {
        private let base: T

        init(_ base: T) {
            self.base = base
        }

        override func execute(_ parameters: T.Parameters) async -> Result<T.Success, T.Failure> {
            await base.execute(parameters)
        }
    }
}
