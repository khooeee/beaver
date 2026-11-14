# Set default to the default branch of $project, or empty when unknown.
set_default() {
    default=
    if ref=$(git -C "$project" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null); then
        case $ref in
            origin/*) default=${ref#origin/} ;;
            *) default=$ref ;;
        esac
    elif git -C "$project" show-ref --verify --quiet refs/heads/main; then
        default=main
    elif git -C "$project" show-ref --verify --quiet refs/heads/master; then
        default=master
    fi
}
