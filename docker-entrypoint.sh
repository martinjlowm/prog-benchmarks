#!/bin/bash

eval "$(luaenv init -)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"

eval "$@"
