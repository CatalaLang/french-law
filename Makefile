help : Makefile
	@sed -n 's/^#> //p' $<

OPAM = opam --cli=2.1

CATALA_LIBDIR ?= $(shell $(OPAM) var catala:lib)
CATALA_EXAMPLES_LIBDIR ?= $(shell $(OPAM) var catala-examples:lib)

#-----------------------------------------
# OCaml
#-----------------------------------------

FRENCH_LAW_OCAML_LIB_DIR = ocaml

run_french_law_library_benchmark_ocaml:
	dune exec $(FRENCH_LAW_OCAML_LIB_DIR)/bench.exe

#-----------------------------------------
# JS
#-----------------------------------------

FRENCH_LAW_JS_LIB_DIR = js

dependencies-js:
	npm install benchmark $(CATALA_EXAMPLES_LIBDIR)/french-law_npm.tar.gz

run_french_law_library_benchmark_js: build_french_law_library_js
	node js/examples.js

#-----------------------------------------
# Rescript
#-----------------------------------------

#> build_french_law_library_web_api     : Builds the rescript web API of the French law library
build_french_law_library_web_api:
	cd rescript && yarn && yarn build

#-----------------------------------------
# Python
#-----------------------------------------

# Venv setup

PY_VENV_DIR ?= _python_venv

PY_VENV_ACTIVATE = . $(PY_VENV_DIR)/bin/activate;

# Rebuild when requirements change
$(PY_VENV_DIR): $(PY_VENV_DIR)/stamp

# Setup a venv and intall the Catala runtime from opam
$(PY_VENV_DIR)/stamp:
	test -d $(PY_VENV_DIR) || python3 -m venv $(PY_VENV_DIR)
	$(PY_VENV_ACTIVATE) python3 -m pip install -U pip
	$(PY_VENV_ACTIVATE) python3 -m pip install -U \
	  $(CATALA_LIBDIR)/runtime_python \
	  $(CATALA_EXAMPLES_LIBDIR)/french-law_python.tar.gz
	touch $@

dependencies-python: $(PY_VENV_DIR)

# Python libs

FRENCH_LAW_PYTHON_LIB_DIR=python

#> type_french_law_library_python	       : Types the French law library Python sources with mypy
type_french_law_library_python:
	$(PY_VENV_ACTIVATE) $(MAKE) -C $(FRENCH_LAW_PYTHON_LIB_DIR) type

run_french_law_library_benchmark_python: type_french_law_library_python
	$(PY_VENV_ACTIVATE) $(MAKE) -C $(FRENCH_LAW_PYTHON_LIB_DIR) bench

#########################################
# High-level test and benchmarks commands
#########################################

dependencies: dependencies-js dependencies-python

#> bench_ocaml			  : Run OCaml benchmarks for the Catala-generated code
bench_ocaml: run_french_law_library_benchmark_ocaml

#> bench_js			     : Run JS benchmarks for the Catala-generated code
bench_js: run_french_law_library_benchmark_js

#> bench_python			 : Run Python benchmarks for the Catala-generated code
bench_python: run_french_law_library_benchmark_python

website-assets-base: build_french_law_library_web_api

all: \
  bench_ocaml \
  build_french_law_library_js \
  bench_js \
  bench_python \
  website-assets-base
