# Print each remote-tracking branch of $project other than $default,
# one per line.
remote_branches() {
    # strip=2 keeps origin/HEAD; refname:short collapses that ref to origin.
    git -C "$project" for-each-ref --format='%(refname:strip=2)' refs/remotes |
        while IFS= read -r branch; do
            [ -n "$branch" ] || continue
            case $branch in
                */HEAD) continue ;;
            esac
            [ -n "$default" ] && [ "${branch#*/}" = "$default" ] && continue
            printf '%s\n' "$branch"
        done
}
