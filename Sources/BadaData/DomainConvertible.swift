import Foundation

protocol DomainConvertible {
    associatedtype DomainType

    var domain: DomainType { get }
    init(domain: DomainType)
}
