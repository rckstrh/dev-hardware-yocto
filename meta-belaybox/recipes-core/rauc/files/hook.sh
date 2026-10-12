#!/bin/sh
# RAUC bundle hook, runs from the bundle on the currently running system.
# Temporary guard: kirkstone -> scarthgap updates leave the device unbootable,
# so refuse the bundle on kirkstone systems until the root cause is fixed.

case "$1" in
  install-check)
    osr=/etc/os-release
    [ -r "$osr" ] || osr=/usr/lib/os-release
    if [ -r "$osr" ]; then
      eval "$(. "$osr" 2>/dev/null; echo "codename='$VERSION_CODENAME' version_id='$VERSION_ID'")"
    fi
    case "$codename:$version_id" in
      kirkstone:*|*:4.0|*:4.0.*)
        echo "Refusing update: kirkstone -> scarthgap updates are currently blocked (known boot failure)" >&2
        exit 10
        ;;
    esac
    # a custom install-check replaces RAUC's default compatible check, so do it here
    if [ "$RAUC_MF_COMPATIBLE" != "$RAUC_SYSTEM_COMPATIBLE" ]; then
      echo "Compatible mismatch: bundle '$RAUC_MF_COMPATIBLE' vs system '$RAUC_SYSTEM_COMPATIBLE'" >&2
      exit 10
    fi
    ;;
esac
exit 0
