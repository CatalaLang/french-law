# OCaml French Law Library

This folder contains a ready-to-use OCaml library featuring French public
algorithms coded up in Catala.

## Organization

### Dependencies

The wrappers here depend on the actual implementation defined in the
`catala-examples` repository, which are expected to be installed as OCaml
libraries (typically through `opam`)

We also provide `run_unit_tests.ml` that builds into an executable
that runs the unit tests coming from the source Catala examples, and that can
be launched with

```
make run_french_law_library_ocaml_tests
```

### Wrappers

Then, the `api.{ml, mli}` module provides a wrapper around the functions
exported in `law_source`. These wrappers mostly convert back and forth between
idiomatic OCaml types and the types expected by the Catala programs in OCaml.

`api_web.ml` is used for the JS library (see the [dedicated README](../js/README.md)).

Finally, `bench.ml` provides a simple benchmarking executable that runs the
computations of each algorithm a bunch of times with random inputs. You can run it
from the root of this repository with

```
make run_french_law_library_benchmark_ocaml
```
