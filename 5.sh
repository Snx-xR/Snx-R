TIME_START=$(date +%s)
TIME_END=$(date +%s)
# Split time elapsed
H=$(t_ | cut -f1 -d":")
M=$(t_ | cut -f2 -d":")
S=$(t_ | cut -f3 -d":")
echo "$(date -u --date @$(($TIME_END - $TIME_START)) +%H:%M:%S)"; }