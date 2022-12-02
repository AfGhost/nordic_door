DROP DATABASE nordic_door;
CREATE DATABASE nordic_door;

USE nordic_door;

CREATE OR REPLACE TABLE navn (
navn_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
fornavn VARCHAR(30) NOT NULL,
mellomnavn VARCHAR(30),
etternavn VARCHAR(30) NOT NULL,
brukernavn VARCHAR(50) NOT NULL
);

CREATE OR REPLACE TABLE teams (
teams_id TINYINT AUTO_INCREMENT PRIMARY KEY,
team VARCHAR(20) NOT NULL
);

CREATE OR REPLACE TABLE roller (
roller_id TINYINT AUTO_INCREMENT PRIMARY KEY,
rolle VARCHAR(20) NOT NULL,
grad INT NOT NULL
);

CREATE OR REPLACE TABLE t_medlemmer (
t_medlemmer_id TINYINT AUTO_INCREMENT PRIMARY KEY,
navn_id SMALLINT,
teams_id TINYINT,
CONSTRAINT tm_navn_FK FOREIGN KEY (navn_id) REFERENCES navn(navn_id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT tm_teams_FK FOREIGN KEY (teams_id) REFERENCES teams(teams_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE OR REPLACE TABLE ansatt (
ansatt_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
epost VARCHAR(50),
passord VARCHAR(50) NOT NULL,
ansatt_tilstand VARCHAR(50) NOT NULL,
navn_id SMALLINT,
teams_id TINYINT,
roller_id TINYINT,
t_medlemmer_id TINYINT,
CONSTRAINT navn_ansatt_FK FOREIGN KEY (navn_id) REFERENCES navn(navn_id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT teams_ansatt_FK FOREIGN KEY (teams_id) REFERENCES teams(teams_id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT grad_ansatt_FK FOREIGN KEY (roller_id) REFERENCES roller(roller_id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT tm_ansatt_FK FOREIGN KEY (t_medlemmer_id) REFERENCES t_medlemmer(t_medlemmer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE rapporter_problem (
rproblem_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT,
problem_tittel VARCHAR(100) NOT NULL,
problem_tekst VARCHAR(1000) NOT NULL,
CONSTRAINT ansatt_rp_FK FOREIGN KEY (ansatt_id) REFERENCES ansatt(ansatt_id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE OR REPLACE TABLE godkjenning (
gkjenning_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT,
gkjent_ikke_gkjent VARCHAR(50),
type_godkjenning SMALLINT,
CONSTRAINT ansatt_gkjenning_FK FOREIGN KEY (ansatt_id) REFERENCES ansatt(ansatt_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE OR REPLACE TABLE tidsperiode (
tperiode_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
varighet VARCHAR(30),
tperiode VARCHAR(30),
type_tid SMALLINT
);

CREATE OR REPLACE TABLE kostnad (
kostnad_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
kostnad VARCHAR(70),
med_uten_K VARCHAR(30),
type_K SMALLINT
);

CREATE OR REPLACE TABLE fremdrift (
fremdrift_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
status_id SMALLINT,
forslag_id SMALLINT,
fremgang VARCHAR(100) NOT NULL,
aktiv_ikke_aktiv VARCHAR(50),
type_aktiv SMALLINT,
prosentvis_fullført DECIMAL,
tildelt_team TINYINT
);

CREATE OR REPLACE TABLE status_f (
status_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
fremdrift_id SMALLINT,
CONSTRAINT status_fremdrift_FK FOREIGN KEY (fremdrift_id) REFERENCES fremdrift(fremdrift_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE OR REPLACE TABLE forslag (
forslag_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT,
tittel VARCHAR(100) NOT NULL,
nyttforslag VARCHAR (1000) NOT NULL,
årsak VARCHAR(500),
mål VARCHAR(500),
løsning VARCHAR(1000),
dato_registrert DATETIME NOT NULL,
frist DATETIME,
bilde LONGBLOB,
navn_id SMALLINT,
ansvarlig VARCHAR(50),
tperiode_id SMALLINT,
kostnad_id SMALLINT,
teams_id TINYINT,
gkjenning_id SMALLINT,
status_id SMALLINT,
CONSTRAINT navn_forslag_FK FOREIGN KEY (navn_id) REFERENCES navn(navn_id) ON UPDATE CASCADE ON DELETE SET NULL ,
CONSTRAINT tperiode_forslag_FK FOREIGN KEY (tperiode_id) REFERENCES tidsperiode(tperiode_id) ON UPDATE CASCADE ON DELETE SET NULL ,
CONSTRAINT kostnad_forslag_FK FOREIGN KEY (kostnad_id) REFERENCES kostnad(kostnad_id) ON UPDATE CASCADE ON DELETE SET NULL ,
CONSTRAINT ansatt_forslag_FK FOREIGN KEY (ansatt_id) REFERENCES ansatt(ansatt_id) ON UPDATE CASCADE ON DELETE SET NULL ,
CONSTRAINT teams_forslag_FK FOREIGN KEY (teams_id) REFERENCES teams(teams_id) ON UPDATE CASCADE ON DELETE SET NULL ,
CONSTRAINT gkjenning_forslag_FK FOREIGN KEY (gkjenning_id) REFERENCES godkjenning(gkjenning_id) ON UPDATE CASCADE ON DELETE SET NULL ,
CONSTRAINT status_forslag_FK FOREIGN KEY (status_id) REFERENCES status_f(status_id) ON UPDATE CASCADE ON DELETE SET NULL
);


INSERT INTO navn (fornavn, mellomnavn, etternavn, brukernavn)
VALUES ('Ardian', 'Abc', 'Gorgaj', 'argo1'),
       ('Janis', 'G', 'Gailis', 'jaga2'),
       ('Ola', 'N', 'Nordmann', 'olno3'),
       ('Manis', 'V', 'Katis', 'maka4'),
       ('Christoffer', 'B', 'Buvik', 'chbu5'),
       ('Anders', 'Nilsen', 'Bærum', 'anbæ6'),
       ('Abdullah', '', 'Kadir', 'abka7'),
       ('Fana', '', 'Hansa', 'faha8'),
       ('Elion', '', 'Muriqi', 'elmo9'),
       ('Albert ', 'Jenns', 'Bjarne', 'albj10'),
       ('Rollf', 'Arne', 'Henriksen', 'rohen11'),
       ('Rona', '', 'Fjert', 'rofj12'),
       ('Shlirim', 'Chelsea', 'Balaj', 'shba13'),
       ('Mona', 'Rita', 'Danielsen', 'moda14'),
       ('Ole', 'Kristian', 'Hansen', 'olha15'),
       ('Maria', 'K', 'Krim', 'makr16'),
       ('Abdallah', 'Def', 'Bakir', 'abba17'),
       ('OlavMagnus', 'Oliver', 'Jensen', 'olje18'),
       ('Nadia', 'Jamal', 'Mahmood', 'nama19'),
       ('Shima', 'S', 'Johnsen', 'shjo20'),
       ('Morchal', 'Afghan', 'Safi', 'mosa21'),
       ('Vasi', 'Lin', 'Milan', 'vami22'),
       ('Maria', 'Bru', 'Hochnovska', 'maho23'),
       ('Sarah', 'S', 'Sara', 'sasa24');

INSERT INTO teams(team)
VALUES(4),
      (4),
      (4),
      (4),
      (2),
      (2),
      (2),
      (2),
      (20),
      (20),
      (20),
      (20),
      (5),
      (5),
      (5),
      (5),
      (9),
      (9),
      (9),
      (9),
      (7),
      (7),
      (7),
      (7);

INSERT INTO roller(rolle, grad)
VALUES('Bruker', '3'),
      ('Administrator', '1'),
      ('Teamleder', '2'),
      ('Bruker', '3'),
      ('Teamleder', '2'),
      ('Bruker', '3'),
      ('Administrator', '1'),
      ('Bruker', '3'),
      ('Administrator', '1'),
      ('Bruker', '3'),
      ('Teamleder', '2'),
      ('Bruker', '3'),
      ('Administrator', '1'),
      ('Bruker', '3'),
      ('Teamleder', '2'),
      ('Bruker', '3'),
      ('Teamleder', '2'),
      ('Bruker', '3'),
      ('Administrator', '1'),
      ('Bruker', '3'),
      ('Administrator', '3'),
      ('Teamleder', '2'),
      ('Bruker', '3'),
      ('Bruker', '3');

INSERT INTO t_medlemmer(navn_id, teams_id)
VALUES('1', '1'),
      ('2', '2'),
      ('3', '3'),
      ('4', '4'),
      ('5', '5'),
      ('6', '6'),
      ('7', '7'),
      ('8', '8'),
      ('9', '9'),
      ('10', '10'),
      ('11', '11'),
      ('12', '12'),
      ('13', '13'),
      ('14', '14'),
      ('15', '15'),
      ('16', '16'),
      ('17', '17'),
      ('18', '18'),
      ('19', '19'),
      ('20', '20'),
      ('21', '21'),
      ('22', '22'),
      ('23', '23'),
      ('24', '24');

INSERT INTO ansatt(ansatt_id, epost, passord, ansatt_tilstand, navn_id, teams_id, roller_id, t_medlemmer_id)
VALUES('1', 'ag@gmail.com', 'Testing1234', 'Aktiv', 1, 1, 3, 1),
      ('2', 'olanordman@yahoo.com', 'JG12345', 'Aktiv', 2, 2, 1, 2),
      ('3', 'olanordman@yahoo.com', 'Ola54321', 'Aktiv', 3, 3, 2, 3),
      ('4', 'manis@gmail.com', 'Manka5234', 'Ikke Aktiv', 4, 4, 3, 4),
      ('5', 'buvikchristoffer@gmail.com', 'Ronaldo7', 'Aktiv', 5, 5, 2, 5),
      ('6', 'andersnb@gmail.com', 'Tacokveld124', 'Aktiv', 6, 6, 3, 6),
      ('7', 'abdigang@gmail.com', 'Marinertepølser', 'Aktiv', 7, 7, 1, 7),
      ('8', 'fana@gmail.com', 'Hansafa8923', 'Ikke Aktiv', 8, 8, 3, 8),
      ('9', 'muriqielion@gmail.com', 'Test1234', 'Aktiv', 9, 9, 1, 9),
      ('10', 'rolff@gmail.com', 'Anti12', 'Aktiv', 10, 10, 3, 10),
      ('11', 'arne@gmail.com', 'Rolff123', 'Aktiv', 11, 11, 2, 11),
      ('12', 'rona@gmail.com', 'Rof1212', 'Aktiv', 12, 12, 3, 12),
      ('13', 'shlirim.balaj@gmail.com', 'Abc123', 'Aktiv', 13, 13, 1, 13),
      ('14', 'mona66@hotmail.no', 'Lfc123', 'Aktiv', 14, 14, 3, 14),
      ('15', 'ok.hansen@outlook.no', 'Kattepus22', 'Ikke Aktiv', 15, 15, 2, 15),
      ('16', 'maria@gmail.com', 'Fjott56', 'Aktiv', 16, 16, 3, 16),
      ('17', 'abdallahbakir02@gmail.com', 'Testingtesting1234', 'Aktiv', 17, 17, 2, 17),
      ('18', 'olaJensen@gmail.com', 'Norge123', 'Aktiv', 18, 18, 3, 18),
      ('19', 'nadiaMahmood@gmail.com', 'NadiaM', 'Aktiv', 19, 19, 1, 19),
      ('20', 'shima@gmail.com', 'Shi45', 'Aktiv', 20, 20, 3, 20),
      ('21', 'stemi@gmail.com', 'Mo1616', 'Aktiv', 21, 21, 1, 21),
      ('22', 'vasi@gmail.com', 'Vam1717', 'Aktiv', 22, 22, 2, 22),
      ('23', 'maria@gmail.com', 'Hoch1818', 'Aktiv', '23', '23', '3', 23),
      ('24', 'sarsa@gmail.com', 'Sasa0193','Ikke Aktiv', 24, 24, 3, 24);

INSERT INTO rapporter_problem(ansatt_id, problem_tittel, problem_tekst)
VALUES(4, 'Lagre knapp', 'Får ikke lagret forslaget på nettsiden da lagre knappen dukker ikke opp.'),
      (6, 'Innlogging', 'Problemer med innlogging av min bruker.'),
      (11, 'Scrolling', 'Får ikke scrollet nedover på siden, da siden hopper tilbake til toppen igjen.'),
      (18, 'Passord', 'Passordet mitt fungerer ikke igjen, selv om jeg fikk nytt passord i går og den ble testet.');

INSERT INTO godkjenning(ansatt_id, gkjent_ikke_gkjent, type_godkjenning)
VALUES(1, 'Vurderes', 2),
      (2, 'Godkjent', 1),
      (3, 'Godkjent', 1),
      (5, 'Vurderes', 2),
      (6, 'Godkjent', 1),
      (7, 'Godkjent', 1),
      (9, 'Ikke godkjent', 0),
      (10, 'Godkjent', 1),
      (11, 'Vurderes', 2),
      (13, 'Vurderes', 2),
      (14, 'Vurderes', 2),
      (15, 'Godkjent', 1),
      (17, 'Godkjent', 1),
      (18, 'Godkjent', 1),
      (19, 'Godkjent', 1),
      (21, 'Ikke godkjent', 0),
      (22, 'Godkjent', 1),
      (23, 'Vurderes', 2),
      (1, 'Godkjent', 1),
      (9, 'Vurderes', 2),
      (21, 'Vurderes', 2),
      (21, 'Vurderes', 2),
      (1, 'Godkjent', 1),
      (9, 'Godkjent', 1),
      (21, 'Godkjent', 1),
      (1, 'Godkjent', 1),
      (9, 'Godkjent', 1);

INSERT INTO tidsperiode(varighet, tperiode, type_tid)
VALUES('1 måned', 'Kortsiktig', 0),
      ('2 måneder', 'Langsiktig', 1),
      ('1 måned', 'Kortsiktig', 0),
      ('1 uke', 'Kortsiktig', 0),
      ('1 dag', 'Kortsiktig', 0),
      ('4 måneder', 'Langsiktig', 1),
      ('1 år', 'Langsiktig', 1),
      ('1 måned', 'Kortsiktig', 0),
      ('5 måneder', 'Langsiktig', 1),
      ('2 måneder', 'Langsiktig', 1),
      ('6 måneder', 'Langsiktig', 1),
      ('1 år', 'Langsiktig', 1),
      ('1 måned', 'Kortsiktig', 0),
      ('4 måneder', 'Langsiktig', 1),
      ('1 måned', 'Kortsiktig', 0),
      ('2 måneder', 'Langsiktig', 1),
      ('1 uke', 'Kortsiktig', 0),
      ('4 måneder', 'Langsiktig', 1),
      ('4 måneder', 'Langsiktig', 1),
      ('4 måneder', 'Langsiktig', 1),
      ('6 måneder', 'Langsiktig', 1),
      ('4 måneder', 'Langsiktig', 1),
      ('3 måneder', 'Langsiktig', 1),
      ('13 dager', 'Kortsiktig', 0),
      ('15 dager', 'Kortsiktig', 0),
      ('13 dager', 'Kortsiktig', 0),
      ('14 dager', 'Kortsiktig', 0);

INSERT INTO kostnad(kostnad, med_uten_K, type_K)
VALUES('', 'Med kostnad', 1),
      ('', 'Med kostnad', 1),
      (0, 'Uten kostnad', 0),
      ('', 'Med kostnad', 1),
      (0, 'Uten kostnad', 0),
      (0, 'Uten kostnad', 0),
      (10000, 'Med kostnad', 1),
      (5000, 'Med kostnad', 1),
      (50000, 'Med kostnad', 1),
      (1100, 'Med kostnad', 1),
      ('', 'Med kostnad', 1),
      (200, 'Med kostnad', 1),
      (500, 'Med kostnad', 1),
      (200, 'Med kostnad', 1),
      (0, 'Uten kostnad', 0),
      (300000, 'Med kostnad', 1),
      (0, 'Uten kostnad', 0),
      ('', 'Med kostnad', 1),
      ('150000', 'Med kostnad', 1),
      ('', 'Med kostnad', 1),
      ('', 'Med kostnad', 1),
      ('', 'Med kostnad', 1),
      ('', 'Uten kostnad', 0),
      ('', 'Uten kostnad', 0),
      ('0', 'Uten kostnad', 0),
      ('0', 'Uten kostnad', 0),
      ('0', 'Uten kostnad', 0);

INSERT INTO fremdrift(status_id, forslag_id, fremgang, aktiv_ikke_aktiv, type_aktiv, prosentvis_fullført, tildelt_team)
VALUES(1, 1, 'Diskuteres', 'Aktiv', '1', '0', '4'),
      (2, 2, 'Under arbeid', 'Aktiv', '1', '50', '4'),
      (3, 3, 'Ikke startet', 'Ikke aktiv', '0', '0', '4'),
      (4, 4, 'Diskuteres', 'Aktiv', '1', '0', '2'),
      (5, 5, 'Fullført', 'Ikke aktiv', '0', '100', '2'),
      (6, 6, 'Under arbeid', 'Aktiv', '1', '25', '2'),
      (7, 7, 'Avslått', 'Ikke aktiv', '0', '100', '20'),
      (8, 8, 'Under arbeid', 'Aktiv', '1', '75', '20'),
      (9, 9, 'Diskuteres', 'Aktiv', '1', '0', '20'),
      (10, 10, 'Diskuteres', 'Aktiv', '1', '0', '5'),
      (11, 11, 'Diskuteres', 'Aktiv', '1', '0', '5'),
      (12, 12, 'Fullført', 'Ikke aktiv', '0', '100', '5'),
      (13, 13, 'Venter deler', 'Aktiv', '1', '25', '9'),
      (14, 14, 'Ikke startet', 'Ikke aktiv', '0', '0', '9'),
      (15, 15, 'Under arbeid', 'Aktiv', '1', '50', '9'),
      (16, 16, 'Avslått', 'Ikke aktiv', '0', '0', '7'),
      (17, 17, 'Under arbeid', 'Aktiv', '1', '25', '7'),
      (18, 18, 'Diskuteres', 'Aktiv', '1', '0', '7'),
      (19, 19, 'Under arbeid', 'Aktiv', '1', '0', '4'),
      (20, 20, 'Diskuteres', 'Aktiv', '1', '0', '20'),
      (21, 21, 'Diskuteres', 'Aktiv', '1', '0', '7'),
      (22, 22, 'Diskuteres', 'Aktiv', '1', '0', '7'),
      (23, 23, 'Bestilt ny', 'Aktiv', '1', '25', '4'),
      (24, 24, 'Endret/fullført', 'Ikke aktiv', '0', '100', '20'),
      (25, 25, 'Under arbeid', 'Aktiv', '1', '25', '7'),
      (26, 26, 'Under arbeid', 'Aktiv', '1', '0', '4'),
      (27, 27, 'Under arbeid', 'Aktiv', '1', '0', '7');

INSERT INTO status_f(status_id, fremdrift_id)
VALUES(1, 1),
      (2, 2),
      (3, 3),
      (4, 4),
      (5, 5),
      (6, 6),
      (7, 7),
      (8, 8),
      (9, 9),
      (10, 10),
      (11, 11),
      (12, 12),
      (13, 13),
      (14, 14),
      (15, 15),
      (16, 16),
      (17, 17),
      (18, 18),
      (19, 19),
      (20, 20),
      (21, 21),
      (22, 22),
      (23, 23),
      (24, 24),
      (25, 25),
      (26, 26),
      (27, 27);



INSERT INTO forslag(ansatt_id, tittel, nyttforslag, årsak, mål, løsning, dato_registrert, frist, bilde, tperiode_id, kostnad_id, navn_id, ansvarlig, teams_id, gkjenning_id, status_id)
VALUES('1', 'Maskin', 'Maskin ødelagt', 'Elion brukte den feil', 'Fikse maskinen', 'Smøres', '2022-11-03', '2022-12-03', '', '1', '1', '1', '', '1', '1', '1'),
      ('2', 'Pc', 'Se gjennom maskin', 'Pc er ødelagt', 'Få start på pc', 'Bytte pc/endre deler', '2022-11-04', '2023-01-01', '', '2', '2', '2', '', '2', '2', '2'),
      ('3', 'Dårlig stemning', 'Møte', 'Forvirring over hvem som skal gjøre hva', 'Oppklaring mellom ansatte', 'Ha et møte med ansatte, teambuilding kan være et forlag', '2022-11-05', '2022-11-30', '', '3', '3', '3', '', '3', '3', '3'),
      ('5', 'Forslagapp', 'Grad på hvor viktig forslag', 'Ønsker å ha en form for rangering på de ulike forslagene. Når det blir sendt inn forslag så er det noen forslag som er viktigere enn andre. Ønsker derfor å kunne ha en side på nytt forslag som du kan gi en skala fra 1-10 hvor viktig forslaget er.', 'Gi forslag rangeringer på applikasjonen.', 'Legge til en ny funskjon i nytt forslag handlingen, hvor brukeren kan gi en skala fra 1-10 hvor viktig forslaget.', '2022-11-03', '2022-11-10', '', '4', '4', '5', 'Abdullah', '4', '4', '4'),
      ('6', 'Aktiviteter', 'Aktiviteter arrangert av jobben', 'Jeg føler at de ansatte som jobber sammen ikk er så godt kjent med hverandre. Det kan være ulike årsaker til det og føler ikke den blir bedre med de travle dagene på jobb. Kjemien kunne vært bedre når det kommer til samarbeid.', 'Starte med aktiviteter som innebærer samarbeid mellom teams.', 'Ha ulike teambuilding arrangementer.Kan skje på fritiden hvor jobben arrangerer aktiviteter som: Jobbfester, Teambuilding, seminarer, og Escape room osv.', '2022-11-12', '2022-12-12', '', '5', '5', '6', '', '5', '5', '5'),
      ('7', 'Mangel på folk', 'Flere medlemmer på team 2', 'På 2 team sliter vi med å fordele arbeid på grunn som vi er for få.', 'Skaffe flere teammedlemmer', 'Legge over ansatte fra andre team som er overbemannet', '2022-06-11', '2022-10-12', '', '6', '6', '7', '', '6', '6', '6'),
      ('9', 'Rengjøring', 'Få ny vaskemaskin', 'Ardian kan ikke vaske ', 'Vaske bedre', 'Ny maskin', '2022-11-11', '2023-11-11', '', '7', '7', '9', '', '7', '7', '7'),
      ('10', 'Kantina', 'Ny ovn', 'Varmer ikke opp maten', 'Ny ovn', 'Kjøpe ny ovn', '2022-10-23', '2023-01-01', '', '8', '8', '10', '', '8', '8', '8'),
      ('11', 'Toallettet', 'Nytt toallett', 'Tett do 4 ganger i uka ', 'Ny toallett', 'Ny rørsystem', '2022-10-02', '2023-03-02', '', '9', '9', '11', '', '9', '9', '9'),
      ('13', 'Parkering', 'Ny parkeringsplass?', 'For lite plass', 'Kunne parkere ', 'Oppdatere parkering', '2022-11-01', '2023-01-01', '', '10', '10', '13', '', '10', '10', '10'),
      ('14', 'Kantina', 'Glutenfri mat', 'For lite utvalg av glutenfri mat', 'Mer mat i kantine', 'Endre kantinemeny', '2022-10-02', '2023-04-02', '', '11', '11', '14', '', '11', '11', '11'),
      ('15', 'Feiekost', 'Ny feiekost', 'Feiekost er ødelagt, trenger ny', 'Kunne feie', 'Kjøpe ny feiekost', '2022-05-16', '2023-05-16', '', '12', '12', '15', '', '12', '12', '12'),
      ('17', 'Søppeldunk', 'Ny lokk', 'Ødelagt', 'Lukke søppeldunken', 'Ny lokk', '2022-10-10', '2022-11-11', '', '13', '13', '17', 'OlavMagnus', '13', '13', '13'),
      ('18', 'Handicappparkering', 'Parkering for Funksjonshemmede', 'Ingen parkering for funksjonshemmede', 'Gjøre det lettere for funksjonshemmede', 'Merke noen av parkeringsplassene med Handicapskilt', '2022-08-09', '2022-12-15', '', '14', '14', '18', 'Abdallah', '14', '14', '14'),
      ('19', 'Hoveddøra', 'Lager mye lyd ved åpning', 'Lenge siden den er smørt', 'Bli kvitt knirkelyder', 'Smøre døra med olje', '2022-11-03', '2022-12-03', '', '15', '15', '19', 'Nadia', '15', '15', '15'),
      ('21', 'Elbil', 'Lurt å ha en elbil for kundebesøk slik at vi kan lettere nå kundene våre i nærområdet uten å måtte sykle.', 'Drit lei av å sykle for jobb.', 'Overbevise ledelsen om at El-bil er lurt', 'Kjøpe ny El-bil', '2022-10-03', '2022-01-01', '', '16', '16', '21', '', '16', '16', '16'),
      ('22', 'Søppelcontainer', 'Flytte søppelcontaineren til bak bygget slik at  innkjøring til lageret får mer plass for lastebiler og andre kunder som skal til  hentelageret.', 'Plassering av containeren er på feil sted der den stenger innkjørselen til lageret og kunder sliter med å kjøre til lageret.', 'Flytte containeren.', 'Bestille bil som kan flytte Containeren eller få de til å plassere container vedneste henting.', '2022-11-03', '2022-11-10', '', '17', '17', '22', '', '17', '17', '17'),
      ('23', 'Mikro', 'Kjøpe ny og bedre mikro', 'Mikro på kjøkkenet har eksplodert', 'Erstatte med ny og større mikro.', 'Kjøpe en bedre og større mikro siden denne er for liten, pluss kanskje kjøpe 2 stk da det er mange som venter i kø.', '2022-10-31', '2023-02-01', '', '18', '18', '23', '', '18', '18', '18'),
      ('1', 'Rør', 'Oppgradere rør', 'For gamle rør i bygg 2 som lekker og repareres kontinuerlig.', 'Snakke med et firma om det pris og tidsbruk.', 'Skifte rør, oppgradere og tørke slik at fuktskaden i bygg 2 forsvinner.', '2022-11-07', '2023-02-07', '', '19', '19', '1', 'Ardian', '19', '19', '19'),
      ('9', 'Parkeringsplass', 'Forstørre parkeringsplassene bak bygget.', 'For trange p-plasser bak bygget. Får nesten ikke parkert eller gått ut av bilen når man parkerer.', 'Utvide p-plassene', 'Finne ut hvilket firma som kan forstørre p-plassene.', '2022-09-12', '2023-01-12', '', '20', '20', '9', 'Elion', '20', '20', '20'),
      ('21', 'Taket', 'Forhøye taket', 'For lite truck høyde, trangt i høyden', 'Snakke med et firma om det er mulig.', 'Tømme lager nr. 1 hvis forhøying er mulig.', '2022-11-08', '2023-04-08', '', '21', '21', '21', 'Safi', '21', '21', '21'),
      ('21', 'Parkeringsplass', 'Tydeligere merking', 'Usynlig merking på p-plasser', 'Remerke p-plassene på hele området', 'Snakke med samme firma som utvider p-plassene om de kan remerke alle plassene.', '2022-09-12', '2023-01-12', '', '22', '22', '21', 'Elion', '22', '22', '22'),
      ('1', 'Kopimaskin', 'Flytte kopimaskin ut fra kontoret', 'Andre må gå langt for å kopiere.', 'Gi alle lettere tilgang på kopimaskinen.', 'Enten flytte kopimaskinen ut fra kontoret slik at den er lett tilgjengelig for alle eller kjøpe en til for resten av bygget som kan plasseres i kantina.', '2022-10-06', '2023-01-01', '', '23', '23', '1', '', '23', '23', '23'),
      ('9', 'Jente toalett', 'Gjøre om 1 av 2 toalettene i bygg A til jente toalett.', 'Jentene mangler toalett, men gutter har 2 stk i bygg A.', 'Fikse toalett for damene.', 'Bestille og endre skilt på døren til Jenter.', '2022-11-02', '2022-11-15', '', '24', '24', '9', 'Safi', '24', '24', '24'),
      ('21', 'Kaffemaskin', 'Flytting av kaffemaskin.', 'Mindre effektivitet da alle må gå helt opp til andre for kontinuerlig henting av kaffe.', 'Bedre effektivitet, mindre sløsing av tid. Bedre å flytte maskinen en etasje ned.', 'Sette opp et bord ved trappa og flytte kaffemaskinen ned til gangen.', '2022-11-15', '2022-11-30', '', '25', '25', '21', 'Safi', '7', '25', '25'),
      ('1', 'Oppvask', 'Daglig rutine for å sette på oppvaskmaskinen på kjøkkenet.', 'Lage en bedre rutine for å starte oppvaskmaskin før man reiser hjem.', 'Ha nyvasket bestikk/tallerken klar for dagen etter.', 'Peke ut en i hver senskift som setter på oppvaskmaskinen før personen drar hjem for dagen.', '2022-11-18', '2022-11-30', '', '26', '26', '1', 'Shlirim', '4', '26', '26'),
      ('21', 'Kjøleskap', 'Rydde kjøleskap for gammel mat.', 'Gammel mat blir gjenværende for lenge i kjøleskapet.', 'Ikke la gammel mat ligge for lenge i kjøleskapet.', 'Bedre rutine. Utpeke en hver uke som renser kjøleskapet for gammel mat hver fredag før endt dag.', '2022-11-17', '2022-11-30', '', '27', '27', '21', 'Christoffer', '7', '27', '27');






