#!/env/zsh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source ~/.config/zsh/functions/pyenv.zsh

project_name="$1"; shift
author_name="$1"; shift
author_email="$1"; shift
language_type="$1"; shift
license_type="$1"

mkdir $project_name
cd $project_name

cp ~/.local/share/mkproject/licenses/${license_type}_license LICENSE.txt
touch HOW_TO_CONTRIBUTE CODE_OF_CONDUCT
mkdir $project_name docs tests
case $language_type in
    python)
        touch $project_name/__init__.py $project_name/app.py
        touch tests/__init__.py tests/test_app.py
        cp ~/.local/share/mkproject/requirements/${language_type}_requirements.txt requirements.txt
        cp ~/.local/share/mkproject/requirements/${language_type}_test-requirements.txt test-requirements.txt
        touch README.rst examples.py
        ;;
esac

sed -i '' -e "s/\[year\]/$(date +"%Y")/" LICENSE.txt
sed -i '' -e "s/\[fullname\]/${author_name} <${author_email}>/" LICENSE.txt
# echo into README.rst

git init -q

echo -n "Provide user name for local git repository: "
read git_username
git config --local user.name "$git_username"

echo -n "Provide user email for local git repository: "
read git_email
git config --local user.email "${git_email:l}"

cp ~/.local/share/misc/gitignore/Python.gitignore .gitignore

case $language_type in
    python)
        mkenv -y
        ;;
esac
