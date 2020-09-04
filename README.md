# OSLogStoreTest

Test app for evaluating if apps can access their own OSLog logs via [`OSLogStore`](https://developer.apple.com/documentation/oslog/oslogstore?language=objc) in iOS 14 and/or macOS 11.0.

## iOS 14

I can’t get it to work on an iOS device running iOS 14.0 beta 1–6. I can instantiate an `OSLogStore` and `OSLogEnumerator`, but the enumerator doesn’t provide any log entries (unless I’m holding it wrong), and I’m seeing this error message in the Xcode console:

On iOS 14.0 beta 7 the sample crashes with:
```
+[OSLogStore storeWithScope:error:]: unrecognized selector sent to class 0x1fceb5728
```
Given Xcode 12 beta 7 isn't released yet, I dumped the OSLogStore classs and it would seem the method was removed without an obvious replacement to call.

```
Error Error Domain=NSCocoaErrorDomain Code=4099
"The connection to service on pid 0 named com.apple.OSLogService
was invalidated." UserInfo={NSDebugDescription=The connection to
service on pid 0 named com.apple.OSLogService was invalidated.}
```

When running in the iOS simulator, the error message is different:

```
Error Domain=OSLogErrorDomain Code=9
"Client lacks entitlement to perform operation"
UserInfo={NSLocalizedDescription=Client lacks entitlement
to perform operation, _OSLogErrorInternalCode=14}
```

Apple engineers have confirmed this is a bug. I hope it will get fixed before the final iOS 14 release.

* [Tweet by Brandon Titus](https://twitter.com/bjtitus/status/1276211162506424323)
* [Tweet by Quinn “The Eskimo!”](https://twitter.com/justkwin/status/1276271590360199172)

## macOS 11.0 Big Sur

The code works as expected in the macOS target.

## More about OSLog in iOS 14 and macOS 11

See Peter Steinberger's article: [Logging in Swift](https://steipete.com/posts/logging-in-swift/) (08/2020)

