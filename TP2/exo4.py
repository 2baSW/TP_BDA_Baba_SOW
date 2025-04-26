myrelations = [
    {'A', 'B', 'C', 'G', 'H', 'I'},
    {'X', 'Y'}
]

mydependencies = [
    [{'A'}, {'B'}],  # A -> B
    [{'A'}, {'C'}],  # A -> C
    [{'C', 'G'}, {'H'}],  # CG -> H
    [{'C', 'G'}, {'I'}],  # CG -> I
    [{'B'}, {'H'}]  # B -> H
]

def afficher_dependances(liste_dependances: "list of dependencies"):
    for ant, cons in liste_dependances:
        print("\t", ant, "-->", cons)
        
        
def afficher_relations(liste_relations: "list of relations"):
    print("Voici les relations présentes :")
    for relation in liste_relations:
        print("\t", relation)



import itertools

def ensemble_sous_ensembles(inputset: "set"):
    resultat = []
    for r in range(1, len(inputset) + 1):
        resultat += map(set, itertools.combinations(inputset, r))
    return resultat



def calculer_cloture_attributs(F: "list of dependencies", K: "set"):
    fermeture = set(K)
    taille = -1
    while taille != len(fermeture):
        taille = len(fermeture)
        for antecedent, consequent in F:
            if antecedent.issubset(fermeture):
                fermeture.update(consequent)
    return fermeture


def generer_cloture_fonctionnelle(F: "list of dependencies"):
    ensemble = set()
    for ant, cons in F:
        ensemble.update(ant | cons)

    F_plus = []
    for K in ensemble_sous_ensembles(ensemble):
        for partie in ensemble_sous_ensembles(calculer_cloture_attributs(F, K)):
            F_plus.append([K, partie])

    return F_plus


def verifier_dependance(F: "list of dependencies", alpha: "set", beta: "set"):
    return beta.issubset(calculer_cloture_attributs(F, alpha))


def est_super_cle(F: "list of dependencies", R: "set", K: "set"):
    return R.issubset(calculer_cloture_attributs(F, K))


def est_cle_candidate(F: "list of dependencies", R: "set", K: "set"):
    if not est_super_cle(F, R, K):
        return False
    for attribut in K:
        sous_ensemble = set(K)
        sous_ensemble.discard(attribut)
        if est_super_cle(F, R, sous_ensemble):
            return False
    return True


def trouver_cles_candidates(F: "list of dependencies", R: "set"):
    cles_candidates = []
    for K in ensemble_sous_ensembles(R):
        if est_cle_candidate(F, R, K):
            cles_candidates.append(K)
    return cles_candidates


def trouver_super_cles(F: "list of dependencies", R: "set"):
    super_cles = []
    for K in ensemble_sous_ensembles(R):
        if est_super_cle(F, R, K):
            super_cles.append(K)
    return super_cles


def trouver_une_cle_candidate(F: "list of dependencies", R: "set"):
    K = set(R)
    while not est_cle_candidate(F, R, K):
        for attribut in list(K):
            sous_ensemble = K - {attribut}
            if est_super_cle(F, R, sous_ensemble):
                K.remove(attribut)
                break
    return K

def est_relation_bcnf(F: "list of dependencies", R: "set"):
    for sous_ensemble in ensemble_sous_ensembles(R):
        fermeture = calculer_cloture_attributs(F, sous_ensemble)
        if not R.issubset(fermeture) and not fermeture.isdisjoint(R - sous_ensemble):
            return False
    return True


def est_schema_bcnf(F: "list of dependencies", T: "list of relations"):
    for relation in T:
        if not est_relation_bcnf(F, relation):
            return False
    return True


def decomposer_schema_bcnf(F: "list of dependencies", T: "list of relations"):
    nouvelles_relations = list(T)
    taille = 0

    while taille != len(nouvelles_relations):
        taille = len(nouvelles_relations)
        for relation in nouvelles_relations:
            if not est_relation_bcnf(F, relation):
                for sous_ensemble in ensemble_sous_ensembles(relation):
                    fermeture = calculer_cloture_attributs(F, sous_ensemble)
                    if not relation.issubset(fermeture) and not fermeture.isdisjoint(relation - sous_ensemble):
                        R1 = sous_ensemble.union(fermeture.intersection(relation))
                        R2 = relation - (fermeture - sous_ensemble)
                        nouvelles_relations.remove(relation)
                        if R1 not in nouvelles_relations:
                            nouvelles_relations.append(R1)
                        if R2 not in nouvelles_relations:
                            nouvelles_relations.append(R2)
                        break
                break
    return nouvelles_relations


if __name__ == "__main__":
    resultat_bcnf = decomposer_schema_bcnf(mydependencies, myrelations)
    print("Relations obtenues après décomposition BCNF :")
    afficher_relations(resultat_bcnf)
