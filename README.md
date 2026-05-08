A lightweight hook to bypass Cocoa's implementation of the new design introduced
in macOS Tahoe.

<!-- prettier-ignore -->
> [!IMPORTANT]
> Feature flags are left untouched. That is, this hook can only ever affect
> individual applications; do not expect the Dock, menu bar, or other system
> widgets to be affected.

## usage

Generate an Xcode project with [XcodeGen], open it and build the shared library,
and then inject the build product into any Cocoa application via
[`DYLD_INSERT_LIBRARIES`][DYLD_INSERT_LIBRARIES].

To automatically inject the library into launched processes, use [Saagar Jha]'s
[library_injector] tool.

To inject into the Finder, you also need to forcibly disable library validation:

```console
sudo defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true
```

[XcodeGen]: https://github.com/yonaskolb/XcodeGen
[Mark Rowe]: https://github.com/bdash
[Saagar Jha]: https://github.com/saagarjha
[library_injector]:
  https://gist.github.com/saagarjha/a70d44951cb72f82efee3317d80ac07f
[DYLD_INSERT_LIBRARIES]:
  https://www.manpagez.com/man/1/dyld/#:~:text=cache%20in%20use.-,DYLD_INSERT_LIBRARIES,-This%20%20is%20%20a

### extras

A tip sourced from [Mark Rowe]: to prevent some SF Symbols from being used as
images within menu items, set the `NSMenuEnableActionImages` defaults key to
`false`. This can be done globally:

```console
defaults write -g NSMenuEnableActionImages -bool NO
```
