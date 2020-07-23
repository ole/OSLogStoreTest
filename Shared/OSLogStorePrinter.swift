import OSLog

func printLogEntries() {
  do {
    let logStore = try OSLogStore(scope: .currentProcessIdentifier)
    print("logStore=\(logStore)")
    let oneHourAgo = logStore.position(date: Date().addingTimeInterval(-3600))
    let enumerator = try logStore.__entriesEnumerator(position: oneHourAgo, predicate: nil)
    for entry in enumerator {
      print("Log entry: \(entry)")
    }
  } catch {
    print("Error: \(error)")
  }
}
