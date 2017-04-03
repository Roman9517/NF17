1. Afficher les vins affectés par un aléa climatique.
        
SELECT DISTINCT vin.nom, vin.annee_vin
FROM toucher, assembler, vin
WHERE assembler.id_cadastral=toucher.id_cadastral
AND assembler.annee_vin=toucher.annee
AND vin.annee_vin=assembler.annee_vin
AND vin.nom=assembler.nom
GROUP BY vin.annee_vin, vin.nom, assembler.id_cadastral, id_alea, intensite
ORDER BY vin.nom;




1. Afficher la note de différents vins en fonction d’un critère sélectionné.




SELECT * FROM noter WHERE (nom_critere='robe')
Order by note;


        
1. Afficher l’historique des exploitations pour une parcelle donnée.


SELECT * FROM exploitation 
WHERE id_cadastral=1 
ORDER BY annee DESC;     




1. Pour un vin donné, afficher le nombre de traitement utilisé par exploitation le composant.


SELECT assembler.nom, assembler.annee_vin, assembler.id_cadastral, exploitation.traitement  FROM assembler 
INNER JOIN exploitation 
ON assembler.nom='Chateau1'
AND assembler.annee='2001' 
AND exploitation.annee = '2001' 
AND assembler.id_cadastral = exploitation.id_cadastral 
AND exploitation.traitement>0;




1. Afficher, pour un vin et une année donnés, les différentes exploitations utilisées ainsi que les cépages associés et le nombre de bouteilles produites.


SELECT assembler.nom, assembler.annee_vin, parcelle.id_cadastral,cepage,nb_bouteille        
FROM assembler, parcelle, vin
WHERE assembler.nom='Chateau1'
AND assembler.annee_vin='2001' 
AND parcelle.id_cadastral=assembler.id_cadastral 
AND VIN.annee_vin=assembler.annee_vin 
AND assembler.nom=vin.nom;




1. Afficher l’ensemble des exploitations touchées par un aléa d’intensité maximale (>90), dont la proportion dans un vin est supérieur à 50 (assurance).


SELECT assembler.nom, assembler.annee_vin,assembler.id_cadastral, assembler.annee, proportion, intensite
FROM toucher, assembler
WHERE assembler.id_cadastral=toucher.id_cadastral
AND assembler.annee=toucher.annee
AND assembler.proportion>50
AND intensite>90
ORDER BY intensite DESC;




1. Afficher un tableau rangé par ordre croissant du nombre de bouteilles produites d’un vin donné en fonction de toutes les années où il a été produit et du nombre de traitement utilisé.


SELECT vin.annee_vin,vin.nom, vin.nb_bouteille, sum(exploitation.traitement) AS nb_traitement 
FROM vin, exploitation, assembler
WHERE vin.nom='Chateau1'
AND assembler.nom=vin.nom
AND assembler.annee_vin=vin.annee_vin
AND assembler.id_cadastral=exploitation.id_cadastral
GROUP BY vin.annee_vin, vin.nom
ORDER BY  nb_bouteille DESC;       






1. Afficher le nombre de cépage dans un vin et une date donnée (retourne uniquement un entier).


SELECT COUNT (*) FROM assembler
WHERE assembler.nom='Chateau1'
AND assembler.annee=2001;


1. Changer la note d’un vin.


UPDATE noter
SET note =6
WHERE nom= 'Chateau1' AND nom_critere = 'robe' AND annee_vin=2001;




1. Compter le nombre de vin pour une année donnée.


SELECT COUNT(*) 
FROM vin 
WHERE annee_vin = 2001;




1.  Afficher les caractéristiques des vins ayant une note supérieure ou égale à la moyenne pour un critère donné.


SELECT DISTINCT noter.nom, nom_critere, noter.annee_vin, note, exploitation.id_cadastral,cepage, gestion_sol, taille, traitement, type_sol, pluviometrie, ensoleillement
FROM noter, parcelle, exploitation
WHERE noter.note>60
AND noter.annee_vin=exploitation.annee
AND exploitation.id_cadastral=parcelle.id_cadastral
AND nom_critere='robe'
ORDER BY noter.nom;