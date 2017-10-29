import Foundation

enum InputMethod: String {
    case us = "com.apple.keylayout.US"
    case cn = "com.apple.inputmethod.SCIM.ITABC"

    mutating func toggle() {
        self = self == .us ? .cn : .us
    }
}

extension InputSource {
    var inputMethod: InputMethod {
        guard let inputMethod = InputMethod(rawValue: id) else {
            fatalError("unexpected keyboard layout: \(id)")
        }
        return inputMethod
    }
}

private var currentIM: InputMethod {
    get {
        let currentSource = InputSource()
        return currentSource.inputMethod
    }
    set {
        let targetInputSource = InputSourceManager.inputSources.first(where: { $0.inputMethod == newValue })
        targetInputSource?.select()
    }
}

InputSourceManager.initialize()

let arguments = CommandLine.arguments

if arguments.count == 1 { // no args
    print("\(currentIM == .us ? 1 : 2)", terminator: "")
} else if arguments.count == 2 {
    switch arguments[1] {
    case "-o":
        currentIM = .cn
    case "-c":
        currentIM = .us
    case "-t":
        currentIM.toggle()
    case "-n":
        print(InputSource().id)
    default:
        fatalError("unexpected fcitx-remote option")
    }
} else {
    fatalError("too many fcitx-remote arguments")
}
