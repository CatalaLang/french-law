(* This file is part of the French law library, a collection of functions for
   computing French taxes and benefits derived from Catala programs. Copyright
   (C) 2021 Inria, contributor: Denis Merigoux <denis.merigoux@inria.fr>

   Licensed under the Apache License, Version 2.0 (the "License"); you may not
   use this file except in compliance with the License. You may obtain a copy of
   the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
   WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
   License for the specific language governing permissions and limitations under
   the License. *)

module Allocations_familiales = Law_source.Allocations_familiales
module AF = Allocations_familiales
open Runtime
open Js_of_ocaml

class type enfant_entree =
  object
    method id : int Js.readonly_prop
    method remunerationMensuelle : int Js.readonly_prop
    method dateNaissance : Js.date Js.t Js.readonly_prop
    method gardeAlternee : bool Js.t Js.readonly_prop
    method gardeAlterneePartageAllocation : bool Js.t Js.readonly_prop

    method priseEnCharge : Js.js_string Js.t Js.readonly_prop
    (** Expects one of the five:

        - "Effective et permanente"
        - "Garde alternée, allocataire unique"
        - "Garde alternée, partage des allocations"
        - "Confié aux service sociaux, allocation versée à la famille"
        - "Confié aux service sociaux, allocation versée aux services sociaux" *)

    method aDejaOuvertDroitAuxAllocationsFamiliales : bool Js.t Js.readonly_prop

    method beneficieTitrePersonnelAidePersonnelleAuLogement :
      bool Js.t Js.readonly_prop
  end

class type allocations_familiales_input =
  object
    method currentDate : Js.date Js.t Js.readonly_prop
    method children : enfant_entree Js.t Js.js_array Js.t Js.readonly_prop
    method income : int Js.readonly_prop
    method residence : Js.js_string Js.t Js.readonly_prop

    method personneQuiAssumeLaChargeEffectivePermanenteEstParent :
      bool Js.t Js.readonly_prop

    method
        personneQuiAssumeLaChargeEffectivePermanenteRemplitConditionsTitreISecuriteSociale :
      bool Js.t Js.readonly_prop
  end

class type source_position =
  object
    method fileName : Js.js_string Js.t Js.prop
    method startLine : int Js.prop
    method endLine : int Js.prop
    method startColumn : int Js.prop
    method endColumn : int Js.prop
    method lawHeadings : Js.js_string Js.t Js.js_array Js.t Js.prop
  end

class type raw_event =
  object
    method eventType : Js.js_string Js.t Js.prop
    method information : Js.js_string Js.t Js.js_array Js.t Js.prop
    method sourcePosition : source_position Js.t Js.optdef Js.prop
    method loggedValueJson : Js.js_string Js.t Js.prop
  end

class type event =
  object
    method data : Js.js_string Js.t Js.prop
  end

let _ =
  Js.export_all
    (object%js
       method resetLog : (unit -> unit) Js.callback = Js.wrap_callback reset_log

       method retrieveEvents : (unit -> event Js.t Js.js_array Js.t) Js.callback
           =
         Js.wrap_callback (fun () ->
             Js.array
               (Array.of_list
                  (retrieve_log () |> EventParser.parse_raw_events
                  |> List.map (fun event ->
                         object%js
                           val mutable data =
                             event |> Runtime.yojson_of_event
                             |> Yojson.Safe.to_string |> Js.string
                         end))))

       method retrieveRawEvents
           : (unit -> raw_event Js.t Js.js_array Js.t) Js.callback =
         Js.wrap_callback (fun () ->
             Js.array
               (Array.of_list
                  (List.map
                     (fun evt ->
                       object%js
                         val mutable eventType =
                           Js.string
                             (match evt with
                             | BeginCall _ -> "Begin call"
                             | EndCall _ -> "End call"
                             | VariableDefinition _ -> "Variable definition"
                             | DecisionTaken _ -> "Decision taken")

                         val mutable information =
                           Js.array
                             (Array.of_list
                                (match evt with
                                | BeginCall info
                                | EndCall info
                                | VariableDefinition (info, _) ->
                                  List.map Js.string info
                                | DecisionTaken _ -> []))

                         val mutable loggedValueJson =
                           (match evt with
                           | VariableDefinition (_, v) -> v
                           | EndCall _ | BeginCall _ | DecisionTaken _ ->
                             Runtime.unembeddable ())
                           |> Runtime.yojson_of_runtime_value
                           |> Yojson.Safe.to_string |> Js.string

                         val mutable sourcePosition =
                           match evt with
                           | DecisionTaken pos ->
                             Js.def
                               (object%js
                                  val mutable fileName = Js.string pos.filename
                                  val mutable startLine = pos.start_line
                                  val mutable endLine = pos.end_line
                                  val mutable startColumn = pos.start_column
                                  val mutable endColumn = pos.end_column

                                  val mutable lawHeadings =
                                    Js.array
                                      (Array.of_list
                                         (List.map Js.string pos.law_headings))
                               end)
                           | _ -> Js.undefined
                       end)
                     (retrieve_log ()))))

       method computeAllocationsFamiliales
           : (allocations_familiales_input Js.t -> float) Js.callback =
         Js.wrap_callback (fun input ->
             let result =
               AF.interface_allocations_familiales
                 {
                   AF.InterfaceAllocationsFamilialesIn
                   .i_personne_charge_effective_permanente_est_parent_in =
                     Js.to_bool
                       input##.personneQuiAssumeLaChargeEffectivePermanenteEstParent;
                   AF.InterfaceAllocationsFamilialesIn
                   .i_personne_charge_effective_permanente_remplit_titre_I_in =
                     Js.to_bool
                       input##.personneQuiAssumeLaChargeEffectivePermanenteRemplitConditionsTitreISecuriteSociale;
                   AF.InterfaceAllocationsFamilialesIn.i_date_courante_in =
                     date_of_numbers
                       input##.currentDate##getUTCFullYear
                       input##.currentDate##getUTCMonth
                       input##.currentDate##getUTCDate;
                   AF.InterfaceAllocationsFamilialesIn.i_enfants_in =
                     Array.map
                       (fun (child : enfant_entree Js.t) ->
                         {
                           AF.EnfantEntree
                           .d_a_deja_ouvert_droit_aux_allocations_familiales =
                             Js.to_bool
                               child##.aDejaOuvertDroitAuxAllocationsFamiliales;
                           AF.EnfantEntree.d_identifiant =
                             integer_of_int child##.id;
                           AF.EnfantEntree.d_date_de_naissance =
                             date_of_numbers
                               child##.dateNaissance##getUTCFullYear
                               child##.dateNaissance##getUTCMonth
                               child##.dateNaissance##getUTCDate;
                           AF.EnfantEntree.d_prise_en_charge =
                             (match Js.to_string child##.priseEnCharge with
                             | "Effective et permanente" ->
                               EffectiveEtPermanente ()
                             | "Garde alternée, allocataire unique" ->
                               GardeAlterneeAllocataireUnique ()
                             | "Garde alternée, partage des allocations" ->
                               GardeAlterneePartageAllocations ()
                             | "Confié aux service sociaux, allocation versée \
                                à la famille" ->
                               ServicesSociauxAllocationVerseeALaFamille ()
                             | "Confié aux service sociaux, allocation versée \
                                aux services sociaux" ->
                               ServicesSociauxAllocationVerseeAuxServicesSociaux
                                 ()
                             | _ -> failwith "Unknown prise en charge");
                           AF.EnfantEntree.d_remuneration_mensuelle =
                             money_of_units_int child##.remunerationMensuelle;
                           AF.EnfantEntree
                           .d_beneficie_titre_personnel_aide_personnelle_logement =
                             Js.to_bool
                               child##.beneficieTitrePersonnelAidePersonnelleAuLogement;
                         })
                       (Js.to_array input##.children);
                   AF.InterfaceAllocationsFamilialesIn.i_ressources_menage_in =
                     money_of_units_int input##.income;
                   AF.InterfaceAllocationsFamilialesIn.i_residence_in =
                     (match Js.to_string input##.residence with
                     | "Métropole" -> AF.Metropole ()
                     | "Guyane" -> AF.Guyane ()
                     | "Guadeloupe" -> AF.Guadeloupe ()
                     | "Martinique" -> AF.Martinique ()
                     | "La Réunion" -> AF.LaReunion ()
                     | "Saint Barthélemy" -> AF.SaintBarthelemy ()
                     | "Saint Pierre et Miquelon" -> AF.SaintPierreEtMiquelon ()
                     | "Saint Martin" -> AF.SaintMartin ()
                     | "Mayotte" -> AF.Mayotte ()
                     | _ -> failwith "unknown collectivite!");
                   AF.InterfaceAllocationsFamilialesIn
                   .i_avait_enfant_a_charge_avant_1er_janvier_2012_in =
                     Js.to_bool input##.avaitEnfantAChargeAvant1erJanvier2012;
                 }
             in
             money_to_float
               result.AF.InterfaceAllocationsFamilialesOut.i_montant_verse_out)
    end)
