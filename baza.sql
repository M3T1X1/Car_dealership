PGDMP      +                 }            bazaaa    16.3    17.1 �    H           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            I           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            J           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            K           1262    25105    bazaaa    DATABASE     y   CREATE DATABASE bazaaa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE bazaaa;
                     postgres    false                        2615    25106    Firmy    SCHEMA        CREATE SCHEMA "Firmy";
    DROP SCHEMA "Firmy";
                     postgres    false                        2615    25107    Klienci    SCHEMA        CREATE SCHEMA "Klienci";
    DROP SCHEMA "Klienci";
                     postgres    false                        2615    25108    Placowki    SCHEMA        CREATE SCHEMA "Placowki";
    DROP SCHEMA "Placowki";
                     postgres    false            	            2615    25109    Podwykonawcy    SCHEMA        CREATE SCHEMA "Podwykonawcy";
    DROP SCHEMA "Podwykonawcy";
                     postgres    false            
            2615    25110 
   Pracownicy    SCHEMA        CREATE SCHEMA "Pracownicy";
    DROP SCHEMA "Pracownicy";
                     postgres    false                        2615    25111 	   Samochody    SCHEMA        CREATE SCHEMA "Samochody";
    DROP SCHEMA "Samochody";
                     postgres    false                        2615    25112    Samochody_Podwykonawcy    SCHEMA     (   CREATE SCHEMA "Samochody_Podwykonawcy";
 &   DROP SCHEMA "Samochody_Podwykonawcy";
                     postgres    false                        2615    25113 
   Stanowiska    SCHEMA        CREATE SCHEMA "Stanowiska";
    DROP SCHEMA "Stanowiska";
                     postgres    false                        2615    25114 
   Zamowienia    SCHEMA        CREATE SCHEMA "Zamowienia";
    DROP SCHEMA "Zamowienia";
                     postgres    false            �            1255    25115 0   dodajfirme(character varying, character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Firmy".dodajfirme(IN p_nazwafirmy character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO firmy (nazwaFirmy, nip)
VALUES (p_nazwaFirmy, p_nip);
END;
$$;
 b   DROP PROCEDURE "Firmy".dodajfirme(IN p_nazwafirmy character varying, IN p_nip character varying);
       Firmy               postgres    false    6            �            1255    25116 D   edytujfirme(character varying, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE "Firmy".edytujfirme(IN p_nazwafirmydozmiany character varying, IN p_nazwafirmy character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE firmy
SET nazwaFirmy = p_nazwaFirmy, nip = p_nip
WHERE nazwaFirmy = p_nazwaFirmyDoZmiany;
END;
$$;
 �   DROP PROCEDURE "Firmy".edytujfirme(IN p_nazwafirmydozmiany character varying, IN p_nazwafirmy character varying, IN p_nip character varying);
       Firmy               postgres    false    6            �            1255    25117    pobierz_firmy()    FUNCTION     �   CREATE FUNCTION "Firmy".pobierz_firmy() RETURNS TABLE(nazwafirmy character varying, nip character)
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
       Firmy               postgres    false    6            �            1255    25118    usunfirme(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Firmy".usunfirme(IN p_nazwafirmy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
DELETE FROM firmy
WHERE nazwaFirmy = p_nazwaFirmy;
END;
$$;
 E   DROP PROCEDURE "Firmy".usunfirme(IN p_nazwafirmy character varying);
       Firmy               postgres    false    6            �            1255    25119 k   dodajklienta(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     y  CREATE PROCEDURE "Klienci".dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO klienci (pesel,imie,nazwisko,nip,telefon)
VALUES (p_pesel,p_imie,p_nazwisko,p_nip,p_telefon);
END;
$$;
 �   DROP PROCEDURE "Klienci".dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       Klienci               postgres    false    7            �            1255    25120    edytujklienta(character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Klienci".edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE klienci
SET pesel=p_pesel,imie=p_imie,nazwisko=p_nazwisko,telefon=p_telefon,nip=p_nip
WHERE pesel = p_peseldozmiany;
END;
$$;
 �   DROP PROCEDURE "Klienci".edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       Klienci               postgres    false    7            �            1255    25121    pobierz_klienci()    FUNCTION     e  CREATE FUNCTION "Klienci".pobierz_klienci() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, nip character, telefon character varying)
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
       Klienci               postgres    false    7            �            1255    25122    usunklienta(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Klienci".usunklienta(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM klienci
	WHERE pesel = p_pesel;
END;
$$;
 D   DROP PROCEDURE "Klienci".usunklienta(IN p_pesel character varying);
       Klienci               postgres    false    7                       1255    25291    check_iloscmiejscapozostalego()    FUNCTION     O  CREATE FUNCTION "Placowki".check_iloscmiejscapozostalego() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (SELECT iloscmiejscapozostalego FROM placowki WHERE id_placowki = NEW.placowkaid) = 0 THEN
        RAISE EXCEPTION 'Nie można dodać samochodu: brak wolnych miejsc w placówce';
    END IF;
    RETURN NEW;
END;
$$;
 :   DROP FUNCTION "Placowki".check_iloscmiejscapozostalego();
       Placowki               postgres    false    8            �            1255    25125 !   dekrementacjamiejscapozostalego()    FUNCTION     �   CREATE FUNCTION "Placowki".dekrementacjamiejscapozostalego() RETURNS trigger
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
       Placowki               postgres    false    8            �            1255    25126    dekremetacjaliczbyaut()    FUNCTION     �   CREATE FUNCTION "Placowki".dekremetacjaliczbyaut() RETURNS trigger
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
       Placowki               postgres    false    8            �            1255    25127 E   dodajplacowke(character varying, character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE "Placowki".dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego)
    VALUES (nextval('placowki_id_seq'), p_miasto, p_ulica, p_numerbudynku, 0, p_iloscmiejscapozostalego);
END;
$$;
 �   DROP PROCEDURE "Placowki".dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer);
       Placowki               postgres    false    8            �            1255    25128 b   edytujplacowke(integer, character varying, character varying, character varying, integer, integer) 	   PROCEDURE       CREATE PROCEDURE "Placowki".edytujplacowke(IN p_id_placowki integer, IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku character varying, IN p_iloscsamochodow integer, IN p_iloscmiejscapozostalego integer)
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
       Placowki               postgres    false    8            �            1255    25129    inkremetacjaLiczbyAut()    FUNCTION     �   CREATE FUNCTION "Placowki"."inkremetacjaLiczbyAut"() RETURNS trigger
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
       Placowki               postgres    false    8                        1255    25130     inkremetacjaMiejscaPozostalego()    FUNCTION     �   CREATE FUNCTION "Placowki"."inkremetacjaMiejscaPozostalego"() RETURNS trigger
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
       Placowki               postgres    false    8                       1255    25131    pobierz_placowki()    FUNCTION     �  CREATE FUNCTION "Placowki".pobierz_placowki() RETURNS TABLE(id_placowki integer, miasto character varying, ulica character varying, numerbudynku character varying, iloscsamochodow integer, iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT p.id_placowki, p.miasto, p.ulica, p.numerbudynku, p.iloscsamochodow, p.iloscmiejscapozostalego
    FROM placowki p;
END;
$$;
 -   DROP FUNCTION "Placowki".pobierz_placowki();
       Placowki               postgres    false    8                       1255    25132    usunplacowke(integer) 	   PROCEDURE     �   CREATE PROCEDURE "Placowki".usunplacowke(IN p_id_placowki integer)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
    DELETE FROM placowki 
	WHERE id_placowki=p_id_placowki;
END;
$$;
 B   DROP PROCEDURE "Placowki".usunplacowke(IN p_id_placowki integer);
       Placowki               postgres    false    8                       1255    25133 J   dodajpodwykonawce(character varying, character varying, character varying) 	   PROCEDURE     E  CREATE PROCEDURE "Podwykonawcy".dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO podwykonawcy (nippodwykonawcy, nazwa, specjalizacja)
VALUES (p_nippodwykonawcy, p_nazwa, p_specjalizacja); 
END;
$$;
 �   DROP PROCEDURE "Podwykonawcy".dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       Podwykonawcy               postgres    false    9                       1255    25134 ^   edytujpodwykonawce(character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Podwykonawcy".edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE podwykonawcy 
SET nippodwykonawcy = p_nippodwykonawcy, nazwa = p_nazwa, specjalizacja = p_specjalizacja
WHERE nippodwykonawcy = p_nipdozmiany;
END;
$$;
 �   DROP PROCEDURE "Podwykonawcy".edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       Podwykonawcy               postgres    false    9                       1255    25135 (   historia_podwykonawcy(character varying)    FUNCTION     /  CREATE FUNCTION "Podwykonawcy".historia_podwykonawcy(p_nip character varying) RETURNS TABLE(vin character, nippodwykonawcy character)
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
       Podwykonawcy               postgres    false    9                       1255    25136 )   oblicz_statystyki_podwykonawcy(character)    FUNCTION     :  CREATE FUNCTION "Podwykonawcy".oblicz_statystyki_podwykonawcy(nippodwykonawcy_param character) RETURNS TABLE(nippodwykonawcy character, suma_wartosci double precision, wskaznik_efektywnosci double precision)
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
       Podwykonawcy               postgres    false    9                       1255    25137    pobierz_podwykonawcy()    FUNCTION     A  CREATE FUNCTION "Podwykonawcy".pobierz_podwykonawcy() RETURNS TABLE(nippodwykonawcy character, nazwa character varying, specjalizacja character varying)
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
       Podwykonawcy               postgres    false    9            	           1255    25138 #   usunpodwykonawce(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Podwykonawcy".usunpodwykonawce(IN p_nippodwykonawcy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM podwykonawcy
WHERE nippodwykonawcy = p_nippodwykonawcy;
END;
$$;
 X   DROP PROCEDURE "Podwykonawcy".usunpodwykonawce(IN p_nippodwykonawcy character varying);
       Podwykonawcy               postgres    false    9            
           1255    25139 l   dodajpracownika(character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE "Pracownicy".dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO pracownicy(pesel,imie,nazwisko,stanowiskoid,placowkaid,zarobki)
VALUES (p_pesel,p_imie,p_nazwisko,p_stanowiskoid,p_placowkaid,p_zarobki);
END;
$$;
 �   DROP PROCEDURE "Pracownicy".dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
    
   Pracownicy               postgres    false    10                       1255    25140 �   edytujpracownika(character varying, character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE "Pracownicy".edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
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
   Pracownicy               postgres    false    10                       1255    25141    pobierz_pracownicy()    FUNCTION     �  CREATE FUNCTION "Pracownicy".pobierz_pracownicy() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, stanowiskoid integer, placowkaid integer, zarobki numeric)
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
   Pracownicy               postgres    false    10                       1255    25142 !   usunpracownika(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Pracownicy".usunpracownika(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
DELETE FROM pracownicy
WHERE pesel = p_pesel;
END;
$$;
 J   DROP PROCEDURE "Pracownicy".usunpracownika(IN p_pesel character varying);
    
   Pracownicy               postgres    false    10                       1255    25143 �   dodajsamochod(character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     �  CREATE PROCEDURE "Samochody".dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO samochody (vin,marka,model,rocznik,silnik,skrzynia,stan,cena,placowkaid)
VALUES (p_vin,p_marka,p_model,p_rocznik,p_silnik,p_skrzynia,p_stan,p_cena,p_placowkaid);
END;
$$;
 !  DROP PROCEDURE "Samochody".dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer);
    	   Samochody               postgres    false    11                       1255    25144 �   edytujsamochod(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     O  CREATE PROCEDURE "Samochody".edytujsamochod(IN p_vindozmiany character varying, IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
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
    	   Samochody               postgres    false    11                       1255    25145    pobierz_samochody()    FUNCTION       CREATE FUNCTION "Samochody".pobierz_samochody() RETURNS TABLE(vin character, marka character varying, model character varying, rocznik integer, silnik character varying, skrzynia character varying, stan character varying, cena numeric, placowkaid integer)
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
    	   Samochody               postgres    false    11                       1255    25146    usunsamochod(character varying) 	   PROCEDURE     �   CREATE PROCEDURE "Samochody".usunsamochod(IN p_vin character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM samochody
WHERE vin = p_vin;
END;
$$;
 E   DROP PROCEDURE "Samochody".usunsamochod(IN p_vin character varying);
    	   Samochody               postgres    false    11                       1255    25147 A   dodajsamochody_podwykonawcy(character varying, character varying) 	   PROCEDURE        CREATE PROCEDURE "Samochody_Podwykonawcy".dodajsamochody_podwykonawcy(IN p_vin character varying, IN p_nippodwykonawcy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO samochody_podwykonawcy
	VALUES (p_vin, p_nippodwykonawcy);
END;
$$;
 �   DROP PROCEDURE "Samochody_Podwykonawcy".dodajsamochody_podwykonawcy(IN p_vin character varying, IN p_nippodwykonawcy character varying);
       Samochody_Podwykonawcy               postgres    false    12                       1255    25148 U   edytujsamochody_podwykonawcy(character varying, character varying, character varying) 	   PROCEDURE     6  CREATE PROCEDURE "Samochody_Podwykonawcy".edytujsamochody_podwykonawcy(IN p_vindoedycji character varying, IN p_vin character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE samochody_podwykonawcy
	SET vin = p_vin, nippodwykonawcy = p_nip
	WHERE vin = p_vinDoEdycji;
END;
$$;
 �   DROP PROCEDURE "Samochody_Podwykonawcy".edytujsamochody_podwykonawcy(IN p_vindoedycji character varying, IN p_vin character varying, IN p_nip character varying);
       Samochody_Podwykonawcy               postgres    false    12                        1255    25149     pobierz_samochody_podwykonawcy()    FUNCTION     +  CREATE FUNCTION "Samochody_Podwykonawcy".pobierz_samochody_podwykonawcy() RETURNS TABLE(vin character, nippodwykonawcy character)
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
       Samochody_Podwykonawcy               postgres    false    12            !           1255    25150 0   usunsamochody_podwykonawcy(character, character) 	   PROCEDURE       CREATE PROCEDURE "Samochody_Podwykonawcy".usunsamochody_podwykonawcy(IN p_vin character, IN p_nippodwykonawcy character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "samochody_podwykonawcy"
    WHERE vin = p_vin AND nippodwykonawcy = p_nippodwykonawcy;
END;
$$;
 x   DROP PROCEDURE "Samochody_Podwykonawcy".usunsamochody_podwykonawcy(IN p_vin character, IN p_nippodwykonawcy character);
       Samochody_Podwykonawcy               postgres    false    12            "           1255    25151 G   dodajstanowisko(character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Stanowiska".dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie)
VALUES (nextval('stanowiska_id_stanowiska_seq'),p_nazwastanowiska,p_minzarobki,p_maxzarobki,p_doswiadczenie);
END;
$$;
 �   DROP PROCEDURE "Stanowiska".dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying);
    
   Stanowiska               postgres    false    13            #           1255    25152 c   edytujstanowisko(integer, character varying, double precision, double precision, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "Stanowiska".edytujstanowisko(IN p_id_stanowiska integer, IN p_nazwa character varying, IN p_min_zarobki double precision, IN p_max_zarobki double precision, IN p_doswiadczenie character varying)
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
   Stanowiska               postgres    false    13            $           1255    25153    ilosc_pracownikow(integer)    FUNCTION     �  CREATE FUNCTION "Stanowiska".ilosc_pracownikow(p_placowkaid integer DEFAULT NULL::integer) RETURNS numeric
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
   Stanowiska               postgres    false    13            %           1255    25154    pobierz_stanowiska()    FUNCTION     �  CREATE FUNCTION "Stanowiska".pobierz_stanowiska() RETURNS TABLE(id_stanowiska integer, nazwastanowiska character varying, minzarobki double precision, maxzarobki double precision, doswiadczenie character varying)
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
   Stanowiska               postgres    false    13            &           1255    25155    usunstanowisko(integer) 	   PROCEDURE     �   CREATE PROCEDURE "Stanowiska".usunstanowisko(IN p_id_stanowiska integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM stanowiska
    WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 H   DROP PROCEDURE "Stanowiska".usunstanowisko(IN p_id_stanowiska integer);
    
   Stanowiska               postgres    false    13            '           1255    25156 K   dodajzamowienie(double precision, character, character, boolean, character) 	   PROCEDURE     �  CREATE PROCEDURE "Zamowienia".dodajzamowienie(IN p_kwota double precision, IN p_pesel_klienta character, IN p_vin character, IN p_usluganaprawy boolean, IN p_pesel_pracownika character)
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
   Zamowienia               postgres    false    14            (           1255    25157 m   edytujzamowienie(integer, double precision, character varying, character varying, boolean, character varying) 	   PROCEDURE       CREATE PROCEDURE "Zamowienia".edytujzamowienie(IN p_iddozmiany integer, IN p_kwota double precision, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying)
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
   Zamowienia               postgres    false    14                       1255    25158    pobierz_zamowienia()    FUNCTION     �  CREATE FUNCTION "Zamowienia".pobierz_zamowienia() RETURNS TABLE(id_zamowienia integer, kwota double precision, pesel_klienta character, vin character, usluganaprawy boolean, pesel_pracownika character)
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
   Zamowienia               postgres    false    14            �            1255    25159 $   suma_kwoty_zamowien_usluga_naprawy()    FUNCTION     �  CREATE FUNCTION "Zamowienia".suma_kwoty_zamowien_usluga_naprawy() RETURNS double precision
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
   Zamowienia               postgres    false    14            �            1255    25160    usunzamowienie(integer) 	   PROCEDURE     �   CREATE PROCEDURE "Zamowienia".usunzamowienie(IN p_idzamowienia integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM zamowienia
    WHERE id_zamowienia = p_idzamowienia;
END;
$$;
 G   DROP PROCEDURE "Zamowienia".usunzamowienie(IN p_idzamowienia integer);
    
   Zamowienia               postgres    false    14            )           1255    25161 $   zamowienia_danego_klienta(character)    FUNCTION     �  CREATE FUNCTION "Zamowienia".zamowienia_danego_klienta(pesel character) RETURNS TABLE(id_zamowienia integer, kwota double precision, pesel_klienta character, vin character, usluganaprawy boolean, pesel_pracownika character)
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
   Zamowienia               postgres    false    14            *           1255    25162    sumazarobkow(integer)    FUNCTION     v  CREATE FUNCTION public.sumazarobkow(p_placowkaid integer DEFAULT NULL::integer) RETURNS numeric
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
       public               postgres    false            �            1259    25163    firmy    TABLE     n   CREATE TABLE public.firmy (
    nazwafirmy character varying(100) NOT NULL,
    nip character(10) NOT NULL
);
    DROP TABLE public.firmy;
       public         heap r       postgres    false            �            1259    25166    id_pracownika_seq    SEQUENCE     z   CREATE SEQUENCE public.id_pracownika_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.id_pracownika_seq;
       public               postgres    false            �            1259    25167    klienci    TABLE     �   CREATE TABLE public.klienci (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    nip character(10),
    telefon character varying(15) NOT NULL
);
    DROP TABLE public.klienci;
       public         heap r       postgres    false            �            1259    25170    placowki    TABLE     (  CREATE TABLE public.placowki (
    id_placowki integer NOT NULL,
    miasto character varying(50) NOT NULL,
    ulica character varying(100) NOT NULL,
    numerbudynku character varying(10) NOT NULL,
    iloscsamochodow integer DEFAULT 0 NOT NULL,
    iloscmiejscapozostalego integer NOT NULL
);
    DROP TABLE public.placowki;
       public         heap r       postgres    false            �            1259    25174    placowki_id_placowki_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_id_placowki_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.placowki_id_placowki_seq;
       public               postgres    false    227            L           0    0    placowki_id_placowki_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.placowki_id_placowki_seq OWNED BY public.placowki.id_placowki;
          public               postgres    false    228            �            1259    25175    placowki_id_seq    SEQUENCE     x   CREATE SEQUENCE public.placowki_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.placowki_id_seq;
       public               postgres    false            �            1259    25176    placowki_placowkaid_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_placowkaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.placowki_placowkaid_seq;
       public               postgres    false            �            1259    25177    podwykonawcy    TABLE     �   CREATE TABLE public.podwykonawcy (
    nippodwykonawcy character(10) NOT NULL,
    nazwa character varying(100) NOT NULL,
    specjalizacja character varying(50) NOT NULL
);
     DROP TABLE public.podwykonawcy;
       public         heap r       postgres    false            �            1259    25180 
   pracownicy    TABLE       CREATE TABLE public.pracownicy (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    stanowiskoid integer NOT NULL,
    placowkaid integer NOT NULL,
    zarobki double precision NOT NULL
);
    DROP TABLE public.pracownicy;
       public         heap r       postgres    false            �            1259    25183 	   samochody    TABLE     z  CREATE TABLE public.samochody (
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
       public         heap r       postgres    false            �            1259    25186    samochody_podwykonawcy    TABLE     {   CREATE TABLE public.samochody_podwykonawcy (
    vin character(17) NOT NULL,
    nippodwykonawcy character(10) NOT NULL
);
 *   DROP TABLE public.samochody_podwykonawcy;
       public         heap r       postgres    false            �            1259    25189 
   stanowiska    TABLE       CREATE TABLE public.stanowiska (
    id_stanowiska integer NOT NULL,
    nazwastanowiska character varying(100) NOT NULL,
    minzarobki double precision NOT NULL,
    maxzarobki double precision NOT NULL,
    doswiadczenie character varying(20) NOT NULL
);
    DROP TABLE public.stanowiska;
       public         heap r       postgres    false            �            1259    25192    stanowiska_id_stanowiska_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_id_stanowiska_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.stanowiska_id_stanowiska_seq;
       public               postgres    false    235            M           0    0    stanowiska_id_stanowiska_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.stanowiska_id_stanowiska_seq OWNED BY public.stanowiska.id_stanowiska;
          public               postgres    false    236            �            1259    25193    stanowiska_stanowiskoid_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_stanowiskoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.stanowiska_stanowiskoid_seq;
       public               postgres    false            �            1259    25194 
   zamowienia    TABLE       CREATE TABLE public.zamowienia (
    id_zamowienia integer NOT NULL,
    kwota double precision NOT NULL,
    pesel_klienta character(11) NOT NULL,
    vin character(17) NOT NULL,
    usluganaprawy boolean NOT NULL,
    pesel_pracownika character(11) NOT NULL
);
    DROP TABLE public.zamowienia;
       public         heap r       postgres    false            �            1259    25197    zamowienia_id_zamowienia_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_id_zamowienia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.zamowienia_id_zamowienia_seq;
       public               postgres    false    238            N           0    0    zamowienia_id_zamowienia_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.zamowienia_id_zamowienia_seq OWNED BY public.zamowienia.id_zamowienia;
          public               postgres    false    239            �            1259    25198    zamowienia_zamowienieid_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_zamowienieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.zamowienia_zamowienieid_seq;
       public               postgres    false            y           2604    25199    placowki id_placowki    DEFAULT     |   ALTER TABLE ONLY public.placowki ALTER COLUMN id_placowki SET DEFAULT nextval('public.placowki_id_placowki_seq'::regclass);
 C   ALTER TABLE public.placowki ALTER COLUMN id_placowki DROP DEFAULT;
       public               postgres    false    228    227            {           2604    25200    stanowiska id_stanowiska    DEFAULT     �   ALTER TABLE ONLY public.stanowiska ALTER COLUMN id_stanowiska SET DEFAULT nextval('public.stanowiska_id_stanowiska_seq'::regclass);
 G   ALTER TABLE public.stanowiska ALTER COLUMN id_stanowiska DROP DEFAULT;
       public               postgres    false    236    235            |           2604    25201    zamowienia id_zamowienia    DEFAULT     �   ALTER TABLE ONLY public.zamowienia ALTER COLUMN id_zamowienia SET DEFAULT nextval('public.zamowienia_id_zamowienia_seq'::regclass);
 G   ALTER TABLE public.zamowienia ALTER COLUMN id_zamowienia DROP DEFAULT;
       public               postgres    false    239    238            5          0    25163    firmy 
   TABLE DATA           0   COPY public.firmy (nazwafirmy, nip) FROM stdin;
    public               postgres    false    224   ��       7          0    25167    klienci 
   TABLE DATA           F   COPY public.klienci (pesel, imie, nazwisko, nip, telefon) FROM stdin;
    public               postgres    false    226   Y�       8          0    25170    placowki 
   TABLE DATA           v   COPY public.placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego) FROM stdin;
    public               postgres    false    227   ��       <          0    25177    podwykonawcy 
   TABLE DATA           M   COPY public.podwykonawcy (nippodwykonawcy, nazwa, specjalizacja) FROM stdin;
    public               postgres    false    231   �       =          0    25180 
   pracownicy 
   TABLE DATA           ^   COPY public.pracownicy (pesel, imie, nazwisko, stanowiskoid, placowkaid, zarobki) FROM stdin;
    public               postgres    false    232   ��       >          0    25183 	   samochody 
   TABLE DATA           i   COPY public.samochody (vin, marka, model, rocznik, silnik, skrzynia, stan, cena, placowkaid) FROM stdin;
    public               postgres    false    233   ��       ?          0    25186    samochody_podwykonawcy 
   TABLE DATA           F   COPY public.samochody_podwykonawcy (vin, nippodwykonawcy) FROM stdin;
    public               postgres    false    234   ��       @          0    25189 
   stanowiska 
   TABLE DATA           k   COPY public.stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie) FROM stdin;
    public               postgres    false    235   p�       C          0    25194 
   zamowienia 
   TABLE DATA           o   COPY public.zamowienia (id_zamowienia, kwota, pesel_klienta, vin, usluganaprawy, pesel_pracownika) FROM stdin;
    public               postgres    false    238   ?�       O           0    0    id_pracownika_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.id_pracownika_seq', 1, false);
          public               postgres    false    225            P           0    0    placowki_id_placowki_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.placowki_id_placowki_seq', 1, false);
          public               postgres    false    228            Q           0    0    placowki_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.placowki_id_seq', 7, true);
          public               postgres    false    229            R           0    0    placowki_placowkaid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.placowki_placowkaid_seq', 1, false);
          public               postgres    false    230            S           0    0    stanowiska_id_stanowiska_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.stanowiska_id_stanowiska_seq', 20, true);
          public               postgres    false    236            T           0    0    stanowiska_stanowiskoid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_stanowiskoid_seq', 1, false);
          public               postgres    false    237            U           0    0    zamowienia_id_zamowienia_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.zamowienia_id_zamowienia_seq', 34, true);
          public               postgres    false    239            V           0    0    zamowienia_zamowienieid_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.zamowienia_zamowienieid_seq', 1, true);
          public               postgres    false    240            ~           2606    25203    firmy firmy_nip_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_nip_key UNIQUE (nip);
 =   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_nip_key;
       public                 postgres    false    224            �           2606    25205    firmy firmy_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_pkey PRIMARY KEY (nazwafirmy);
 :   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_pkey;
       public                 postgres    false    224            �           2606    25207    klienci klienci_nip_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_key UNIQUE (nip);
 A   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_key;
       public                 postgres    false    226            �           2606    25209    klienci klienci_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (pesel);
 >   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_pkey;
       public                 postgres    false    226            �           2606    25211    placowki placowki_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.placowki
    ADD CONSTRAINT placowki_pkey PRIMARY KEY (id_placowki);
 @   ALTER TABLE ONLY public.placowki DROP CONSTRAINT placowki_pkey;
       public                 postgres    false    227            �           2606    25213    podwykonawcy podwykonawcy_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.podwykonawcy
    ADD CONSTRAINT podwykonawcy_pkey PRIMARY KEY (nippodwykonawcy);
 H   ALTER TABLE ONLY public.podwykonawcy DROP CONSTRAINT podwykonawcy_pkey;
       public                 postgres    false    231            �           2606    25215    pracownicy pracownicy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (pesel);
 D   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_pkey;
       public                 postgres    false    232            �           2606    25217    samochody samochody_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_pkey PRIMARY KEY (vin);
 B   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_pkey;
       public                 postgres    false    233            �           2606    25219 2   samochody_podwykonawcy samochody_podwykonawcy_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_pkey PRIMARY KEY (vin, nippodwykonawcy);
 \   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_pkey;
       public                 postgres    false    234    234            �           2606    25221    stanowiska stanowiska_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.stanowiska
    ADD CONSTRAINT stanowiska_pkey PRIMARY KEY (id_stanowiska);
 D   ALTER TABLE ONLY public.stanowiska DROP CONSTRAINT stanowiska_pkey;
       public                 postgres    false    235            �           2606    25223    zamowienia unique_vin 
   CONSTRAINT     O   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT unique_vin UNIQUE (vin);
 ?   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT unique_vin;
       public                 postgres    false    238            �           2606    25225    zamowienia zamowienia_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (id_zamowienia);
 D   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pkey;
       public                 postgres    false    238            �           2606    25227    zamowienia zamowienia_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_key UNIQUE (vin);
 G   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_key;
       public                 postgres    false    238            �           2620    25292 !   samochody before_insert_samochody    TRIGGER     �   CREATE TRIGGER before_insert_samochody BEFORE INSERT ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki".check_iloscmiejscapozostalego();
 :   DROP TRIGGER before_insert_samochody ON public.samochody;
       public               postgres    false    263    233            �           2620    25228     samochody dekrementacjaliczbyaut    TRIGGER     �   CREATE TRIGGER dekrementacjaliczbyaut AFTER DELETE ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki".dekremetacjaliczbyaut();
 9   DROP TRIGGER dekrementacjaliczbyaut ON public.samochody;
       public               postgres    false    250    233            �           2620    25229 (   samochody dekremetacjamiejscapozostalego    TRIGGER     �   CREATE TRIGGER dekremetacjamiejscapozostalego AFTER DELETE ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki".dekrementacjamiejscapozostalego();
 A   DROP TRIGGER dekremetacjamiejscapozostalego ON public.samochody;
       public               postgres    false    233    249            �           2620    25230 '   samochody trigger_aktualizacjaliczbyaut    TRIGGER     �   CREATE TRIGGER trigger_aktualizacjaliczbyaut AFTER INSERT ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki"."inkremetacjaLiczbyAut"();
 @   DROP TRIGGER trigger_aktualizacjaliczbyaut ON public.samochody;
       public               postgres    false    233    255            �           2620    25231 6   samochody trigger_aktualizacjaliczbymiejscapozostalego    TRIGGER     �   CREATE TRIGGER trigger_aktualizacjaliczbymiejscapozostalego AFTER INSERT ON public.samochody FOR EACH ROW EXECUTE FUNCTION "Placowki"."inkremetacjaMiejscaPozostalego"();
 O   DROP TRIGGER trigger_aktualizacjaliczbymiejscapozostalego ON public.samochody;
       public               postgres    false    233    256            �           2606    25232    klienci fk_klienci_firmy    FK CONSTRAINT     t   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT fk_klienci_firmy FOREIGN KEY (nip) REFERENCES public.firmy(nip);
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT fk_klienci_firmy;
       public               postgres    false    224    4734    226            �           2606    25237    klienci klienci_nip_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_fkey FOREIGN KEY (nip) REFERENCES public.firmy(nip) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_fkey;
       public               postgres    false    226    4734    224            �           2606    25242 %   pracownicy pracownicy_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_placowkaid_fkey;
       public               postgres    false    227    4742    232            �           2606    25247 '   pracownicy pracownicy_stanowiskoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_stanowiskoid_fkey FOREIGN KEY (stanowiskoid) REFERENCES public.stanowiska(id_stanowiska) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_stanowiskoid_fkey;
       public               postgres    false    4752    235    232            �           2606    25252 #   samochody samochody_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_placowkaid_fkey;
       public               postgres    false    4742    233    227            �           2606    25257 B   samochody_podwykonawcy samochody_podwykonawcy_nippodwykonawcy_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey FOREIGN KEY (nippodwykonawcy) REFERENCES public.podwykonawcy(nippodwykonawcy) ON DELETE SET NULL;
 l   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey;
       public               postgres    false    234    231    4744            �           2606    25262 6   samochody_podwykonawcy samochody_podwykonawcy_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_vin_fkey;
       public               postgres    false    4748    234    233            �           2606    25267 (   zamowienia zamowienia_pesel_klienta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_klienta_fkey FOREIGN KEY (pesel_klienta) REFERENCES public.klienci(pesel) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_klienta_fkey;
       public               postgres    false    226    238    4740            �           2606    25272 +   zamowienia zamowienia_pesel_pracownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_pracownika_fkey FOREIGN KEY (pesel_pracownika) REFERENCES public.pracownicy(pesel) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_pracownika_fkey;
       public               postgres    false    238    4746    232            �           2606    25277    zamowienia zamowienia_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_fkey;
       public               postgres    false    4748    238    233            5   p   x�%�;
�@ �z�0���~�0���Yt�-døJ����{n�ti�,����|�����1xG�h�`Wj�Y�<2(��1��Gx����+9�}1b�e��w�43��u��@�\�      7   &  x�-�An�0E���T��^���D]T�Te3!�uM@� v�z���^l��`����13̲��
v]GP�3��'g�6A!�7as�'�pp���pd5�T�ȳM�Xa,��K�]������Ȣ�<�`�E ��˝s��-k9\�_�R̤L�Q�~��a橙����?XD�\X�M�᥿Ҹ�#�EU�*�(���OgxsM�֟�;P��y�e"5#�{�vm�G�ox����9z�ck��T��-����u��z��^b)��~M�a������z���$iT*qzB�H�t�      8   o   x�3�/�O>ڔX�����tvr&���)��)�gPUjqU~9�w~qe^fj����@	NNC3.sN��l�dpU6Pk"��9��1�\�GjInb^qv"�D3N�=... Y"      <   �   x�E�=�0�='0|�Fcd����6Ҁ��%F�%<����^BL`}y����1KRm[#�]ÕAGhX����,NS���2��@��V����pk�Bھ(q�aB):�*��jY�9Ѝ�>��0�q�X��):H#���WD��ލ^.�u��3e��t���4�\܍���� �aNt      =   �  x�M�An�0Eד�RɥA�:(��n[I�" ��]��=F���^�!����?��	�Q�Bê�<\��7� �B\X'$J](�p�;��� �IR��I��.I��}l��	��]���񀖥��YQ�)5|q���p��� �t��pd�4�	�z�/��]����lϡ0(�}	W�6$�a˗:Ҙ�)�E�;���8�c���ח�m�M�t�i���K-����0Ӝ��n�CY��.T\bF+?z�J;WS�c���� -�Uyꏸ�����>oBK�Re���tVm��n�3�x�rE�腣�j���?�=o�#�K�B(,����mM�vȀp�E���
V;���Hh���B[�)�Rh���pMk3�ZE�g�D�s�}hx�T��|l89�t�,��}=|��{����Z��r�x�JJ�$-�V�d��OEѿ��tJ�d�qI�԰�1��+?�~i�\�2B
d���_�C��%Q��u���?���!�B� !�_ʮ�!��q����������m�e�K����Q����<Б��'��0r�W�>��ח~�H��&����y��uK`cOO�b(T�&����q���$���DN�\�3�*�yX�/�K��o��&v�����a ����ը��0��?�Ϛ�aB�cH� ԍ�pˏՒ"��p��^|�w��x�O�A:��Թ>�a���Wzt�Ϋ�X��o��?�٘"��q�6��J��eJ�f��ǯ� c�eR      >   �  x����r�@���S����e� Q�R�p��ti��B ���l����n2:&qvh�W?��΁�؏da� Z *�=l�+�=@&4��'��m!�o������0/�Z��i����[���B�9�E	��vb/� ��s~<*xhF�8���b��6�N�ԙB��b�>�(�#��b^4<��߿�7^��F
b�z�盔8d!
��Lv��P,���y�Q��y�&	�#;�;Ԧ̟�o� 
0u�%�t$����w"tt�4d�u��B���U*�+I��ɩ'h,�,a(ͨ�iƋ�`Q��
,xqݳdZ�V���f9�#?��'޺��m���)�����	a0���;q�`=ҐP)5m�,h��8��"�e뷜�!KI��o�����S�gr��Je�U���6�����7J,��	�R����L����t�]0�Q�Ve.j�⏥�D��F0�);�f��m;&�/��_�m�a��Q�}�����4J�}]e��g3��~��]��-\�N�R�)�piճ(�8y��/{�g��:��\���0�n��5qU��d���j�[ҋ�sM�TOK/<�=6��,EQW���[+�,]�6���w��ts�m),K7��0	i0%���gR�?��4���'ɺ +�U��c(��W �3X�d�ӊ#S2�/���ٱv�D�k����7X�����}k�Hw�7!��^�ZA�݃h��%�Q4|q�>i���a e���      ?   �   x�m�A� E�r��a`��X�Ņ	Ր��mm���߾�2�aH>��:�^�"� H����x�],:�PA�L�F�B	�gpE��.}M"����Y�u`�p���z�g�o�0����6���|v� �}B�U��)k���ʑ�Ք�}\�OՐEd      @   �   x�M���0��ۧ�	Lˏ���.7�`�SJ�����(�ek�a9C��/��.�7!�"����&�PZ�
!���F)k�"�=��
!v��te1R�nl�
�Y�� u�Q�\x{���h[ޛ�)���<�V��
��^~^M7N�8�m��]&�ޥ=*8���|S	)&-��gɆ^v��/]�M�      C   ?  x�m��n�@���a*��}\A�!*%E=�	���.��E{���g�!
"�F$$bq�����|(� W��J�1xW� ��`����χ]C;�ГfD�b����G�����_C�п���Dޤ������յ���F� oV*@��E44+���%�>.����Q<mc~�z?�#�z��]�a Gh+V����j��Au+<^x�G��A��U����(�t6)S$��p}�!��|������ -�����QB {>or�Q���$5��_�.��9��Pϝ����e����F���%���H)�L�����_k���     