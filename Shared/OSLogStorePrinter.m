#import "OSLogStorePrinter.h"
@import OSLog;

@implementation OSLogStorePrinter

+ (void)printLogs {
  NSError *error = nil;
  OSLogStore *logStore = [OSLogStore storeWithScope:OSLogStoreCurrentProcessIdentifier error:&error];
  if (logStore == nil) {
    NSLog(@"Error creating OSLogStore: %@", error);
    return;
  }
  NSLog(@"logStore: %@", logStore);

  OSLogEnumerator *enumerator = [logStore entriesEnumeratorAndReturnError:&error];
  if (enumerator == nil) {
    NSLog(@"Error creating OSLogEnumerator: %@", error);
    return;
  }
  NSLog(@"enumerator: %@", enumerator);

  NSLog(@"Start enumerating log entries");
  for (OSLogEntry *entry in enumerator) {
    NSLog(@"Log entry: %@", entry);
  }
}

@end
