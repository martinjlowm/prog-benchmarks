#!/usr/bin/env bash

for f in "scripts/tables/*"; do
    docker run -it prog-benchmarks "luaenv shell 5.0.3 && lua -e \"$(cat $f)\""
    docker run -it prog-benchmarks "luaenv shell 5.1.5 && lua -e \"$(cat $f)\""
    docker run -it prog-benchmarks "luaenv shell 5.2.4 && lua -e \"$(cat $f)\""
    docker run -it prog-benchmarks "luaenv shell 5.3.3 && lua -e \"$(cat $f)\""
done
