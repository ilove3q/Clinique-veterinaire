# Creation des tables


CREATE TABLE Client ( 
    id INTEGER SERIAL, 
    nom VARCHAR(50) NOT NULL, 
    prenom VARCHAR(50) NOT NULL, 
    dateNaissance DATE NOT NULL, 
    adresse VARCHAR(50) NOT NULL, 
    numero VARCHAR(10) NOT NULL, 
    PRIMARY KEY(id),
    UNIQUE (nom,prenom,dateNaissance), 
    CONSTRAINT ck_phone 
        CHECK(numero 
            LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')) 
);

CREATE TABLE Animal (
    id INTEGER SERIAL, 
    nom VARCHAR(50) NOT NULL, 
    proprietaire INTEGER NOT NULL, 
    poids FLOAT NOT NULL, 
    taille FLOAT NOT NULL, 
    dateNaissance DATE, 
    espece VARCHAR NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE (nom,proprietaire), 
    CONSTRAINT chk_poids CHECK (poids > 0),
    CONSTRAINT chk_taille CHECK (taille > 0 )
);

CREATE TABLE Veterinaire(
  id            SERIAL,
  nom           VARCHAR(50) NOT NULL,
  prenom        VARCHAR(50) NOT NULL,
  dateNaissance DATE        NOT NULL,
  adreesse      VARCHAR(50) NOT NULL,
  numero        CHAR(10)    NOT NULL,
  specialite    VARCHAR(50),
  FOREIGN KEY (specialite) REFERENCES classeEspece (nom),
  PRIMARY KEY (id),
  UNIQUE (nom, prenom, dateNaissance),
  CONSTRAINT ck_phone
    CHECK ( numero LIKE ('0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
);

CREATE TABLE Assiant
(
  id            SERIAL,
  nom           VARCHAR(50) NOT NULL,
  prenom        VARCHAR(50) NOT NULL,
  dateNaissance DATE        NOT NULL,
  adreesse      VARCHAR(50) NOT NULL,
  numero        CHAR(10)    NOT NULL,
  specialite    VARCHAR(50),
  FOREIGN KEY (specialite) REFERENCES classeEspece (nom),
  PRIMARY KEY (id),
  UNIQUE (nom, prenom, dateNaissance),
  CONSTRAINT ck_phone
    CHECK ( numero LIKE ('0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
);


CREATE TABLE ClasseEspece (
    nom VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Espece (
    nom VARCHAR(50) PRIMARY KEY,
    classe VARCHAR(50) NOT NULL,
    FOREIGN KEY(classe) REFERENCES ClasseEspece(nom)
);

CREATE TABLE Medicament (
    nomMolecule VARCHAR(100) PRIMARY KEY,
    description TEXT NOT NULL
);


CREATE TABLE AutorisationMedicament(
    medicament VARCHAR(100),
    espece VARCHAR(100),
    PRIMARY KEY(medicament, espece),
    FOREIGN KEY(medicament) REFERENCES Medicament(nomMolecule),
    FOREIGN KEY(espece) REFERENCES Espece(nom)
);

CREATE TABLE Traitement (
    id INTEGER SERIAL, 
    debut DATE NOT NULL,
    animal INTEGER NOT NULL,
    duree INTEGER NOT NULL,
    veterinaire INTEGER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(animal) REFERENCES Animal(id),
    FOREIGN KEY(veterinaire) REFERENCES Veterinaire(id),
    CONSTRAINT chk_duree CHECK (duree > 0)
);

CREATE TABLE Prescription (
    medicament VARCHAR(100),
    traitement INTEGER,
    quantite INTEGER NOT NULL,
    PRIMARY KEY(medicament, traitement),
    FOREIGN KEY(medicament) REFERENCES Medicament(nomMolecule),
    FOREIGN KEY(traitement) REFERENCES Traitement(id),
    CONSTRAINT chk_quantite CHECK (quantite > 0)
);
