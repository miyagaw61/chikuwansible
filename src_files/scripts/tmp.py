#!/usr/bin/env python3

from enert import *
import os
this_file = os.path.basename(__file__)

cmd = """lf"""
files, _ = Shell(cmd).readlines()

for f in files:
    if f == this_file or f == 's' or f == 'desktop.ini':
        continue
    n = 'new_' + f
    print(f'{f}')
