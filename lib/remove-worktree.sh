# Remove the linked worktree at $wt from $project, counting the result in
# removed_wt or failed. Falls back to unregistering a worktree Git refuses
# to remove, leaving its checkout in place.
remove_worktree() {
    if [ ! -e "$wt" ]; then
        find_admin && unregister_admin
        git -C "$project" worktree prune >/dev/null 2>&1 || true
        printf 'pruned missing worktree %s\n' "$wt"
        removed_wt=$((removed_wt + 1))
        return 0
    fi

    if [ -d "$wt/.git" ]; then
        if find_admin && unregister_admin; then
            printf 'unregistered worktree (full .git left in place): %s\n' "$wt"
            removed_wt=$((removed_wt + 1))
        else
            printf 'failed to unregister worktree %s\n' "$wt" >&2
            failed=$((failed + 1))
        fi
        return 0
    fi

    find_admin || admin=
    if gitfile_target && [ -n "$admin" ] && [ "$pointed" != "$admin" ]; then
        printf 'gitdir: %s\n' "$admin" >"$wt/.git"
        printf 'repaired gitfile %s\n' "$wt"
    fi

    if try_git_remove; then
        printf 'removed worktree %s\n' "$wt"
        removed_wt=$((removed_wt + 1))
        return 0
    fi

    if [ -n "$admin" ] && unregister_admin; then
        printf 'unregistered stale worktree %s (checkout left in place)\n' "$wt"
        removed_wt=$((removed_wt + 1))
    else
        printf 'failed to remove worktree %s\n' "$wt" >&2
        failed=$((failed + 1))
    fi
}

# Set common to the absolute Git common directory of $project.
set_common() {
    common=$(git -C "$project" rev-parse --path-format=absolute --git-common-dir 2>/dev/null) ||
        common=
    if [ -z "$common" ] || [ ! -d "$common" ]; then
        rel=$(git -C "$project" rev-parse --git-common-dir) || return 1
        case $rel in
            /*) common=$rel ;;
            *) common=$(CDPATH= cd -- "$project/$rel" && pwd) || return 1 ;;
        esac
    fi
}

# Set admin to the administrative directory Git keeps for $wt.
find_admin() {
    admin=
    set_common || return 1
    [ -d "$common/worktrees" ] || return 1
    for cand in "$common/worktrees"/*; do
        [ -f "$cand/gitdir" ] || continue
        pointed=$(tr -d '\r' <"$cand/gitdir")
        [ "$pointed" = "$wt/.git" ] || continue
        admin=$cand
        return 0
    done
    return 1
}

# Set pointed to the gitdir that the .git file in $wt points at.
gitfile_target() {
    pointed=
    [ -f "$wt/.git" ] || return 1
    line=$(tr -d '\r' <"$wt/.git")
    case $line in
        gitdir:*) ;;
        *) return 1 ;;
    esac
    pointed=${line#gitdir:}
    while [ "$pointed" != "${pointed# }" ]; do
        pointed=${pointed# }
    done
    [ -n "$pointed" ]
}

unregister_admin() {
    [ -n "$admin" ] || return 1
    rm -rf -- "$admin"
    git -C "$project" worktree prune >/dev/null 2>&1 || true
}

try_git_remove() {
    git -C "$project" worktree unlock -- "$wt" >/dev/null 2>&1 || true
    git -C "$project" worktree remove -- "$wt" >/dev/null 2>&1 && return 0
    git -C "$project" worktree remove --force -- "$wt" >/dev/null 2>&1
}
