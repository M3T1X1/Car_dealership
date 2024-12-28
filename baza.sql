PGDMP  *    6                |         	   autoKomis    16.3    16.3 p    7           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            8           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            9           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            :           1262    16441 	   autoKomis    DATABASE     ~   CREATE DATABASE "autoKomis" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE "autoKomis";
                postgres    false            ;           0    0    DATABASE "autoKomis"    COMMENT     G   COMMENT ON DATABASE "autoKomis" IS 'Projekt na bazy danych semestr 3';
                   postgres    false    4922            �            1255    24694 !   dekrementacjamiejscapozostalego()    FUNCTION     �   CREATE FUNCTION public.dekrementacjamiejscapozostalego() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE placowki
SET iloscmiejscapozostalego = iloscmiejscapozostalego + 1
WHERE id_placowki = OLD.placowkaid;
RETURN OLD;
END;
$$;
 8   DROP FUNCTION public.dekrementacjamiejscapozostalego();
       public          postgres    false            �            1255    24691    dekremetacjaliczbyaut()    FUNCTION     �   CREATE FUNCTION public.dekremetacjaliczbyaut() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE placowki
SET iloscsamochodow = iloscsamochodow -1
WHERE id_placowki = OLD.placowkaid;
RETURN OLD;
END;
$$;
 .   DROP FUNCTION public.dekremetacjaliczbyaut();
       public          postgres    false            �            1255    24655 0   dodajfirme(character varying, character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.dodajfirme(IN p_nazwafirmy character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO firmy (nazwaFirmy, nip)
VALUES (p_nazwaFirmy, p_nip);
END;
$$;
 a   DROP PROCEDURE public.dodajfirme(IN p_nazwafirmy character varying, IN p_nip character varying);
       public          postgres    false            �            1255    24656 k   dodajklienta(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     v  CREATE PROCEDURE public.dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO klienci (pesel,imie,nazwisko,nip,telefon)
VALUES (p_pesel,p_imie,p_nazwisko,p_nip,p_telefon);
END;
$$;
 �   DROP PROCEDURE public.dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       public          postgres    false            �            1255    24640 E   dodajplacowke(character varying, character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego)
    VALUES (nextval('placowki_id_seq'), p_miasto, p_ulica, p_numerbudynku, 0, p_iloscmiejscapozostalego);
END;
$$;
 �   DROP PROCEDURE public.dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer);
       public          postgres    false            �            1255    24657 J   dodajpodwykonawce(character varying, character varying, character varying) 	   PROCEDURE     =  CREATE PROCEDURE public.dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO podwykonawcy (nippodwykonawcy, nazwa, specjalizacja)
VALUES (p_nippodwykonawcy, p_nazwa, p_specjalizacja); 
END;
$$;
 �   DROP PROCEDURE public.dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       public          postgres    false            �            1255    24658 l   dodajpracownika(character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO pracownicy(pesel,imie,nazwisko,stanowiskoid,placowkaid,zarobki)
VALUES (p_pesel,p_imie,p_nazwisko,p_stanowiskoid,p_placowkaid,p_zarobki);
END;
$$;
 �   DROP PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
       public          postgres    false            �            1255    24659 �   dodajsamochod(character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO samochody (vin,marka,model,rocznik,silnik,skrzynia,stan,cena,placowkaid)
VALUES (p_vin,p_marka,p_model,p_rocznik,p_silnik,p_skrzynia,p_stan,p_cena,p_placowkaid);
END;
$$;
   DROP PROCEDURE public.dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer);
       public          postgres    false            �            1255    24644 G   dodajstanowisko(character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie)
VALUES (nextval('stanowiska_id_stanowiska_seq'),p_nazwastanowiska,p_minzarobki,p_maxzarobki,p_doswiadczenie);
END;
$$;
 �   DROP PROCEDURE public.dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying);
       public          postgres    false                       1255    24660 Z   dodajzamowienie(numeric, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajzamowienie(IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO zamowienia (zamowienieid, kwota,pesel,vin,usluganaprawy,pesel_pracownika)
VALUES (nextval('zamowienia_zamowienieid_seq'),p_kwota,p_pesel,p_vin,p_usluganaprawy,p_pesel_pracownika);
END;
$$;
 �   DROP PROCEDURE public.dodajzamowienie(IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying);
       public          postgres    false            �            1255    24652 Q   edytujStanowisko(integer, character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public."edytujStanowisko"(IN p_id_staonwiska integer, IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE stanowiska
SET nazwastanoiwksa = p_nazwastanowiska, minzarobki=p_minzarobki, maxzarobki=p_maxzarobki, doswiadczenie=p_doswiadczenie
WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 �   DROP PROCEDURE public."edytujStanowisko"(IN p_id_staonwiska integer, IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying);
       public          postgres    false                       1255    24661 D   edytujfirme(character varying, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE public.edytujfirme(IN p_nazwafirmydozmiany character varying, IN p_nazwafirmy character varying, IN p_nip character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE firmy
SET nazwaFirmy = p_nazwaFirmy, nip = p_nip
WHERE nazwaFirmy = p_nazwaFirmyDoZmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujfirme(IN p_nazwafirmydozmiany character varying, IN p_nazwafirmy character varying, IN p_nip character varying);
       public          postgres    false                       1255    24662    edytujklienta(character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE klienci
SET pesel=p_pesel,imie=p_imie,nazwisko=p_nazwisko,telefon=p_telefon,nip=p_nip
WHERE pesel = p_peseldozmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       public          postgres    false            �            1255    24643 X   edytujplacowke(integer, character varying, character varying, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujplacowke(IN p_id_placowki integer, IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscsamochodow integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE placowki
	SET miasto = p_miasto, ulica = p_ulica, numerbudynku = p_numerbudynku, iloscsamochodow = p_iloscsamochodow, iloscmiejscawolnego = p_iloscmiejscapozostalego
	WHERE id_placowki = p_id_placowki;
END;
$$;
 �   DROP PROCEDURE public.edytujplacowke(IN p_id_placowki integer, IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscsamochodow integer, IN p_iloscmiejscapozostalego integer);
       public          postgres    false                       1255    24663 ^   edytujpodwykonawce(character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE podwykonawcy 
SET nippodwykonawcy = p_nippodwykonawcy, nazwa = p_nazwa, specjalizacja = p_specjalizacja
WHERE nippodwykonawcy = p_nipdozmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       public          postgres    false            �            1255    16544 �   edytujpracownika(character varying, character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE pracownicy
SET pesel=p_pesel, imie = p_imie, nazwisko = p_nazwisko, stanowiskoid = p_stanowiskoid, placowkaid = p_placowkaid, zarobki = p_zarobki
WHERE pesel = p_peselDoZmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
       public          postgres    false                       1255    24664 �   edytujsamochod(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     J  CREATE PROCEDURE public.edytujsamochod(IN p_vindozmiany character varying, IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE samochody 
SET vin = p_vin, marka = p_marka, model = p_model, rocznik = p_rocznik, silnik = p_silnik, 
	skrzynia = p_skrzynia, stan = p_stan, cena = p_cena, placowkaid = p_placowkaid
WHERE vin = p_vindozmiany;
END;
$$;
 A  DROP PROCEDURE public.edytujsamochod(IN p_vindozmiany character varying, IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer);
       public          postgres    false                       1255    24686 c   edytujstanowisko(integer, character varying, double precision, double precision, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujstanowisko(IN p_id_stanowiska integer, IN p_nazwa character varying, IN p_min_zarobki double precision, IN p_max_zarobki double precision, IN p_doswiadczenie character varying)
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
 �   DROP PROCEDURE public.edytujstanowisko(IN p_id_stanowiska integer, IN p_nazwa character varying, IN p_min_zarobki double precision, IN p_max_zarobki double precision, IN p_doswiadczenie character varying);
       public          postgres    false            	           1255    24665 d   edytujzamowienie(integer, numeric, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujzamowienie(IN p_iddozmiany integer, IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE zamowienia
SET kwota = p_kwota, pesel = p_pesel, vin = p_vin, usluganaprawy = p_usluganaprawy, pesel_pracownika = p_pesel_pracownika
WHERE idzamowienia = p_iddozmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujzamowienie(IN p_iddozmiany integer, IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying);
       public          postgres    false                       1255    24684    iloscstanowisk(integer)    FUNCTION     �  CREATE FUNCTION public.iloscstanowisk(p_placowkaid integer DEFAULT NULL::integer) RETURNS numeric
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
 ;   DROP FUNCTION public.iloscstanowisk(p_placowkaid integer);
       public          postgres    false            �            1255    24679    inkremetacjaLiczbyAut()    FUNCTION     �   CREATE FUNCTION public."inkremetacjaLiczbyAut"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE placowki
SET iloscsamochodow = iloscsamochodow+1
WHERE id_placowki = NEW.placowkaid;
RETURN NEW;
END;
$$;
 0   DROP FUNCTION public."inkremetacjaLiczbyAut"();
       public          postgres    false            �            1255    24682     inkremetacjaMiejscaPozostalego()    FUNCTION     �   CREATE FUNCTION public."inkremetacjaMiejscaPozostalego"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE placowki
SET iloscmiejscapozostalego = iloscmiejscapozostalego - 1
WHERE id_placowki = NEW.placowkaid;

RETURN NEW;
END;
$$;
 9   DROP FUNCTION public."inkremetacjaMiejscaPozostalego"();
       public          postgres    false            
           1255    24666    pobierz_firmy()    FUNCTION     �   CREATE FUNCTION public.pobierz_firmy() RETURNS TABLE(nazwafirmy character varying, nip character)
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
 &   DROP FUNCTION public.pobierz_firmy();
       public          postgres    false                       1255    24667    pobierz_klienci()    FUNCTION     S  CREATE FUNCTION public.pobierz_klienci() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, nip character, telefon character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        k.pesel,
        k.imie,
        k.nazwisko,
        k.nip,
        k.telefon
    FROM klienci k;
END;
$$;
 (   DROP FUNCTION public.pobierz_klienci();
       public          postgres    false                       1255    24668    pobierz_placowki()    FUNCTION     �  CREATE FUNCTION public.pobierz_placowki() RETURNS TABLE(placowkaid integer, miasto character varying, ulica character varying, numerbudynku integer, iloscsamochodow integer, iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.placowkaid,
        p.miasto,
        p.ulica,
        p.numerbudynku,
        p.iloscsamochodow,
        p.iloscmiejscapozostalego
    FROM placowki p;
END;
$$;
 )   DROP FUNCTION public.pobierz_placowki();
       public          postgres    false                       1255    24669    pobierz_podwykonawcy()    FUNCTION     9  CREATE FUNCTION public.pobierz_podwykonawcy() RETURNS TABLE(nippodwykonawcy character, nazwa character varying, specjalizacja character varying)
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
 -   DROP FUNCTION public.pobierz_podwykonawcy();
       public          postgres    false                       1255    24670    pobierz_pracownicy()    FUNCTION     �  CREATE FUNCTION public.pobierz_pracownicy() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, stanowiskoid integer, placowkaid integer, zarobki numeric)
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
        p.zarobki
    FROM pracownicy p;
END;
$$;
 +   DROP FUNCTION public.pobierz_pracownicy();
       public          postgres    false                       1255    24671    pobierz_samochody()    FUNCTION     �  CREATE FUNCTION public.pobierz_samochody() RETURNS TABLE(vin character, marka character varying, model character varying, rocznik integer, silnik character varying, skrzynia character varying, stan character varying, cena numeric, placowkaid integer)
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
        s.cena,
        s.placowkaid
    FROM samochody s;
END;
$$;
 *   DROP FUNCTION public.pobierz_samochody();
       public          postgres    false                       1255    24672    pobierz_stanowiska()    FUNCTION     �  CREATE FUNCTION public.pobierz_stanowiska() RETURNS TABLE(stanowiskoid integer, nazwastanowiska character varying, minzarobki numeric, maxzarobki numeric, doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.stanowiskoid,
        s.nazwastanowiska,
        s.minzarobki,
        s.maxzarobki,
        s.doswiadczenie
    FROM stanowiska s;
END;
$$;
 +   DROP FUNCTION public.pobierz_stanowiska();
       public          postgres    false                       1255    24673    pobierz_zamowienia()    FUNCTION     �  CREATE FUNCTION public.pobierz_zamowienia() RETURNS TABLE(zamowienieid integer, kwota numeric, pesel character, vin character, usluganaprawy boolean, pesel_pracownika character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        z.zamowienieid,
        z.kwota,
        z.pesel,
        z.vin,
        z.usluganaprawy,
        z.pesel_pracownika
    FROM zamowienia z;
END;
$$;
 +   DROP FUNCTION public.pobierz_zamowienia();
       public          postgres    false                       1255    24685    sumazarobkow(integer)    FUNCTION     v  CREATE FUNCTION public.sumazarobkow(p_placowkaid integer DEFAULT NULL::integer) RETURNS numeric
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
       public          postgres    false            �            1255    24648    usunStanowisko(integer) 	   PROCEDURE     �   CREATE PROCEDURE public."usunStanowisko"(IN p_id_stanowiska integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROm stanowiska
WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 D   DROP PROCEDURE public."usunStanowisko"(IN p_id_stanowiska integer);
       public          postgres    false                       1255    24674    usunfirme(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunfirme(IN p_nazwafirmy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
DELETE FROM firmy
WHERE nazwaFirmy = p_nazwaFirmy;
END;
$$;
 D   DROP PROCEDURE public.usunfirme(IN p_nazwafirmy character varying);
       public          postgres    false                       1255    24675    usunklienta(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunklienta(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM klienci
	WHERE pesel = p_pesel;
END;
$$;
 A   DROP PROCEDURE public.usunklienta(IN p_pesel character varying);
       public          postgres    false            �            1255    24637    usunplacowke(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.usunplacowke(IN p_id_placowki integer)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
    DELETE FROM placowki 
	WHERE id_placowki=p_id_placowki;
END;
$$;
 >   DROP PROCEDURE public.usunplacowke(IN p_id_placowki integer);
       public          postgres    false                       1255    24676 #   usunpodwykonawce(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunpodwykonawce(IN p_nippodwykonawcy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM podwykonawcy
WHERE nippodwykonawcy = p_nippodwykonawcy;
END;
$$;
 P   DROP PROCEDURE public.usunpodwykonawce(IN p_nippodwykonawcy character varying);
       public          postgres    false            �            1255    16545 !   usunpracownika(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunpracownika(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
DELETE FROM pracownicy
WHERE pesel = p_pesel;
END;
$$;
 D   DROP PROCEDURE public.usunpracownika(IN p_pesel character varying);
       public          postgres    false                       1255    24677    usunsamochod(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunsamochod(IN p_vin character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM samochody
WHERE vin = p_vin;
END;
$$;
 @   DROP PROCEDURE public.usunsamochod(IN p_vin character varying);
       public          postgres    false                       1255    24687    usunstanowisko(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.usunstanowisko(IN p_id_stanowiska integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM stanowiska
    WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 B   DROP PROCEDURE public.usunstanowisko(IN p_id_stanowiska integer);
       public          postgres    false                       1255    24678    usunzamowienie(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.usunzamowienie(IN p_idzamowienia integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM zamowienia
WHERE idzamowienia = p_idzamowienia;
END;
$$;
 A   DROP PROCEDURE public.usunzamowienie(IN p_idzamowienia integer);
       public          postgres    false            �            1259    16482    firmy    TABLE     n   CREATE TABLE public.firmy (
    nazwafirmy character varying(100) NOT NULL,
    nip character(10) NOT NULL
);
    DROP TABLE public.firmy;
       public         heap    postgres    false            �            1259    24641    id_pracownika_seq    SEQUENCE     z   CREATE SEQUENCE public.id_pracownika_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.id_pracownika_seq;
       public          postgres    false            �            1259    16489    klienci    TABLE     �   CREATE TABLE public.klienci (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    nip character(10),
    telefon character varying(15) NOT NULL
);
    DROP TABLE public.klienci;
       public         heap    postgres    false            �            1259    16450    placowki    TABLE     (  CREATE TABLE public.placowki (
    id_placowki integer NOT NULL,
    miasto character varying(50) NOT NULL,
    ulica character varying(100) NOT NULL,
    numerbudynku character varying(10) NOT NULL,
    iloscsamochodow integer DEFAULT 0 NOT NULL,
    iloscmiejscapozostalego integer NOT NULL
);
    DROP TABLE public.placowki;
       public         heap    postgres    false            �            1259    16449    placowki_id_placowki_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_id_placowki_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.placowki_id_placowki_seq;
       public          postgres    false    218            <           0    0    placowki_id_placowki_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.placowki_id_placowki_seq OWNED BY public.placowki.id_placowki;
          public          postgres    false    217            �            1259    24639    placowki_id_seq    SEQUENCE     x   CREATE SEQUENCE public.placowki_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.placowki_id_seq;
       public          postgres    false            �            1259    16546    placowki_placowkaid_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_placowkaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.placowki_placowkaid_seq;
       public          postgres    false            �            1259    16499    podwykonawcy    TABLE     �   CREATE TABLE public.podwykonawcy (
    nippodwykonawcy character(10) NOT NULL,
    nazwa character varying(100) NOT NULL,
    specjalizacja character varying(50) NOT NULL
);
     DROP TABLE public.podwykonawcy;
       public         heap    postgres    false            �            1259    16457 
   pracownicy    TABLE       CREATE TABLE public.pracownicy (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    stanowiskoid integer NOT NULL,
    placowkaid integer NOT NULL,
    zarobki double precision NOT NULL
);
    DROP TABLE public.pracownicy;
       public         heap    postgres    false            �            1259    16472 	   samochody    TABLE     z  CREATE TABLE public.samochody (
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
       public         heap    postgres    false            �            1259    16528    samochody_podwykonawcy    TABLE     {   CREATE TABLE public.samochody_podwykonawcy (
    vin character(17) NOT NULL,
    nippodwykonawcy character(10) NOT NULL
);
 *   DROP TABLE public.samochody_podwykonawcy;
       public         heap    postgres    false            �            1259    16443 
   stanowiska    TABLE       CREATE TABLE public.stanowiska (
    id_stanowiska integer NOT NULL,
    nazwastanowiska character varying(100) NOT NULL,
    minzarobki double precision NOT NULL,
    maxzarobki double precision NOT NULL,
    doswiadczenie character varying(20) NOT NULL
);
    DROP TABLE public.stanowiska;
       public         heap    postgres    false            �            1259    16442    stanowiska_id_stanowiska_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_id_stanowiska_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.stanowiska_id_stanowiska_seq;
       public          postgres    false    216            =           0    0    stanowiska_id_stanowiska_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.stanowiska_id_stanowiska_seq OWNED BY public.stanowiska.id_stanowiska;
          public          postgres    false    215            �            1259    16547    stanowiska_stanowiskoid_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_stanowiskoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.stanowiska_stanowiskoid_seq;
       public          postgres    false            �            1259    16505 
   zamowienia    TABLE       CREATE TABLE public.zamowienia (
    id_zamowienia integer NOT NULL,
    kwota double precision NOT NULL,
    pesel_klienta character(11) NOT NULL,
    vin character(17) NOT NULL,
    usluganaprawy boolean NOT NULL,
    pesel_pracownika character(11) NOT NULL
);
    DROP TABLE public.zamowienia;
       public         heap    postgres    false            �            1259    16504    zamowienia_id_zamowienia_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_id_zamowienia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.zamowienia_id_zamowienia_seq;
       public          postgres    false    225            >           0    0    zamowienia_id_zamowienia_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.zamowienia_id_zamowienia_seq OWNED BY public.zamowienia.id_zamowienia;
          public          postgres    false    224            �            1259    16548    zamowienia_zamowienieid_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_zamowienieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.zamowienia_zamowienieid_seq;
       public          postgres    false            j           2604    24688    placowki id_placowki    DEFAULT     |   ALTER TABLE ONLY public.placowki ALTER COLUMN id_placowki SET DEFAULT nextval('public.placowki_id_placowki_seq'::regclass);
 C   ALTER TABLE public.placowki ALTER COLUMN id_placowki DROP DEFAULT;
       public          postgres    false    218    217    218            i           2604    24689    stanowiska id_stanowiska    DEFAULT     �   ALTER TABLE ONLY public.stanowiska ALTER COLUMN id_stanowiska SET DEFAULT nextval('public.stanowiska_id_stanowiska_seq'::regclass);
 G   ALTER TABLE public.stanowiska ALTER COLUMN id_stanowiska DROP DEFAULT;
       public          postgres    false    215    216    216            l           2604    24690    zamowienia id_zamowienia    DEFAULT     �   ALTER TABLE ONLY public.zamowienia ALTER COLUMN id_zamowienia SET DEFAULT nextval('public.zamowienia_id_zamowienia_seq'::regclass);
 G   ALTER TABLE public.zamowienia ALTER COLUMN id_zamowienia DROP DEFAULT;
       public          postgres    false    224    225    225            *          0    16482    firmy 
   TABLE DATA           0   COPY public.firmy (nazwafirmy, nip) FROM stdin;
    public          postgres    false    221   B�       +          0    16489    klienci 
   TABLE DATA           F   COPY public.klienci (pesel, imie, nazwisko, nip, telefon) FROM stdin;
    public          postgres    false    222   ��       '          0    16450    placowki 
   TABLE DATA           v   COPY public.placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego) FROM stdin;
    public          postgres    false    218   ]�       ,          0    16499    podwykonawcy 
   TABLE DATA           M   COPY public.podwykonawcy (nippodwykonawcy, nazwa, specjalizacja) FROM stdin;
    public          postgres    false    223   ��       (          0    16457 
   pracownicy 
   TABLE DATA           ^   COPY public.pracownicy (pesel, imie, nazwisko, stanowiskoid, placowkaid, zarobki) FROM stdin;
    public          postgres    false    219   ��       )          0    16472 	   samochody 
   TABLE DATA           i   COPY public.samochody (vin, marka, model, rocznik, silnik, skrzynia, stan, cena, placowkaid) FROM stdin;
    public          postgres    false    220   ޾       /          0    16528    samochody_podwykonawcy 
   TABLE DATA           F   COPY public.samochody_podwykonawcy (vin, nippodwykonawcy) FROM stdin;
    public          postgres    false    226   L�       %          0    16443 
   stanowiska 
   TABLE DATA           k   COPY public.stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie) FROM stdin;
    public          postgres    false    216   i�       .          0    16505 
   zamowienia 
   TABLE DATA           o   COPY public.zamowienia (id_zamowienia, kwota, pesel_klienta, vin, usluganaprawy, pesel_pracownika) FROM stdin;
    public          postgres    false    225   ��       ?           0    0    id_pracownika_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.id_pracownika_seq', 1, false);
          public          postgres    false    231            @           0    0    placowki_id_placowki_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.placowki_id_placowki_seq', 1, false);
          public          postgres    false    217            A           0    0    placowki_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.placowki_id_seq', 5, true);
          public          postgres    false    230            B           0    0    placowki_placowkaid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.placowki_placowkaid_seq', 1, false);
          public          postgres    false    227            C           0    0    stanowiska_id_stanowiska_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.stanowiska_id_stanowiska_seq', 11, true);
          public          postgres    false    215            D           0    0    stanowiska_stanowiskoid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_stanowiskoid_seq', 1, false);
          public          postgres    false    228            E           0    0    zamowienia_id_zamowienia_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.zamowienia_id_zamowienia_seq', 1, false);
          public          postgres    false    224            F           0    0    zamowienia_zamowienieid_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.zamowienia_zamowienieid_seq', 1, true);
          public          postgres    false    229            v           2606    16488    firmy firmy_nip_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_nip_key UNIQUE (nip);
 =   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_nip_key;
       public            postgres    false    221            x           2606    16486    firmy firmy_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_pkey PRIMARY KEY (nazwafirmy);
 :   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_pkey;
       public            postgres    false    221            z           2606    16550    klienci klienci_nip_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_key UNIQUE (nip);
 A   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_key;
       public            postgres    false    222            |           2606    16493    klienci klienci_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (pesel);
 >   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_pkey;
       public            postgres    false    222            p           2606    16456    placowki placowki_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.placowki
    ADD CONSTRAINT placowki_pkey PRIMARY KEY (id_placowki);
 @   ALTER TABLE ONLY public.placowki DROP CONSTRAINT placowki_pkey;
       public            postgres    false    218            ~           2606    16503    podwykonawcy podwykonawcy_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.podwykonawcy
    ADD CONSTRAINT podwykonawcy_pkey PRIMARY KEY (nippodwykonawcy);
 H   ALTER TABLE ONLY public.podwykonawcy DROP CONSTRAINT podwykonawcy_pkey;
       public            postgres    false    223            r           2606    16461    pracownicy pracownicy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (pesel);
 D   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_pkey;
       public            postgres    false    219            t           2606    16476    samochody samochody_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_pkey PRIMARY KEY (vin);
 B   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_pkey;
       public            postgres    false    220            �           2606    16532 2   samochody_podwykonawcy samochody_podwykonawcy_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_pkey PRIMARY KEY (vin, nippodwykonawcy);
 \   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_pkey;
       public            postgres    false    226    226            n           2606    16448    stanowiska stanowiska_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.stanowiska
    ADD CONSTRAINT stanowiska_pkey PRIMARY KEY (id_stanowiska);
 D   ALTER TABLE ONLY public.stanowiska DROP CONSTRAINT stanowiska_pkey;
       public            postgres    false    216            �           2606    16512    zamowienia unique_vin 
   CONSTRAINT     O   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT unique_vin UNIQUE (vin);
 ?   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT unique_vin;
       public            postgres    false    225            �           2606    16510    zamowienia zamowienia_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (id_zamowienia);
 D   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pkey;
       public            postgres    false    225            �           2606    16552    zamowienia zamowienia_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_key UNIQUE (vin);
 G   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_key;
       public            postgres    false    225            �           2620    24692     samochody dekrementacjaliczbyaut    TRIGGER     �   CREATE TRIGGER dekrementacjaliczbyaut AFTER DELETE ON public.samochody FOR EACH ROW EXECUTE FUNCTION public.dekremetacjaliczbyaut();
 9   DROP TRIGGER dekrementacjaliczbyaut ON public.samochody;
       public          postgres    false    243    220            �           2620    24695 (   samochody dekremetacjamiejscapozostalego    TRIGGER     �   CREATE TRIGGER dekremetacjamiejscapozostalego AFTER DELETE ON public.samochody FOR EACH ROW EXECUTE FUNCTION public.dekrementacjamiejscapozostalego();
 A   DROP TRIGGER dekremetacjamiejscapozostalego ON public.samochody;
       public          postgres    false    220    245            �           2620    24680 '   samochody trigger_aktualizacjaliczbyaut    TRIGGER     �   CREATE TRIGGER trigger_aktualizacjaliczbyaut AFTER INSERT ON public.samochody FOR EACH ROW EXECUTE FUNCTION public."inkremetacjaLiczbyAut"();
 @   DROP TRIGGER trigger_aktualizacjaliczbyaut ON public.samochody;
       public          postgres    false    241    220            �           2620    24683 6   samochody trigger_aktualizacjaliczbymiejscapozostalego    TRIGGER     �   CREATE TRIGGER trigger_aktualizacjaliczbymiejscapozostalego AFTER INSERT ON public.samochody FOR EACH ROW EXECUTE FUNCTION public."inkremetacjaMiejscaPozostalego"();
 O   DROP TRIGGER trigger_aktualizacjaliczbymiejscapozostalego ON public.samochody;
       public          postgres    false    242    220            �           2606    16553    klienci fk_klienci_firmy    FK CONSTRAINT     t   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT fk_klienci_firmy FOREIGN KEY (nip) REFERENCES public.firmy(nip);
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT fk_klienci_firmy;
       public          postgres    false    221    222    4726            �           2606    16494    klienci klienci_nip_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_fkey FOREIGN KEY (nip) REFERENCES public.firmy(nip) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_fkey;
       public          postgres    false    221    4726    222            �           2606    16467 %   pracownicy pracownicy_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_placowkaid_fkey;
       public          postgres    false    218    4720    219            �           2606    16462 '   pracownicy pracownicy_stanowiskoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_stanowiskoid_fkey FOREIGN KEY (stanowiskoid) REFERENCES public.stanowiska(id_stanowiska) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_stanowiskoid_fkey;
       public          postgres    false    4718    219    216            �           2606    16477 #   samochody samochody_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_placowkaid_fkey;
       public          postgres    false    220    218    4720            �           2606    16538 B   samochody_podwykonawcy samochody_podwykonawcy_nippodwykonawcy_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey FOREIGN KEY (nippodwykonawcy) REFERENCES public.podwykonawcy(nippodwykonawcy) ON DELETE SET NULL;
 l   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey;
       public          postgres    false    226    4734    223            �           2606    16533 6   samochody_podwykonawcy samochody_podwykonawcy_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_vin_fkey;
       public          postgres    false    226    4724    220            �           2606    16513 (   zamowienia zamowienia_pesel_klienta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_klienta_fkey FOREIGN KEY (pesel_klienta) REFERENCES public.klienci(pesel) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_klienta_fkey;
       public          postgres    false    225    4732    222            �           2606    16523 +   zamowienia zamowienia_pesel_pracownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_pracownika_fkey FOREIGN KEY (pesel_pracownika) REFERENCES public.pracownicy(pesel) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_pracownika_fkey;
       public          postgres    false    225    4722    219            �           2606    16518    zamowienia zamowienia_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_fkey;
       public          postgres    false    4724    220    225            *   6   x�s�,�MTp�4426153��4�r9q�E�BΜy�!��%


\1z\\\ �.6      +   �   x�u�K�0���)8���c��Ite�L�&��5Bd��<�t�Dg�����x~F��v�zp$]r	��I@��7eh�IO����5Y���Bk�I��T�_���3�(�����Ӱ�fhe)5��@���#�Y��x��qF���X�r�ڰ�1��Jb��afT{y��*�;�b��;f~@�ִ&�^�,,��"~ ¢f�      '   7   x�3��J-��/��H-�M�+�N�44�4�42�2�&g
�3ĮϘ�Ђ+F��� �J�      ,      x������ � �      (      x������ � �      )   ^   x�3426624T�N'�p�SN#CN�Լ�ʼDN�ļ���Ъ��ļJ�prB4�j6'V����͎�)����`�tBu��qqq LZ,�      /      x������ � �      %   9   x�3�N�.J-I,�N�4100�4��)\F��%�G�TINC��1�����qqq ��a      .      x������ � �     