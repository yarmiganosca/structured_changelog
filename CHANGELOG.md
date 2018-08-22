## ROADMAP

* investigate partial parsing of a file if parsing slows down *too much* on large changelogs
* validate that each line starts with BREAKING/FEATURE/FIX/ENHANCEMENT/DEPRECATION
* require release block lines to be ordered in descending severity
* disable strict semver version validation before 1.0.0

## RELEASE 0.11.0

* FEATURE: `changelog:preview` task will output a preview of the release section that `changelog:compile` would add to the changelog
* ENHANCEMENT: the `changelog:compile` task now shows up in rake -T listings

## RELEASE 0.10.2

* ENHANCEMENT: release lines can now be embedded in any commit message body

## RELEASE 0.10.1

* FIX: Fixed an issue that resulted in `changelog:compile` pulling in release lines from previous releases

## RELEASE 0.10.0

* FEATURE: `changelog:compile` task that pulls all `[CHANGELOG]` commit messages since the last release, determines the minimum necessary release version, and appends a new section to the top of the releases in the changelog. See the README for more information.

## RELEASE 0.9.0

* FEATURE: `changelog:prep` task that performs `changelog:validate`, `changelog:sync`, and `changelog:commit`.

## RELEASE 0.8.3

* FIX: `Gemfile.lock` now gets updated with the new version before `changelog:commit` runs during `changelog:release`

## RELEASE 0.8.2

* FIX: `rake changelog:commit` now doesn't care if more things change in your Gemfile.lock during release

## RELEASE 0.8.1

* FIX: `rake changelog:commit` wasn't allowing Gemfile.lock to change version.

## RELEASE 0.8.0

* FEATURE: `rake changelog:sync` will update your gem's VERSION constant to your changelog's latest release version. This will let devs stop requiring `structured_changelog` to be installed before they can bundle their projects.
* FEATURE: `rake changelog:release` will validate the Changelog, sync the Changelog release to `VERSION`, commit the version bump, then proceed with the default `rake release` task.

## RELEASE 0.7.2

* FIX: fixed version comparison

## RELEASE 0.7.1

* FIX: stopped trying to hijack gem tasks, as that led to errors in downstream projects
* FIX: added missing require

## RELEASE 0.7.0

* FEATURE: rake changelog:recent displays the N most recent release sections

## RELEASE 0.6.2

* FIX: fixed notes task query for wider version numbers

## RELEASE 0.6.1

* FIX: non-semver versions were temporarily supported; they aren't. variants still are.

## RELEASE 0.6.0

* FEATURE: variant versions (rc1, pre, alpha, etc..) are supported
* FEATURE: non-numbered roadmap versions (for un-released but immediate work) are now supported

## RELEASE 0.5.0

* FEATURE: a `rake changelog:version` to display the current version

## RELEASE 0.4.1

* FIX: with no query, `rake changelog:notes` outputs the notes of the current version (instead of all versions)

## RELEASE 0.4.0

* FEATURE: view the release notes for a version (or range of versions) with "rake changelog:notes"

## RELEASE 0.3.0

* FEATURE: include a changelog:validate task

## RELEASE 0.2.0

* FEATURE: handle ROADMAP blocks

## RELEASE 0.1.0

* FEATURE: handle RELEASE blocks
