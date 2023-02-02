yarn global add gitbook-cli

gitbook build

git checkout gh-pages

cp -R _book/* ./

git add .

git commit -m "update"

git push

git checkout master

