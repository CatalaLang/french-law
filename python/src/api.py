from abc import ABC, abstractmethod
from catala.runtime import *  # type: ignore
import french_law.France as France
import french_law.Prestations_familiales as PF
import french_law.Allocations_familiales as AF
import french_law.Aides_logement as AL
from typing import cast

# Allocations familiales


class Enfant:
    def __init__(
        self,
        id: int,
        remuneration_mensuelle: int,
        date_de_naissance: datetime.date,
        prise_en_charge: AF.PriseEnCharge_Code,
        a_deja_ouvert_droit_aux_allocations_familiales: bool,
        beneficie_titre_personnel_aide_personnelle_logement: bool
    ) -> None:
        self.id = id
        self.remuneration_mensuelle = remuneration_mensuelle
        self.date_de_naissance = date_de_naissance
        self.prise_en_charge = prise_en_charge
        self.a_deja_ouvert_droit_aux_allocations_familiales = a_deja_ouvert_droit_aux_allocations_familiales
        self.beneficie_titre_personnel_aide_personnelle_logement = beneficie_titre_personnel_aide_personnelle_logement

    def to_allocations_familiales(self) -> AF.EnfantEntree:
        return AF.EnfantEntree(
            d_identifiant=integer_of_int(self.id),
            d_remuneration_mensuelle=money_of_units_int(
                self.remuneration_mensuelle),
            d_a_deja_ouvert_droit_aux_allocations_familiales=self.a_deja_ouvert_droit_aux_allocations_familiales,
            d_beneficie_titre_personnel_aide_personnelle_logement=self.beneficie_titre_personnel_aide_personnelle_logement,
            d_date_de_naissance=date_of_datetime(self.date_de_naissance),
            d_prise_en_charge=AF.PriseEnCharge(self.prise_en_charge, Unit())
        )


def allocations_familiales(
        date_courante: datetime.date,
        enfants: List[Enfant],
        ressources_menage: int,
        residence: France.Collectivite_Code,
        personne_charge_effective_permanente_est_parent: bool,
        personne_charge_effective_permanente_remplit_titre_I: bool,
        avait_enfant_a_charge_avant_1er_janvier_2012: bool
):
    out = AF.interface_allocations_familiales(AF.InterfaceAllocationsFamilialesIn(
        i_date_courante_in=date_of_datetime(date_courante),
        i_enfants_in=[enfant.to_allocations_familiales()
                      for enfant in enfants],
        i_ressources_menage_in=money_of_units_int(ressources_menage),
        i_residence_in=France.Collectivite(residence, Unit()),
        i_personne_charge_effective_permanente_est_parent_in=personne_charge_effective_permanente_est_parent,
        i_personne_charge_effective_permanente_remplit_titre_I_in=personne_charge_effective_permanente_remplit_titre_I,
        i_avait_enfant_a_charge_avant_1er_janvier_2012_in=avait_enfant_a_charge_avant_1er_janvier_2012
    ))
    return money_to_float(out.i_montant_verse)

# Aides au logement


class PersonneAChargeAPL_Code(Enum):
    CodeEnfant = 0
    CodeParent = 1


class PersonneAChargeAPL(ABC):

    @abstractmethod
    def code(self) -> PersonneAChargeAPL_Code:
        pass


class EnfantAPL(PersonneAChargeAPL):
    def __init__(self, identifiant: int,
                 a_deja_ouvert_droit_aux_allocations_familiales: bool,
                 date_de_naissance: datetime.date,
                 remuneration_mensuelle: int,
                 obligation_scolaire: PF.SituationObligationScolaire_Code,
                 situation_garde_alternee: AL.SituationGardeAlternee_Code,
                 coefficient_garde_alternee: Optional[int],
                 nationalite: AL.Nationalite,
                 etudes_apprentissage_stage_formation_pro_impossibilite_travail: bool):
        self.identifiant = identifiant
        self.a_deja_ouvert_droit_aux_allocations_familiales = a_deja_ouvert_droit_aux_allocations_familiales
        self.date_de_naissance = date_de_naissance,
        self.remuneration_mensuelle = remuneration_mensuelle
        self.obligation_scolaire = obligation_scolaire
        self.situation_garde_alternee = situation_garde_alternee
        self.coefficient_garde_alternee = coefficient_garde_alternee
        self.nationalite = nationalite
        self.etudes_apprentissage_stage_formation_pro_impossibilite_travail = etudes_apprentissage_stage_formation_pro_impossibilite_travail
        self.code_v = PersonneAChargeAPL_Code.CodeEnfant

    def code(self):
        return self.code_v


class ParentAPL(PersonneAChargeAPL):
    def __init__(self, date_naissance: datetime.date,
                 ressources: int,
                 ascendant_descendant_collateral_deuxieme_troisieme_degre: bool,
                 parente: AL.Parente_Code,
                 incapacite_80_pourcent_ou_restriction_emploi: bool,
                 beneficiaire_l161_19_l351_8_l643_3_secu: bool,
                 titulaire_allocation_personne_agee: bool):
        self.date_naissance = date_naissance
        self.ressources = ressources
        self.ascendant_descendant_collateral_deuxieme_troisieme_degre = ascendant_descendant_collateral_deuxieme_troisieme_degre
        self.parente = parente
        self.incapacite_80_pourcent_ou_restriction_emploi = incapacite_80_pourcent_ou_restriction_emploi
        self.beneficiaire_l161_19_l351_8_l643_3_secu = beneficiaire_l161_19_l351_8_l643_3_secu
        self.titulaire_allocation_personne_agee = titulaire_allocation_personne_agee
        self.code_v = PersonneAChargeAPL_Code.CodeParent

    def code(self):
        return self.code_v


class InfosSpecifiques_Code(Enum):
    CodeLocation = 0
    CodeLogementFoyer = 1
    CodeAccessionPropriete = 2


class InfosSpecifiques(ABC):

    @abstractmethod
    def code(self) -> InfosSpecifiques_Code:
        pass


class InfosLocation(InfosSpecifiques):
    def __init__(self,
                 loyer_principal: int,
                 beneficiaire_aide_adulte_ou_enfant_handicapes: bool,
                 logement_est_chambre: bool,
                 colocation: bool,
                 agees_ou_handicap_adultes_hebergees_onereux_particuliers: bool,
                 logement_meuble_d842_2: bool,
                 ancien_loyer_et_apl_relogement: Optional[Tuple[int, int]],
                 type_bailleur: AL.TypeBailleur_Code,
                 bailleur_conventionne: Optional[bool],
                 reduction_loyer_solidarite: Optional[int]):
        self.loyer_principal = loyer_principal
        self.beneficiaire_aide_adulte_ou_enfant_handicapes = beneficiaire_aide_adulte_ou_enfant_handicapes
        self.logement_est_chambre = logement_est_chambre
        self.colocation = colocation
        self.agees_ou_handicap_adultes_hebergees_onereux_particuliers = agees_ou_handicap_adultes_hebergees_onereux_particuliers
        self.logement_meuble_d842_2 = logement_meuble_d842_2
        self.ancien_loyer_et_apl_relogement = ancien_loyer_et_apl_relogement
        self.type_bailleur = type_bailleur
        self.bailleur_conventionne = bailleur_conventionne
        self.reduction_loyer_solidarite = reduction_loyer_solidarite
        self.code_v = InfosSpecifiques_Code.CodeLocation

    def code(self):
        return self.code_v


class InfosLogementFoyer(InfosSpecifiques):
    def __init__(self,
                 type_logement: AL.TypeLogementFoyer_Code,
                 remplit_conditions_r832_21: bool,
                 conventionne_livre_III_titre_V_chap_III: bool,
                 date_conventionnement: datetime.date,
                 construit_application_loi_1957_12_III: bool,
                 redevance: int,
                 categorie_equivalence_loyer_d842_16: AL.CategorieEquivalenceLoyerAllocationLogementFoyer_Code,
                 conventionne_selon_regles_drom: bool,
                 beneficiaire_aide_adulte_ou_enfant_handicapes: bool,
                 logement_est_chambre: bool,
                 colocation: bool,
                 logement_meuble_d842_2: bool,
                 logement_foyer_jeunes_travailleurs: bool):
        self.logement_foyer_jeunes_travailleurs = logement_foyer_jeunes_travailleurs
        self.type_logement = type_logement
        self.remplit_conditions_r832_21 = remplit_conditions_r832_21
        self.conventionne_livre_III_titre_V_chap_III = conventionne_livre_III_titre_V_chap_III
        self.date_conventionnement = date_conventionnement
        self.construit_application_loi_1957_12_III = construit_application_loi_1957_12_III
        self.redevance = redevance
        self.categorie_equivalence_loyer_d842_16 = categorie_equivalence_loyer_d842_16
        self.conventionne_selon_regles_drom = conventionne_selon_regles_drom
        self.beneficiaire_aide_adulte_ou_enfant_handicapes = beneficiaire_aide_adulte_ou_enfant_handicapes
        self.logement_meuble_d842_2 = logement_meuble_d842_2
        self.logement_est_chambre = logement_est_chambre
        self.colocation = colocation
        self.code_v = InfosSpecifiques_Code.CodeLogementFoyer

    def code(self):
        return self.code_v


class InfosAccessionPropriete(InfosSpecifiques):
    def __init__(self,
                 logement_situe_commune_desequilibre_l831_2: bool,
                 mensualite_principale: int,
                 charges_mensuelles_pret: int,
                 date_entree_logement: datetime.date,
                 local_habite_premiere_fois_beneficiaire: bool,
                 copropriete: bool,
                 situation_r822_11_13_17: bool,
                 type_travaux_logement_d832_15: AL.TypeTravauxLogementD83215_Code,
                 type_travaux_logement_r842_5: AL.TypeTravauxLogementR8425_Code,
                 anciennete_logement: AL.NeufOuAncien_Code,
                 ameliore_par_occupant: Optional[bool],
                 type_pret: AL.TypePret_Code,
                 date_signature_pret: datetime.date,
                 titulaire_pret: AL.TitulairePret_Code,
                 operations_logement_evolutifs_sociaux_accession_propriete_aidee_Etat: bool,
                 accord_financement_representant_Etat_outre_mer: AL.AccordFinancementRepresentantEtatOutreMer_Code):
        self.logement_situe_commune_desequilibre_l831_2 = logement_situe_commune_desequilibre_l831_2
        self.mensualite_principale = mensualite_principale
        self.charges_mensuelles_pret = charges_mensuelles_pret
        self.date_entree_logement = date_entree_logement
        self.local_habite_premiere_fois_beneficiaire = local_habite_premiere_fois_beneficiaire
        self.copropriete = copropriete
        self.situation_r822_11_13_17 = situation_r822_11_13_17
        self.type_travaux_logement_d832_15 = type_travaux_logement_d832_15
        self.type_travaux_logement_r842_5 = type_travaux_logement_r842_5
        self.anciennete_logement = anciennete_logement
        self.ameliore_par_occupant = ameliore_par_occupant
        self.type_pret = type_pret
        self.date_signature_pret = date_signature_pret
        self.titulaire_pret = titulaire_pret
        self.operations_logement_evolutifs_sociaux_accession_propriete_aidee_Etat = operations_logement_evolutifs_sociaux_accession_propriete_aidee_Etat
        self.accord_financement_representant_Etat_outre_mer = accord_financement_representant_Etat_outre_mer
        self.code_v = InfosSpecifiques_Code.CodeAccessionPropriete

    def code(self):
        return self.code_v


def aides_logement(
    date_courante: datetime.date,
    residence: France.Collectivite_Code,
    ressources_menage_prises_en_compte: int,
    date_naissance_demandeur: datetime.date,
    nationalite_demandeur: AL.Nationalite,
    personne_hebergee_centre_soins: bool,
    personne_rattache_foyer_fiscal_parent_ifi: bool,
    nombre_autres_occupants_logement_hors_menage: int,
    enfant_a_naitre_apres_quatrieme_mois_grossesse: bool,
    personnes_agees_handicapees_foyer_r844_4: bool,
    situation_familiale: AL.SituationFamiliale_Code,
    date_mariage: Optional[datetime.date],
    prestations_recues: List[AL.PrestationRecue_Code],
    residence_principale: bool,
    logement_est_decent: bool,
    surface_logement_m_carres: int,
    zone: AL.ZoneDHabitation_Code,
    parts_logement_propriete_famille: Optional[int],
    parts_logement_usufruits_famille: Optional[int],
    date_naissance_et_conformite_sous_locataire_tiers: Optional[Tuple[datetime.date, bool]],
    magistrat_fonctionnaire_centre_interets_materiels_familiaux_hors_mayotte: bool,
    est_non_salarie_agricole_l781_8_l_781_46_code_rural: bool,
    mode_occupation: AL.ModeOccupation_Code,
    infos_specifiques: InfosSpecifiques,
    personnes_a_charge: List[PersonneAChargeAPL],
):
    if infos_specifiques.code() == InfosSpecifiques_Code.CodeLocation:
        infos_specifiques = cast(InfosLocation, infos_specifiques)
        mode_occupation_value = cast(Any, AL.Location(
            loyer_principal=money_of_units_int(
                infos_specifiques.loyer_principal),
            beneficiaire_aide_adulte_ou_enfant_handicapes=infos_specifiques.beneficiaire_aide_adulte_ou_enfant_handicapes,
            logement_est_chambre=infos_specifiques.logement_est_chambre,
            colocation=infos_specifiques.colocation,
            agees_ou_handicap_adultes_hebergees_onereux_particuliers=infos_specifiques.agees_ou_handicap_adultes_hebergees_onereux_particuliers,
            logement_meuble_d842_2=infos_specifiques.logement_meuble_d842_2,
            changement_logement_d842_4=AL.ChangementLogementD8424(
                code=AL.ChangementLogementD8424_Code.PasDeChangement if
                infos_specifiques.ancien_loyer_et_apl_relogement is None else
                AL.ChangementLogementD8424_Code.Changement,
                value=Unit() if infos_specifiques.ancien_loyer_et_apl_relogement is None else
                AL.InfosChangementLogementD8424(
                    ancien_loyer_principal=money_of_units_int(
                        infos_specifiques.ancien_loyer_et_apl_relogement[0]),
                    ancienne_allocation_logement=money_of_units_int(infos_specifiques.ancien_loyer_et_apl_relogement[1]))
            ),
            bailleur=AL.TypeBailleur(
                code=infos_specifiques.type_bailleur,
                value=Unit() if infos_specifiques.type_bailleur == AL.TypeBailleur_Code.BailleurPrive else (
                    AL.ConventionBailleurSocial(
                        conventionne_livre_III_titre_V_chap_III=False if infos_specifiques.bailleur_conventionne is None
                        else infos_specifiques.bailleur_conventionne,
                        reduction_loyer_solidarite_percue=money_of_units_int(0 if infos_specifiques.reduction_loyer_solidarite is None
                                                                             else infos_specifiques.reduction_loyer_solidarite))
                ) if infos_specifiques.type_bailleur == AL.TypeBailleur_Code.BailleurSocial else (
                    AL.ConventionANHA(
                        conventionne_livre_III_titre_II_chap_I_sec_3=False if infos_specifiques.bailleur_conventionne is None
                        else infos_specifiques.bailleur_conventionne)
                    if infos_specifiques.type_bailleur == AL.TypeBailleur_Code.BailleurPriveAvecConventionnementSocial else
                    None  # type: ignore
                ))
        ))
    elif infos_specifiques.code() == InfosSpecifiques_Code.CodeLogementFoyer:
        infos_specifiques = cast(InfosLogementFoyer, infos_specifiques)
        mode_occupation_value = cast(Any, AL.LogementFoyer(
            logement_foyer_jeunes_travailleurs=infos_specifiques.logement_foyer_jeunes_travailleurs,
            type_logement=AL.TypeLogementFoyer(
                code=infos_specifiques.type_logement, value=Unit()),
            conventionne_selon_regles_drom=infos_specifiques.conventionne_selon_regles_drom,
            logement_meuble_d842_2=infos_specifiques.logement_meuble_d842_2,
            beneficiaire_aide_adulte_ou_enfant_handicapes=infos_specifiques.beneficiaire_aide_adulte_ou_enfant_handicapes,
            remplit_conditions_r832_21=infos_specifiques.remplit_conditions_r832_21,
            conventionne_livre_III_titre_V_chap_III=infos_specifiques.conventionne_livre_III_titre_V_chap_III,
            date_conventionnement=date_of_datetime(
                infos_specifiques.date_conventionnement),
            construit_application_loi_1957_12_III=infos_specifiques.construit_application_loi_1957_12_III,
            redevance=money_of_units_int(
                infos_specifiques.redevance),
            categorie_equivalence_loyer_d842_16=AL.CategorieEquivalenceLoyerAllocationLogementFoyer(
                code=infos_specifiques.categorie_equivalence_loyer_d842_16,
                value=Unit()),
            logement_est_chambre=infos_specifiques.logement_est_chambre,
            colocation=infos_specifiques.colocation
        ))
    else:  # infos_specifiques.code == InfosSpecifiques_Code.CodeAccessionPropriete
        infos_specifiques = cast(InfosAccessionPropriete, infos_specifiques)
        mode_occupation_value = cast(Any, AL.Proprietaire(
            mensualite_principale=money_of_units_int(
                infos_specifiques.mensualite_principale),
            charges_mensuelles_pret=money_of_units_int(
                infos_specifiques.charges_mensuelles_pret),
            date_entree_logement=date_of_datetime(
                infos_specifiques.date_entree_logement),
            local_habite_premiere_fois_beneficiaire=infos_specifiques.local_habite_premiere_fois_beneficiaire,
            copropriete=infos_specifiques.copropriete,
            situation_r822_11_13_17=infos_specifiques.situation_r822_11_13_17,
            type_travaux_logement_d832_15=AL.TypeTravauxLogementD83215(
                code=infos_specifiques.type_travaux_logement_d832_15, value=Unit()),
            type_travaux_logement_r842_5=AL.TypeTravauxLogementR8425(
                code=infos_specifiques.type_travaux_logement_r842_5,
                value=Unit()
            ),
            anciennete_logement=AL.NeufOuAncien(code=infos_specifiques.anciennete_logement, value=Unit()
                                             if infos_specifiques.ameliore_par_occupant is None
                                             else infos_specifiques.ameliore_par_occupant),
            pret=AL.Pret(
                type_pret=AL.TypePret(
                    code=infos_specifiques.type_pret, value=Unit()),
                date_signature=date_of_datetime(
                    infos_specifiques.date_signature_pret),
                titulaire_pret=AL.TitulairePret(
                    code=infos_specifiques.titulaire_pret, value=Unit()),
                accord_financement_representant_Etat_outre_mer=AL.AccordFinancementRepresentantEtatOutreMer(
                    code=infos_specifiques.accord_financement_representant_Etat_outre_mer,
                    value=Unit())
            ),
            operations_logement_evolutifs_sociaux_accession_propriete_aidee_Etat=infos_specifiques.operations_logement_evolutifs_sociaux_accession_propriete_aidee_Etat
        ))

    def transform_personnes_a_charge(personne_a_charge: PersonneAChargeAPL) -> Any:
        if personne_a_charge.code() == PersonneAChargeAPL_Code.CodeEnfant:
            personne_a_charge = cast(EnfantAPL, personne_a_charge)
            out = AL.PersonneACharge(code=AL.PersonneACharge_Code.EnfantACharge,
                                  value=AL.EnfantACharge(
                                      nationalite=personne_a_charge.nationalite,
                                      etudes_apprentissage_stage_formation_pro_impossibilite_travail=personne_a_charge.etudes_apprentissage_stage_formation_pro_impossibilite_travail,
                                      identifiant=integer_of_int(
                                          personne_a_charge.identifiant),
                                      a_deja_ouvert_droit_aux_allocations_familiales=personne_a_charge.a_deja_ouvert_droit_aux_allocations_familiales,
                                      date_de_naissance=date_of_datetime(
                                          personne_a_charge.date_de_naissance[0]),
                                      remuneration_mensuelle=money_of_units_int(
                                          personne_a_charge.remuneration_mensuelle),
                                      obligation_scolaire=PF.SituationObligationScolaire(
                                          code=personne_a_charge.obligation_scolaire, value=Unit()),
                                      situation_garde_alternee=AL.SituationGardeAlternee(code=personne_a_charge.situation_garde_alternee,
                                                                                      value=Unit() if personne_a_charge.coefficient_garde_alternee is None else personne_a_charge.coefficient_garde_alternee)
                                  ))
        else:  # personne_a_charge.code == PersonneAChargeAPL_Code.CodeParent
            personne_a_charge = cast(ParentAPL, personne_a_charge)
            out = AL.PersonneACharge(
                code=AL.PersonneACharge_Code.AutrePersonneACharge,
                value=AL.AutrePersonneACharge(
                    date_naissance=date_of_datetime(
                        personne_a_charge.date_naissance),
                    ressources=money_of_units_int(
                        personne_a_charge.ressources),
                    ascendant_descendant_collateral_deuxieme_troisieme_degre=personne_a_charge.ascendant_descendant_collateral_deuxieme_troisieme_degre,
                    incapacite_80_pourcent_ou_restriction_emploi=personne_a_charge.incapacite_80_pourcent_ou_restriction_emploi,
                    beneficiaire_l161_19_l351_8_l643_3_secu=personne_a_charge.beneficiaire_l161_19_l351_8_l643_3_secu,
                    titulaire_allocation_personne_agee=personne_a_charge.titulaire_allocation_personne_agee,
                    parente=AL.Parente(
                        code=personne_a_charge.parente, value=Unit())
                ))
        return out

    out = AL.calculette_aides_au_logement_garde_alternee(AL.CalculetteAidesAuLogementGardeAlterneeIn(
        menage_in=AL.Menage(
            residence=France.Collectivite(
                code=residence, value=Unit()),
            prestations_recues=[AL.PrestationRecue(
                code=presta, value=Unit()) for presta in prestations_recues],
            logement=AL.Logement(
                residence_principale=residence_principale,
                mode_occupation=AL.ModeOccupation(
                    code=mode_occupation,
                    value=mode_occupation_value
                ),
                proprietaire=AL.ParentOuAutre(
                    code=AL.ParentOuAutre_Code.Autre if parts_logement_propriete_famille is None else AL.ParentOuAutre_Code.DemandeurOuConjointOuParentOuViaPartsSocietes,
                    value=Unit() if parts_logement_propriete_famille is None else parts_logement_propriete_famille),
                usufruit=AL.ParentOuAutre(
                    code=AL.ParentOuAutre_Code.Autre if parts_logement_usufruits_famille is None else AL.ParentOuAutre_Code.DemandeurOuConjointOuParentOuViaPartsSocietes,
                    value=Unit() if parts_logement_usufruits_famille is None else parts_logement_usufruits_famille),
                loue_ou_sous_loue_a_des_tiers=AL.LoueOuSousLoueADesTiers(
                    code=AL.LoueOuSousLoueADesTiers_Code.Non if date_naissance_et_conformite_sous_locataire_tiers is None else AL.LoueOuSousLoueADesTiers_Code.Oui,
                    value=Unit() if date_naissance_et_conformite_sous_locataire_tiers is None else AL.PersonneSousLocation(
                        date_naissance_personne_sous_location=date_of_datetime(date_naissance_et_conformite_sous_locataire_tiers[
                            0]),
                        conforme_article_l442_1=date_naissance_et_conformite_sous_locataire_tiers[
                            1]
                    )
                ),
                logement_decent_l89_462=logement_est_decent,
                surface_m_carres=integer_of_int(surface_logement_m_carres),
                zone=AL.ZoneDHabitation(code=zone, value=Unit())
            ),
            personnes_a_charge=[
                transform_personnes_a_charge(personne_a_charge)
                for personne_a_charge in personnes_a_charge],
            nombre_autres_occupants_logement=integer_of_int(
                nombre_autres_occupants_logement_hors_menage),
            situation_familiale=AL.SituationFamiliale(
                code=situation_familiale,
                value=Unit() if date_mariage is None else date_of_datetime(date_mariage)
            ),
            condition_rattache_foyer_fiscal_parent_ifi=personne_rattache_foyer_fiscal_parent_ifi,
            enfant_a_naitre_apres_quatrieme_mois_grossesse=enfant_a_naitre_apres_quatrieme_mois_grossesse,
            personnes_agees_handicapees_foyer_r844_4=personnes_agees_handicapees_foyer_r844_4
        ),
        demandeur_in=AL.Demandeur(
            date_naissance=date_of_datetime(date_naissance_demandeur),
            nationalite=nationalite_demandeur,
            est_non_salarie_agricole_l781_8_l_781_46_code_rural=est_non_salarie_agricole_l781_8_l_781_46_code_rural,
            magistrat_fonctionnaire_centre_interets_materiels_familiaux_hors_mayotte=magistrat_fonctionnaire_centre_interets_materiels_familiaux_hors_mayotte,
            personne_hebergee_centre_soin_l_L162_22_3_securite_sociale=personne_hebergee_centre_soins,
        ),
        date_courante_in=date_of_datetime(date_courante),
        ressources_menage_prises_en_compte_in=money_of_units_int(
            ressources_menage_prises_en_compte),
    ))
    return money_to_float(out.aide_finale)
