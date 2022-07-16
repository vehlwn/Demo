#!/bin/bash

required_packages=(
    black
    cmakelang
    conan
    matplotlib
    mypy
    neovim
    numpy
    requests
    scipy
    sympy
    telethon
    tensorflow
    tensorflow_probability
)
pip3 install --upgrade --user wheel
pip3 install --upgrade --user ${required_packages[*]}
