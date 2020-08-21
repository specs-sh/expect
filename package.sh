name expect

version "$( grep VERSION= expect.sh | sed 's/.*VERSION=\(.*\)/\1/' | sed 's/"//g' )"

description "🧐 Expectations"

main expect.sh

exclude spec/

devDependency spec
devDependency assert
devDependency run