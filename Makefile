help : Makefile
	@sed -n 's/^#> //p' $<

CATALA_LIBDIR ?= $(shell ocamlfind query catala)
CATALA_EXAMPLES_LIBDIR ?= $(shell ocamlfind query catala-examples)

#-----------------------------------------
# OCaml
#-----------------------------------------

FRENCH_LAW_OCAML_LIB_DIR = ocaml

dependencies-ocaml:
	opam --cli=2.1 install "benchmark>=1.6"
# Note: we could use `opam --cli=2.1 install . --deps-only`, but would rather
# not include catala and catala-examples in the automatically installed
# dependencies since they are likely to be installed by hand.

french_law_library_ocaml:
	dune build @install

run_french_law_library_benchmark_ocaml: french_law_library_ocaml
	dune exec $(FRENCH_LAW_OCAML_LIB_DIR)/bench.exe

#-----------------------------------------
# JS
#-----------------------------------------

FRENCH_LAW_JS_LIB_DIR = js

dependencies-js:
	npm install benchmark $(CATALA_EXAMPLES_LIBDIR)/french-law_npm.tar.gz

run_french_law_library_benchmark_js:
	node js/examples.js

#-----------------------------------------
# Rescript
#-----------------------------------------

#> build_french_law_library_web_api     : Builds the rescript web API of the French law library
build_french_law_library_web_api:
	cd rescript && \
	yarn add $(CATALA_LIBDIR)/runtime_rescript \
	         $(CATALA_EXAMPLES_LIBDIR)/french-law_npm.tar.gz && \
	yarn && yarn build

#-----------------------------------------
# Python
#-----------------------------------------

# Venv setup

PY_VENV_DIR ?= _python_venv

PY_VENV_ACTIVATE = . $(PY_VENV_DIR)/bin/activate;

# Rebuild when requirements change
$(PY_VENV_DIR): $(PY_VENV_DIR)/french-law.stamp

# Setup a venv and intall the Catala runtime from opam
$(PY_VENV_DIR)/french-law.stamp:
	test -d $(PY_VENV_DIR) || python3 -m venv $(PY_VENV_DIR)
	$(PY_VENV_ACTIVATE) python3 -m pip install -U pip
	$(PY_VENV_ACTIVATE) python3 -m pip install -U \
	  $(CATALA_LIBDIR)/runtime_python \
	  $(CATALA_EXAMPLES_LIBDIR)/french_law_python.tar.gz
	$(PY_VENV_ACTIVATE) python3 -m pip install -U requests # Needed by cnaf_cross_tester
	touch $@

dependencies-python: $(PY_VENV_DIR)

# Python libs

FRENCH_LAW_PYTHON_LIB_DIR=python

#> type_french_law_library_python	       : Types the French law library Python sources with mypy
type_french_law_library_python: dependencies-python
	$(PY_VENV_ACTIVATE) $(MAKE) -C $(FRENCH_LAW_PYTHON_LIB_DIR) type

run_french_law_library_benchmark_python: type_french_law_library_python
	$(PY_VENV_ACTIVATE) $(MAKE) -C $(FRENCH_LAW_PYTHON_LIB_DIR) bench

run_cnaf_cross_tester: dependencies-python
	$(PY_VENV_ACTIVATE) python -m $(FRENCH_LAW_PYTHON_LIB_DIR).cnaf_cross_tester.main

#########################################
# High-level test and benchmarks commands
#########################################

dependencies: dependencies-ocaml dependencies-js dependencies-python

#> bench_ocaml			  : Run OCaml benchmarks for the Catala-generated code
bench_ocaml: run_french_law_library_benchmark_ocaml

#> bench_js			     : Run JS benchmarks for the Catala-generated code
bench_js: run_french_law_library_benchmark_js

#> bench_python			 : Run Python benchmarks for the Catala-generated code
bench_python: run_french_law_library_benchmark_python

website-assets-base: build_french_law_library_web_api

all: \
  bench_ocaml \
  bench_js \
  bench_python \
  website-assets-base
