trim_string(){
    trim=${1#${1%%[![:space:]]*}}
    trim=${trim%${trim##*[![:space:]]}}
    printf '%s\n' "$trim"
}
s="     hello         world     "
trim_string "$s"

trim_all(){
    set -f
    set -- $*
    printf '%s\n' "$*"
    set +f
}
name="    John is       my name    "
trim_all $name



var="This string contains sub_string1"

case $var in
    *sub_string1*)
        echo "Pattern 1 matched"
    ;;
    
    *sub_string2*)
        echo "Pattern 2 matched"
    ;;
    
    *)
        echo "No pattern matched"
    ;;
esac


# Split a string on a delimiter
split(){
    set -f 
    old_ifs=$IFS 
    IFS=$2
    set -- $1
    printf '%s\n' "$@"
    IFS=$old_ifs
    set +f
}
split "apples,oranges,pears,grapes" ","

# Tri Quotes from string
trim_quotes(){
    set -f
    old_ifs=$IFS
    IFS=\"\'
    set -- $1
    IFS=
    printf '%s\n' "$*"
    IFS=$old_ifs
    set +f

}
var="'Hello', \"World\""
trim_quotes "$var"

#Parsing a key=val file
while IFS='=' read -r key val;do
    [ "${key##\#*}" ] || continue
    printf '%s: %s\n' "$key" "$val"
done < "key-val.txt"


# Get the first N lines of a file

head()
{
    while IFS= read -r line; do
        printf '%s\n' "$line"
        i=$((i+1))
        [ "$i" = "$1" ] && return
    done < "$2"
    [ -n "$line" ] && printf %s "$line"
        
}
head 2 key-val.txt

# for number of lines we can use wc -l command
#alternative way
liness(){
    while IFS= read -r line || [ -n "$line" ];do
    lines=$((lines+1))
    done < "$1"
    printf '%s\n' "$lines"
}
liness ~/.bashrc
#count file and dir under a dir
count()
{
    [ -e "$1" ]  && printf '%s\n' "$#"  || printf '%s\n' 0
}
count ~/Downloads/*

# Creating an empty file
# :>file 
# or >file

# get the directory name of a file path
dirname(){
    dir=${1:-.}
    dir=${dir%%"${dir##*[!/]}"}
    [ "${dir##*/*}" ] && dir=.
    dir=${dir%/*}
    dir=${dir%%"${dir##*[!/]}"}
    printf '%s\n' "${dir:-/}"

    
}
dirname ~/Pictures/Wallpapers/1.jpg

basename(){
    #usage : basename "path" ["suffix"]
    dir=${1%${1##*[!/]}}
    dir=${dir##*/}
    dir=${dir%"$2"}
    printf '%s\n' "${dir:-/}"

}
basename ~/Pictures/Wallpapers/1.jpg
