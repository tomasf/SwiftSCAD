import Foundation

struct IfPreview3D: Geometry3D {
	let previewBody: Geometry3D?
	let renderBody: Geometry3D?

	init(ifPreview previewBody: Geometry3D? = nil, ifRender renderBody: Geometry3D? = nil) {
		self.previewBody = previewBody
		self.renderBody = renderBody
	}

	func scadString(in environment: Environment) -> String {
		let previewCode = previewBody?.scadString(in: environment)
		let renderCode = renderBody?.scadString(in: environment)

        if let preview = previewCode, let render = renderCode {
            return "if ($preview) { \(preview) } else { \(render) }"
        } else if let preview = previewCode {
            return "if ($preview) { \(preview) }"
        } else if let render = renderCode {
            return "if (!$preview) { \(render) }"
        } else {
            preconditionFailure("previewBody and renderBody can't both be nil.")
        }
	}
}

public func IfPreview(@UnionBuilder _ preview: () -> Geometry3D, @UnionBuilder ifRender render: () -> Geometry3D) -> Geometry3D {
    IfPreview3D(ifPreview: preview(), ifRender: render())
}

public func IfPreview(@UnionBuilder _ preview: () -> Geometry3D) -> Geometry3D {
    IfPreview3D(ifPreview: preview())
}

public func IfRender(@UnionBuilder _ render: () -> Geometry3D, @UnionBuilder ifPreview preview: () -> Geometry3D) -> Geometry3D {
    IfPreview3D(ifPreview: preview(), ifRender: render())
}

public func IfRender(@UnionBuilder _ render: () -> Geometry3D) -> Geometry3D {
    IfPreview3D(ifRender: render())
}


struct IfPreview2D: Geometry2D {
	let previewBody: Geometry2D?
	let renderBody: Geometry2D?

	init(ifPreview previewBody: Geometry2D? = nil, ifRender renderBody: Geometry2D? = nil) {
		self.previewBody = previewBody
		self.renderBody = renderBody
	}

    func scadString(in environment: Environment) -> String {
        let previewCode = previewBody?.scadString(in: environment)
        let renderCode = renderBody?.scadString(in: environment)

        if let preview = previewCode, let render = renderCode {
            return "if ($preview) { \(preview) } else { \(render) }"
        } else if let preview = previewCode {
            return "if ($preview) { \(preview) }"
        } else if let render = renderCode {
            return "if (!$preview) { \(render) }"
        } else {
            preconditionFailure("previewBody and renderBody can't both be nil.")
        }
    }
}

func IfPreview(@UnionBuilder _ preview: () -> Geometry2D, @UnionBuilder ifRender render: () -> Geometry2D) -> Geometry2D {
    IfPreview2D(ifPreview: preview(), ifRender: render())
}

func IfPreview(@UnionBuilder _ preview: () -> Geometry2D) -> Geometry2D {
    IfPreview2D(ifPreview: preview())
}

func IfRender(@UnionBuilder _ render: () -> Geometry2D, @UnionBuilder ifPreview preview: () -> Geometry2D) -> Geometry2D {
    IfPreview2D(ifPreview: preview(), ifRender: render())
}

func IfRender(@UnionBuilder _ render: () -> Geometry2D) -> Geometry2D {
    IfPreview2D(ifRender: render())
}
