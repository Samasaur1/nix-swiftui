import Foundation
import SwiftUI

struct MyView: View {
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("# Hello")
    }
}
struct MyScene: Scene {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            MyView()
                .onAppear {
                    print("onAppear")
                    NSApplication.shared.activate(ignoringOtherApps: true)
                }
                .onDisappear {
                    print("onDisappear")
                }
        }
    }
}
struct MyApp: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        MyScene()
    }
}

signal(SIGINT) { sig in
    print() // clear line
    exit(1)
}

NSApplication.shared.setActivationPolicy(.regular)
MyApp.main()
