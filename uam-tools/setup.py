"""setup.py: setuptools control."""
 
from setuptools import setup
 
with open("README", "rb") as f:
    long_descr = f.read().decode("utf-8")
 
 
setup(
    name = "uamtools",
    packages = ["uamtools"],
    entry_points = {
        "console_scripts": ['uamtools = uamtools.uamtools:main']
        },
    version = .1,
    description = "Upper Airway Modelling Tools.",
    long_description = long_descr,
    author = "Leonhard Hauptfeld",
    author_email = "leonhard@hauptfeld.com",
    url = "",
    )