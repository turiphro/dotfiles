#!/usr/bin/env python3
# example python command-line tool:
# python implementation of 'cat'

from sys import stdin, stdout

while True:
    line = stdin.readline() # keep streaming
    if not line: # EOF
        break
    stdout.write(line)
    stdout.flush()
