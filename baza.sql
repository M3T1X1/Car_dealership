PGDMP      *        	        |            baza    16.3    16.3 `    ]           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ^           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            _           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            `           1262    33228    baza    DATABASE     w   CREATE DATABASE baza WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE baza;
                postgres    false            �            1255    33229 k   dodajklienta(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     v  CREATE PROCEDURE public.dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO klienci (pesel,imie,nazwisko,nip,telefon)
VALUES (p_pesel,p_imie,p_nazwisko,p_nip,p_telefon);
END;
$$;
 �   DROP PROCEDURE public.dodajklienta(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       public          postgres    false            �            1255    33230 E   dodajplacowke(character varying, character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego)
    VALUES (nextval('placowki_id_seq'), p_miasto, p_ulica, p_numerbudynku, 0, p_iloscmiejscapozostalego);
END;
$$;
 �   DROP PROCEDURE public.dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer);
       public          postgres    false            �            1255    33231 J   dodajpodwykonawce(character varying, character varying, character varying) 	   PROCEDURE     =  CREATE PROCEDURE public.dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO podwykonawcy (nippodwykonawcy, nazwa, specjalizacja)
VALUES (p_nippodwykonawcy, p_nazwa, p_specjalizacja); 
END;
$$;
 �   DROP PROCEDURE public.dodajpodwykonawce(IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       public          postgres    false            �            1255    33232 l   dodajpracownika(character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO pracownicy(pesel,imie,nazwisko,stanowiskoid,placowkaid,zarobki)
VALUES (p_pesel,p_imie,p_nazwisko,p_stanowiskoid,p_placowkaid,p_zarobki);
END;
$$;
 �   DROP PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
       public          postgres    false            �            1255    33233 �   dodajsamochod(character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO samochody (vin,marka,model,rocznik,silnik,skrzynia,stan,cena,placowkaid)
VALUES (p_vin,p_marka,p_model,p_rocznik,p_silnik,p_skrzynia,p_stan,p_cena,p_placowkaid);
END;
$$;
   DROP PROCEDURE public.dodajsamochod(IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer);
       public          postgres    false            �            1255    33234 G   dodajstanowisko(character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie)
VALUES (nextval('stanowiska_id_stanowiska_seq'),p_nazwastanowiska,p_minzarobki,p_maxzarobki,p_doswiadczenie);
END;
$$;
 �   DROP PROCEDURE public.dodajstanowisko(IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying);
       public          postgres    false            �            1255    33235 Z   dodajzamowienie(numeric, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajzamowienie(IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO zamowienia (zamowienieid, kwota,pesel,vin,usluganaprawy,pesel_pracownika)
VALUES (nextval('zamowienia_zamowienieid_seq'),p_kwota,p_pesel,p_vin,p_usluganaprawy,p_pesel_pracownika);
END;
$$;
 �   DROP PROCEDURE public.dodajzamowienie(IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying);
       public          postgres    false            �            1255    33236 Q   edytujStanowisko(integer, character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public."edytujStanowisko"(IN p_id_staonwiska integer, IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE stanowiska
SET nazwastanoiwksa = p_nazwastanowiska, minzarobki=p_minzarobki, maxzarobki=p_maxzarobki, doswiadczenie=p_doswiadczenie
WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 �   DROP PROCEDURE public."edytujStanowisko"(IN p_id_staonwiska integer, IN p_nazwastanowiska character varying, IN p_minzarobki integer, IN p_maxzarobki integer, IN p_doswiadczenie character varying);
       public          postgres    false            �            1255    33237    edytujklienta(character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE klienci
SET pesel=p_pesel,imie=p_imie,nazwisko=p_nazwisko,telefon=p_telefon,nip=p_nip
WHERE pesel = p_peseldozmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujklienta(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_telefon character varying, IN p_nip character varying);
       public          postgres    false            �            1255    33238 X   edytujplacowke(integer, character varying, character varying, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujplacowke(IN p_id_placowki integer, IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscsamochodow integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE placowki
	SET miasto = p_miasto, ulica = p_ulica, numerbudynku = p_numerbudynku, iloscsamochodow = p_iloscsamochodow, iloscmiejscawolnego = p_iloscmiejscapozostalego
	WHERE id_placowki = p_id_placowki;
END;
$$;
 �   DROP PROCEDURE public.edytujplacowke(IN p_id_placowki integer, IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscsamochodow integer, IN p_iloscmiejscapozostalego integer);
       public          postgres    false            �            1255    33239 ^   edytujpodwykonawce(character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE podwykonawcy 
SET nippodwykonawcy = p_nippodwykonawcy, nazwa = p_nazwa, specjalizacja = p_specjalizacja
WHERE nippodwykonawcy = p_nipdozmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujpodwykonawce(IN p_nipdozmiany character varying, IN p_nippodwykonawcy character varying, IN p_nazwa character varying, IN p_specjalizacja character varying);
       public          postgres    false            �            1255    33240 �   edytujpracownika(character varying, character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE pracownicy
SET pesel=p_pesel, imie = p_imie, nazwisko = p_nazwisko, stanowiskoid = p_stanowiskoid, placowkaid = p_placowkaid, zarobki = p_zarobki
WHERE pesel = p_peselDoZmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
       public          postgres    false            �            1255    33241 �   edytujsamochod(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying, numeric, integer) 	   PROCEDURE     J  CREATE PROCEDURE public.edytujsamochod(IN p_vindozmiany character varying, IN p_vin character varying, IN p_marka character varying, IN p_model character varying, IN p_rocznik integer, IN p_silnik character varying, IN p_skrzynia character varying, IN p_stan character varying, IN p_cena numeric, IN p_placowkaid integer)
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
       public          postgres    false            �            1255    33242 d   edytujzamowienie(integer, numeric, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujzamowienie(IN p_iddozmiany integer, IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE zamowienia
SET kwota = p_kwota, pesel = p_pesel, vin = p_vin, usluganaprawy = p_usluganaprawy, pesel_pracownika = p_pesel_pracownika
WHERE idzamowienia = p_iddozmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujzamowienie(IN p_iddozmiany integer, IN p_kwota numeric, IN p_pesel character varying, IN p_vin character varying, IN p_usluganaprawy boolean, IN p_pesel_pracownika character varying);
       public          postgres    false                       1255    33374    pobierz_firmy()    FUNCTION     �   CREATE FUNCTION public.pobierz_firmy() RETURNS TABLE(nazwafirmy character varying, nip character)
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
       public          postgres    false                       1255    33373    pobierz_klienci()    FUNCTION     S  CREATE FUNCTION public.pobierz_klienci() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, nip character, telefon character)
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
       public          postgres    false                       1255    33369    pobierz_placowki()    FUNCTION     �  CREATE FUNCTION public.pobierz_placowki() RETURNS TABLE(placowkaid integer, miasto character varying, ulica character varying, numerbudynku integer, iloscsamochodow integer, iloscmiejscapozostalego integer)
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
       public          postgres    false                       1255    33375    pobierz_podwykonawcy()    FUNCTION     9  CREATE FUNCTION public.pobierz_podwykonawcy() RETURNS TABLE(nippodwykonawcy character, nazwa character varying, specjalizacja character varying)
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
       public          postgres    false            �            1255    33364    pobierz_pracownicy()    FUNCTION     �  CREATE FUNCTION public.pobierz_pracownicy() RETURNS TABLE(pesel character, imie character varying, nazwisko character varying, stanowiskoid integer, placowkaid integer, zarobki numeric)
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
       public          postgres    false            �            1255    33367    pobierz_samochody()    FUNCTION     �  CREATE FUNCTION public.pobierz_samochody() RETURNS TABLE(vin character, marka character varying, model character varying, rocznik integer, silnik character varying, skrzynia character varying, stan character varying, cena numeric, placowkaid integer)
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
       public          postgres    false                       1255    33370    pobierz_stanowiska()    FUNCTION     �  CREATE FUNCTION public.pobierz_stanowiska() RETURNS TABLE(stanowiskoid integer, nazwastanowiska character varying, minzarobki numeric, maxzarobki numeric, doswiadczenie character varying)
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
       public          postgres    false                       1255    33376    pobierz_zamowienia()    FUNCTION     �  CREATE FUNCTION public.pobierz_zamowienia() RETURNS TABLE(zamowienieid integer, kwota numeric, pesel character, vin character, usluganaprawy boolean, pesel_pracownika character)
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
       public          postgres    false            �            1255    33243    usunStanowisko(integer) 	   PROCEDURE     �   CREATE PROCEDURE public."usunStanowisko"(IN p_id_stanowiska integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROm stanowiska
WHERE id_stanowiska = p_id_stanowiska;
END;
$$;
 D   DROP PROCEDURE public."usunStanowisko"(IN p_id_stanowiska integer);
       public          postgres    false            �            1255    33244    usunklienta(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunklienta(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM klienci
	WHERE pesel = p_pesel;
END;
$$;
 A   DROP PROCEDURE public.usunklienta(IN p_pesel character varying);
       public          postgres    false            �            1255    33245    usunplacowke(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.usunplacowke(IN p_id_placowki integer)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
    DELETE FROM placowki 
	WHERE id_placowki=p_id_placowki;
END;
$$;
 >   DROP PROCEDURE public.usunplacowke(IN p_id_placowki integer);
       public          postgres    false            �            1255    33246 #   usunpodwykonawce(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunpodwykonawce(IN p_nippodwykonawcy character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM podwykonawcy
WHERE nippodwykonawcy = p_nippodwykonawcy;
END;
$$;
 P   DROP PROCEDURE public.usunpodwykonawce(IN p_nippodwykonawcy character varying);
       public          postgres    false            �            1255    33247 !   usunpracownika(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunpracownika(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
DELETE FROM pracownicy
WHERE pesel = p_pesel;
END;
$$;
 D   DROP PROCEDURE public.usunpracownika(IN p_pesel character varying);
       public          postgres    false            �            1255    33248    usunsamochod(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunsamochod(IN p_vin character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM samochody
WHERE vin = p_vin;
END;
$$;
 @   DROP PROCEDURE public.usunsamochod(IN p_vin character varying);
       public          postgres    false            �            1255    33249    usunzamowienie(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.usunzamowienie(IN p_idzamowienia integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
DELETE FROM zamowienia
WHERE idzamowienia = p_idzamowienia;
END;
$$;
 A   DROP PROCEDURE public.usunzamowienie(IN p_idzamowienia integer);
       public          postgres    false            �            1259    33250    firmy    TABLE     n   CREATE TABLE public.firmy (
    nazwafirmy character varying(100) NOT NULL,
    nip character(10) NOT NULL
);
    DROP TABLE public.firmy;
       public         heap    postgres    false            �            1259    33253    id_pracownika_seq    SEQUENCE     z   CREATE SEQUENCE public.id_pracownika_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.id_pracownika_seq;
       public          postgres    false            �            1259    33254    klienci    TABLE     �   CREATE TABLE public.klienci (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    nip character(10),
    telefon character(9) NOT NULL
);
    DROP TABLE public.klienci;
       public         heap    postgres    false            �            1259    33257    placowki    TABLE       CREATE TABLE public.placowki (
    placowkaid integer NOT NULL,
    miasto character varying(50) NOT NULL,
    ulica character varying(100) NOT NULL,
    numerbudynku integer NOT NULL,
    iloscsamochodow integer NOT NULL,
    iloscmiejscapozostalego integer NOT NULL
);
    DROP TABLE public.placowki;
       public         heap    postgres    false            �            1259    33260    placowki_id_placowki_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_id_placowki_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.placowki_id_placowki_seq;
       public          postgres    false            �            1259    33261    placowki_id_seq    SEQUENCE     x   CREATE SEQUENCE public.placowki_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.placowki_id_seq;
       public          postgres    false            �            1259    33262    placowki_placowkaid_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_placowkaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.placowki_placowkaid_seq;
       public          postgres    false    218            a           0    0    placowki_placowkaid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.placowki_placowkaid_seq OWNED BY public.placowki.placowkaid;
          public          postgres    false    221            �            1259    33263    podwykonawcy    TABLE     �   CREATE TABLE public.podwykonawcy (
    nippodwykonawcy character(10) NOT NULL,
    nazwa character varying(100) NOT NULL,
    specjalizacja character varying(50) NOT NULL
);
     DROP TABLE public.podwykonawcy;
       public         heap    postgres    false            �            1259    33266 
   pracownicy    TABLE       CREATE TABLE public.pracownicy (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    stanowiskoid integer NOT NULL,
    placowkaid integer NOT NULL,
    zarobki numeric(10,2) NOT NULL
);
    DROP TABLE public.pracownicy;
       public         heap    postgres    false            �            1259    33269 	   samochody    TABLE     w  CREATE TABLE public.samochody (
    vin character(17) NOT NULL,
    marka character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    rocznik integer NOT NULL,
    silnik character varying(50) NOT NULL,
    skrzynia character varying(50) NOT NULL,
    stan character varying(50) NOT NULL,
    cena numeric(10,2) NOT NULL,
    placowkaid integer NOT NULL
);
    DROP TABLE public.samochody;
       public         heap    postgres    false            �            1259    33272    samochody_podwykonawcy    TABLE     {   CREATE TABLE public.samochody_podwykonawcy (
    vin character(17) NOT NULL,
    nippodwykonawcy character(10) NOT NULL
);
 *   DROP TABLE public.samochody_podwykonawcy;
       public         heap    postgres    false            �            1259    33275 
   stanowiska    TABLE     �   CREATE TABLE public.stanowiska (
    stanowiskoid integer NOT NULL,
    nazwastanowiska character varying(50) NOT NULL,
    minzarobki numeric(10,2) NOT NULL,
    maxzarobki numeric(10,2) NOT NULL,
    doswiadczenie character varying(50) NOT NULL
);
    DROP TABLE public.stanowiska;
       public         heap    postgres    false            �            1259    33278    stanowiska_id_stanowiska_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_id_stanowiska_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.stanowiska_id_stanowiska_seq;
       public          postgres    false            �            1259    33279    stanowiska_stanowiskoid_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_stanowiskoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.stanowiska_stanowiskoid_seq;
       public          postgres    false    226            b           0    0    stanowiska_stanowiskoid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.stanowiska_stanowiskoid_seq OWNED BY public.stanowiska.stanowiskoid;
          public          postgres    false    228            �            1259    33280 
   zamowienia    TABLE     �   CREATE TABLE public.zamowienia (
    zamowienieid integer NOT NULL,
    kwota numeric(10,2) NOT NULL,
    pesel character(11) NOT NULL,
    vin character(17) NOT NULL,
    usluganaprawy boolean NOT NULL,
    pesel_pracownika character(11) NOT NULL
);
    DROP TABLE public.zamowienia;
       public         heap    postgres    false            �            1259    33283    zamowienia_id_zamowienia_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_id_zamowienia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.zamowienia_id_zamowienia_seq;
       public          postgres    false            �            1259    33284    zamowienia_zamowienieid_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_zamowienieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.zamowienia_zamowienieid_seq;
       public          postgres    false    229            c           0    0    zamowienia_zamowienieid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.zamowienia_zamowienieid_seq OWNED BY public.zamowienia.zamowienieid;
          public          postgres    false    231            �           2604    33285    placowki placowkaid    DEFAULT     z   ALTER TABLE ONLY public.placowki ALTER COLUMN placowkaid SET DEFAULT nextval('public.placowki_placowkaid_seq'::regclass);
 B   ALTER TABLE public.placowki ALTER COLUMN placowkaid DROP DEFAULT;
       public          postgres    false    221    218            �           2604    33286    stanowiska stanowiskoid    DEFAULT     �   ALTER TABLE ONLY public.stanowiska ALTER COLUMN stanowiskoid SET DEFAULT nextval('public.stanowiska_stanowiskoid_seq'::regclass);
 F   ALTER TABLE public.stanowiska ALTER COLUMN stanowiskoid DROP DEFAULT;
       public          postgres    false    228    226            �           2604    33287    zamowienia zamowienieid    DEFAULT     �   ALTER TABLE ONLY public.zamowienia ALTER COLUMN zamowienieid SET DEFAULT nextval('public.zamowienia_zamowienieid_seq'::regclass);
 F   ALTER TABLE public.zamowienia ALTER COLUMN zamowienieid DROP DEFAULT;
       public          postgres    false    231    229            J          0    33250    firmy 
   TABLE DATA           0   COPY public.firmy (nazwafirmy, nip) FROM stdin;
    public          postgres    false    215   ��       L          0    33254    klienci 
   TABLE DATA           F   COPY public.klienci (pesel, imie, nazwisko, nip, telefon) FROM stdin;
    public          postgres    false    217   ��       M          0    33257    placowki 
   TABLE DATA           u   COPY public.placowki (placowkaid, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego) FROM stdin;
    public          postgres    false    218   ��       Q          0    33263    podwykonawcy 
   TABLE DATA           M   COPY public.podwykonawcy (nippodwykonawcy, nazwa, specjalizacja) FROM stdin;
    public          postgres    false    222   �       R          0    33266 
   pracownicy 
   TABLE DATA           ^   COPY public.pracownicy (pesel, imie, nazwisko, stanowiskoid, placowkaid, zarobki) FROM stdin;
    public          postgres    false    223   %�       S          0    33269 	   samochody 
   TABLE DATA           i   COPY public.samochody (vin, marka, model, rocznik, silnik, skrzynia, stan, cena, placowkaid) FROM stdin;
    public          postgres    false    224   ��       T          0    33272    samochody_podwykonawcy 
   TABLE DATA           F   COPY public.samochody_podwykonawcy (vin, nippodwykonawcy) FROM stdin;
    public          postgres    false    225   ��       U          0    33275 
   stanowiska 
   TABLE DATA           j   COPY public.stanowiska (stanowiskoid, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie) FROM stdin;
    public          postgres    false    226   ��       X          0    33280 
   zamowienia 
   TABLE DATA           f   COPY public.zamowienia (zamowienieid, kwota, pesel, vin, usluganaprawy, pesel_pracownika) FROM stdin;
    public          postgres    false    229   t�       d           0    0    id_pracownika_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.id_pracownika_seq', 1, false);
          public          postgres    false    216            e           0    0    placowki_id_placowki_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.placowki_id_placowki_seq', 1, false);
          public          postgres    false    219            f           0    0    placowki_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.placowki_id_seq', 2, true);
          public          postgres    false    220            g           0    0    placowki_placowkaid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.placowki_placowkaid_seq', 1, false);
          public          postgres    false    221            h           0    0    stanowiska_id_stanowiska_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_id_stanowiska_seq', 1, true);
          public          postgres    false    227            i           0    0    stanowiska_stanowiskoid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_stanowiskoid_seq', 1, false);
          public          postgres    false    228            j           0    0    zamowienia_id_zamowienia_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.zamowienia_id_zamowienia_seq', 1, false);
          public          postgres    false    230            k           0    0    zamowienia_zamowienieid_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.zamowienia_zamowienieid_seq', 1, true);
          public          postgres    false    231            �           2606    33289    firmy firmy_nip_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_nip_key UNIQUE (nip);
 =   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_nip_key;
       public            postgres    false    215            �           2606    33291    firmy firmy_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_pkey PRIMARY KEY (nazwafirmy);
 :   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_pkey;
       public            postgres    false    215            �           2606    33293    klienci klienci_nip_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_key UNIQUE (nip);
 A   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_key;
       public            postgres    false    217            �           2606    33295    klienci klienci_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (pesel);
 >   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_pkey;
       public            postgres    false    217            �           2606    33297    placowki placowki_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.placowki
    ADD CONSTRAINT placowki_pkey PRIMARY KEY (placowkaid);
 @   ALTER TABLE ONLY public.placowki DROP CONSTRAINT placowki_pkey;
       public            postgres    false    218            �           2606    33299    podwykonawcy podwykonawcy_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.podwykonawcy
    ADD CONSTRAINT podwykonawcy_pkey PRIMARY KEY (nippodwykonawcy);
 H   ALTER TABLE ONLY public.podwykonawcy DROP CONSTRAINT podwykonawcy_pkey;
       public            postgres    false    222            �           2606    33301    pracownicy pracownicy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (pesel);
 D   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_pkey;
       public            postgres    false    223            �           2606    33303    samochody samochody_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_pkey PRIMARY KEY (vin);
 B   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_pkey;
       public            postgres    false    224            �           2606    33305 2   samochody_podwykonawcy samochody_podwykonawcy_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_pkey PRIMARY KEY (vin, nippodwykonawcy);
 \   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_pkey;
       public            postgres    false    225    225            �           2606    33307    stanowiska stanowiska_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.stanowiska
    ADD CONSTRAINT stanowiska_pkey PRIMARY KEY (stanowiskoid);
 D   ALTER TABLE ONLY public.stanowiska DROP CONSTRAINT stanowiska_pkey;
       public            postgres    false    226            �           2606    33309    zamowienia unique_vin 
   CONSTRAINT     O   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT unique_vin UNIQUE (vin);
 ?   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT unique_vin;
       public            postgres    false    229            �           2606    33311    zamowienia zamowienia_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (zamowienieid);
 D   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pkey;
       public            postgres    false    229            �           2606    33313    zamowienia zamowienia_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_key UNIQUE (vin);
 G   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_key;
       public            postgres    false    229            �           2606    33314    klienci fk_klienci_firmy    FK CONSTRAINT     t   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT fk_klienci_firmy FOREIGN KEY (nip) REFERENCES public.firmy(nip);
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT fk_klienci_firmy;
       public          postgres    false    215    217    4760            �           2606    33319    klienci klienci_nip_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_fkey FOREIGN KEY (nip) REFERENCES public.firmy(nip) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_fkey;
       public          postgres    false    4760    215    217            �           2606    33324 %   pracownicy pracownicy_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(placowkaid);
 O   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_placowkaid_fkey;
       public          postgres    false    223    4768    218            �           2606    33329 '   pracownicy pracownicy_stanowiskoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_stanowiskoid_fkey FOREIGN KEY (stanowiskoid) REFERENCES public.stanowiska(stanowiskoid);
 Q   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_stanowiskoid_fkey;
       public          postgres    false    4778    223    226            �           2606    33334 #   samochody samochody_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(placowkaid);
 M   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_placowkaid_fkey;
       public          postgres    false    224    4768    218            �           2606    33339 B   samochody_podwykonawcy samochody_podwykonawcy_nippodwykonawcy_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey FOREIGN KEY (nippodwykonawcy) REFERENCES public.podwykonawcy(nippodwykonawcy);
 l   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey;
       public          postgres    false    225    4770    222            �           2606    33344 6   samochody_podwykonawcy samochody_podwykonawcy_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin);
 `   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_vin_fkey;
       public          postgres    false    224    225    4774            �           2606    33349     zamowienia zamowienia_pesel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_fkey FOREIGN KEY (pesel) REFERENCES public.klienci(pesel);
 J   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_fkey;
       public          postgres    false    217    4766    229            �           2606    33354 +   zamowienia zamowienia_pesel_pracownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_pracownika_fkey FOREIGN KEY (pesel_pracownika) REFERENCES public.pracownicy(pesel);
 U   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_pracownika_fkey;
       public          postgres    false    4772    223    229            �           2606    33359    zamowienia zamowienia_vin_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin);
 H   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_fkey;
       public          postgres    false    224    229    4774            J   (   x�s�,�MTp�4426153��4�r9q�E�b���� �~	�      L   ~   x�3426153��40��M,J�����/O����4��q!q��'r��g&g'"Tp�Y\�Ɯ.�E�ٜQ�YGZ�AF���L8�s��W�q"����Ҕ�;�83��)�(1d\�+F��� �0      M   s   x��1
�0���a�z�Ka�fPq1]���$�2݃�����zE�=l������{���k�4\��ͨ��Wt1�mΔĠ���C���7+����>=�:!8      Q      x������ � �      R   _  x�E�=j�@�zt#��ϥ���0�4�$;�,H
�[��"�H�6�^y��^ܸ����FB�Q��K?�j���pI����/|�sB�^龥��U\�R�����!m�UL����L�B�V9ы��3���*3ג"�b�bZ���3%ӆk5|u��J;�ф6��v��'z*.��zzh�GDb��x�9�@��**;:N�hg��ʹ�gs�yt���I��ş=T
#z�m
|4 �Y�R�a�`��)κ5��m���T}2�;C����>[��T�Ms7Hs�'Ծ�S3b�Oi�sS�U���Uvk�>�d�=��g��@�b{!�8�ד�w��x,�d #�u�y�?�h��      S   �   x�uбn�0���y��>bF���-(��b$bK���5�c�ʒ�������yZJ9�r�Pk&��0(@��N�X��TzV����0���)F�bI�Vl�.��
�[g���q��ݹ �'sR��_{Q�x	/�,fa�=��[��CX�0�� N������e��!!)�W���~_�4��o#�pmrĝlj�Dn��!K|B�o�&�� �:\C      T      x������ � �      U   �   x�U���0E�ӏ1�Q(KMܨld�f�V�%C���1A�����̽�Y+g{�k���pz�h�XE�Ua_"D���Ϭ� W��11I5�����h�X��php�w�ڞ�?N �;_3���@,<)Uw�����	�ꥍ~w;�ָ��6��*U[>�$E傅8�t��&!I|G�c�� Zb      X      x������ � �     