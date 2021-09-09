#!usr/bin/python3
#apt install.py

import apt
import sys

pkg_name=input("Aranan paket: ")

cache=apt.cache.Cache()
cache.update()
cache.open()


pkg = cache[pkg_name]
if pkg.is_installed:
    print("{pkg_name} önceden indirilmiş)".format(pkg_name=pkg_name))
else:
    pkg.mark_install()
