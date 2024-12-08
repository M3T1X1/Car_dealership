PGDMP  0    9                |         	   autoKomis    16.3    16.3 J               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16441 	   autoKomis    DATABASE     ~   CREATE DATABASE "autoKomis" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE "autoKomis";
                postgres    false                       0    0    DATABASE "autoKomis"    COMMENT     G   COMMENT ON DATABASE "autoKomis" IS 'Projekt na bazy danych semestr 3';
                   postgres    false    4884            �            1255    24640 E   dodajplacowke(character varying, character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego)
    VALUES (nextval('placowki_id_seq'), p_miasto, p_ulica, p_numerbudynku, 0, p_iloscmiejscapozostalego);
END;
$$;
 �   DROP PROCEDURE public.dodajplacowke(IN p_miasto character varying, IN p_ulica character varying, IN p_numerbudynku integer, IN p_iloscmiejscapozostalego integer);
       public          postgres    false            �            1255    24642 Y   dodajpracownika(character varying, character varying, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko integer, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO pracownicy (pesel, imie, nazwisko, staonwiskoid, placowkaid, zarobki)
    VALUES (p_pesel, p_imie, p_nazwisko, p_stanowiskoid, p_placowkaid, p_zarobki);
END;
$$;
 �   DROP PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko integer, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki integer);
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
       public          postgres    false            �            1255    24637    usunplacowke(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.usunplacowke(IN p_id_placowki integer)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
    DELETE FROM placowki 
	WHERE id_placowki=p_id_placowki;
END;
$$;
 >   DROP PROCEDURE public.usunplacowke(IN p_id_placowki integer);
       public          postgres    false            �            1255    16545 !   usunpracownika(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunpracownika(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
DELETE FROM pracownicy
WHERE pesel = p_pesel;
END;
$$;
 D   DROP PROCEDURE public.usunpracownika(IN p_pesel character varying);
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
       public          postgres    false    218                       0    0    placowki_id_placowki_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.placowki_id_placowki_seq OWNED BY public.placowki.id_placowki;
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
       public          postgres    false    216                       0    0    stanowiska_id_stanowiska_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.stanowiska_id_stanowiska_seq OWNED BY public.stanowiska.id_stanowiska;
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
       public          postgres    false    225                       0    0    zamowienia_id_zamowienia_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.zamowienia_id_zamowienia_seq OWNED BY public.zamowienia.id_zamowienia;
          public          postgres    false    224            �            1259    16548    zamowienia_zamowienieid_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_zamowienieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.zamowienia_zamowienieid_seq;
       public          postgres    false            H           2604    16453    placowki id_placowki    DEFAULT     |   ALTER TABLE ONLY public.placowki ALTER COLUMN id_placowki SET DEFAULT nextval('public.placowki_id_placowki_seq'::regclass);
 C   ALTER TABLE public.placowki ALTER COLUMN id_placowki DROP DEFAULT;
       public          postgres    false    218    217    218            G           2604    16446    stanowiska id_stanowiska    DEFAULT     �   ALTER TABLE ONLY public.stanowiska ALTER COLUMN id_stanowiska SET DEFAULT nextval('public.stanowiska_id_stanowiska_seq'::regclass);
 G   ALTER TABLE public.stanowiska ALTER COLUMN id_stanowiska DROP DEFAULT;
       public          postgres    false    216    215    216            J           2604    16508    zamowienia id_zamowienia    DEFAULT     �   ALTER TABLE ONLY public.zamowienia ALTER COLUMN id_zamowienia SET DEFAULT nextval('public.zamowienia_id_zamowienia_seq'::regclass);
 G   ALTER TABLE public.zamowienia ALTER COLUMN id_zamowienia DROP DEFAULT;
       public          postgres    false    225    224    225                      0    16482    firmy 
   TABLE DATA           0   COPY public.firmy (nazwafirmy, nip) FROM stdin;
    public          postgres    false    221    e                 0    16489    klienci 
   TABLE DATA           F   COPY public.klienci (pesel, imie, nazwisko, nip, telefon) FROM stdin;
    public          postgres    false    222   Xe                 0    16450    placowki 
   TABLE DATA           v   COPY public.placowki (id_placowki, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego) FROM stdin;
    public          postgres    false    218   �e                 0    16499    podwykonawcy 
   TABLE DATA           M   COPY public.podwykonawcy (nippodwykonawcy, nazwa, specjalizacja) FROM stdin;
    public          postgres    false    223   (f                 0    16457 
   pracownicy 
   TABLE DATA           ^   COPY public.pracownicy (pesel, imie, nazwisko, stanowiskoid, placowkaid, zarobki) FROM stdin;
    public          postgres    false    219   Ef                 0    16472 	   samochody 
   TABLE DATA           i   COPY public.samochody (vin, marka, model, rocznik, silnik, skrzynia, stan, cena, placowkaid) FROM stdin;
    public          postgres    false    220   bf       	          0    16528    samochody_podwykonawcy 
   TABLE DATA           F   COPY public.samochody_podwykonawcy (vin, nippodwykonawcy) FROM stdin;
    public          postgres    false    226   f       �          0    16443 
   stanowiska 
   TABLE DATA           k   COPY public.stanowiska (id_stanowiska, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie) FROM stdin;
    public          postgres    false    216   �f                 0    16505 
   zamowienia 
   TABLE DATA           o   COPY public.zamowienia (id_zamowienia, kwota, pesel_klienta, vin, usluganaprawy, pesel_pracownika) FROM stdin;
    public          postgres    false    225   �f                  0    0    id_pracownika_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.id_pracownika_seq', 1, false);
          public          postgres    false    231                       0    0    placowki_id_placowki_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.placowki_id_placowki_seq', 1, false);
          public          postgres    false    217                       0    0    placowki_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.placowki_id_seq', 2, true);
          public          postgres    false    230                       0    0    placowki_placowkaid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.placowki_placowkaid_seq', 1, false);
          public          postgres    false    227                       0    0    stanowiska_id_stanowiska_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.stanowiska_id_stanowiska_seq', 1, false);
          public          postgres    false    215                       0    0    stanowiska_stanowiskoid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_stanowiskoid_seq', 1, false);
          public          postgres    false    228                       0    0    zamowienia_id_zamowienia_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.zamowienia_id_zamowienia_seq', 1, false);
          public          postgres    false    224                        0    0    zamowienia_zamowienieid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.zamowienia_zamowienieid_seq', 1, false);
          public          postgres    false    229            T           2606    16488    firmy firmy_nip_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_nip_key UNIQUE (nip);
 =   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_nip_key;
       public            postgres    false    221            V           2606    16486    firmy firmy_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_pkey PRIMARY KEY (nazwafirmy);
 :   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_pkey;
       public            postgres    false    221            X           2606    16550    klienci klienci_nip_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_key UNIQUE (nip);
 A   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_key;
       public            postgres    false    222            Z           2606    16493    klienci klienci_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (pesel);
 >   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_pkey;
       public            postgres    false    222            N           2606    16456    placowki placowki_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.placowki
    ADD CONSTRAINT placowki_pkey PRIMARY KEY (id_placowki);
 @   ALTER TABLE ONLY public.placowki DROP CONSTRAINT placowki_pkey;
       public            postgres    false    218            \           2606    16503    podwykonawcy podwykonawcy_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.podwykonawcy
    ADD CONSTRAINT podwykonawcy_pkey PRIMARY KEY (nippodwykonawcy);
 H   ALTER TABLE ONLY public.podwykonawcy DROP CONSTRAINT podwykonawcy_pkey;
       public            postgres    false    223            P           2606    16461    pracownicy pracownicy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (pesel);
 D   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_pkey;
       public            postgres    false    219            R           2606    16476    samochody samochody_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_pkey PRIMARY KEY (vin);
 B   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_pkey;
       public            postgres    false    220            d           2606    16532 2   samochody_podwykonawcy samochody_podwykonawcy_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_pkey PRIMARY KEY (vin, nippodwykonawcy);
 \   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_pkey;
       public            postgres    false    226    226            L           2606    16448    stanowiska stanowiska_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.stanowiska
    ADD CONSTRAINT stanowiska_pkey PRIMARY KEY (id_stanowiska);
 D   ALTER TABLE ONLY public.stanowiska DROP CONSTRAINT stanowiska_pkey;
       public            postgres    false    216            ^           2606    16512    zamowienia unique_vin 
   CONSTRAINT     O   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT unique_vin UNIQUE (vin);
 ?   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT unique_vin;
       public            postgres    false    225            `           2606    16510    zamowienia zamowienia_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (id_zamowienia);
 D   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pkey;
       public            postgres    false    225            b           2606    16552    zamowienia zamowienia_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_key UNIQUE (vin);
 G   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_key;
       public            postgres    false    225            h           2606    16553    klienci fk_klienci_firmy    FK CONSTRAINT     t   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT fk_klienci_firmy FOREIGN KEY (nip) REFERENCES public.firmy(nip);
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT fk_klienci_firmy;
       public          postgres    false    222    4692    221            i           2606    16494    klienci klienci_nip_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_fkey FOREIGN KEY (nip) REFERENCES public.firmy(nip) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_fkey;
       public          postgres    false    222    221    4692            e           2606    16467 %   pracownicy pracownicy_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_placowkaid_fkey;
       public          postgres    false    219    4686    218            f           2606    16462 '   pracownicy pracownicy_stanowiskoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_stanowiskoid_fkey FOREIGN KEY (stanowiskoid) REFERENCES public.stanowiska(id_stanowiska) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_stanowiskoid_fkey;
       public          postgres    false    4684    216    219            g           2606    16477 #   samochody samochody_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(id_placowki) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_placowkaid_fkey;
       public          postgres    false    220    218    4686            m           2606    16538 B   samochody_podwykonawcy samochody_podwykonawcy_nippodwykonawcy_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey FOREIGN KEY (nippodwykonawcy) REFERENCES public.podwykonawcy(nippodwykonawcy) ON DELETE SET NULL;
 l   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey;
       public          postgres    false    223    4700    226            n           2606    16533 6   samochody_podwykonawcy samochody_podwykonawcy_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_vin_fkey;
       public          postgres    false    4690    226    220            j           2606    16513 (   zamowienia zamowienia_pesel_klienta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_klienta_fkey FOREIGN KEY (pesel_klienta) REFERENCES public.klienci(pesel) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_klienta_fkey;
       public          postgres    false    4698    222    225            k           2606    16523 +   zamowienia zamowienia_pesel_pracownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_pracownika_fkey FOREIGN KEY (pesel_pracownika) REFERENCES public.pracownicy(pesel) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_pracownika_fkey;
       public          postgres    false    4688    225    219            l           2606    16518    zamowienia zamowienia_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_fkey;
       public          postgres    false    225    4690    220               (   x�s�,�MTp�4426153��4�r9q�E�b���� �~	�         ~   x�3426153��40��M,J�����/O����4��q!q��'r��g&g'"Tp�Y\�Ɯ.�E�ٜQ�YGZ�AF���L8�s��W�q"����Ҕ�;�83��)�(1d\�+F��� �0         2   x�3��J-��/��H-�M�+�N�44�4�42�2�#g�M�"���� ���            x������ � �            x������ � �            x������ � �      	      x������ � �      �      x������ � �            x������ � �     