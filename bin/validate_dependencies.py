#!/usr/bin/env python
# -*- coding=utf8 -*-

"""
	author: Vincent Dowling (vdowlin@us.ibm.com)
	usage: python validate_dependencies.py
	description: Validates that the dependencies have been properly installed
"""

# Metadata
__author__ = 'Vincent Dowling'
__email__ = 'vdowlin@us.ibm.com'

import sys
import os

try:
	import flask
	import argparse
	import requests
	import futures
	import cherrypy
	import configparser
	import rr_scorers
	sys.exit(0)
except Exception, e:
	print "[python] Failure when importing dependencies. Exception : %r" % e
	sys.exit(1)
