## ROADMAP 1.0.0

* validate that each line starts with BREAKING:/FEATURE:/FIX:
* validate that each release has the appropriate version
* validate that release numbers increase monotonically
* have a README
* support variant versions (rc1, pre, alpha, etc..)
* centralize the version regex (if possible)
* add a `rake changelog:version` to provide the version from the command line

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
