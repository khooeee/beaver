# Sourced by each bin script after it sets script_dir.
# Projects live beside the bin directory, at ../projects.
LC_ALL=C
export LC_ALL
projects_link=$script_dir/../projects

if [ ! -d "$projects_link" ]; then
    printf 'Projects directory not found: %s\n' "$projects_link" >&2
    exit 1
fi
