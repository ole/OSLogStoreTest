# OSLogStoreTest

Test app for evaluating if apps can access their own OSLog logs via [`OSLogStore`](https://developer.apple.com/documentation/oslog/oslogstore?language=objc) in iOS 14 and/or macOS 11.0.

## iOS 14

I can’t get it to work on an iOS device running iOS 14.0 beta 1. I can instantiate an `OSLogStore` and `OSLogEnumerator`, but the enumerator doesn’t provide any log entries (unless I’m holding it wrong), and I’m seeing this error message in the Xcode console:

```
Error Error Domain=NSCocoaErrorDomain Code=4099 "The connection to service on pid 0 named com.apple.OSLogService was invalidated." UserInfo={NSDebugDescription=The connection to service on pid 0 named com.apple.OSLogService was invalidated.}
```

## macOS 11.0 Big Sur

I haven’t got a Big Sur machine yet. If you have one, please clone the repository and build and run it in Xcode 12 on macOS 11. I’d love to know if it works.
