A lightweight hook to bypass the new design introduced in macOS Tahoe.

To use, generate an Xcode project with
[XcodeGen](https://github.com/yonaskolb/XcodeGen), open it and build the shared
library, and then inject the build product into any Cocoa application via
`DYLD_INSERT_LIBRARIES`.

To automatically inject the library into launched processes, use
[Saagar Jha](https://github.com/saagarjha)'s
[library_injector](https://gist.github.com/saagarjha/a70d44951cb72f82efee3317d80ac07f)
tool.

If you wish to inject into the Finder, you also need to forcibly disable library
validation:

```console
sudo defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true
```
