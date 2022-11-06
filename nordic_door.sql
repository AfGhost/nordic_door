
USE nordic_door;

CREATE OR REPLACE TABLE navn (
navn_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT NULL,
fornavn VARCHAR(30) NOT NULL,
mellomnavn VARCHAR(30) NULL,
etternavn VARCHAR(30) NOT NULL,
brukernavn VARCHAR(50) NOT NULL
);

CREATE OR REPLACE TABLE teams (
teams_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT NULL,
team VARCHAR(20) NOT NULL
);

CREATE OR REPLACE TABLE roller (
roller_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT NULL,
rolle VARCHAR(20) NOT NULL,
grad INT NOT NULL
);

CREATE OR REPLACE TABLE t_medlemmer (
t_medlemmer_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT NULL,
navn_id SMALLINT NULL,
teams_id SMALLINT NULL,
CONSTRAINT tm_navn_FK FOREIGN KEY (navn_id) REFERENCES navn(navn_id),
CONSTRAINT tm_teams_FK FOREIGN KEY (teams_id) REFERENCES teams(teams_id)
);

CREATE OR REPLACE TABLE ansatt (
ansatt_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
epost VARCHAR(50) NULL,
passord VARCHAR(50) NOT NULL,
navn_id SMALLINT NULL,
teams_id SMALLINT NULL,
roller_id SMALLINT NULL,
t_medlemmer_id SMALLINT NULL,
CONSTRAINT navn_ansatt_FK FOREIGN KEY (navn_id) REFERENCES navn(navn_id),
CONSTRAINT teams_ansatt_FK FOREIGN KEY (teams_id) REFERENCES teams(teams_id),
CONSTRAINT grad_ansatt_FK FOREIGN KEY (roller_id) REFERENCES roller(roller_id),
CONSTRAINT tm_ansatt_FK FOREIGN KEY (t_medlemmer_id) REFERENCES t_medlemmer(t_medlemmer_id)
);

CREATE TABLE rapporter_problem (
rproblem_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT NULL,
problem_tittel VARCHAR(100) NOT NULL,
problem_tekst VARCHAR(1000) NOT NULL,
CONSTRAINT ansatt_rp_FK FOREIGN KEY (ansatt_id) REFERENCES ansatt(ansatt_id)
);

CREATE OR REPLACE TABLE godkjenning (
gkjenning_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT NULL,
forslag_id SMALLINT NULL,
gkjent_ikke_gkjent VARCHAR(50) NULL,
type_godkjenning SMALLINT NULL,
CONSTRAINT ansatt_gkjenning_FK FOREIGN KEY (ansatt_id) REFERENCES ansatt(ansatt_id)
);

CREATE OR REPLACE TABLE tidsperiode (
tperiode_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
forslag_id SMALLINT NULL,
varighet VARCHAR(30) NULL,
tperiode VARCHAR(30) NULL,
type_tid SMALLINT NULL
);

CREATE OR REPLACE TABLE kostnad (
kostnad_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
forslag_id SMALLINT NULL,
kostnad VARCHAR(70) NULL,
med_uten_K VARCHAR(30) NULL,
type_K SMALLINT NULL
);

CREATE OR REPLACE TABLE fremdrift (
fremdrift_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
status_id SMALLINT NULL,
forslag_id SMALLINT NULL,
fremgang VARCHAR(100) NOT NULL,
prosentvis_fullført DECIMAL NULL
);

CREATE OR REPLACE TABLE status_f (
status_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
forslag_id SMALLINT NULL,
fremdrift_id SMALLINT NULL,
CONSTRAINT status_fremdrift_FK FOREIGN KEY (fremdrift_id) REFERENCES fremdrift(fremdrift_id)
);

CREATE OR REPLACE TABLE forslag (
forslag_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT NULL,
tittel VARCHAR(100) NOT NULL,
forslag VARCHAR (1000) NULL,
årsak VARCHAR(500) NULL,
mål VARCHAR(500) NULL,
løsning VARCHAR(1000) NULL,
dato_registrert DATETIME NOT NULL,
frist DATETIME NULL,
bilde LONGBLOB NULL,
tperiode_id SMALLINT NULL,
kostnad_id SMALLINT NULL,
ansvarlig_id SMALLINT NULL,
teams_id SMALLINT NULL,
gkjenning_id SMALLINT NULL,
status_id SMALLINT NULL,
CONSTRAINT tperiode_forslag_FK FOREIGN KEY (tperiode_id) REFERENCES tidsperiode(tperiode_id),
CONSTRAINT kostnad_forslag_FK FOREIGN KEY (kostnad_id) REFERENCES kostnad(kostnad_id),
CONSTRAINT ansatt_forslag_FK FOREIGN KEY (ansatt_id) REFERENCES ansatt(ansatt_id),
CONSTRAINT ansvarlig_forslag_FK FOREIGN KEY (ansvarlig_id) REFERENCES ansatt(ansatt_id),
CONSTRAINT teams_forslag_FK FOREIGN KEY (teams_id) REFERENCES teams(teams_id),
CONSTRAINT gkjenning_forslag_FK FOREIGN KEY (gkjenning_id) REFERENCES godkjenning(gkjenning_id),
CONSTRAINT status_forslag_FK FOREIGN KEY (status_id) REFERENCES status_f(status_id)
);


INSERT INTO navn (ansatt_id, fornavn, mellomnavn, etternavn, brukernavn)
VALUES (1, 'Ardian', 'Abc', 'Gorgaj', 'argo1'),
       (2, 'Janis', 'G', 'Gailis', 'jaga2'),
       (3, 'Ola', 'N', 'Nordmann', 'olno3'),
       (4, 'Manis', 'V', 'Katis', 'maka4'),
       (5, 'Christoffer', 'B', 'Buvik', 'chbu5'),
       (6, 'Anders', 'Nilsen', 'Bærum', 'anbæ6'),
       (7, 'Abdullah', '', 'Kadir', 'abka7'),
       (8, 'Fana', '', 'Hansa', 'faha8'),
       (9, 'Elion', '', 'Muriqi', 'elmo9'),
       (10, 'Albert ', 'Jenns', 'Bjarne', 'albj10'),
       (11, 'Rollf', 'Arne', 'Henriksen', 'rohen11'),
       (12, 'Rona', '', 'Fjert', 'rofj12'),
       (13, 'Shlirim', 'Chelsea', 'Balaj', 'shba13'),
       (14, 'Mona', 'Rita', 'Danielsen', 'moda14'),
       (15, 'Ole', 'Kristian', 'Hansen', 'olha15'),
       (16, 'Maria', 'K', 'Krim', 'makr16'),
       (17, 'Abdallah', 'Def', 'Bakir', 'abba17'),
       (18, 'OlavMagnus', 'Oliver', 'Jensen', 'olje18'),
       (19, 'Nadia', 'Jamal', 'Mahmood', 'nama19'),
       (20, 'Shima', 'S', 'Johnsen', 'shjo20'),
       (21, 'Morchal', 'Afghan', 'Safi', 'mosa21'),
       (22, 'Vasi', 'Lin', 'Milan', 'vami22'),
       (23, 'Maria', 'Bru', 'Hochnovska', 'maho23'),
       (24, 'Sarah', 'S', 'Sara', 'sasa24');

INSERT INTO teams(ansatt_id, team)
VALUES(1, 4),
      (2, 4),
      (3, 4),
      (4, 4),
      (5, 2),
      (6, 2),
      (7, 2),
      (8, 2),
      (9, 20),
      (10, 20),
      (11, 20),
      (12, 20),
      (13, 5),
      (14, 5),
      (15, 5),
      (16, 5),
      (17, 9),
      (18, 9),
      (19, 9),
      (20, 9),
      (21, 7),
      (22, 7),
      (23, 7),
      (24, 7);

INSERT INTO roller(ansatt_id, rolle, grad)
VALUES('1', 'Bruker', '3'),
      ('2', 'Administrator', '1'),
      ('3', 'Teamleder', '2'),
      ('4', 'Bruker', '3'),
      ('5', 'Teamleder', '2'),
      ('6', 'Bruker', '3'),
      ('7', 'Administrator', '1'),
      ('8', 'Bruker', '3'),
      ('9', 'Administrator', '1'),
      ('10', 'Bruker', '3'),
      ('11', 'Teamleder', '2'),
      ('12', 'Bruker', '3'),
      ('13', 'Administrator', '1'),
      ('14', 'Bruker', '3'),
      ('15', 'Teamleder', '2'),
      ('16', 'Bruker', '3'),
      ('17', 'Teamleder', '2'),
      ('18', 'Bruker', '3'),
      ('19', 'Administrator', '1'),
      ('20', 'Bruker', '3'),
      ('21', 'Administrator', '3'),
      ('22', 'Teamleder', '2'),
      ('23', 'Bruker', '3'),
      ('24', 'Bruker', '3');

INSERT INTO t_medlemmer(ansatt_id, navn_id, teams_id)
VALUES('1', '1', '1'),
      ('2', '2', '2'),
      ('3', '3', '3'),
      ('4', '4', '4'),
      ('5', '5', '5'),
      ('6', '6', '6'),
      ('7', '7', '7'),
      ('8', '8', '8'),
      ('9', '9', '9'),
      ('10', '10', '10'),
      ('11', '11', '11'),
      ('12', '12', '12'),
      ('13', '13', '13'),
      ('14', '14', '14'),
      ('15', '15', '15'),
      ('16', '16', '16'),
      ('17', '17', '17'),
      ('18', '18', '18'),
      ('19', '19', '19'),
      ('20', '20', '20'),
      ('21', '21', '21'),
      ('22', '22', '22'),
      ('23', '23', '23'),
      ('24', '24', '24');

INSERT INTO ansatt(ansatt_id, epost, passord, navn_id, teams_id, roller_id, t_medlemmer_id)
VALUES('1', 'ag@gmail.com', 'Testing1234', 1, 1, 3, 1),
      ('2', 'olanordman@yahoo.com', 'JG12345', 2, 2, 1, 2),
      ('3', 'olanordman@yahoo.com', 'Ola54321', 3, 3, 2, 3),
      ('4', 'manis@gmail.com', 'Manka5234', 4, 4, 3, 4),
      ('5', 'buvikchristoffer@gmail.com', 'Ronaldo7', 5, 5, 2, 5),
      ('6', 'andersnb@gmail.com', 'Tacokveld124', 6, 6, 3, 6),
      ('7', 'abdigang@gmail.com', 'Marinertepølser', 7, 7, 1, 7),
      ('8', 'fana@gmail.com', 'Hansafa8923', 8, 8, 3, 8),
      ('9', 'muriqielion@gmail.com', 'Test1234', 9, 9, 1, 9),
      ('10', 'rolff@gmail.com', 'Anti12', 10, 10, 3, 10),
      ('11', 'arne@gmail.com', 'Rolff123', 11, 11, 2, 11),
      ('12', 'rona@gmail.com', 'Rof1212', 12, 12, 3, 12),
      ('13', 'shlirim.balaj@gmail.com', 'Abc123', 13, 13, 1, 13),
      ('14', 'mona66@hotmail.no', 'Lfc123', 14, 14, 3, 14),
      ('15', 'ok.hansen@outlook.no', 'Kattepus22', 15, 15, 2, 15),
      ('16', 'maria@gmail.com', 'Fjott56', 16, 16, 3, 16),
      ('17', 'abdallahbakir02@gmail.com', 'Testingtesting1234', 17, 17, 2, 17),
      ('18', 'olaJensen@gmail.com', 'Norge123', 18, 18, 3, 18),
      ('19', 'nadiaMahmood@gmail.com', 'NadiaM', 19, 19, 1, 19),
      ('20', 'shima@gmail.com', 'Shi45', 20, 20, 3, 20),
      ('21', 'stemi@gmail.com', 'Mo1616', 21, 21, 1, 21),
      ('22', 'vasi@gmail.com', 'Vam1717', 22, 22, 2, 22),
      ('23', 'maria@gmail.com', 'Hoch1818', '23', '23', '3', 23),
      ('24', 'sarsa@gmail.com', 'Sasa0193', 24, 24, 3, 24);

INSERT INTO rapporter_problem(ansatt_id, problem_tittel, problem_tekst)
VALUES(4, 'Lagre knapp', 'Får ikke lagret forslaget på nettsiden da lagre knappen dukker ikke opp.'),
      (6, 'Innlogging', 'Problemer med innlogging av min bruker.'),
      (11, 'Scrolling', 'Får ikke scrollet nedover på siden, da siden hopper tilbake til toppen igjen.'),
      (18, 'Passord', 'Passordet mitt fungerer ikke igjen, selv om jeg fikk nytt passord i går og den ble testet.');

INSERT INTO godkjenning(ansatt_id, forslag_id, gkjent_ikke_gkjent, type_godkjenning)
VALUES(1, 1, 'Vurderes', 2),
      (2, 2, 'Godkjent', 1),
      (3, 3, 'Godkjent', 1),
      (5, 4, 'Vurderes', 2),
      (6, 5, 'Godkjent', 1),
      (7, 6, 'Godkjent', 1),
      (9, 7, 'Ikke godkjent', 0),
      (10, 8, 'Godkjent', 1),
      (11, 9, 'Vurderes', 2),
      (13, 10, 'Vurderes', 2),
      (14, 11, 'Vurderes', 2),
      (15, 12, 'Godkjent', 1),
      (17, 13, 'Godkjent', 1),
      (18, 14, 'Godkjent', 1),
      (19, 15, 'Godkjent', 1),
      (21, 16, 'Ikke godkjent', 0),
      (22, 17, 'Godkjent', 1),
      (23, 18, 'Vurderes', 2);

INSERT INTO tidsperiode(forslag_id, varighet, tperiode, type_tid)
VALUES(1, '1 måned', 'Kortsiktig', 0),
      (2, '2 måneder', 'Langsiktig', 1),
      (3, '1 måned', 'Kortsiktig', 0),
      (4, '1 uke', 'Kortsiktig', 0),
      (5, '1 dag', 'Kortsiktig', 0),
      (6, '4 måneder', 'Langsiktig', 1),
      (7, '1 år', 'Langsiktig', 1),
      (8, '1 måned', 'Kortsiktig', 0),
      (9, '5 måneder', 'Langsiktig', 1),
      (10, '2 måneder', 'Langsiktig', 1),
      (11, '6 måneder', 'Langsiktig', 1),
      (12, '1 år', 'Langsiktig', 1),
      (13, '1 måned', 'Kortsiktig', 0),
      (14, '4 måneder', 'Langsiktig', 1),
      (15, '1 måned', 'Kortsiktig', 0),
      (16, '2 måneder', 'Langsiktig', 1),
      (17, '1 uke', 'Kortsiktig', 0),
      (18, '4 måneder', 'Langsiktig', 1);

INSERT INTO kostnad(forslag_id, kostnad, med_uten_K, type_K)
VALUES(1, '', 'Med kostnad', 1),
      (2, '', 'Med kostnad', 1),
      (3, 0, 'Uten kostnad', 0),
      (4, '', 'Med kostnad', 1),
      (5, 0, 'Uten kostnad', 0),
      (6, 0, 'Uten kostnad', 0),
      (7, 10000, 'Med kostnad', 1),
      (8, 5000, 'Med kostnad', 1),
      (9, 50000, 'Med kostnad', 1),
      (10, 1100, 'Med kostnad', 1),
      (11, '', 'Med kostnad', 1),
      (12, 200, 'Med kostnad', 1),
      (13, 500, 'Med kostnad', 1),
      (14, 200, 'Med kostnad', 1),
      (15, 0, 'Uten kostnad', 0),
      (16, 300000, 'Med kostnad', 1),
      (17, 0, 'Uten kostnad', 0),
      (18, '', 'Med kostnad', 1);

INSERT INTO fremdrift(status_id, forslag_id, fremgang, prosentvis_fullført)
VALUES(1, 1, 'Diskuteres', '0'),
      (2, 2, 'Under arbeid', '50'),
      (3, 3, 'Ikke startet', '0'),
      (4, 4, 'Diskuteres', '0'),
      (5, 5, 'Fullført', '100'),
      (6, 6, 'Under arbeid', '25'),
      (7, 7, 'Avslått', '100'),
      (8, 8, 'Under arbeid', '75'),
      (9, 9, 'Diskuteres', '0'),
      (10, 10, 'Diskuteres', '0'),
      (11, 11, 'Diskuteres', '0'),
      (12, 12, 'Fullført', '100'),
      (13, 13, 'Venter deler', '25'),
      (14, 14, 'Ikke startet', '0'),
      (15, 15, 'Under arbeid', '50'),
      (16, 16, 'Avslått', '0'),
      (17, 17, 'Under arbeid', '25'),
      (18, 18, 'Diskuteres', '0');

INSERT INTO status_f(status_id, forslag_id, fremdrift_id)
VALUES(1, 1, 1),
      (2, 2, 2),
      (3, 3, 3),
      (4, 4, 4),
      (5, 5, 5),
      (6, 6, 6),
      (7, 7, 7),
      (8, 8, 8),
      (9, 9, 9),
      (10, 10, 10),
      (11, 11, 11),
      (12, 12, 12),
      (13, 13, 13),
      (14, 14, 14),
      (15, 15, 15),
      (16, 16, 16),
      (17, 17, 17),
      (18, 18, 18);



INSERT INTO forslag(ansatt_id, tittel, forslag, årsak, mål, løsning, dato_registrert, frist, bilde, tperiode_id, kostnad_id, ansvarlig_id, teams_id, gkjenning_id, status_id)
VALUES('1', 'Maskin', 'Maskin ødelagt', 'Elion brukte den feil', 'Fikse maskinen', 'Smøres', '2022-11-03', '2022-12-03', '', '1', '1', NULL, '1', '1', '1'),
      ('2', 'Pc', 'Se gjennom maskin', 'Pc er ødelagt', 'Få start på pc', 'Bytte pc/endre deler', '2022-11-04', '2023-01-01', '', '2', '2', NULL, '2', '2', '2'),
      ('3', 'Dårlig stemning', 'Møte', 'Forvirring over hvem som skal gjøre hva', 'Oppklaring mellom ansatte', 'Ha et møte med ansatte, teambuilding kan være et forlag', '2022-11-05', '2022-11-30', '', '3', '3', NULL, '3', '3', '3'),
      ('5', 'Forslagapp', 'Grad på hvor viktig forslag', 'Ønsker å ha en form for rangering på de ulike forslagene. Når det blir sendt inn forslag så er det noen forslag som er viktigere enn andre. Ønsker derfor å kunne ha en side på nytt forslag som du kan gi en skala fra 1-10 hvor viktig forslaget er.', 'Gi forslag rangeringer på applikasjonen.', 'Legge til en ny funskjon i nytt forslag handlingen, hvor brukeren kan gi en skala fra 1-10 hvor viktig forslaget.', '2022-11-03', '2022-11-10', '', '4', '4', '7', '4', '4', '4'),
      ('6', 'Aktiviteter', 'Aktiviteter arrangert av jobben', 'Jeg føler at de ansatte som jobber sammen ikk er så godt kjent med hverandre. Det kan være ulike årsaker til det og føler ikke den blir bedre med de travle dagene på jobb. Kjemien kunne vært bedre når det kommer til samarbeid.', 'Starte med aktiviteter som innebærer samarbeid mellom teams.', 'Ha ulike teambuilding arrangementer.Kan skje på fritiden hvor jobben arrangerer aktiviteter som: Jobbfester, Teambuilding, seminarer, og Escape room osv.', '2022-11-12', '2022-12-12', '', '5', '5', NULL, '5', '5', '5'),
      ('7', 'Mangel på folk', 'Flere medlemmer på team 2', 'På 2 team sliter vi med å fordele arbeid på grunn som vi er for få.', 'Skaffe flere teammedlemmer', 'Legge over ansatte fra andre team som er overbemannet', '2022-06-11', '2022-10-12', '', '6', '6', NULL, '6', '6', '6'),
      ('9', 'Rengjøring', 'Få ny vaskemaskin', 'Ardian kan ikke vaske ', 'Vaske bedre', 'Ny maskin', '2022-11-11', '2023-11-11', '', '7', '7', NULL, '7', '7', '7'),
      ('10', 'Kantina', 'Ny ovn', 'Varmer ikke opp maten', 'Ny ovn', 'Kjøpe ny ovn', '2022-10-23', '2023-01-01', '', '8', '8', NULL, '8', '8', '8'),
      ('11', 'Toallettet', 'Nytt toallett', 'Tett do 4 ganger i uka ', 'Ny toallett', 'Ny rørsystem', '2022-10-02', '2023-03-02', '', '9', '9', NULL, '9', '9', '9'),
      ('13', 'Parkering', 'Ny parkeringsplass?', 'For lite plass', 'Kunne parkere ', 'Oppdatere parkering', '2022-11-01', '2023-01-01', '', '10', '10', NULL, '10', '10', '10'),
      ('14', 'Kantina', 'Glutenfri mat', 'For lite utvalg av glutenfri mat', 'Mer mat i kantine', 'Endre kantinemeny', '2022-10-02', '2023-04-02', '', '11', '11', NULL, '11', '11', '11'),
      ('15', 'Feiekost', 'Ny feiekost', 'Feiekost er ødelagt, trenger ny', 'Kunne feie', 'Kjøpe ny feiekost', '2022-05-16', '2023-05-16', '', '12', '12', NULL, '12', '12', '12'),
      ('17', 'Søppeldunk', 'Ny lokk', 'Ødelagt', 'Lukke søppeldunken', 'Ny lokk', '2022-10-10', '2022-11-11', '', '13', '13', '18', '13', '13', '13'),
      ('18', 'Handicappparkering', 'Parkering for Funksjonshemmede', 'Ingen parkering for funksjonshemmede', 'Gjøre det lettere for funksjonshemmede', 'Merke noen av parkeringsplassene med Handicapskilt', '2022-08-09', '2022-12-15', '', '14', '14', '17', '14', '14', '14'),
      ('19', 'Hoveddøra', 'Lager mye lyd ved åpning', 'Lenge siden den er smørt', 'Bli kvitt knirkelyder', 'Smøre døra med olje', '2022-11-03', '2022-12-03', '', '15', '15', '19', '15', '15', '15'),
      ('21', 'Elbil', 'Lurt å ha en elbil for kundebesøk slik at vi kan lettere nå kundene våre i nærområdet uten å måtte sykle.', 'Drit lei av å sykle for jobb.', 'Overbevise ledelsen om at El-bil er lurt', 'Kjøpe ny El-bil', '2022-10-03', '2022-01-01', '', '16', '16', NULL, '16', '16', '16'),
      ('22', 'Søppelcontainer', 'Flytte søppelcontaineren til bak bygget slik at  innkjøring til lageret får mer plass for lastebiler og andre kunder som skal til  hentelageret.', 'Plassering av containeren er på feil sted der den stenger innkjørselen til lageret og kunder sliter med å kjøre til lageret.', 'Flytte containeren.', 'Bestille bil som kan flytte Containeren eller få de til å plassere container vedneste henting.', '2022-11-03', '2022-11-10', '', '17', '17', NULL, '17', '17', '17'),
      ('23', 'Mikro', 'Kjøpe ny og bedre mikro', 'Mikro på kjøkkenet har eksplodert', 'Erstatte med ny og større mikro.', 'Kjøpe en bedre og større mikro siden denne er for liten, pluss kanskje kjøpe 2 stk da det er mange som venter i kø.', '2022-10-31', '2023-02-01', '', '18', '18', NULL, '18', '18', '18');
*/



