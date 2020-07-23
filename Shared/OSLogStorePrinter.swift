import OSLog

func printLogEntries() {
  do {
    let logStore = try OSLogStore(scope: .currentProcessIdentifier)
    print("logStore=\(logStore)")
    let oneHourAgo = logStore.position(date: Date().addingTimeInterval(-3600))
    // TODO: How to format the predicate? See "PREDICATE-BASED FILTERING" in `man log`.
    // Things I tried unsuccessfully:
    // - NSPredicate(format: "subsystem == %@", "net.oleb.OSLogStoreTest")
    // - NSPredicate(format: "subsystem == \"net.oleb.OSLogStoreTest\"")
    let enumerator = try logStore.__entriesEnumerator(position: oneHourAgo, predicate: nil)
    let allEntries = Array(enumerator)
    print("Found \(allEntries.count) log entries")
    let osLogEntryObjects = allEntries.compactMap { $0 as? OSLogEntry }
    let osLogEntryLogObjects = allEntries.compactMap { $0 as? OSLogEntryLog }
    print("– \(osLogEntryObjects.count) of type OSLogEntry")
    print("  – \(osLogEntryLogObjects.count) of type OSLogEntryLog")
    let bySubsystem = Dictionary(grouping: osLogEntryLogObjects) { $0.subsystem }.sorted(by: { $0.key < $1.key })
    let countsBySubsystem = bySubsystem.map { (subsystem: $0.key, count: $0.value.count) }
    let countsBySubsystemString = countsBySubsystem
      .map { "\($0.subsystem.isEmpty ? "(Empty)" : $0.subsystem)=\($0.count)" }
      .joined(separator: ", ")
    print("     – By subsytem: \(countsBySubsystemString)")
    let ourApp = "net.oleb.OSLogStoreTest"
    print("Iterating over entries from \(ourApp):")
    for entry in osLogEntryLogObjects where entry.subsystem == ourApp {
      print("\(entry.date);    \(entry.subsystem);    \(entry.category);    \(entry.composedMessage)")
    }
  } catch {
    print("Error: \(error)")
  }
}
