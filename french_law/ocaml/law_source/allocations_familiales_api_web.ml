(** This file has been generated by the Catala compiler, do not edit! *)

open Runtime_ocaml.Runtime
open Runtime_jsoo.Runtime
open Js_of_ocaml
open Allocations_familiales

[@@@ocaml.warning "-4-26-27-32-41-42"]

(* Generated API *)

class type prise_en_charge =
  object
    method kind :
      Js.js_string Js.t Js.readonly_prop
      (** Expects one of:
        - "GardeAlterneePartageAllocations"
        - "GardeAlterneeAllocataireUnique"
        - "EffectiveEtPermanente"
        - "ServicesSociauxAllocationVerseeALaFamille"
        - "ServicesSociauxAllocationVerseeAuxServicesSociaux" *)
    
    method payload : Js.Unsafe.any Js.t Js.readonly_prop
  end

let prise_en_charge_to_jsoo : PriseEnCharge.t -> prise_en_charge Js.t
  = function
  | GardeAlterneePartageAllocations arg -> object%js
      val kind = Js.string "GardeAlterneePartageAllocations"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | GardeAlterneeAllocataireUnique arg -> object%js
      val kind = Js.string "GardeAlterneeAllocataireUnique"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | EffectiveEtPermanente arg -> object%js
      val kind = Js.string "EffectiveEtPermanente"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | ServicesSociauxAllocationVerseeALaFamille arg -> object%js
      val kind = Js.string "ServicesSociauxAllocationVerseeALaFamille"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | ServicesSociauxAllocationVerseeAuxServicesSociaux arg -> object%js
      val kind = Js.string "ServicesSociauxAllocationVerseeAuxServicesSociaux"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end

let prise_en_charge_of_jsoo (prise_en_charge : prise_en_charge Js.t)
  : PriseEnCharge.t =
  match prise_en_charge##.kind |> Js.to_string with
  | "GardeAlterneePartageAllocations" ->
    PriseEnCharge.GardeAlterneePartageAllocations ()
  | "GardeAlterneeAllocataireUnique" ->
    PriseEnCharge.GardeAlterneeAllocataireUnique ()
  | "EffectiveEtPermanente" -> PriseEnCharge.EffectiveEtPermanente ()
  | "ServicesSociauxAllocationVerseeALaFamille" ->
    PriseEnCharge.ServicesSociauxAllocationVerseeALaFamille ()
  | "ServicesSociauxAllocationVerseeAuxServicesSociaux" ->
    PriseEnCharge.ServicesSociauxAllocationVerseeAuxServicesSociaux ()
  | cons ->
    failwith
      (Printf.sprintf
        "Unexpected '%s' kind for the enumeration 'PriseEnCharge.t'" cons)


class type situation_obligation_scolaire =
  object
    method kind :
      Js.js_string Js.t Js.readonly_prop
      (** Expects one of:
        - "Avant"
        - "Pendant"
        - "Apres" *)
    
    method payload : Js.Unsafe.any Js.t Js.readonly_prop
  end

let situation_obligation_scolaire_to_jsoo
  : SituationObligationScolaire.t -> situation_obligation_scolaire Js.t
  = function
  | Avant arg -> object%js
      val kind = Js.string "Avant"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Pendant arg -> object%js
      val kind = Js.string "Pendant"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Apres arg -> object%js
      val kind = Js.string "Apres"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end

let situation_obligation_scolaire_of_jsoo
  (situation_obligation_scolaire : situation_obligation_scolaire Js.t)
  : SituationObligationScolaire.t =
  match situation_obligation_scolaire##.kind |> Js.to_string with
  | "Avant" -> SituationObligationScolaire.Avant ()
  | "Pendant" -> SituationObligationScolaire.Pendant ()
  | "Apres" -> SituationObligationScolaire.Apres ()
  | cons ->
    failwith
      (Printf.sprintf
        "Unexpected '%s' kind for the enumeration 'SituationObligationScolaire.t'"
        cons)


class type prise_en_compte =
  object
    method kind :
      Js.js_string Js.t Js.readonly_prop
      (** Expects one of:
        - "Complete"
        - "Partagee"
        - "Zero" *)
    
    method payload : Js.Unsafe.any Js.t Js.readonly_prop
  end

let prise_en_compte_to_jsoo : PriseEnCompte.t -> prise_en_compte Js.t
  = function
  | Complete arg -> object%js
      val kind = Js.string "Complete"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Partagee arg -> object%js
      val kind = Js.string "Partagee"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Zero arg -> object%js
      val kind = Js.string "Zero"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end

let prise_en_compte_of_jsoo (prise_en_compte : prise_en_compte Js.t)
  : PriseEnCompte.t =
  match prise_en_compte##.kind |> Js.to_string with
  | "Complete" -> PriseEnCompte.Complete ()
  | "Partagee" -> PriseEnCompte.Partagee ()
  | "Zero" -> PriseEnCompte.Zero ()
  | cons ->
    failwith
      (Printf.sprintf
        "Unexpected '%s' kind for the enumeration 'PriseEnCompte.t'" cons)


class type versement_allocations =
  object
    method kind :
      Js.js_string Js.t Js.readonly_prop
      (** Expects one of:
        - "Normal"
        - "AllocationVerseeAuxServicesSociaux" *)
    
    method payload : Js.Unsafe.any Js.t Js.readonly_prop
  end

let versement_allocations_to_jsoo
  : VersementAllocations.t -> versement_allocations Js.t
  = function
  | Normal arg -> object%js
      val kind = Js.string "Normal"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | AllocationVerseeAuxServicesSociaux arg -> object%js
      val kind = Js.string "AllocationVerseeAuxServicesSociaux"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end

let versement_allocations_of_jsoo
  (versement_allocations : versement_allocations Js.t)
  : VersementAllocations.t =
  match versement_allocations##.kind |> Js.to_string with
  | "Normal" -> VersementAllocations.Normal ()
  | "AllocationVerseeAuxServicesSociaux" ->
    VersementAllocations.AllocationVerseeAuxServicesSociaux ()
  | cons ->
    failwith
      (Printf.sprintf
        "Unexpected '%s' kind for the enumeration 'VersementAllocations.t'"
        cons)


class type element_prestations_familiales =
  object
    method kind :
      Js.js_string Js.t Js.readonly_prop
      (** Expects one of:
        - "PrestationAccueilJeuneEnfant"
        - "AllocationsFamiliales"
        - "ComplementFamilial"
        - "AllocationLogement"
        - "AllocationEducationEnfantHandicape"
        - "AllocationSoutienFamilial"
        - "AllocationRentreeScolaire"
        - "AllocationJournalierePresenceParentale" *)
    
    method payload : Js.Unsafe.any Js.t Js.readonly_prop
  end

let element_prestations_familiales_to_jsoo
  : ElementPrestationsFamiliales.t -> element_prestations_familiales Js.t
  = function
  | PrestationAccueilJeuneEnfant arg -> object%js
      val kind = Js.string "PrestationAccueilJeuneEnfant"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | AllocationsFamiliales arg -> object%js
      val kind = Js.string "AllocationsFamiliales"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | ComplementFamilial arg -> object%js
      val kind = Js.string "ComplementFamilial"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | AllocationLogement arg -> object%js
      val kind = Js.string "AllocationLogement"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | AllocationEducationEnfantHandicape arg -> object%js
      val kind = Js.string "AllocationEducationEnfantHandicape"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | AllocationSoutienFamilial arg -> object%js
      val kind = Js.string "AllocationSoutienFamilial"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | AllocationRentreeScolaire arg -> object%js
      val kind = Js.string "AllocationRentreeScolaire"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | AllocationJournalierePresenceParentale arg -> object%js
      val kind = Js.string "AllocationJournalierePresenceParentale"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end

let element_prestations_familiales_of_jsoo
  (element_prestations_familiales : element_prestations_familiales Js.t)
  : ElementPrestationsFamiliales.t =
  match element_prestations_familiales##.kind |> Js.to_string with
  | "PrestationAccueilJeuneEnfant" ->
    ElementPrestationsFamiliales.PrestationAccueilJeuneEnfant ()
  | "AllocationsFamiliales" ->
    ElementPrestationsFamiliales.AllocationsFamiliales ()
  | "ComplementFamilial" ->
    ElementPrestationsFamiliales.ComplementFamilial ()
  | "AllocationLogement" ->
    ElementPrestationsFamiliales.AllocationLogement ()
  | "AllocationEducationEnfantHandicape" ->
    ElementPrestationsFamiliales.AllocationEducationEnfantHandicape ()
  | "AllocationSoutienFamilial" ->
    ElementPrestationsFamiliales.AllocationSoutienFamilial ()
  | "AllocationRentreeScolaire" ->
    ElementPrestationsFamiliales.AllocationRentreeScolaire ()
  | "AllocationJournalierePresenceParentale" ->
    ElementPrestationsFamiliales.AllocationJournalierePresenceParentale ()
  | cons ->
    failwith
      (Printf.sprintf
        "Unexpected '%s' kind for the enumeration 'ElementPrestationsFamiliales.t'"
        cons)


class type collectivite =
  object
    method kind :
      Js.js_string Js.t Js.readonly_prop
      (** Expects one of:
        - "Guadeloupe"
        - "Guyane"
        - "Martinique"
        - "LaReunion"
        - "SaintBarthelemy"
        - "SaintMartin"
        - "Metropole"
        - "SaintPierreEtMiquelon"
        - "Mayotte" *)
    
    method payload : Js.Unsafe.any Js.t Js.readonly_prop
  end

let collectivite_to_jsoo : Collectivite.t -> collectivite Js.t
  = function
  | Guadeloupe arg -> object%js
      val kind = Js.string "Guadeloupe"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Guyane arg -> object%js
      val kind = Js.string "Guyane"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Martinique arg -> object%js
      val kind = Js.string "Martinique"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | LaReunion arg -> object%js
      val kind = Js.string "LaReunion"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | SaintBarthelemy arg -> object%js
      val kind = Js.string "SaintBarthelemy"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | SaintMartin arg -> object%js
      val kind = Js.string "SaintMartin"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Metropole arg -> object%js
      val kind = Js.string "Metropole"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | SaintPierreEtMiquelon arg -> object%js
      val kind = Js.string "SaintPierreEtMiquelon"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end
  | Mayotte arg -> object%js
      val kind = Js.string "Mayotte"
      val payload = Js.Unsafe.coerce (Js.Unsafe.inject ( arg))
    end

let collectivite_of_jsoo (collectivite : collectivite Js.t)
  : Collectivite.t =
  match collectivite##.kind |> Js.to_string with
  | "Guadeloupe" -> Collectivite.Guadeloupe ()
  | "Guyane" -> Collectivite.Guyane ()
  | "Martinique" -> Collectivite.Martinique ()
  | "LaReunion" -> Collectivite.LaReunion ()
  | "SaintBarthelemy" -> Collectivite.SaintBarthelemy ()
  | "SaintMartin" -> Collectivite.SaintMartin ()
  | "Metropole" -> Collectivite.Metropole ()
  | "SaintPierreEtMiquelon" -> Collectivite.SaintPierreEtMiquelon ()
  | "Mayotte" -> Collectivite.Mayotte ()
  | cons ->
    failwith
      (Printf.sprintf
        "Unexpected '%s' kind for the enumeration 'Collectivite.t'" cons)


class type enfant_entree =
  object
    method dIdentifiant: int Js.readonly_prop
    method dRemunerationMensuelle: Js.number Js.t Js.readonly_prop
    method dDateDeNaissance: Js.js_string Js.t Js.readonly_prop
    method dPriseEnCharge: prise_en_charge Js.t Js.readonly_prop
    method dADejaOuvertDroitAuxAllocationsFamiliales:
      bool Js.t Js.readonly_prop
    method dBeneficieTitrePersonnelAidePersonnelleLogement:
      bool Js.t Js.readonly_prop
  end
  let enfant_entree_to_jsoo (enfant_entree : EnfantEntree.t)
    : enfant_entree Js.t =
    object%js
      val dIdentifiant = integer_to_int enfant_entree.d_identifiant
      val dRemunerationMensuelle =
        Js.number_of_float @@ money_to_float enfant_entree.d_remuneration_mensuelle
      val dDateDeNaissance = date_to_jsoo enfant_entree.d_date_de_naissance
      val dPriseEnCharge =
        prise_en_charge_to_jsoo enfant_entree.d_prise_en_charge
      val dADejaOuvertDroitAuxAllocationsFamiliales =
        Js.bool enfant_entree.d_a_deja_ouvert_droit_aux_allocations_familiales
      val dBeneficieTitrePersonnelAidePersonnelleLogement =
        Js.bool enfant_entree.d_beneficie_titre_personnel_aide_personnelle_logement
      end
  let enfant_entree_of_jsoo (enfant_entree : enfant_entree Js.t) :
    EnfantEntree.t =
    {
      d_identifiant = integer_of_int enfant_entree##.dIdentifiant;
      d_remuneration_mensuelle =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          enfant_entree##.dRemunerationMensuelle;
      d_date_de_naissance = date_of_jsoo enfant_entree##.dDateDeNaissance;
      d_prise_en_charge =
        prise_en_charge_of_jsoo enfant_entree##.dPriseEnCharge;
      d_a_deja_ouvert_droit_aux_allocations_familiales =
        Js.to_bool enfant_entree##.dADejaOuvertDroitAuxAllocationsFamiliales;
      d_beneficie_titre_personnel_aide_personnelle_logement =
        Js.to_bool
          enfant_entree##.dBeneficieTitrePersonnelAidePersonnelleLogement
    }

class type enfant =
  object
    method identifiant: int Js.readonly_prop
    method obligationScolaire:
      situation_obligation_scolaire Js.t Js.readonly_prop
    method remunerationMensuelle: Js.number Js.t Js.readonly_prop
    method dateDeNaissance: Js.js_string Js.t Js.readonly_prop
    method priseEnCharge: prise_en_charge Js.t Js.readonly_prop
    method aDejaOuvertDroitAuxAllocationsFamiliales:
      bool Js.t Js.readonly_prop
    method beneficieTitrePersonnelAidePersonnelleLogement:
      bool Js.t Js.readonly_prop
  end
  let enfant_to_jsoo (enfant : Enfant.t) : enfant Js.t =
    object%js
      val identifiant = integer_to_int enfant.identifiant
      val obligationScolaire =
        situation_obligation_scolaire_to_jsoo enfant.obligation_scolaire
      val remunerationMensuelle =
        Js.number_of_float @@ money_to_float enfant.remuneration_mensuelle
      val dateDeNaissance = date_to_jsoo enfant.date_de_naissance
      val priseEnCharge = prise_en_charge_to_jsoo enfant.prise_en_charge
      val aDejaOuvertDroitAuxAllocationsFamiliales =
        Js.bool enfant.a_deja_ouvert_droit_aux_allocations_familiales
      val beneficieTitrePersonnelAidePersonnelleLogement =
        Js.bool enfant.beneficie_titre_personnel_aide_personnelle_logement
      end
  let enfant_of_jsoo (enfant : enfant Js.t) : Enfant.t =
    {
      identifiant = integer_of_int enfant##.identifiant;
      obligation_scolaire =
        situation_obligation_scolaire_of_jsoo enfant##.obligationScolaire;
      remuneration_mensuelle =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          enfant##.remunerationMensuelle;
      date_de_naissance = date_of_jsoo enfant##.dateDeNaissance;
      prise_en_charge = prise_en_charge_of_jsoo enfant##.priseEnCharge;
      a_deja_ouvert_droit_aux_allocations_familiales =
        Js.to_bool enfant##.aDejaOuvertDroitAuxAllocationsFamiliales;
      beneficie_titre_personnel_aide_personnelle_logement =
        Js.to_bool enfant##.beneficieTitrePersonnelAidePersonnelleLogement
    }

class type prestations_familiales_out =
  object
    method droitOuvertOut: (enfant Js.t,  bool Js.t) Js.meth_callback Js.meth
    method conditionsHorsAgeOut:
      (enfant Js.t,  bool Js.t) Js.meth_callback Js.meth
    method ageL51232Out: Runtime_jsoo.Runtime.duration Js.t Js.readonly_prop
    method regimeOutreMerL7511Out: bool Js.t Js.readonly_prop
  end
  let prestations_familiales_out_to_jsoo (prestations_familiales_out
    : PrestationsFamilialesOut.t) : prestations_familiales_out Js.t =
    object%js
      method droitOuvertOut = Js.wrap_meth_callback
        (
          fun input ->
          Js.bool (prestations_familiales_out.droit_ouvert_out (enfant_of_jsoo input)))
      method conditionsHorsAgeOut = Js.wrap_meth_callback
        (
          fun input ->
          Js.bool (prestations_familiales_out.conditions_hors_age_out (enfant_of_jsoo input)))
      val ageL51232Out =
        duration_to_jsoo prestations_familiales_out.age_l512_3_2_out
      val regimeOutreMerL7511Out =
        Js.bool prestations_familiales_out.regime_outre_mer_l751_1_out
      end
  let prestations_familiales_out_of_jsoo
    (prestations_familiales_out : prestations_familiales_out Js.t) :
    PrestationsFamilialesOut.t =
    {
      droit_ouvert_out = failwith "The function 'droit_ouvert_out' translation isn't yet supported...";
      conditions_hors_age_out = failwith "The function 'conditions_hors_age_out' translation isn't yet supported...";
      age_l512_3_2_out =
        duration_of_jsoo prestations_familiales_out##.ageL51232Out;
      regime_outre_mer_l751_1_out =
        Js.to_bool prestations_familiales_out##.regimeOutreMerL7511Out
    }

class type prestations_familiales_in =
  object
    method dateCouranteIn: Js.js_string Js.t Js.readonly_prop
    method prestationCouranteIn:
      element_prestations_familiales Js.t Js.readonly_prop
    method residenceIn: collectivite Js.t Js.readonly_prop
  end
  let prestations_familiales_in_to_jsoo (prestations_familiales_in
    : PrestationsFamilialesIn.t) : prestations_familiales_in Js.t =
    object%js
      val dateCouranteIn =
        date_to_jsoo prestations_familiales_in.date_courante_in
      val prestationCouranteIn =
        element_prestations_familiales_to_jsoo prestations_familiales_in.prestation_courante_in
      val residenceIn =
        collectivite_to_jsoo prestations_familiales_in.residence_in
      end
  let prestations_familiales_in_of_jsoo
    (prestations_familiales_in : prestations_familiales_in Js.t) :
    PrestationsFamilialesIn.t =
    {
      date_courante_in =
        date_of_jsoo prestations_familiales_in##.dateCouranteIn;
      prestation_courante_in =
        element_prestations_familiales_of_jsoo
          prestations_familiales_in##.prestationCouranteIn;
      residence_in =
        collectivite_of_jsoo prestations_familiales_in##.residenceIn
    }

class type allocation_familiales_avril2008_out =
  object
    method ageMinimumAlinea1L5213Out:
      Runtime_jsoo.Runtime.duration Js.t Js.readonly_prop
  end
  let allocation_familiales_avril2008_out_to_jsoo
    (allocation_familiales_avril2008_out
    : AllocationFamilialesAvril2008Out.t)
    : allocation_familiales_avril2008_out Js.t =
    object%js
      val ageMinimumAlinea1L5213Out =
        duration_to_jsoo allocation_familiales_avril2008_out.age_minimum_alinea_1_l521_3_out
      end
  let allocation_familiales_avril2008_out_of_jsoo
    (allocation_familiales_avril2008_out
      : allocation_familiales_avril2008_out Js.t) :
    AllocationFamilialesAvril2008Out.t =
    {
      age_minimum_alinea_1_l521_3_out =
        duration_of_jsoo
          allocation_familiales_avril2008_out##.ageMinimumAlinea1L5213Out
    }

class type allocation_familiales_avril2008_in =
object end
let allocation_familiales_avril2008_in_to_jsoo (_ : AllocationFamilialesAvril2008In.t) : allocation_familiales_avril2008_in Js.t = object%js end
let allocation_familiales_avril2008_in_of_jsoo (_ : allocation_familiales_avril2008_in Js.t) : AllocationFamilialesAvril2008In.t = ()
class type enfant_le_plus_age_out =
  object method lePlusAgeOut: enfant Js.t Js.readonly_prop
  end
  let enfant_le_plus_age_out_to_jsoo (enfant_le_plus_age_out
    : EnfantLePlusAgeOut.t) : enfant_le_plus_age_out Js.t =
    object%js
      val lePlusAgeOut =
        enfant_to_jsoo enfant_le_plus_age_out.le_plus_age_out
      end
  let enfant_le_plus_age_out_of_jsoo
    (enfant_le_plus_age_out : enfant_le_plus_age_out Js.t) :
    EnfantLePlusAgeOut.t =
    {le_plus_age_out = enfant_of_jsoo enfant_le_plus_age_out##.lePlusAgeOut
    }

class type enfant_le_plus_age_in =
  object method enfantsIn: enfant Js.t Js.js_array Js.t Js.readonly_prop
  end
  let enfant_le_plus_age_in_to_jsoo (enfant_le_plus_age_in
    : EnfantLePlusAgeIn.t) : enfant_le_plus_age_in Js.t =
    object%js
      val enfantsIn =
        Js.array @@ Array.map (fun x -> enfant_to_jsoo x) enfant_le_plus_age_in.enfants_in
      end
  let enfant_le_plus_age_in_of_jsoo
    (enfant_le_plus_age_in : enfant_le_plus_age_in Js.t) :
    EnfantLePlusAgeIn.t =
    {
      enfants_in =
        Array.map (fun x -> enfant_of_jsoo x) @@ Js.to_array
          enfant_le_plus_age_in##.enfantsIn
    }

class type allocations_familiales_out =
  object method montantVerseOut: Js.number Js.t Js.readonly_prop
  end
  let allocations_familiales_out_to_jsoo (allocations_familiales_out
    : AllocationsFamilialesOut.t) : allocations_familiales_out Js.t =
    object%js
      val montantVerseOut =
        Js.number_of_float @@ money_to_float allocations_familiales_out.montant_verse_out
      end
  let allocations_familiales_out_of_jsoo
    (allocations_familiales_out : allocations_familiales_out Js.t) :
    AllocationsFamilialesOut.t =
    {
      montant_verse_out =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          allocations_familiales_out##.montantVerseOut
    }

class type allocations_familiales_in =
  object
    method personneChargeEffectivePermanenteEstParentIn:
      bool Js.t Js.readonly_prop
    method personneChargeEffectivePermanenteRemplitTitreIIn:
      bool Js.t Js.readonly_prop
    method ressourcesMenageIn: Js.number Js.t Js.readonly_prop
    method residenceIn: collectivite Js.t Js.readonly_prop
    method dateCouranteIn: Js.js_string Js.t Js.readonly_prop
    method enfantsAChargeIn: enfant Js.t Js.js_array Js.t Js.readonly_prop
    method avaitEnfantAChargeAvant1erJanvier2012In:
      bool Js.t Js.readonly_prop
  end
  let allocations_familiales_in_to_jsoo (allocations_familiales_in
    : AllocationsFamilialesIn.t) : allocations_familiales_in Js.t =
    object%js
      val personneChargeEffectivePermanenteEstParentIn =
        Js.bool allocations_familiales_in.personne_charge_effective_permanente_est_parent_in
      val personneChargeEffectivePermanenteRemplitTitreIIn =
        Js.bool allocations_familiales_in.personne_charge_effective_permanente_remplit_titre_I_in
      val ressourcesMenageIn =
        Js.number_of_float @@ money_to_float allocations_familiales_in.ressources_menage_in
      val residenceIn =
        collectivite_to_jsoo allocations_familiales_in.residence_in
      val dateCouranteIn =
        date_to_jsoo allocations_familiales_in.date_courante_in
      val enfantsAChargeIn =
        Js.array @@ Array.map (fun x -> enfant_to_jsoo x) allocations_familiales_in.enfants_a_charge_in
      val avaitEnfantAChargeAvant1erJanvier2012In =
        Js.bool allocations_familiales_in.avait_enfant_a_charge_avant_1er_janvier_2012_in
      end
  let allocations_familiales_in_of_jsoo
    (allocations_familiales_in : allocations_familiales_in Js.t) :
    AllocationsFamilialesIn.t =
    {
      personne_charge_effective_permanente_est_parent_in =
        Js.to_bool
          allocations_familiales_in
          ##.personneChargeEffectivePermanenteEstParentIn;
      personne_charge_effective_permanente_remplit_titre_I_in =
        Js.to_bool
          allocations_familiales_in
          ##.personneChargeEffectivePermanenteRemplitTitreIIn;
      ressources_menage_in =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          allocations_familiales_in##.ressourcesMenageIn;
      residence_in =
        collectivite_of_jsoo allocations_familiales_in##.residenceIn;
      date_courante_in =
        date_of_jsoo allocations_familiales_in##.dateCouranteIn;
      enfants_a_charge_in =
        Array.map (fun x -> enfant_of_jsoo x) @@ Js.to_array
          allocations_familiales_in##.enfantsAChargeIn;
      avait_enfant_a_charge_avant_1er_janvier_2012_in =
        Js.to_bool
          allocations_familiales_in##.avaitEnfantAChargeAvant1erJanvier2012In
    }

class type smic_out =
  object method brutHoraireOut: Js.number Js.t Js.readonly_prop
  end
  let smic_out_to_jsoo (smic_out : SmicOut.t) : smic_out Js.t =
    object%js
      val brutHoraireOut =
        Js.number_of_float @@ money_to_float smic_out.brut_horaire_out
      end
  let smic_out_of_jsoo (smic_out : smic_out Js.t) : SmicOut.t =
    {
      brut_horaire_out =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          smic_out##.brutHoraireOut
    }

class type smic_in =
  object
    method dateCouranteIn: Js.js_string Js.t Js.readonly_prop
    method residenceIn: collectivite Js.t Js.readonly_prop
  end
  let smic_in_to_jsoo (smic_in : SmicIn.t) : smic_in Js.t =
    object%js
      val dateCouranteIn = date_to_jsoo smic_in.date_courante_in
      val residenceIn = collectivite_to_jsoo smic_in.residence_in
      end
  let smic_in_of_jsoo (smic_in : smic_in Js.t) : SmicIn.t =
    {
      date_courante_in = date_of_jsoo smic_in##.dateCouranteIn;
      residence_in = collectivite_of_jsoo smic_in##.residenceIn
    }

class type base_mensuelle_allocations_familiales_out =
  object method montantOut: Js.number Js.t Js.readonly_prop
  end
  let base_mensuelle_allocations_familiales_out_to_jsoo
    (base_mensuelle_allocations_familiales_out
    : BaseMensuelleAllocationsFamilialesOut.t)
    : base_mensuelle_allocations_familiales_out Js.t =
    object%js
      val montantOut =
        Js.number_of_float @@ money_to_float base_mensuelle_allocations_familiales_out.montant_out
      end
  let base_mensuelle_allocations_familiales_out_of_jsoo
    (base_mensuelle_allocations_familiales_out
      : base_mensuelle_allocations_familiales_out Js.t) :
    BaseMensuelleAllocationsFamilialesOut.t =
    {
      montant_out =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          base_mensuelle_allocations_familiales_out##.montantOut
    }

class type base_mensuelle_allocations_familiales_in =
  object method dateCouranteIn: Js.js_string Js.t Js.readonly_prop
  end
  let base_mensuelle_allocations_familiales_in_to_jsoo
    (base_mensuelle_allocations_familiales_in
    : BaseMensuelleAllocationsFamilialesIn.t)
    : base_mensuelle_allocations_familiales_in Js.t =
    object%js
      val dateCouranteIn =
        date_to_jsoo base_mensuelle_allocations_familiales_in.date_courante_in
      end
  let base_mensuelle_allocations_familiales_in_of_jsoo
    (base_mensuelle_allocations_familiales_in
      : base_mensuelle_allocations_familiales_in Js.t) :
    BaseMensuelleAllocationsFamilialesIn.t =
    {
      date_courante_in =
        date_of_jsoo
          base_mensuelle_allocations_familiales_in##.dateCouranteIn
    }

class type interface_allocations_familiales_out =
  object method iMontantVerseOut: Js.number Js.t Js.readonly_prop
  end
  let interface_allocations_familiales_out_to_jsoo
    (interface_allocations_familiales_out
    : InterfaceAllocationsFamilialesOut.t)
    : interface_allocations_familiales_out Js.t =
    object%js
      val iMontantVerseOut =
        Js.number_of_float @@ money_to_float interface_allocations_familiales_out.i_montant_verse_out
      end
  let interface_allocations_familiales_out_of_jsoo
    (interface_allocations_familiales_out
      : interface_allocations_familiales_out Js.t) :
    InterfaceAllocationsFamilialesOut.t =
    {
      i_montant_verse_out =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          interface_allocations_familiales_out##.iMontantVerseOut
    }

class type interface_allocations_familiales_in =
  object
    method iDateCouranteIn: Js.js_string Js.t Js.readonly_prop
    method iEnfantsIn: enfant_entree Js.t Js.js_array Js.t Js.readonly_prop
    method iRessourcesMenageIn: Js.number Js.t Js.readonly_prop
    method iResidenceIn: collectivite Js.t Js.readonly_prop
    method iPersonneChargeEffectivePermanenteEstParentIn:
      bool Js.t Js.readonly_prop
    method iPersonneChargeEffectivePermanenteRemplitTitreIIn:
      bool Js.t Js.readonly_prop
    method iAvaitEnfantAChargeAvant1erJanvier2012In:
      bool Js.t Js.readonly_prop
  end
  let interface_allocations_familiales_in_to_jsoo
    (interface_allocations_familiales_in
    : InterfaceAllocationsFamilialesIn.t)
    : interface_allocations_familiales_in Js.t =
    object%js
      val iDateCouranteIn =
        date_to_jsoo interface_allocations_familiales_in.i_date_courante_in
      val iEnfantsIn =
        Js.array @@ Array.map (fun x -> enfant_entree_to_jsoo x) interface_allocations_familiales_in.i_enfants_in
      val iRessourcesMenageIn =
        Js.number_of_float @@ money_to_float interface_allocations_familiales_in.i_ressources_menage_in
      val iResidenceIn =
        collectivite_to_jsoo interface_allocations_familiales_in.i_residence_in
      val iPersonneChargeEffectivePermanenteEstParentIn =
        Js.bool interface_allocations_familiales_in.i_personne_charge_effective_permanente_est_parent_in
      val iPersonneChargeEffectivePermanenteRemplitTitreIIn =
        Js.bool interface_allocations_familiales_in.i_personne_charge_effective_permanente_remplit_titre_I_in
      val iAvaitEnfantAChargeAvant1erJanvier2012In =
        Js.bool interface_allocations_familiales_in.i_avait_enfant_a_charge_avant_1er_janvier_2012_in
      end
  let interface_allocations_familiales_in_of_jsoo
    (interface_allocations_familiales_in
      : interface_allocations_familiales_in Js.t) :
    InterfaceAllocationsFamilialesIn.t =
    {
      i_date_courante_in =
        date_of_jsoo interface_allocations_familiales_in##.iDateCouranteIn;
      i_enfants_in =
        Array.map (fun x -> enfant_entree_of_jsoo x) @@ Js.to_array
          interface_allocations_familiales_in##.iEnfantsIn;
      i_ressources_menage_in =
        money_of_decimal @@ decimal_of_float @@ Js.float_of_number
          interface_allocations_familiales_in##.iRessourcesMenageIn;
      i_residence_in =
        collectivite_of_jsoo
          interface_allocations_familiales_in##.iResidenceIn;
      i_personne_charge_effective_permanente_est_parent_in =
        Js.to_bool
          interface_allocations_familiales_in
          ##.iPersonneChargeEffectivePermanenteEstParentIn;
      i_personne_charge_effective_permanente_remplit_titre_I_in =
        Js.to_bool
          interface_allocations_familiales_in
          ##.iPersonneChargeEffectivePermanenteRemplitTitreIIn;
      i_avait_enfant_a_charge_avant_1er_janvier_2012_in =
        Js.to_bool
          interface_allocations_familiales_in
          ##.iAvaitEnfantAChargeAvant1erJanvier2012In
    }




let allocation_familiales_avril2008
  (allocation_familiales_avril2008_in : allocation_familiales_avril2008_in Js.t)
  : allocation_familiales_avril2008_out Js.t =
  allocation_familiales_avril2008_in
  |> allocation_familiales_avril2008_in_of_jsoo
  |> allocation_familiales_avril2008
  |> allocation_familiales_avril2008_out_to_jsoo


let enfant_le_plus_age (enfant_le_plus_age_in : enfant_le_plus_age_in Js.t)
  : enfant_le_plus_age_out Js.t =
  enfant_le_plus_age_in
  |> enfant_le_plus_age_in_of_jsoo
  |> enfant_le_plus_age
  |> enfant_le_plus_age_out_to_jsoo


let smic (smic_in : smic_in Js.t)
  : smic_out Js.t =
  smic_in |> smic_in_of_jsoo |> smic |> smic_out_to_jsoo


let base_mensuelle_allocations_familiales
  (base_mensuelle_allocations_familiales_in : base_mensuelle_allocations_familiales_in Js.t)
  : base_mensuelle_allocations_familiales_out Js.t =
  base_mensuelle_allocations_familiales_in
  |> base_mensuelle_allocations_familiales_in_of_jsoo
  |> base_mensuelle_allocations_familiales
  |> base_mensuelle_allocations_familiales_out_to_jsoo


let prestations_familiales
  (prestations_familiales_in : prestations_familiales_in Js.t)
  : prestations_familiales_out Js.t =
  prestations_familiales_in
  |> prestations_familiales_in_of_jsoo
  |> prestations_familiales
  |> prestations_familiales_out_to_jsoo


let allocations_familiales
  (allocations_familiales_in : allocations_familiales_in Js.t)
  : allocations_familiales_out Js.t =
  allocations_familiales_in
  |> allocations_familiales_in_of_jsoo
  |> allocations_familiales
  |> allocations_familiales_out_to_jsoo


let interface_allocations_familiales
  (interface_allocations_familiales_in : interface_allocations_familiales_in Js.t)
  : interface_allocations_familiales_out Js.t =
  interface_allocations_familiales_in
  |> interface_allocations_familiales_in_of_jsoo
  |> interface_allocations_familiales
  |> interface_allocations_familiales_out_to_jsoo


let _ =
   Js.export "AllocationsFamilialesLib"
    (object%js
      
      method allocationFamilialesAvril2008 : (allocation_familiales_avril2008_in Js.t -> allocation_familiales_avril2008_out Js.t) Js.callback =
        Js.wrap_callback allocation_familiales_avril2008
      
      method enfantLePlusAge : (enfant_le_plus_age_in Js.t -> enfant_le_plus_age_out Js.t) Js.callback =
        Js.wrap_callback enfant_le_plus_age
      
      method smic : (smic_in Js.t -> smic_out Js.t) Js.callback =
        Js.wrap_callback smic
      
      method baseMensuelleAllocationsFamiliales : (base_mensuelle_allocations_familiales_in Js.t -> base_mensuelle_allocations_familiales_out Js.t) Js.callback =
        Js.wrap_callback base_mensuelle_allocations_familiales
      
      method prestationsFamiliales : (prestations_familiales_in Js.t -> prestations_familiales_out Js.t) Js.callback =
        Js.wrap_callback prestations_familiales
      
      method allocationsFamiliales : (allocations_familiales_in Js.t -> allocations_familiales_out Js.t) Js.callback =
        Js.wrap_callback allocations_familiales
      
      method interfaceAllocationsFamiliales : (interface_allocations_familiales_in Js.t -> interface_allocations_familiales_out Js.t) Js.callback =
        Js.wrap_callback interface_allocations_familiales
      
    end)