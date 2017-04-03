CREATE TABLE VIN (
nom VARCHAR(50),
nb_bouteille INT NOT NULL,
annee_vin int,
PRIMARY KEY(nom, annee_vin),
CHECK (annee_vin <= date_part('year',current_timestamp)));

CREATE TABLE CRITERE (
nom_critere VARCHAR(50) PRIMARY KEY,
description VARCHAR(100) NOT NULL);

CREATE TABLE NOTER (
nom VARCHAR(50),
annee_vin int,
nom_critere VARCHAR(50),
note int NOT NULL,
FOREIGN KEY (nom, annee_vin) REFERENCES VIN (nom, annee_vin),
FOREIGN KEY (nom_critere) REFERENCES CRITERE (nom_critere),
PRIMARY KEY (nom, annee_vin, nom_critere),
CHECK (note <= 100),
CHECK (note >=0));



CREATE TABLE PARCELLE (
id_cadastral INT,
cepage VARCHAR(50) NOT NULL,
superficie INT NOT NULL, 
type_sol VARCHAR(50) NOT NULL,
pluviometrie INT NOT NULL,
ensoleillement INT NOT NULL,
PRIMARY KEY (id_cadastral),
CHECK(superficie >= 0),
CHECK(0 <= pluviometrie),
CHECK(pluviometrie <= 100),
CHECK(ensoleillement >= 0),
CHECK(ensoleillement <= 100));

CREATE TABLE EXPLOITATION (
annee int,
id_cadastral int,
traitement int NOT NULL,
gestion_sol VARCHAR(50) NOT NULL,
taille VARCHAR(50) NOT NULL,
FOREIGN KEY (id_cadastral) REFERENCES PARCELLE (id_cadastral),
PRIMARY KEY (annee, id_cadastral),
CHECK (annee <= date_part('year',current_timestamp)),
CHECK (traitement >=0)
);





CREATE TABLE ASSEMBLER (
nom VARCHAR(50),
annee_vin int,
id_cadastral int,
annee int,
proportion int NOT NULL,
FOREIGN KEY (nom, annee_vin) REFERENCES VIN (nom, annee_vin),
FOREIGN KEY (id_cadastral, annee) REFERENCES EXPLOITATION (id_cadastral, annee),
PRIMARY KEY (nom, annee_vin, id_cadastral, annee),
CHECK (annee_vin = annee),
CHECK (proportion <= 100),
CHECK (proportion >= 0) );

CREATE TABLE ALEA  (
id_alea int NOT NULL,
nom VARCHAR(50) NOT NULL,
jour int NOT NULL,
mois int NOT NULL,
PRIMARY KEY (id_alea),
CHECK ( mois > 0),
CHECK (mois <= 12),
CHECK (jour > 0),
CHECK( jour <= 31) 
);

CREATE TABLE TOUCHER (
id_alea int,
annee int,
id_cadastral int,
intensite int NOT NULL,
FOREIGN KEY (id_alea) REFERENCES ALEA (id_alea),
FOREiGN KEY (annee, id_cadastral) REFERENCES EXPLOITATION (annee, id_cadastral),
PRIMARY KEY (id_alea, annee, id_cadastral),
CHECK (intensite >=0),
CHECK (intensite <=100));
