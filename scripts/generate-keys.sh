#!/bin/sh

while read line; do
    values=(${line//=/ })

    rbenv exec bundle exec pod keys set ${values[0]} ${values[1]}
done < .env

echo 'current keys'
rbenv exec bundle exec pod keys