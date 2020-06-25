#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Written in Obj-C because OSLogStoreEnumerator is not exposed to Swift.
@interface OSLogStorePrinter : NSObject

+ (void)printLogs;

@end

NS_ASSUME_NONNULL_END
