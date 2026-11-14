# Print each local branch of $project other than $default, one per line.
local_branches() {
    git -C "$project" for-each-ref --format='%(refname:short)' refs/heads |
        while IFS= read -r branch; do
            [ -n "$branch" ] || continue
            [ "$branch" = "$default" ] && continue
            printf '%s\n' "$branch"
        done
}
