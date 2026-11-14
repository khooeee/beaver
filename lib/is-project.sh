# Succeed when $1 is a project repository, and set name to its folder name.
is_project() {
    [ -d "$1" ] || return 1
    name=${1##*/}
    # These directories hold linked worktrees; they are not projects.
    case $name in
        *.worktrees) return 1 ;;
    esac
    # Require the child's own Git metadata; never discover the enclosing repo.
    [ -e "$1/.git" ] || return 1
    git -C "$1" rev-parse --git-dir >/dev/null 2>&1
}
