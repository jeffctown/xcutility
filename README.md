# xcodemissing

[![Build Status](https://travis-ci.org/jeffctown/xcodemissing.svg?branch=master)](https://travis-ci.org/jeffctown/xcodemissing)
[![codecov.io](https://codecov.io/github/jeffctown/xcodemissing/coverage.svg?branch=master)](https://codecov.io/github/jeffctown/xcodemissing?branch=master)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/Carthage/Carthage/master/LICENSE.md) 
[![GitHub release](https://img.shields.io/github/release/jeffctown/xcodemissing.svg)](https://github.com/jeffctown/xcodemissing/releases)


xcodemissing is a tool to find and delete files missing from your Xcode project.

## Installation

### Using a pre-built package:

You can install XcodeMissing by downloading `XcodeMissing.pkg` from the
[latest GitHub release](https://github.com/jeffctown/xcodemissing/releases/latest) and
running it.

### Compiling from source:

You can also build from source by cloning this project and running
`make install` (Xcode 10.2 or later).

## Usage


### Help

```
$ xcodemissing help
Available commands:

   delete    Delete files that are not referenced in any Xcode projects
   find      Find files that are not referenced in any Xcode projects
   help      Display general or command-specific help
   version   Display the current version of xcodemissing
```

### Find


#### Find Files Missing from Xcode in the Current Directory

```bash
xcodemissing find
```

#### Find Files In a Specific Path

```bash
xcodemissing find --path ~/MySweetSweetApp/
```

#### Find Only Files With a Certain Extension

```bash
xcodemissing find --extensions .swift
```

#### Find Only Files With Multiple Extensions

```bash
xcodemissing find --extensions .swift,.h,.m
```

#### Find Verbosely

```bash
xcodemissing find --verbose
```

### Find Combined Usage

```bash
xcodemissing find --path ~/MySweetSweetApp/ --extension .swift,.h,.m --verbose
```

### Delete

#### Delete Files Missing from Xcode in the Current Directory

```bash
xcodemissing delete
```

#### Delete Files In a Specific Path

```bash
xcodemissing delete --path ~/MySweetSweetApp/
```

#### Delete Only Files With a Certain Extension

```bash
xcodemissing delete --extensions .swift
```

#### Delete Only Files With Multiple Extensions

```bash
xcodemissing delete --extensions .swift,.h,.m
```

#### Delete Verbosely

```bash
xcodemissing delete --verbose
```

### Delete Combined Usage

```bash
xcodemissing delete --path ~/MySweetSweetApp/ --extension .swift,.h,.m --verbose
```

## License

xcodemissing is released under the [MIT license](LICENSE.md).