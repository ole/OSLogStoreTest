import OSLog
import SwiftUI

struct ContentView: View {
  static let logger = Logger(subsystem: "ContentView", category: "counter")

  @State private var counter: Int = 0

  var body: some View {
    VStack {
      VStack {
        Text("Play with the stepper to generate some OSLog messages")
        Stepper("Counter: \(counter)", value: $counter, in: 0...100)
          .font(.title)
          .padding([.top, .bottom], 16)
        Text("You should see log messages in the Xcode console as you change the counter.")
      }
      .padding()
      VStack {
        Text("Then tap the button to attempt to read the logs from OSLogStore")
        Button("Read from OSLogStore") {
          // Attempt to read the logs using OSLogStore
          OSLogStorePrinter.printLogs()
        }
        .font(.title)
        .padding([.top, .bottom], 16)
        Text("""
          If it works, you should see the log messages (and no errors) printed in the Xcode console.

          I can't get it to work on an iOS device running iOS 14.0 beta 1.

          But maybe it works on macOS? I don't have a Big Sur installation yet.
          """)
      }
      .padding()
      Spacer()
    }
    .onChange(of: counter) { value in
      // Log counter value every time it changes
      Self.logger.error("counter=\(counter)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
