#!/usr/bin/env bash 

# Stash a user instagram photos on your drive

if [ $# -eq 0 ] ; then
    echo 'insta.sh [user] - stash which users pictures?'
    exit 1
fi

page="$1"
dir="${1}_images"

if [ ! -d "$dir" ]; then
    mkdir "$dir"
fi

if [ -f "${dir}/${page}" ]; then
    rm "${dir}/${page}"
fi

wget "http://instagram.com/${page}" -P "${dir}"
grep -Po 'http:\\/\\/\K([[:alnum:]]+[.])+com\\/[[:alnum:]]+_7[.]jpg' "${dir}/${page}" |
tr -d '\\' |
grep -v 'instagram' |
xargs wget -P "$dir"
