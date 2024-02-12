help : Makefile
	@sed -n 's/^#> //p' $<

OPAM = opam --cli=2.1

#-----------------------------------------
# OCaml
#-----------------------------------------

FRENCH_LAW_OCAML_LIB_DIR = ocaml

run_french_law_library_benchmark_ocaml:
	dune exec $(FRENCH_LAW_OCAML_LIB_DIR)/bench.exe

run_french_law_library_ocaml_tests:
	dune exec $(FRENCH_LAW_OCAML_LIB_DIR)/run_unit_tests.exe

#-----------------------------------------
# JSON schemas
#-----------------------------------------

FRENCH_LAW_JS_LIB_DIR=js

JSON_SCHEMAS = \
  $(FRENCH_LAW_JS_LIB_DIR)/aides_logement_schema.json \
  $(FRENCH_LAW_JS_LIB_DIR)/allocations_familiales_schema.json

#> generate_french_law_json_schemas     : Generates the French law library JSON schemas
$(addprefix _build/default/,$(JSON_SCHEMAS)):
	dune build $@

generate_french_law_json_schemas:
	dune build $(JSON_SCHEMAS)

#-----------------------------------------
# JS
#-----------------------------------------

dependencies-js-full:
	$(MAKE) -C $(FRENCH_LAW_JS_LIB_DIR) dependencies

dependencies-js:
	npm install benchmark

run_french_law_library_benchmark_js: build_french_law_library_js
	$(MAKE) -C $(FRENCH_LAW_JS_LIB_DIR) bench

#> build_french_law_library_js	  : Builds the JS version of the OCaml French law library
build_french_law_library_js:
	dune build $(FRENCH_LAW_JS_LIB_DIR)/src/french_law.js
	$(MAKE) -C $(FRENCH_LAW_JS_LIB_DIR) bench

#> build_french_law_library_web_api     : Builds the web API of the French law library
build_french_law_library_web_api: build_french_law_library_js generate_french_law_json_schemas

#-----------------------------------------
# Python
#-----------------------------------------

# Venv setup

PY_VENV_DIR = _python_venv

PY_VENV_ACTIVATE = . $(PY_VENV_DIR)/bin/activate;

# Rebuild when requirements change
$(PY_VENV_DIR): $(PY_VENV_DIR)/stamp

# Setup a venv and intall the Catala runtime from opam
$(PY_VENV_DIR)/stamp:
	test -d $(PY_VENV_DIR) || python3 -m venv $(PY_VENV_DIR)
	$(PY_VENV_ACTIVATE) python3 -m pip install -U pip
	$(PY_VENV_ACTIVATE) python3 -m pip install -U \
	  -e $$($(OPAM) var catala:lib)/runtime_python
	touch $@

dependencies-python: $(PY_VENV_DIR)

# Python libs

FRENCH_LAW_PYTHON_LIB_DIR=python

FRENCH_LAW_LIBRARY_PYTHON = \
  $(FRENCH_LAW_PYTHON_LIB_DIR)/src/allocations_familiales.py \
  $(FRENCH_LAW_PYTHON_LIB_DIR)/src/aides_logement.py

$(FRENCH_LAW_LIBRARY_PYTHON):
	dune build $@

#> generate_french_law_library_python   : Generates the French law library Python sources from Catala
generate_french_law_library_python:
	dune build $(FRENCH_LAW_LIBRARY_PYTHON)

#> type_french_law_library_python	       : Types the French law library Python sources with mypy
type_french_law_library_python: generate_french_law_library_python
	$(PY_VENV_ACTIVATE) $(MAKE) -C $(FRENCH_LAW_PYTHON_LIB_DIR) type

run_french_law_library_benchmark_python: type_french_law_library_python
	$(PY_VENV_ACTIVATE) $(MAKE) -C $(FRENCH_LAW_PYTHON_LIB_DIR) bench

##########################################
# High-level test and benchmarks commands
##########################################

dependencies: dependencies-js dependencies-python

#> tests_ocaml			  : Run OCaml unit tests for the Catala-generated code
tests_ocaml: run_french_law_library_ocaml_tests

#> bench_ocaml			  : Run OCaml benchmarks for the Catala-generated code
bench_ocaml: run_french_law_library_benchmark_ocaml

#> bench_js			     : Run JS benchmarks for the Catala-generated code
bench_js: run_french_law_library_benchmark_js

#> bench_python			 : Run Python benchmarks for the Catala-generated code
bench_python: run_french_law_library_benchmark_python

website-assets-base: build_french_law_library_web_api

all: \
  tests_ocaml bench_ocaml \
  build_french_law_library_js \
  bench_js \
  generate_french_law_library_python \
  type_french_law_library_python \
  bench_python \
  website-assets-base
