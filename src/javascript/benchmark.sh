#!/usr/bin/env bash

for f in "*.js"; do
    docker run -it prog-benchmarks "nodenv shell 6.12.3 && node <<EOF
$(cat $f)
EOF"
    docker run -it prog-benchmarks "nodenv shell 7.10.1 && node <<EOF
$(cat $f)
EOF"
    docker run -it prog-benchmarks "nodenv shell 8.9.4 && node <<EOF
$(cat $f)
EOF"
    docker run -it prog-benchmarks "nodenv shell 9.4.0 && node <<EOF
$(cat $f)
EOF"
done
