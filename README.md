A lightweight hook to bypass the new design introduced in macOS Tahoe.

To use, generate an Xcode project with
[XcodeGen](https://github.com/yonaskolb/XcodeGen), open it and build the shared
library, and then inject the build product into any Cocoa application via
`DYLD_INSERT_LIBRARIES`.
