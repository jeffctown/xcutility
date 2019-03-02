# xcutility

[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg?style=for-the-badge)](https://swift.org)
[![GitHub release](https://img.shields.io/github/release/jeffctown/xcutility.svg?style=for-the-badge)](https://github.com/jeffctown/xcutility/releases)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=for-the-badge)](https://raw.githubusercontent.com/jeffctown/xcutility/master/LICENSE.md) 

[![Build Status](https://travis-ci.org/jeffctown/xcutility.svg?&branch=master)](https://travis-ci.org/jeffctown/xcutility)[![codecov.io](https://codecov.io/github/jeffctown/xcutility/coverage.svg?branch=master)](https://codecov.io/github/jeffctown/xcutility?branch=master)

xcutility is a tool to find and delete unused files from Xcode projects.  

It recursively searches through a path to find all of the path's Xcode projects and files, and will tell you which files are not referenced or built in any of your Xcode projects.  

## Installation

### Using a pre-built package:

You can install xcutility by downloading `xcutility.pkg` from the
[latest GitHub release](https://github.com/jeffctown/xcutility/releases/latest) and
running it.

### Compiling from source:

You can also build from source by cloning this project and running
`make install` (Xcode 10.2 or later).

## Quick Start

* Find Swift files not referenced in any Xcode projects:
```xcutility norefs --extensions .swift```

* Find Objective C files not referenced in any Xcode projects:
```xcutility norefs --extensions .m,.h```

* Find Swift & Objective C files not referenced in any Xcode projects:
```xcutility norefs --extensions .m,.h,.swift```

* Find Swift files not compiled in any Xcode projects:
```xcutility unbuilt --extensions .swift```

* Find Objective C files not compiled in any Xcode projects:
```xcutility unbuilt --extensions .m```

* Find Swift & Objective C files not compiled in any Xcode projects:
```xcutility unbuilt --extensions .m,.swift```


## Usage


### Help

```
$ xcutility help
Available commands:

   all       Find files that are not built or referenced in any Xcode projects
   help      Display general or command-specific help
   norefs    Find files that are not referenced in any Xcode projects
   unbuilt   Find files that are referenced in Xcode but not built in any build phases
   version   Display the current version of xcutility
```

### Unreferenced Files


#### Find Files that are Unreferenced by any Xcode Projects in the Current Directory

```bash
xcutility norefs
```

#### Find Files that are Unreferenced by any Xcode Projects In a Specific Path

```bash
xcutility norefs --path ~/MySweetSweetApp/
```

#### Find Files With a Certain Extension that are Unreferenced by any Xcode Projects 

```bash
xcutility norefs --extensions .swift
```

#### Find Only Files With Multiple Extensions that are Unreferenced by any Xcode Projects

```bash
xcutility norefs --extensions .swift,.h,.m
```

#### Find And Delete Files With Multiple Extensions that are Unreferenced by any Xcode Projects

```bash
xcutility norefs --extensions .swift,.h,.m --delete
```

#### Find Unreferenced Files Verbosely

```bash
xcutility norefs --verbose
```

### Find Unreferenced Files Combined Usage

```bash
xcutility norefs --path ~/MySweetSweetApp/ --extension .swift,.h,.m --verbose --delete
```

### Unbuilt Files


#### Find Files that are not built by any Xcode Project Build Phases in the Current Directory

```bash
xcutility unbuilt
```

#### Find Files that are not built by any Xcode Project Build Phases in a specific path

```bash
xcutility unbuilt --path ~/MySweetSweetApp/
```

#### Find Files With a Certain Extension that are not built by any Xcode Projects Build Phases

```bash
xcutility unbuilt --extensions .swift
```

#### Find Only Files With Multiple Extensions that are not built by any Xcode Projects Build Phases

```bash
xcutility unbuilt --extensions .swift,.h,.m
```

#### Find And Delete Files With Multiple Extensions that are not built by any Xcode Projects Build Phases

```bash
xcutility unbuilt --extensions .swift,.m --delete
```

#### Find Unbuilt Files Verbosely

```bash
xcutility unbuilt --verbose
```

### Find Unbuilt Files Combined Usage

```bash
xcutility unbuilt --path ~/MySweetSweetApp/ --extension .swift,.m --verbose --delete
```


## License

xcutility is released under the [MIT license](LICENSE.md).