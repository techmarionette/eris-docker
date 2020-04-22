if [ "$#" -ne 2 ]; then
    echo "Usage: update <tag> <branch>"
fi

content="$( sed "s/^> Version: .*$/> Version: ${1}/" README.md )"
echo "$content" > README.md

git add .
git commit -m "Update to version ${1}"
git push origin "${2}"
