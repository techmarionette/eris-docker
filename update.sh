if [ "$#" -ne 2 ]; then
    echo "Usage: update <tag> <branch>"
fi

cd "$(dirname "$0")" || exit

git config user.email "reliza@techmarionnete.com"
git config user.name "R. Eliza"

content="$( sed "s/^> Version: .*$/> Version: ${1}/" README.md )"
echo "$content" > README.md

git add .
git commit -m "Update to version ${1}"
git push origin "${2}"
