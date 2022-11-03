
USE nordic_door;

CREATE OR REPLACE TABLE navn (
navn_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT,
fornavn VARCHAR(30) NOT NULL,
mellomnavn VARCHAR(30) NULL,
etternavn VARCHAR(30) NOT NULL
);

CREATE OR REPLACE TABLE teams (
teams_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT,
team VARCHAR(20) NOT NULL
);

CREATE OR REPLACE TABLE roller (
roller_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
ansatt_id SMALLINT,
rolle VARCHAR(20) NOT NULL,
grad INT NOT NULL
);

CREATE OR REPLACE TABLE t_medlemmer (
t_medlemmer_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
tm_ansatt_id SMALLINT,
tm_navn_id SMALLINT,
tm_teams_id SMALLINT,
CONSTRAINT tm_navn_FK FOREIGN KEY (tm_navn_id) REFERENCES navn(navn_id),
CONSTRAINT tm_teams_FK FOREIGN KEY (tm_teams_id) REFERENCES teams(teams_id)
);

CREATE TABLE rapporter_problem (
rproblem_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
rp_ansatt_id SMALLINT NULL,
problem_tittel VARCHAR(100) NOT NULL,
problem_tekst VARCHAR(1000) NOT NULL
);

CREATE OR REPLACE TABLE ansatt (
ansatt_id SMALLINT PRIMARY KEY,
epost VARCHAR(50) NULL,
passord VARCHAR(50) NOT NULL,
navn_ansatt_id SMALLINT,
teams_ansatt_id SMALLINT,
grad_ansatt_id SMALLINT,
tm_ansatt_id SMALLINT,
rp_ansatt_id SMALLINT,
CONSTRAINT navn_ansatt_FK FOREIGN KEY (navn_ansatt_id) REFERENCES navn(navn_id),
CONSTRAINT teams_ansatt_FK FOREIGN KEY (teams_ansatt_id) REFERENCES teams(teams_id),
CONSTRAINT grad_ansatt_FK FOREIGN KEY (grad_ansatt_id) REFERENCES roller(roller_id),
CONSTRAINT tm_ansatt_FK FOREIGN KEY (tm_ansatt_id) REFERENCES t_medlemmer(t_medlemmer_id),
CONSTRAINT rp_ansatt_FK FOREIGN KEY (rp_ansatt_id) REFERENCES rapporter_problem(rproblem_id)
);

CREATE OR REPLACE TABLE tidsperiode (
tperiode_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
tperiode_forslag_id SMALLINT,
varighet DATETIME NULL,
tperiode VARCHAR(30) NOT NULL,
tid INT NOT NULL
);

CREATE OR REPLACE TABLE kostnad (
kostnad_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
kostnad_forslag_id SMALLINT,
kostnad VARCHAR(70) NULL,
med_uten_K VARCHAR(30) NOT NULL,
type_K SMALLINT
);

CREATE OR REPLACE TABLE fremdrift (
fremdrift_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
status_fremdrift_id SMALLINT,
fremgang VARCHAR(100) NOT NULL,
prosentvis SMALLINT NOT NULL
);

CREATE OR REPLACE TABLE status_f (
status_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
status_forslag_id SMALLINT,
status_fremdrift_id SMALLINT,
CONSTRAINT status_fremdrift_FK FOREIGN KEY (status_fremdrift_id) REFERENCES fremdrift(fremdrift_id)
);

CREATE OR REPLACE TABLE forslag (
forslag_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
tittel VARCHAR(100) NOT NULL,
forslag VARCHAR (1000) NULL,
årsak VARCHAR(500) NULL,
mål VARCHAR(500) NULL,
løsning VARCHAR(1000) NULL,
dato_registrert DATETIME NOT NULL,
frist DATETIME NULL,
bilde LONGBLOB NULL,
tperiode_forslag_id SMALLINT,
kostnad_forslag_id SMALLINT,
ansatt_forslag_id SMALLINT,
ansvarlig_forslag_id SMALLINT,
teams_forslag_id SMALLINT,
status_forslag_id SMALLINT,
CONSTRAINT tperiode_forslag_FK FOREIGN KEY (tperiode_forslag_id) REFERENCES tidsperiode(tperiode_id),
CONSTRAINT kostnad_forslag_FK FOREIGN KEY (kostnad_forslag_id) REFERENCES kostnad(kostnad_id),
CONSTRAINT ansatt_forslag_FK FOREIGN KEY (ansatt_forslag_id) REFERENCES ansatt(ansatt_id),
CONSTRAINT ansvarlig_forslag_FK FOREIGN KEY (ansvarlig_forslag_id) REFERENCES ansatt(ansatt_id),
CONSTRAINT teams_forslag_FK FOREIGN KEY (teams_forslag_id) REFERENCES teams(teams_id),
CONSTRAINT status_forslag_FK FOREIGN KEY (status_forslag_id) REFERENCES status_f(status_id)
);

INSERT INTO roller(rolle, grad)
VALUES('Administrator', 1), ('Teamleder', 2), ('Bruker', 3);

INSERT INTO tidsperiode(tperiode, tid)
VALUES('Kortsiktig forslag', 0), ('Langsiktig forslag', 1);

INSERT INTO kostnad(med_uten_K, type_K)
VALUES('Med kostnad', 0), ('Uten kostnad', 1);






