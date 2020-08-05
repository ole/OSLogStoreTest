import OSLog

func printLogEntries() {
  do {
    let logStore = try OSLogStore(scope: .currentProcessIdentifier)
    print("logStore=\(logStore)")
    
    // OSLogStore.getEntries is not available on iOS. Use OSLogEnumerator.
    let enumerator = try logStore.__entriesEnumerator(position: nil, predicate: nil)
    let allEntries = Array(enumerator)
    let osLogEntryObjects = allEntries.compactMap { $0 as? OSLogEntry }
    let osLogEntryLogObjects = osLogEntryObjects.compactMap { $0 as? OSLogEntryLog }
    print("– \(allEntries.count) entries returned by OSLogEnumerator")
    print("  – \(osLogEntryObjects.count) of type OSLogEntry")
    print("    – \(osLogEntryLogObjects.count) of type OSLogEntryLog")
    
    let bySubsystem = Dictionary(grouping: osLogEntryLogObjects) { $0.subsystem }
      .sorted(by: { $0.key < $1.key })
    let countsBySubsystem = bySubsystem.map { (subsystem: $0.key, count: $0.value.count) }
    let countsBySubsystemString = countsBySubsystem
      .map { "\($0.subsystem.isEmpty ? "(Empty)" : $0.subsystem)=\($0.count)" }
      .joined(separator: ", ")
    print("     – By subsytem: \(countsBySubsystemString)")
    
    let subsystem = Bundle.main.bundleIdentifier!
    print("Iterating over entries from \(subsystem):")
    for entry in osLogEntryLogObjects where entry.subsystem == subsystem {
      print("\(entry.date);    \(entry.subsystem);    \(entry.category);    \(entry.composedMessage)")
    }
  } catch {
    print("Error: \(error)")
  }
}
