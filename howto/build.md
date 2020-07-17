# Debian Build System

## HowTo

Skip packages to build?

- `dh --no-package=package-name`
- Example `debian/rules` (from Florian Haftmann, LHM) which allows to skip some packages on build with just a `touch debian/package.skip`:

```
SKIP_PACKAGES := $(foreach SKIP,$(wildcard debian/*.skip),--no-package=$(basename $(notdir $(SKIP))))
%:
	dh $@ ${SKIP_PACKAGES}
```
