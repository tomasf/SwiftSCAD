//
//  MergeStrategy.swift
//  SwiftSCAD
//
//  Created by Tomas Wincent Franzén on 2024-11-23.
//


internal extension Boundary {
    struct MergeStrategy {
        private let operation: ([Boundary]) -> Boundary?

        init(operation: @escaping ([Boundary]) -> Boundary?) {
            self.operation = operation
        }

        func apply(_ bounds: [Boundary]) -> Boundary {
            operation(bounds) ?? .empty
        }
    }
}

extension Boundary.MergeStrategy {
    static var union: Self {
        Self { .union($0) }
    }

    static var first: Self {
        Self { $0.first }
    }

    static var boxIntersection: Self {
        Self {
            $0.compactMap(\.boundingBox)
                .reduce { $0.intersection(with: $1) ?? .zero }
                .map(Boundary.init(boundingBox:))
        }
    }

    static var minkowskiSum: Self {
        Self { $0.reduce { $0.minkowskiSum($1) } }
    }
}
