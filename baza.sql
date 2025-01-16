PGDMP                       }            baza    17.2    17.0 �    Q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            R           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            S           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            T           1262    33730    baza    DATABASE     w   CREATE DATABASE baza WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE baza;
                     postgres    false                        2615    33731    Firmy    SCHEMA        CREATE SCHEMA "Firmy";
    DROP SCHEMA "Firmy";
                     postgres    false                        2615    33732    Klienci    SCHEMA        CREATE SCHEMA "Klienci";
    DROP SCHEMA "Klienci";
                     postgres    false                        2615    33733    Placowki    SCHEMA        CREATE SCHEMA "Placowki";
    DROP SCHEMA "Placowki";
                     postgres    false            	            2615    33734    Podwykonawcy    SCHEMA        CREATE SCHEMA "Podwykonawcy";
    DROP SCHEMA "Podwykonawcy";
                     postgres    false            
            2615    33735 
   Pracownicy    SCHEMA        CREATE SCHEMA "Pracownicy";
    DROP SCHEMA "Pracownicy";
                     postgres    false                        2615    33736 	   Samochody    SCHEMA        CREATE SCHEMA "Samochody";
    DROP SCHEMA "Samochody";
                     postgres    false                        2615    33737    Samochody_Podwykonawcy    SCHEMA     (   CREATE SCHEMA "Samochody_Podwykonawcy";
 &   DROP SCHEMA "Samochody_Podwykonawcy";
                     postgres    false                        2615    33738 
   Stanowiska    SCHEMA        CREATE SCHEMA "Stanowiska";
    DROP SCHEMA "Stanowiska";
                     postgres    false                        2615    33739 
   Zamowienia    SCHEMA        CREATE SCHEMA "Zamowienia";
    DROP SCHEMA "Zamowienia";
                     postgres    false            �            1255    33740 0   dodajfirme(character varying, character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Firmy".dodajfirme(IN p_nazwafirmy character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO firmy (nazwaFirmy, nip)
VALUES (p_nazwaFirmy, p_nip);
END;
$$;
 b   DROP PROCEDURE "Firmy".dodajfirme(IN p_nazwafirmy character varying, IN p_nip character varying);
       Firmy               postgres    false    6            �            1255    33741 D   edytujfirme(character varying, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE "Firmy".edytujfirme(IN p_nazwafirmydozmiany character varying, IN p_nazwafirmy character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE firmy
SET nazwaFirmy = p_nazwaFirmy, nip = p_nip
WHERE nazwaFirmy = p_nazwaFirmyDoZmiany;
END;
$$;
 �   DROP PROCEDURE "Firmy".edytujfirme(IN p_nazwafirmydozmiany character varying, IN p_nazwafirmy character varying, IN p_nip character varying);
       Firmy               postgres    false    6            �            1255    33742    pobierz_firmy()    FUNCTION     �   CREATE FUNCTION "Firmy".pobierz_firmy() RETURNS TABLE(nazwafirmy character varying, nip character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        f.nazwafirmy,
        f.nip
    FROM firmy f;
END;
$$;
 '   DROP FUNCTION "Firmy".pobierz_firmy();
       Firmy               postgres    false    6            �            1255    33743    usunfirme(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Firmy".usunfirme(IN p_nazwafirmy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
DELETE FROM firmy
WHERE nazwaFirmy = p_nazwaFirmy;
END;
$$;
 E   DROP PROCEDURE "Firmy".usunfirme(IN p_nazwafirmy character varying);
       Firmy               postgres    false    6            �            1255    33744 k   dodajklienta(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     y  CREATE PROCEDURE "Klienci".dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO klienci (pesel,imie,nazwisko,nip,telefon)
VALUES (p_pesel,p_imie,p_nazwisko,p_nip,p_telefon);
END;
$$;
 �   DROP PROCEDURE "Klienci".dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       Klienci               postgres    false    7            �            1255    33745    edytujklienta(character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Klienci".edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE klienci
SET pesel=p_pesel,imie=p_imie,nazwisko=p_nazwisko,telefon=p_telefon,nip=p_nip
WHERE pesel = p_peseldozmiany;
END;
$$;
 �   DROP PROCEDURE "Klienci".edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       Klienci               postgres    false    7            �            1255    33746    pobierz_klienci()    FUNCTION     e  CREATE FUNCTION "Klienci".pobierz_klienci() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, nip character, telefon character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT k.pesel, 
           k.imie, 
           k.nazwisko, 
           k.nip, 
           k.telefon
    FROM klienci k;
END;
$$;
 +   DROP FUNCTION "Klienci".pobierz_klienci();
       Klienci               postgres    false    7            �            1255    33747    usunklienta(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Klienci".usunklienta(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM klienci
	WHERE pesel = p_pesel;
END;
$$;
 D   DROP PROCEDURE "Klienci".usunklienta(IN p_pesel character varying);
       Klienci               postgres    false    7            �            1255    33748    aktualizacjaliczbyaut()    FUNCTION     �   CREATE FUNCTION "Placowki".aktualizacjaliczbyaut() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE placowki
SET iloscsamochodow = iloscsamochodow+1
WHERE id_placowki = NEW.placowkaid;
RETURN NEW;
END;
$$;
 2   DROP FUNCTION "Placowki".aktualizacjaliczbyaut();
       Placowki               postgres    false    8            �            1255    33749 &   aktualizacjaliczbymiejscapozostalego()    FUNCTION     �   CREATE FUNCTION "Placowki".aktualizacjaliczbymiejscapozostalego() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE placowki
SET iloscmiejscapozostalego = iloscmiejscapozostalego - 1
WHERE id_placowki = NEW.placowkaid;

RETURN NEW;
END;
$$;
 A   DROP FUNCTION "Placowki".aktualizacjaliczbymiejscapozostalego();
       Placowki               postgres    false    8            �            1255    33750 !   dekrementacjamiejscapozostalego()    FUNCTION     �   CREATE FUNCTION "Placowki".dekrementacjamiejscapozostalego() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE placowki
SET iloscmiejscapozostalego = iloscmiejscapozostalego + 1
WHERE id_placowki = OLD.placowkaid;
RETURN OLD;
END;
$$;
 <   DROP FUNCTION "Placowki".dekrementacjamiejscapozostalego();
       Placowki               postgres    false    8            �            1255    33751    dekremetacjaliczbyaut()    FUNCTION     �   CREATE FUNCTION "Placowki".dekremetacjaliczbyaut() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE placowki
SET iloscsamochodow = iloscsamochodow -1
WHERE id_placowki = OLD.placowkaid;
RETURN OLD;
END;
$$;
 2   DROP FUNCTION "Placowki".dekremetacjaliczbyaut();
       Placowki               postgres    false    8            �            1255    33752 E   dodajplacowke(character varying, character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE "Placowki".dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego)
    VALUES (nextval('placowki_id_seq'), p_miasto, p_ulica, p_numerbudynku, 0, p_iloscmiejscapozostalego);
END;
$$;
 �   DROP PROCEDURE "Placowki".dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer);
       Placowki               postgres    false    8                        1255    33753 b   edytujplacowke(integer, character varying, character varying, character varying, integer, integer) 	   PROCEDURE       CREATE PROCEDURE "Placowki".edytujplacowke(IN p_id_placowki integer, IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku character varying, IN p_iloscsamochodow integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE placowki
    SET miasto = p_miasto,
        ulica = p_ulica,
        numerbudynku = p_numerbudynku,
        iloscsamochodow = p_iloscsamochodow,
        iloscmiejscapozostalego = p_iloscmiejscapozostalego
    WHERE id_placowki = p_id_placowki;
END;
$$;
 �   DROP PROCEDURE "Placowki".edytujplacowke(IN p_id_placowki integer, IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku character varying, IN p_iloscsamochodow integer, IN p_iloscmiejscapozostalego integer);
       Placowki               postgres    false    8                       1255    33754    inkremetacjaLiczbyAut()    FUNCTION     �   CREATE FUNCTION "Placowki"."inkremetacjaLiczbyAut"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE placowki
SET iloscsamochodow = iloscsamochodow+1
WHERE id_placowki = NEW.placowkaid;
RETURN NEW;
END;
$$;
 4   DROP FUNCTION "Placowki"."inkremetacjaLiczbyAut"();
       Placowki               postgres    false    8                       1255    33755     inkremetacjaMiejscaPozostalego()    FUNCTION     �   CREATE FUNCTION "Placowki"."inkremetacjaMiejscaPozostalego"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE placowki
SET iloscmiejscapozostalego = iloscmiejscapozostalego - 1
WHERE id_placowki = NEW.placowkaid;

RETURN NEW;
END;
$$;
 =   DROP FUNCTION "Placowki"."inkremetacjaMiejscaPozostalego"();
       Placowki               postgres    false    8                       1255    33756    pobierz_placowki()    FUNCTION     �  CREATE FUNCTION "Placowki".pobierz_placowki() RETURNS TABLE(id_placowki integer, miasto character varying, ulica character varying, numerbudynku character varying, iloscsamochodow integer, iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT p.id_placowki, p.miasto, p.ulica, p.numerbudynku, p.iloscsamochodow, p.iloscmiejscapozostalego
    FROM placowki p;
END;
$$;
 -   DROP FUNCTION "Placowki".pobierz_placowki();
       Placowki               postgres    false    8                       1255    33757    usunplacowke(integer) 	   PROCEDURE     �   CREATE PROCEDURE "Placowki".usunplacowke(IN p_id_placowki integer)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
    DELETE FROM placowki 
	WHERE id_placowki=p_id_placowki;
END;
$$;
 B   DROP PROCEDURE "Placowki".usunplacowke(IN p_id_placowki integer);
       Placowki               postgres    false    8                       1255    33758 J   dodajpodwykonawce(character varying, character varying, character varying) 	   PROCEDURE     E  CREATE PROCEDURE "Podwykonawcy".dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO podwykonawcy (nippodwykonawcy, nazwa, specjalizacja)
VALUES (p_nippodwykonawcy, p_nazwa, p_specjalizacja); 
END;
$$;
 �   DROP PROCEDURE "Podwykonawcy".dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       Podwykonawcy               postgres    false    9                       1255    33759 ^   edytujpodwykonawce(character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Podwykonawcy".edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE podwykonawcy 
SET nippodwykonawcy = p_nippodwykonawcy, nazwa = p_nazwa, specjalizacja = p_specjalizacja
WHERE nippodwykonawcy = p_nipdozmiany;
END;
$$;
 �   DROP PROCEDURE "Podwykonawcy".edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       Podwykonawcy               postgres    false    9                       1255    33760 (   historia_podwykonawcy(character varying)    FUNCTION     /  CREATE FUNCTION "Podwykonawcy".historia_podwykonawcy(p_nip character varying) RETURNS TABLE(vin character, nippodwykonawcy character)
    LANGUAGE plpgsql
    AS $$

BEGIN 
	RETURN QUERY
	SELECT
	sp.vin,
	sp.nippodwykonawcy
	FROM samochody_podwykonawcy as sp
	WHERE sp.nippodwykonawcy = p_nip;
END;
$$;
 M   DROP FUNCTION "Podwykonawcy".historia_podwykonawcy(p_nip character varying);
       Podwykonawcy               postgres    false    9            	           1255    33761 )   oblicz_statystyki_podwykonawcy(character)    FUNCTION     :  CREATE FUNCTION "Podwykonawcy".oblicz_statystyki_podwykonawcy(nippodwykonawcy_param character) RETURNS TABLE(nippodwykonawcy character, suma_wartosci double precision, wskaznik_efektywnosci double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        sp.nippodwykonawcy,
        SUM(s.cena) AS suma_wartosci,
        SUM(s.cena) / COUNT(sp.vin) AS wskaznik_efektywnosci
    FROM samochody_podwykonawcy sp
    JOIN samochody s ON sp.vin = s.vin
    WHERE sp.nippodwykonawcy = nippodwykonawcy_param
    GROUP BY sp.nippodwykonawcy;
END;
$$;
 ^   DROP FUNCTION "Podwykonawcy".oblicz_statystyki_podwykonawcy(nippodwykonawcy_param character);
       Podwykonawcy               postgres    false    9            
           1255    33762    pobierz_podwykonawcy()    FUNCTION     A  CREATE FUNCTION "Podwykonawcy".pobierz_podwykonawcy() RETURNS TABLE(nippodwykonawcy character, nazwa character varying, specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.nippodwykonawcy,
        p.nazwa,
        p.specjalizacja
    FROM podwykonawcy p;
END;
$$;
 5   DROP FUNCTION "Podwykonawcy".pobierz_podwykonawcy();
       Podwykonawcy               postgres    false    9                       1255    33763 #   usunpodwykonawce(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Podwykonawcy".usunpodwykonawce(IN p_nippodwykonawcy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM podwykonawcy
WHERE nippodwykonawcy = p_nippodwykonawcy;
END;
$$;
 X   DROP PROCEDURE "Podwykonawcy".usunpodwykonawce(IN p_nippodwykonawcy character varying);
       Podwykonawcy               postgres    false    9                       1255    33764 l   dodajpracownika(character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE "Pracownicy".dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO pracownicy(pesel,imie,nazwisko,stanowiskoid,placowkaid,zarobki)
VALUES (p_pesel,p_imie,p_nazwisko,p_stanowiskoid,p_placowkaid,p_zarobki);
END;
$$;
 �   DROP PROCEDURE "Pracownicy".dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
    
   Pracownicy               postgres    false    10                       1255    33765 �   edytujpracownika(character varying, character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE "Pracownicy".edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE pracownicy
SET pesel=p_pesel, imie = p_imie, nazwisko = p_nazwisko, stanowiskoid = p_stanowiskoid, placowkaid = p_placowkaid, zarobki = p_zarobki
WHERE pesel = p_peselDoZmiany;
END;
$$;
   DROP PROCEDURE "Pracownicy".edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
    
   Pracownicy               postgres    false    10                       1255    33766    pobierz_pracownicy()    FUNCTION     �  CREATE FUNCTION "Pracownicy".pobierz_pracownicy() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, stanowiskoid integer, placowkaid integer, zarobki numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.pesel,
        p.imie,
        p.nazwisko,
        p.stanowiskoid,
        p.placowkaid,
        p.zarobki::numeric as zarobki
    FROM pracownicy p;
END;
$$;
 1   DROP FUNCTION "Pracownicy".pobierz_pracownicy();
    
   Pracownicy               postgres    false    10                       1255    33767 !   usunpracownika(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Pracownicy".usunpracownika(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
DELETE FROM pracownicy
WHERE pesel = p_pesel;
END;
$$;
 J   DROP PROCEDURE "Pracownicy".usunpracownika(IN p_pesel character varying);
    
   Pracownicy               postgres    false    10                       1255    33768 �   dodajsamochod(character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     �  CREATE PROCEDURE "Samochody".dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO samochody (vin,marka,model,rocznik,silnik,skrzynia,stan,cena,placowkaid)
VALUES (p_vin,p_marka,p_model,p_rocznik,p_silnik,p_skrzynia,p_stan,p_cena,p_placowkaid);
END;
$$;
 !  DROP PROCEDURE "Samochody".dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer);
    	   Samochody               postgres    false    11                       1255    33769 �   edytujsamochod(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     O  CREATE PROCEDURE "Samochody".edytujsamochod(IN p_vindozmiany character varying, IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE samochody 
SET vin = p_vin, marka = p_marka, model = p_model, rocznik = p_rocznik, silnik = p_silnik, 
	skrzynia = p_skrzynia, stan = p_stan, cena = p_cena, placowkaid = p_placowkaid
WHERE vin = p_vindozmiany;
END;
$$;
 F  DROP PROCEDURE "Samochody".edytujsamochod(IN p_vindozmiany character varying, IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer);
    	   Samochody               postgres    false    11                       1255    33770    pobierz_samochody()    FUNCTION       CREATE FUNCTION "Samochody".pobierz_samochody() RETURNS TABLE(vin character, marka character varying, model character varying, rocznik integer, silnik character varying, skrzynia character varying, stan character varying, cena numeric, placowkaid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.vin,
        s.marka,
        s.model,
        s.rocznik,
        s.silnik,
        s.skrzynia,
        s.stan,
        s.cena::numeric as cena,
        s.placowkaid
    FROM samochody s;
END;
$$;
 /   DROP FUNCTION "Samochody".pobierz_samochody();
    	   Samochody               postgres    false    11                       1255    33771    usunsamochod(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Samochody".usunsamochod(IN p_vin character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM samochody
WHERE vin = p_vin;
END;
$$;
 E   DROP PROCEDURE "Samochody".usunsamochod(IN p_vin character varying);
    	   Samochody               postgres    false    11                       1255    33772 A   dodajsamochody_podwykonawcy(character varying, character varying) 	   PROCEDURE        CREATE PROCEDURE "Samochody_Podwykonawcy".dodajsamochody_podwykonawcy(IN p_vin character varying, IN p_nippodwykonawcy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO samochody_podwykonawcy
	VALUES (p_vin, p_nippodwykonawcy);
END;
$$;
 �   DROP PROCEDURE "Samochody_Podwykonawcy".dodajsamochody_podwykonawcy(IN p_vin character varying, IN p_nippodwykonawcy character varying);
       Samochody_Podwykonawcy               postgres    false    12                        1255    33773 U   edytujsamochody_podwykonawcy(character varying, character varying, character varying) 	   PROCEDURE     6  CREATE PROCEDURE "Samochody_Podwykonawcy".edytujsamochody_podwykonawcy(IN p_vindoedycji character varying, IN p_vin character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE samochody_podwykonawcy
	SET vin = p_vin, nippodwykonawcy = p_nip
	WHERE vin = p_vinDoEdycji;
END;
$$;
 �   DROP PROCEDURE "Samochody_Podwykonawcy".edytujsamochody_podwykonawcy(IN p_vindoedycji character varying, IN p_vin character varying, IN p_nip character varying);
       Samochody_Podwykonawcy               postgres    false    12            !           1255    33774     pobierz_samochody_podwykonawcy()    FUNCTION     +  CREATE FUNCTION "Samochody_Podwykonawcy".pobierz_samochody_podwykonawcy() RETURNS TABLE(vin character, nippodwykonawcy character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT sp.vin, 
           sp.nippodwykonawcy
    FROM samochody_podwykonawcy sp
    ORDER BY sp.vin;
END;
$$;
 I   DROP FUNCTION "Samochody_Podwykonawcy".pobierz_samochody_podwykonawcy();
       Samochody_Podwykonawcy               postgres    false    12            "           1255    33775 0   usunsamochody_podwykonawcy(character, character) 	   PROCEDURE       CREATE PROCEDURE "Samochody_Podwykonawcy".usunsamochody_podwykonawcy(IN p_vin character, IN p_nippodwykonawcy character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "samochody_podwykonawcy"
    WHERE vin = p_vin AND nippodwykonawcy = p_nippodwykonawcy;
END;
$$;
 x   DROP PROCEDURE "Samochody_Podwykonawcy".usunsamochody_podwykonawcy(IN p_vin character, IN p_nippodwykonawcy character);
       Samochody_Podwykonawcy               postgres    false    12            #           1255    33776 G   dodajstanowisko(character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Stanowiska".dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie)
VALUES (nextval('stanowiska_id_stanowiska_seq'),p_nazwastanowiska,p_minzarobki,p_maxzarobki,p_doswiadczenie);
END;
$$;
 �   DROP PROCEDURE "Stanowiska".dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying);
    
   Stanowiska               postgres    false    13            $           1255    33777 c   edytujstanowisko(integer, character varying, double precision, double precision, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Stanowiska".edytujstanowisko(IN p_id_stanowiska integer, IN p_nazwa character varying, IN p_min_zarobki double precision, IN p_max_zarobki double precision, IN p_doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE stanowiska
    SET nazwastanowiska = p_nazwa,
        minzarobki = p_min_zarobki,
        maxzarobki = p_max_zarobki,
        doswiadczenie = p_doswiadczenie
    WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 �   DROP PROCEDURE "Stanowiska".edytujstanowisko(IN p_id_stanowiska integer, IN p_nazwa character varying, IN p_min_zarobki double precision, IN p_max_zarobki double precision, IN p_doswiadczenie character varying);
    
   Stanowiska               postgres    false    13            %           1255    33778    ilosc_pracownikow(integer)    FUNCTION     �  CREATE FUNCTION "Stanowiska".ilosc_pracownikow(p_placowkaid integer DEFAULT NULL::integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
ilosc NUMERIC := 0;
BEGIN 
IF p_placowkaid IS NOT NULL THEN
	SELECT COUNT(stanowiskoid) INTO ilosc
	FROM pracownicy
	WHERE placowkaid = p_placowkaid;
ELSE
	SELECT COUNT(stanowiskoid) INTO ilosc
	FROM pracownicy;
END IF;
RETURN COALESCE(ilosc, 0);
END; 
$$;
 D   DROP FUNCTION "Stanowiska".ilosc_pracownikow(p_placowkaid integer);
    
   Stanowiska               postgres    false    13            &           1255    33779    pobierz_stanowiska()    FUNCTION     �  CREATE FUNCTION "Stanowiska".pobierz_stanowiska() RETURNS TABLE(id_stanowiska integer, nazwastanowiska character varying, minzarobki double precision, maxzarobki double precision, doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT s.id_stanowiska, 
           s.nazwastanowiska, 
           s.minzarobki, 
           s.maxzarobki, 
           s.doswiadczenie
    FROM stanowiska s;
END;
$$;
 1   DROP FUNCTION "Stanowiska".pobierz_stanowiska();
    
   Stanowiska               postgres    false    13            '           1255    33780    usunstanowisko(integer) 	   PROCEDURE     �   CREATE PROCEDURE "Stanowiska".usunstanowisko(IN p_id_stanowiska integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM stanowiska
    WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 H   DROP PROCEDURE "Stanowiska".usunstanowisko(IN p_id_stanowiska integer);
    
   Stanowiska               postgres    false    13            (           1255    33781 K   dodajzamowienie(double precision, character, character, boolean, character) 	   PROCEDURE     �  CREATE PROCEDURE "Zamowienia".dodajzamowienie(IN p_kwota double precision, IN p_pesel_klienta character, IN p_vin character, IN p_usluganaprawy boolean, IN p_pesel_pracownika character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO zamowienia (
        kwota, 
        pesel_klienta, 
        vin, 
        usluganaprawy, 
        pesel_pracownika
    ) VALUES (
        p_kwota, 
        p_pesel_klienta, 
        p_vin, 
        p_usluganaprawy, 
        p_pesel_pracownika
    );
END;
$$;
 �   DROP PROCEDURE "Zamowienia".dodajzamowienie(IN p_kwota double precision, IN p_pesel_klienta character, IN p_vin character, IN p_usluganaprawy boolean, IN p_pesel_pracownika character);
    
   Zamowienia               postgres    false    14                       1255    33782 m   edytujzamowienie(integer, double precision, character varying, character varying, boolean, character varying) 	   PROCEDURE       CREATE PROCEDURE "Zamowienia".edytujzamowienie(IN p_iddozmiany integer, IN p_kwota double precision, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE zamowienia
    SET 
        kwota = p_kwota, 
        pesel_klienta = p_pesel, 
        vin = p_vin, 
        usluganaprawy = p_usluganaprawy, 
        pesel_pracownika = p_pesel_pracownika
    WHERE id_zamowienia = p_iddozmiany;
END;
$$;
 �   DROP PROCEDURE "Zamowienia".edytujzamowienie(IN p_iddozmiany integer, IN p_kwota double precision, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying);
    
   Zamowienia               postgres    false    14            )           1255    33783    pobierz_zamowienia()    FUNCTION     �  CREATE FUNCTION "Zamowienia".pobierz_zamowienia() RETURNS TABLE(id_zamowienia integer, kwota double precision, pesel_klienta character, vin character, usluganaprawy boolean, pesel_pracownika character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT z.id_zamowienia, 
           z.kwota, 
           z.pesel_klienta, 
           z.vin, 
           z.usluganaprawy, 
           z.pesel_pracownika
    FROM zamowienia z
    ORDER BY z.id_zamowienia;
END;
$$;
 1   DROP FUNCTION "Zamowienia".pobierz_zamowienia();
    
   Zamowienia               postgres    false    14            *           1255    33784 $   suma_kwoty_zamowien_usluga_naprawy()    FUNCTION     �  CREATE FUNCTION "Zamowienia".suma_kwoty_zamowien_usluga_naprawy() RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
    r RECORD;
    suma double precision := 0;
    cur CURSOR FOR 
        SELECT Kwota 
        FROM zamowienia 
        WHERE usluganaprawy = true;
BEGIN
    OPEN cur;
    
    LOOP
        FETCH cur INTO r;
        EXIT WHEN NOT FOUND; 
        
        suma := suma + r.Kwota;
    END LOOP;
    
    CLOSE cur;
    
    RETURN suma;
END;
$$;
 A   DROP FUNCTION "Zamowienia".suma_kwoty_zamowien_usluga_naprawy();
    
   Zamowienia               postgres    false    14            +           1255    33785    usunzamowienie(integer) 	   PROCEDURE     �   CREATE PROCEDURE "Zamowienia".usunzamowienie(IN p_idzamowienia integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM zamowienia
    WHERE id_zamowienia = p_idzamowienia;
END;
$$;
 G   DROP PROCEDURE "Zamowienia".usunzamowienie(IN p_idzamowienia integer);
    
   Zamowienia               postgres    false    14            -           1255    33907 $   zamowienia_danego_klienta(character)    FUNCTION     �  CREATE FUNCTION "Zamowienia".zamowienia_danego_klienta(pesel character) RETURNS TABLE(id_zamowienia integer, kwota double precision, pesel_klienta character, vin character, usluganaprawy boolean, pesel_pracownika character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        z.id_zamowienia,
        z.kwota,
        z.pesel_klienta,
        z.vin,
        z.usluganaprawy,
        z.pesel_pracownika
    FROM zamowienia AS z
    WHERE z.pesel_klienta = pesel;
END;
$$;
 G   DROP FUNCTION "Zamowienia".zamowienia_danego_klienta(pesel character);
    
   Zamowienia               postgres    false    14            ,           1255    33787    sumazarobkow(integer)    FUNCTION     v  CREATE FUNCTION public.sumazarobkow(p_placowkaid integer DEFAULT NULL::integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
suma NUMERIC := 0;
BEGIN 
IF p_placowkaid IS NOT NULL THEN
	SELECT SUM(zarobki) INTO suma
	FROM pracownicy
	WHERE placowkaid = p_placowkaid;
ELSE
	SELECT SUM(zarobki) INTO suma
	FROM pracownicy;
END IF;
RETURN COALESCE(suma, 0);
END; 
$$;
 9   DROP FUNCTION public.sumazarobkow(p_placowkaid integer);
       public               postgres    false            �            1259    33788    firmy    TABLE     n   CREATE TABLE public.firmy (
    nazwafirmy character varying(100) NOT NULL,
    nip character(10) NOT NULL
);
    DROP TABLE public.firmy;
       public         heap r       postgres    false            �            1259    33791    id_pracownika_seq    SEQUENCE     z   CREATE SEQUENCE public.id_pracownika_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.id_pracownika_seq;
       public               postgres    false            �            1259    33792    klienci    TABLE     �   CREATE TABLE public.klienci (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    nip character(10),
    telefon character varying(15) NOT NULL
);
    DROP TABLE public.klienci;
       public         heap r       postgres    false            �            1259    33795    placowki    TABLE     (  CREATE TABLE public.placowki (
    id_placowki integer NOT NULL,
    miasto character varying(50) NOT NULL,
    ulica character varying(100) NOT NULL,
    numerbudynku character varying(10) NOT NULL,
    iloscsamochodow integer DEFAULT 0 NOT NULL,
    iloscmiejscapozostalego integer NOT NULL
);
    DROP TABLE public.placowki;
       public         heap r       postgres    false            �            1259    33799    placowki_id_placowki_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_id_placowki_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.placowki_id_placowki_seq;
       public               postgres    false    229            U           0    0    placowki_id_placowki_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.placowki_id_placowki_seq OWNED BY public.placowki.id_placowki;
          public               postgres    false    230            �            1259    33800    placowki_id_seq    SEQUENCE     x   CREATE SEQUENCE public.placowki_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.placowki_id_seq;
       public               postgres    false            �            1259    33801    placowki_placowkaid_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_placowkaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.placowki_placowkaid_seq;
       public               postgres    false            �            1259    33802    podwykonawcy    TABLE     �   CREATE TABLE public.podwykonawcy (
    nippodwykonawcy character(10) NOT NULL,
    nazwa character varying(100) NOT NULL,
    specjalizacja character varying(50) NOT NULL
);
     DROP TABLE public.podwykonawcy;
       public         heap r       postgres    false            �            1259    33805 
   pracownicy    TABLE       CREATE TABLE public.pracownicy (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    stanowiskoid integer NOT NULL,
    placowkaid integer NOT NULL,
    zarobki double precision NOT NULL
);
    DROP TABLE public.pracownicy;
       public         heap r       postgres    false            �            1259    33808 	   samochody    TABLE     z  CREATE TABLE public.samochody (
    vin character(17) NOT NULL,
    marka character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    rocznik integer NOT NULL,
    silnik character varying(50) NOT NULL,
    skrzynia character varying(50) NOT NULL,
    stan character varying(20) NOT NULL,
    cena double precision NOT NULL,
    placowkaid integer NOT NULL
);
    DROP TABLE public.samochody;
       public         heap r       postgres    false            �            1259    33811    samochody_podwykonawcy    TABLE     {   CREATE TABLE public.samochody_podwykonawcy (
    vin character(17) NOT NULL,
    nippodwykonawcy character(10) NOT NULL
);
 *   DROP TABLE public.samochody_podwykonawcy;
       public         heap r       postgres    false            �            1259    33814 
   stanowiska    TABLE       CREATE TABLE public.stanowiska (
    id_stanowiska integer NOT NULL,
    nazwastanowiska character varying(100) NOT NULL,
    minzarobki double precision NOT NULL,
    maxzarobki double precision NOT NULL,
    doswiadczenie character varying(20) NOT NULL
);
    DROP TABLE public.stanowiska;
       public         heap r       postgres    false            �            1259    33817    stanowiska_id_stanowiska_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_id_stanowiska_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.stanowiska_id_stanowiska_seq;
       public               postgres    false    237            V           0    0    stanowiska_id_stanowiska_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.stanowiska_id_stanowiska_seq OWNED BY public.stanowiska.id_stanowiska;
          public               postgres    false    238            �            1259    33818    stanowiska_stanowiskoid_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_stanowiskoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.stanowiska_stanowiskoid_seq;
       public               postgres    false            �            1259    33819 
   zamowienia    TABLE       CREATE TABLE public.zamowienia (
    id_zamowienia integer NOT NULL,
    kwota double precision NOT NULL,
    pesel_klienta character(11) NOT NULL,
    vin character(17) NOT NULL,
    usluganaprawy boolean NOT NULL,
    pesel_pracownika character(11) NOT NULL
);
    DROP TABLE public.zamowienia;
       public         heap r       postgres    false            �            1259    33822    zamowienia_id_zamowienia_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_id_zamowienia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.zamowienia_id_zamowienia_seq;
       public               postgres    false    240            W           0    0    zamowienia_id_zamowienia_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.zamowienia_id_zamowienia_seq OWNED BY public.zamowienia.id_zamowienia;
          public               postgres    false    241            �            1259    33823    zamowienia_zamowienieid_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_zamowienieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.zamowienia_zamowienieid_seq;
       public               postgres    false            �           2604    33824    placowki id_placowki    DEFAULT     |   ALTER TABLE ONLY public.placowki ALTER COLUMN id_placowki SET DEFAULT nextval('public.placowki_id_placowki_seq'::regclass);
 C   ALTER TABLE public.placowki ALTER COLUMN id_placowki DROP DEFAULT;
       public               postgres    false    230    229            �           2604    33825    stanowiska id_stanowiska    DEFAULT     �   ALTER TABLE ONLY public.stanowiska ALTER COLUMN id_stanowiska SET DEFAULT nextval('public.stanowiska_id_stanowiska_seq'::regclass);
 G   ALTER TABLE public.stanowiska ALTER COLUMN id_stanowiska DROP DEFAULT;
       public               postgres    false    238    237            �           2604    33826    zamowienia id_zamowienia    DEFAULT     �   ALTER TABLE ONLY public.zamowienia ALTER COLUMN id_zamowienia SET DEFAULT nextval('public.zamowienia_id_zamowienia_seq'::regclass);
 G   ALTER TABLE public.zamowienia ALTER COLUMN id_zamowienia DROP DEFAULT;
       public               postgres    false    241    240            >          0    33788    firmy 
   TABLE DATA           0   COPY public.firmy (nazwafirmy, nip) FROM stdin;
    public               postgres    false    226   ��       @          0    33792    klienci 
   TABLE DATA           F   COPY public.klienci (pesel, imie, nazwisko, nip, telefon) FROM stdin;
    public               postgres    false    228   ��       A          0    33795    placowki 
   TABLE DATA           v   COPY public.placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego) FROM stdin;
    public               postgres    false    229   ��       E          0    33802    podwykonawcy 
   TABLE DATA           M   COPY public.podwykonawcy (nippodwykonawcy, nazwa, specjalizacja) FROM stdin;
    public               postgres    false    233   /�       F          0    33805 
   pracownicy 
   TABLE DATA           ^   COPY public.pracownicy (pesel, imie, nazwisko, stanowiskoid, placowkaid, zarobki) FROM stdin;
    public               postgres    false    234   ��       G          0    33808 	   samochody 
   TABLE DATA           i   COPY public.samochody (vin, marka, model, rocznik, silnik, skrzynia, stan, cena, placowkaid) FROM stdin;
    public               postgres    false    235   ��       H          0    33811    samochody_podwykonawcy 
   TABLE DATA           F   COPY public.samochody_podwykonawcy (vin, nippodwykonawcy) FROM stdin;
    public               postgres    false    236   g�       I          0    33814 
   stanowiska 
   TABLE DATA           k   COPY public.stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie) FROM stdin;
    public               postgres    false    237   ��       L          0    33819 
   zamowienia 
   TABLE DATA           o   COPY public.zamowienia (id_zamowienia, kwota, pesel_klienta, vin, usluganaprawy, pesel_pracownika) FROM stdin;
    public               postgres    false    240   ��       X           0    0    id_pracownika_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.id_pracownika_seq', 1, false);
          public               postgres    false    227            Y           0    0    placowki_id_placowki_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.placowki_id_placowki_seq', 1, false);
          public               postgres    false    230            Z           0    0    placowki_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.placowki_id_seq', 7, true);
          public               postgres    false    231            [           0    0    placowki_placowkaid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.placowki_placowkaid_seq', 1, false);
          public               postgres    false    232            \           0    0    stanowiska_id_stanowiska_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.stanowiska_id_stanowiska_seq', 12, true);
          public               postgres    false    238            ]           0    0    stanowiska_stanowiskoid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_stanowiskoid_seq', 1, false);
          public               postgres    false    239            ^           0    0    zamowienia_id_zamowienia_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.zamowienia_id_zamowienia_seq', 21, true);
          public               postgres    false    241            _           0    0    zamowienia_zamowienieid_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.zamowienia_zamowienieid_seq', 1, true);
          public               postgres    false    242            �           2606    33828    firmy firmy_nip_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_nip_key UNIQUE (nip);
 =   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_nip_key;
       public                 postgres    false    226            �           2606    33830    firmy firmy_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_pkey PRIMARY KEY (nazwafirmy);
 :   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_pkey;
       public                 postgres    false    226            �           2606    33832    klienci klienci_nip_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_key UNIQUE (nip);
 A   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_key;
       public                 postgres    false    228            �           2606    33834    klienci klienci_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (pesel);
 >   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_pkey;
       public                 postgres    false    228            �           2606    33836    placowki placowki_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.placowki
    ADD CONSTRAINT placowki_pkey PRIMARY KEY (id_placowki);
 @   ALTER TABLE ONLY public.placowki DROP CONSTRAINT placowki_pkey;
       public                 postgres    false    229            �           2606    33838    podwykonawcy podwykonawcy_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.podwykonawcy
    ADD CONSTRAINT podwykonawcy_pkey PRIMARY KEY (nippodwykonawcy);
 H   ALTER TABLE ONLY public.podwykonawcy DROP CONSTRAINT podwykonawcy_pkey;
       public                 postgres    false    233            �           2606    33840    pracownicy pracownicy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (pesel);
 D   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_pkey;
       public                 postgres    false    234            �           2606    33842    samochody samochody_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_pkey PRIMARY KEY (vin);
 B   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_pkey;
       public                 postgres    false    235            �           2606    33844 2   samochody_podwykonawcy samochody_podwykonawcy_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_pkey PRIMARY KEY (vin, nippodwykonawcy);
 \   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_pkey;
       public                 postgres    false    236    236            �           2606    33846    stanowiska stanowiska_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.stanowiska
    ADD CONSTRAINT stanowiska_pkey PRIMARY KEY (id_stanowiska);
 D   ALTER TABLE ONLY public.stanowiska DROP CONSTRAINT stanowiska_pkey;
       public                 postgres    false    237            �           2606    33848    zamowienia unique_vin 
   CONSTRAINT     O   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT unique_vin UNIQUE (vin);
 ?   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT unique_vin;
       public                 postgres    false    240            �           2606    33850    zamowienia zamowienia_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (id_zamowienia);
 D   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pkey;
       public                 postgres    false    240            �           2606    33852    zamowienia zamowienia_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_key UNIQUE (vin);
 G   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_key;
       public                 postgres    false    240            �           2620    33853     samochody dekrementacjaliczbyaut    TRIGGER     �   CREATE TRIGGER dekrementacjaliczbyaut AFTER DELETE ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki".dekremetacjaliczbyaut();
 9   DROP TRIGGER dekrementacjaliczbyaut ON public.samochody;
       public               postgres    false    254    235            �           2620    33854 (   samochody dekremetacjamiejscapozostalego    TRIGGER     �   CREATE TRIGGER dekremetacjamiejscapozostalego AFTER DELETE ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki".dekrementacjamiejscapozostalego();
 A   DROP TRIGGER dekremetacjamiejscapozostalego ON public.samochody;
       public               postgres    false    253    235            �           2620    33855 '   samochody trigger_aktualizacjaliczbyaut    TRIGGER     �   CREATE TRIGGER trigger_aktualizacjaliczbyaut AFTER INSERT ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki"."inkremetacjaLiczbyAut"();
 @   DROP TRIGGER trigger_aktualizacjaliczbyaut ON public.samochody;
       public               postgres    false    257    235            �           2620    33856 6   samochody trigger_aktualizacjaliczbymiejscapozostalego    TRIGGER     �   CREATE TRIGGER trigger_aktualizacjaliczbymiejscapozostalego AFTER INSERT ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki"."inkremetacjaMiejscaPozostalego"();
 O   DROP TRIGGER trigger_aktualizacjaliczbymiejscapozostalego ON public.samochody;
       public               postgres    false    258    235            �           2606    33857    klienci fk_klienci_firmy    FK CONSTRAINT     t   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT fk_klienci_firmy FOREIGN KEY (nip) REFERENCES public.firmy(nip);
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT fk_klienci_firmy;
       public               postgres    false    4742    228    226            �           2606    33862    klienci klienci_nip_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_fkey FOREIGN KEY (nip) REFERENCES public.firmy(nip) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_fkey;
       public               postgres    false    228    4742    226            �           2606    33867 %   pracownicy pracownicy_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_placowkaid_fkey;
       public               postgres    false    4750    229    234            �           2606    33872 '   pracownicy pracownicy_stanowiskoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_stanowiskoid_fkey FOREIGN KEY (stanowiskoid) REFERENCES public.stanowiska(id_stanowiska) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_stanowiskoid_fkey;
       public               postgres    false    237    234    4760            �           2606    33877 #   samochody samochody_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_placowkaid_fkey;
       public               postgres    false    229    4750    235            �           2606    33882 B   samochody_podwykonawcy samochody_podwykonawcy_nippodwykonawcy_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey FOREIGN KEY (nippodwykonawcy) REFERENCES public.podwykonawcy(nippodwykonawcy) ON DELETE SET NULL;
 l   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey;
       public               postgres    false    4752    236    233            �           2606    33887 6   samochody_podwykonawcy samochody_podwykonawcy_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_vin_fkey;
       public               postgres    false    236    4756    235            �           2606    33892 (   zamowienia zamowienia_pesel_klienta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_klienta_fkey FOREIGN KEY (pesel_klienta) REFERENCES public.klienci(pesel) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_klienta_fkey;
       public               postgres    false    4748    240    228            �           2606    33897 +   zamowienia zamowienia_pesel_pracownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_pracownika_fkey FOREIGN KEY (pesel_pracownika) REFERENCES public.pracownicy(pesel) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_pracownika_fkey;
       public               postgres    false    240    234    4754            �           2606    33902    zamowienia zamowienia_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_fkey;
       public               postgres    false    240    4756    235            >   6   x�s�,�MTp�4426153��4�r9q�E�BΜy�!��%


\1z\\\ �.6      @   �   x�u�K�0���)8���c��Ite�L�&��5Bd��<�t�Dg�����x~F��v�zp$]r	��I@��7eh�IO����5Y���Bk�I��T�_���3�(�����Ӱ�fhe)5��@���#�Y��x��qF���X�r�ڰ�1��Jb��afT{y��*�;�b��;f~@�ִ&�^�,,��"~ ¢f�      A   K   x�3��J-��/��H-�M�+�N�44�4�42�2�.g�ih�e�MΔSא�Ȑ˜ӻ(1(�X�D�P�b���� ]��      E   N   x���,P� άļ��*����ļ�l���#��
΢��Ҽ�L.#CcsJ�&�&W�fs&� e���b���� ���      F   \   x�3426153��4P�JLI��tNM*�I�4�4�41�2246�b�|~�Ѧ��rN7�p7�#N.C8�LM+�,�@�F��&f�\1z\\\ ��!      G   ^   x�3426624T�N'�p�SN#CN�Լ�ʼDN�ļ���Ъ��ļJ�prB4�j6'V����͎�)����`�tBu��qqq LZ,�      H   %   x�3426624T�μ�(������� �d� V�
^      I   9   x�3�N�.J-I,�N�4100�4��)\F��%�G�TINC��1�����qqq ��a      L   G   x���470�4426153��40���p�q�C1�����1'T9H#H�����1\g	��
\1z\\\ �#     