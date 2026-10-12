# Temporary guard against kirkstone -> scarthgap updates, see files/hook.sh
SRC_URI += "file://hook.sh"
RAUC_BUNDLE_HOOKS[file] = "hook.sh"
RAUC_BUNDLE_HOOKS[hooks] = "install-check"
