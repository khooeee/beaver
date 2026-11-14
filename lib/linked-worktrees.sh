# Print "path<TAB>branch" for each linked worktree of $project.
# Fails when Git cannot list the worktrees.
linked_worktrees() {
    porcelain=$(git -C "$project" worktree list --porcelain 2>/dev/null) || return 1
    wt=
    head=
    branch_ref=
    bare=0
    # Git lists the main worktree first; it is not a linked worktree.
    is_main=1
    while IFS= read -r line || [ -n "$line" ]; do
        case $line in
            '')
                emit_worktree
                ;;
            'worktree '*)
                emit_worktree
                wt=${line#'worktree '}
                ;;
            'HEAD '*)
                head=${line#'HEAD '}
                ;;
            'branch '*)
                branch_ref=${line#'branch '}
                ;;
            bare)
                bare=1
                ;;
            detached)
                branch_ref=
                ;;
        esac
    done <<PORCELAIN
$porcelain
PORCELAIN
    emit_worktree
}

# Print the record for the worktree held in wt, then reset for the next one.
emit_worktree() {
    [ -n "$wt" ] || return 0
    if [ "$is_main" = 1 ]; then
        is_main=0
    elif [ "$bare" = 1 ]; then
        printf '%s\t(bare)\n' "$wt"
    elif [ -n "$branch_ref" ]; then
        printf '%s\t%s\n' "$wt" "${branch_ref#refs/heads/}"
    else
        if ! short=$(git -C "$wt" rev-parse --short HEAD 2>/dev/null); then
            short=$(printf '%.7s' "$head")
        fi
        printf '%s\t(detached at %s)\n' "$wt" "$short"
    fi
    wt=
    head=
    branch_ref=
    bare=0
}
