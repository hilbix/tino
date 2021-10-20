#!/usr/bin/env python3

import sys
import ruamel.yaml
import json

# this is lacking partial :: support
def store(d, args):
	l = None
	while d and not isinstance(d, (str,bool)) and len(args):
		l	= d
		i	= args.pop(0)
		d	= d[i]
	if len(args)==1:
		l[i] = json.loads(args[0])
		return
	json.dump(d, sys.stdout, indent=2, sort_keys=True)
	print()
	if len(args):
		print('missing sub',json.dumps(args))
		sys.exit(2)
	sys.exit(1)

args = sys.argv
args.pop(0)

FILE=args.pop(0)	# '/etc/foreman-installer/scenarios.d/foreman-answers.yaml'

yaml = ruamel.yaml.YAML()
yaml.preserve_quotes = True

with open(FILE, 'r') as f:
	y	= yaml.load(f)

store(y, args)

with open(FILE, 'w') as f:
	yaml.dump(y, f)

