#!/bin/bash

which conda

conda list | grep "gcc\|openmpi\|jdk\|ant\|swig\|swift"
