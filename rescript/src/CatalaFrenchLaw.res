let frenchLaw = %raw(`require("french-law")`)

let resetLog: unit => unit = %raw(`
  function() {
    return frenchLaw.eventsManager.resetLog();
  }
`)

let retrieveRawEventsSerialized: unit => array<CatalaRuntime.Raw.eventSerialized> = %raw(`
  function() {
    return frenchLaw.eventsManager.retrieveRawEvents();
  }
`)

let retrieveEventsSerialized: unit => array<CatalaRuntime.eventSerialized> = %raw(`
  function() {
    return frenchLaw.eventsManager.retrieveEvents();
  }
`)

let computeAllocationsFamiliales: Js.Json.t => float = %raw(`
  function(input) {
    frenchLaw.eventsManager.resetLog();
    return AllocationsFamilialesLib.interfaceAllocationsFamiliales(input).iMontantVerse;
  }
`)

let computeAidesAuLogement: Js.Json.t => float = %raw(`
  function(input) {
    frenchLaw.eventsManager.resetLog(0);
    return frenchLaw.AidesLogementLib.calculetteAidesAuLogementGardeAlternee(input).aideFinale;
  }
`)
