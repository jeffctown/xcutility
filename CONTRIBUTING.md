## Pull Requests

All changes, no matter how trivial, must be done via pull request. Commits
should never be made directly on the `master` branch. Prefer rebasing over
merging `master` into your PR branch to update it and resolve conflicts.

_If you have commit access to XCUtility and believe your change to be trivial
and not worth waiting for review, you may open a pull request and merge
immediately, but this should be the exception, not the norm._

### Tests

XCUtility supports building via Xcode and Swift Package Manager on macOS. When contributing code changes, please
ensure that both supported build methods continue to work and pass tests.

```shell
$ make test
$ make xcodetest
```

## Tracking changes

All changes should be made via pull requests on GitHub.

When issuing a pull request, please add a summary of your changes to
the `CHANGELOG.md` file.
