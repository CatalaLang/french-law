# French law js library, compiled from catala

This folder contains a ready-to-use Javascript library featuring French public
algorithms coded up in Catala.

## Generating the source files

The JS code (extracted from OCaml using
[`js_of_ocaml`](https://ocsigen.org/js_of_ocaml/)) is provided and installed by
the [catala-examples](https://github.com/CatalaLang/catala-examples) repository.
It can be installed with `make dependencies-js` in the parent directory.

See the [dedicated README](../ocaml/README.md) of the OCaml library for more
precisions about the OCaml code.


## API description

The `french-law` npm package exposes:

- an [event manager](#the-event-manager)
- a list of [sub-libraries](#sub-libraries)

See the `examples.js` file for a first overview.

### The event manager

A JavaScript object `eventsManager` is exposed with three callable methods:

```javascript
var frenchLaw = require("french-law");

// Clears the raw log event array.
frenchLaw.eventsManager.resetLog();

// Returns the current content of the raw log event array.
let rawEvents = frenchLaw.eventsManager.retrieveRawEvents();

// Returns the event array parsed from the current content of the raw log event array.
let events = frenchLaw.eventsManager.retrieveEvents();
```

### Sub libraries

The `french-law` npm package exposes the following sub libs:

```javascript
var frenchLaw = require("french-law");

// Allocations familiales
var allocationsFamiliales = frenchLaw.AllocationsFamilialesLib

// APL
var aidesLogement = frenchLaw.AidesLogementLib
```

#### Available algorithms

##### Allocations familiales

The function is `AllocationsFamilialesLib.interfaceAllocationsFamiliales`. This
computation returns an object where the `iMontantVerse` field is the amount of
_allocations familiales_ for one household described by the input. More
precisely, the result returned is the sum of:

- _la base des allocations familiales_
- _l'allocation forfaitaire relai pour dépassement de l'âge limite_
- _la majoration pour âge_
- _le complément dégressif en cas de dépassement du plafond de revenus_

An example of use:

```javascript
var frenchLaw = require("french_law.js");

let amount = frenchLaw.computeAllocationsFamiliales({
  iDateCouranteIn: "2020-04-20",
  iEnfantsIn: [
    {
      dIdentifiant: 0,
      dRemunerationMensuelle: 0,
      dDateDeNaissance: "2003-02-02",
      dPriseEnCharge: { kind: "EffectiveEtPermanente", payload: null },
      dADejaOuvertDroitAuxAllocationsFamiliales: true,
      dBeneficieTitrePersonnelAidePersonnelleLogement: false,
    },
    {
      dIdentifiant: 1,
      dRemunerationMensuelle: 300,
      dDateDeNaissance: "2013-09-30",
      dPriseEnCharge: {
        kind: "GardeAlterneePartageAllocations",
        payload: null,
      },
      dADejaOuvertDroitAuxAllocationsFamiliales: true,
      dBeneficieTitrePersonnelAidePersonnelleLogement: false,
    },
  ],
  iRessourcesMenageIn: 30000,
  iResidenceIn: { kind: "Metropole", payload: null },
  iPersonneChargeEffectivePermanenteEstParentIn: true,
  iPersonneChargeEffectivePermanenteRemplitTitreIIn: true,
  iAvaitEnfantAChargeAvant1erJanvier2012In: false,
});
```

Notably, the `dPriseEnCharge` variable for each child expects a value among:
- "GardeAlterneePartageAllocations"
- "GardeAlterneeAllocataireUnique"
- "EffectiveEtPermanente"
- "ServicesSociauxAllocationVerseeALaFamille"
- "ServicesSociauxAllocationVerseeAuxServicesSociaux"

> See `allocations_familiales_api_web.ml` from `catala-examples` for more
> information about data types.

##### Aides logement

The function is `AidesLogementLib.calculetteAidesAuLogementGardeAlternee`, and
the amount is in the `aideFinale` field of the returned object.

> TODO: add information about `aides_logement_api_web.ml`.

### Date and time

Date values are encoded to JS string according the [ISO8601
format](https://www.iso.org/iso-8601-date-and-time-format.html): 'YYYY-MM-DD'.
