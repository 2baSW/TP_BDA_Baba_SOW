/* Q1
SET SERVEROUTPUT ON;

DECLARE
    a NUMBER := 5;
    b NUMBER := 7;
    somme NUMBER;
BEGIN
    somme := a + b;
    dbms_output.put_line('La somme de ' || a || ' et ' || b || ' est : ' || somme);
END;
/
*/

/* Q2
SET SERVEROUTPUT ON;

DECLARE
    nombre NUMBER := 5;
    i NUMBER;
BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(nombre || ' x ' || i || ' = ' || (nombre * i));
    END LOOP;
END;
/
*/


/* Q3
SET SERVEROUTPUT ON;

DECLARE
    n NUMBER := 5; 
    i NUMBER;
    fact NUMBER := 1;
BEGIN
    FOR i IN 1..n LOOP
        fact := fact * i;
    END LOOP;
    dbms_output.put_line('La factorielle de ' || n || ' est : ' || fact);
END;
/

*/


/* Q4)
CREATE TABLE resultatFactoriel (
    valeur NUMBER,
    factorielle NUMBER
);


SET SERVEROUTPUT ON;

DECLARE
    n NUMBER := 5;
    i NUMBER;
    fact NUMBER := 1;
BEGIN
    IF n > 0 THEN
        FOR i IN 1..n LOOP
            fact := fact * i;
        END LOOP;

        INSERT INTO resultatFactoriel (valeur, factorielle)
        VALUES (n, fact);

        COMMIT;

        dbms_output.put_line('La factorielle de ' || n || ' est ' || fact || ' (stockée dans resultatFactoriel)');
    ELSE
        dbms_output.put_line('Erreur : nombre non valide (doit être strictement positif).');
    END IF;
END;
/

*/
/* Q5

CREATE TABLE emp (
    num NUMBER PRIMARY KEY,
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    age NUMBER
);

*/

SET SERVEROUTPUT ON;

DECLARE
    v_num     NUMBER := 1;         
    v_nom     VARCHAR2(50) := 'Doe';  
    v_prenom  VARCHAR2(50) := 'John';
    v_age     NUMBER := 30;   
BEGIN
    INSERT INTO emp (num, nom, prenom, age)
    VALUES (v_num, v_nom, v_prenom, v_age);

    COMMIT;

    dbms_output.put_line('Insertion réussie de : ' || v_nom || ' ' || v_prenom || ', âge ' || v_age);
END;
/

