import Foundation

internal struct ResultModifier2D: Geometry2D {
    let body: any Geometry2D
    let modifier: (ResultElementsByType) -> ResultElementsByType

    func codeFragment(in environment: Environment) -> CodeFragment {
        body.codeFragment(in: environment)
    }

    func boundary(in environment: Environment) -> Bounds {
        body.boundary(in: environment)
    }

    func elements(in environment: Environment) -> [ObjectIdentifier: any ResultElement] {
        modifier(body.elements(in: environment))
    }
}

public extension Geometry2D {
    func withResult<E: ResultElement>(_ value: E) -> any Geometry2D {
        ResultModifier2D(body: self) { elements in
            elements.setting(E.self, to: value)
        }
    }

    func modifyingResult<E: ResultElement>(_ type: E.Type, modification: @escaping (E?) -> E?) -> any Geometry2D {
        ResultModifier2D(body: self) { elements in
            elements.setting(E.self, to: modification(elements[E.self]))
        }
    }
}

internal struct ResultModifier3D: Geometry3D {
    let body: any Geometry3D
    let modifier: (ResultElementsByType) -> ResultElementsByType

    func codeFragment(in environment: Environment) -> CodeFragment {
        body.codeFragment(in: environment)
    }

    func boundary(in environment: Environment) -> Bounds {
        body.boundary(in: environment)
    }

    func elements(in environment: Environment) -> [ObjectIdentifier: any ResultElement] {
        modifier(body.elements(in: environment))
    }
}

public extension Geometry3D {
    func withResult<E: ResultElement>(_ value: E) -> any Geometry3D {
        ResultModifier3D(body: self) { elements in
            elements.setting(E.self, to: value)
        }
    }

    func modifyingResult<E: ResultElement>(_ type: E.Type, modification: @escaping (E?) -> E?) -> any Geometry3D {
        ResultModifier3D(body: self) { elements in
            elements.setting(E.self, to: modification(elements[E.self]))
        }
    }
}
