# Print tab-separated rows from stdin under the given column headers,
# padding every column but the last.
print_table() {
    {
        (IFS=$(printf '\t'); printf '%s\n' "$*")
        cat
    } | awk -F '\t' -v cols="$#" '
        {
            for (c = 1; c <= cols; c++) {
                cell[NR, c] = $c
                if (length($c) > width[c]) width[c] = length($c)
            }
        }
        END {
            for (r = 1; r <= NR; r++) {
                line = ""
                for (c = 1; c < cols; c++)
                    line = line sprintf("%-*s  ", width[c], cell[r, c])
                print line cell[r, cols]
            }
        }
    '
}
