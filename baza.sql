PGDMP  "    	            
    |         	   autoKomis    16.3    16.3 :                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    32782 	   autoKomis    DATABASE     ~   CREATE DATABASE "autoKomis" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE "autoKomis";
                postgres    false            �            1255    32887 l   dodajpracownika(character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
INSERT INTO pracownicy(pesel,imie,nazwisko,stanowiskoid,placowkaid,zarobki)
VALUES (p_pesel,p_imie,p_nazwisko,p_stanowiskoid,p_placowkaid,p_zarobki);
END;
$$;
 �   DROP PROCEDURE public.dodajpracownika(IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
       public          postgres    false            �            1255    32890 �   edytujpracownika(character varying, character varying, character varying, character varying, integer, integer, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE pracownicy
SET pesel=p_pesel, imie = p_imie, nazwisko = p_nazwisko, stanowiskoid = p_stanowiskoid, placowkaid = p_placowkaid, zarobki = p_zarobki
WHERE pesel = p_peselDoZmiany;
END;
$$;
 �   DROP PROCEDURE public.edytujpracownika(IN p_peseldozmiany character varying, IN p_pesel character varying, IN p_imie character varying, IN p_nazwisko character varying, IN p_stanowiskoid integer, IN p_placowkaid integer, IN p_zarobki double precision);
       public          postgres    false            �            1255    32886 !   usunpracownika(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.usunpracownika(IN p_pesel character varying)
    LANGUAGE plpgsql
    AS $$
	
BEGIN
DELETE FROM pracownicy
WHERE pesel = p_pesel;
END;
$$;
 D   DROP PROCEDURE public.usunpracownika(IN p_pesel character varying);
       public          postgres    false            �            1259    32783    firmy    TABLE     n   CREATE TABLE public.firmy (
    nazwafirmy character varying(100) NOT NULL,
    nip character(10) NOT NULL
);
    DROP TABLE public.firmy;
       public         heap    postgres    false            �            1259    32786    klienci    TABLE     �   CREATE TABLE public.klienci (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    nip character(10),
    telefon character(9) NOT NULL
);
    DROP TABLE public.klienci;
       public         heap    postgres    false            �            1259    32789    placowki    TABLE       CREATE TABLE public.placowki (
    placowkaid integer NOT NULL,
    miasto character varying(50) NOT NULL,
    ulica character varying(100) NOT NULL,
    numerbudynku integer NOT NULL,
    iloscsamochodow integer NOT NULL,
    iloscmiejscapozostalego integer NOT NULL
);
    DROP TABLE public.placowki;
       public         heap    postgres    false            �            1259    32792    placowki_placowkaid_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_placowkaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.placowki_placowkaid_seq;
       public          postgres    false    217                       0    0    placowki_placowkaid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.placowki_placowkaid_seq OWNED BY public.placowki.placowkaid;
          public          postgres    false    218            �            1259    32793    podwykonawcy    TABLE     �   CREATE TABLE public.podwykonawcy (
    nippodwykonawcy character(10) NOT NULL,
    nazwa character varying(100) NOT NULL,
    specjalizacja character varying(50) NOT NULL
);
     DROP TABLE public.podwykonawcy;
       public         heap    postgres    false            �            1259    32796 
   pracownicy    TABLE       CREATE TABLE public.pracownicy (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    stanowiskoid integer NOT NULL,
    placowkaid integer NOT NULL,
    zarobki numeric(10,2) NOT NULL
);
    DROP TABLE public.pracownicy;
       public         heap    postgres    false            �            1259    32799 	   samochody    TABLE     w  CREATE TABLE public.samochody (
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
       public         heap    postgres    false            �            1259    32802    samochody_podwykonawcy    TABLE     {   CREATE TABLE public.samochody_podwykonawcy (
    vin character(17) NOT NULL,
    nippodwykonawcy character(10) NOT NULL
);
 *   DROP TABLE public.samochody_podwykonawcy;
       public         heap    postgres    false            �            1259    32805 
   stanowiska    TABLE     �   CREATE TABLE public.stanowiska (
    stanowiskoid integer NOT NULL,
    nazwastanowiska character varying(50) NOT NULL,
    minzarobki numeric(10,2) NOT NULL,
    maxzarobki numeric(10,2) NOT NULL,
    doswiadczenie character varying(50) NOT NULL
);
    DROP TABLE public.stanowiska;
       public         heap    postgres    false            �            1259    32808    stanowiska_stanowiskoid_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_stanowiskoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.stanowiska_stanowiskoid_seq;
       public          postgres    false    223                       0    0    stanowiska_stanowiskoid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.stanowiska_stanowiskoid_seq OWNED BY public.stanowiska.stanowiskoid;
          public          postgres    false    224            �            1259    32809 
   zamowienia    TABLE     �   CREATE TABLE public.zamowienia (
    zamowienieid integer NOT NULL,
    kwota numeric(10,2) NOT NULL,
    pesel character(11) NOT NULL,
    vin character(17) NOT NULL,
    usluganaprawy boolean NOT NULL,
    pesel_pracownika character(11) NOT NULL
);
    DROP TABLE public.zamowienia;
       public         heap    postgres    false            �            1259    32812    zamowienia_zamowienieid_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_zamowienieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.zamowienia_zamowienieid_seq;
       public          postgres    false    225                       0    0    zamowienia_zamowienieid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.zamowienia_zamowienieid_seq OWNED BY public.zamowienia.zamowienieid;
          public          postgres    false    226            ?           2604    32813    placowki placowkaid    DEFAULT     z   ALTER TABLE ONLY public.placowki ALTER COLUMN placowkaid SET DEFAULT nextval('public.placowki_placowkaid_seq'::regclass);
 B   ALTER TABLE public.placowki ALTER COLUMN placowkaid DROP DEFAULT;
       public          postgres    false    218    217            @           2604    32814    stanowiska stanowiskoid    DEFAULT     �   ALTER TABLE ONLY public.stanowiska ALTER COLUMN stanowiskoid SET DEFAULT nextval('public.stanowiska_stanowiskoid_seq'::regclass);
 F   ALTER TABLE public.stanowiska ALTER COLUMN stanowiskoid DROP DEFAULT;
       public          postgres    false    224    223            A           2604    32815    zamowienia zamowienieid    DEFAULT     �   ALTER TABLE ONLY public.zamowienia ALTER COLUMN zamowienieid SET DEFAULT nextval('public.zamowienia_zamowienieid_seq'::regclass);
 F   ALTER TABLE public.zamowienia ALTER COLUMN zamowienieid DROP DEFAULT;
       public          postgres    false    226    225            �          0    32783    firmy 
   TABLE DATA           0   COPY public.firmy (nazwafirmy, nip) FROM stdin;
    public          postgres    false    215   �M       �          0    32786    klienci 
   TABLE DATA           F   COPY public.klienci (pesel, imie, nazwisko, nip, telefon) FROM stdin;
    public          postgres    false    216   �M       �          0    32789    placowki 
   TABLE DATA           u   COPY public.placowki (placowkaid, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego) FROM stdin;
    public          postgres    false    217   �N       �          0    32793    podwykonawcy 
   TABLE DATA           M   COPY public.podwykonawcy (nippodwykonawcy, nazwa, specjalizacja) FROM stdin;
    public          postgres    false    219   O       �          0    32796 
   pracownicy 
   TABLE DATA           ^   COPY public.pracownicy (pesel, imie, nazwisko, stanowiskoid, placowkaid, zarobki) FROM stdin;
    public          postgres    false    220   *O       �          0    32799 	   samochody 
   TABLE DATA           i   COPY public.samochody (vin, marka, model, rocznik, silnik, skrzynia, stan, cena, placowkaid) FROM stdin;
    public          postgres    false    221   �P       �          0    32802    samochody_podwykonawcy 
   TABLE DATA           F   COPY public.samochody_podwykonawcy (vin, nippodwykonawcy) FROM stdin;
    public          postgres    false    222   �Q       �          0    32805 
   stanowiska 
   TABLE DATA           j   COPY public.stanowiska (stanowiskoid, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie) FROM stdin;
    public          postgres    false    223   �Q       �          0    32809 
   zamowienia 
   TABLE DATA           f   COPY public.zamowienia (zamowienieid, kwota, pesel, vin, usluganaprawy, pesel_pracownika) FROM stdin;
    public          postgres    false    225   yR                  0    0    placowki_placowkaid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.placowki_placowkaid_seq', 1, false);
          public          postgres    false    218                       0    0    stanowiska_stanowiskoid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_stanowiskoid_seq', 1, false);
          public          postgres    false    224            	           0    0    zamowienia_zamowienieid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.zamowienia_zamowienieid_seq', 1, false);
          public          postgres    false    226            C           2606    32817    firmy firmy_nip_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_nip_key UNIQUE (nip);
 =   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_nip_key;
       public            postgres    false    215            E           2606    32819    firmy firmy_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_pkey PRIMARY KEY (nazwafirmy);
 :   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_pkey;
       public            postgres    false    215            G           2606    32821    klienci klienci_nip_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_key UNIQUE (nip);
 A   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_key;
       public            postgres    false    216            I           2606    32823    klienci klienci_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (pesel);
 >   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_pkey;
       public            postgres    false    216            K           2606    32825    placowki placowki_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.placowki
    ADD CONSTRAINT placowki_pkey PRIMARY KEY (placowkaid);
 @   ALTER TABLE ONLY public.placowki DROP CONSTRAINT placowki_pkey;
       public            postgres    false    217            M           2606    32827    podwykonawcy podwykonawcy_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.podwykonawcy
    ADD CONSTRAINT podwykonawcy_pkey PRIMARY KEY (nippodwykonawcy);
 H   ALTER TABLE ONLY public.podwykonawcy DROP CONSTRAINT podwykonawcy_pkey;
       public            postgres    false    219            O           2606    32829    pracownicy pracownicy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (pesel);
 D   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_pkey;
       public            postgres    false    220            Q           2606    32831    samochody samochody_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_pkey PRIMARY KEY (vin);
 B   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_pkey;
       public            postgres    false    221            S           2606    32833 2   samochody_podwykonawcy samochody_podwykonawcy_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_pkey PRIMARY KEY (vin, nippodwykonawcy);
 \   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_pkey;
       public            postgres    false    222    222            U           2606    32835    stanowiska stanowiska_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.stanowiska
    ADD CONSTRAINT stanowiska_pkey PRIMARY KEY (stanowiskoid);
 D   ALTER TABLE ONLY public.stanowiska DROP CONSTRAINT stanowiska_pkey;
       public            postgres    false    223            W           2606    32837    zamowienia zamowienia_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (zamowienieid);
 D   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pkey;
       public            postgres    false    225            Y           2606    32839    zamowienia zamowienia_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_key UNIQUE (vin);
 G   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_key;
       public            postgres    false    225            Z           2606    32840    klienci fk_klienci_firmy    FK CONSTRAINT     t   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT fk_klienci_firmy FOREIGN KEY (nip) REFERENCES public.firmy(nip);
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT fk_klienci_firmy;
       public          postgres    false    216    4675    215            [           2606    32845 %   pracownicy pracownicy_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(placowkaid);
 O   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_placowkaid_fkey;
       public          postgres    false    220    217    4683            \           2606    32850 '   pracownicy pracownicy_stanowiskoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_stanowiskoid_fkey FOREIGN KEY (stanowiskoid) REFERENCES public.stanowiska(stanowiskoid);
 Q   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_stanowiskoid_fkey;
       public          postgres    false    223    4693    220            ]           2606    32855 #   samochody samochody_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(placowkaid);
 M   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_placowkaid_fkey;
       public          postgres    false    217    221    4683            ^           2606    32860 B   samochody_podwykonawcy samochody_podwykonawcy_nippodwykonawcy_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey FOREIGN KEY (nippodwykonawcy) REFERENCES public.podwykonawcy(nippodwykonawcy);
 l   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey;
       public          postgres    false    219    4685    222            _           2606    32865 6   samochody_podwykonawcy samochody_podwykonawcy_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin);
 `   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_vin_fkey;
       public          postgres    false    222    221    4689            `           2606    32870     zamowienia zamowienia_pesel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_fkey FOREIGN KEY (pesel) REFERENCES public.klienci(pesel);
 J   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_fkey;
       public          postgres    false    216    4681    225            a           2606    32875 +   zamowienia zamowienia_pesel_pracownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_pracownika_fkey FOREIGN KEY (pesel_pracownika) REFERENCES public.pracownicy(pesel);
 U   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_pracownika_fkey;
       public          postgres    false    220    225    4687            b           2606    32880    zamowienia zamowienia_vin_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin);
 H   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_fkey;
       public          postgres    false    4689    225    221            �   (   x�s�,�MTp�4426153��4�r9q�E�b���� �~	�      �   ~   x�3426153��40��M,J�����/O����4��q!q��'r��g&g'"Tp�Y\�Ɯ.�E�ٜQ�YGZ�AF���L8�s��W�q"����Ҕ�;�83��)�(1d\�+F��� �0      �   s   x��1
�0���a�z�Ka�fPq1]���$�2݃�����zE�=l������{���k�4\��ͨ��Wt1�mΔĠ���C���7+����>=�:!8      �      x������ � �      �   _  x�E�=j�@�zt#��ϥ���0�4�$;�,H
�[��"�H�6�^y��^ܸ����FB�Q��K?�j���pI����/|�sB�^龥��U\�R�����!m�UL����L�B�V9ы��3���*3ג"�b�bZ���3%ӆk5|u��J;�ф6��v��'z*.��zzh�GDb��x�9�@��**;:N�hg��ʹ�gs�yt���I��ş=T
#z�m
|4 �Y�R�a�`��)κ5��m���T}2�;C����>[��T�Ms7Hs�'Ծ�S3b�Oi�sS�U���Uvk�>�d�=��g��@�b{!�8�ד�w��x,�d #�u�y�?�h��      �   �   x�uбn�0���y��>bF���-(��b$bK���5�c�ʒ�������yZJ9�r�Pk&��0(@��N�X��TzV����0���)F�bI�Vl�.��
�[g���q��ݹ �'sR��_{Q�x	/�,fa�=��[��CX�0�� N������e��!!)�W���~_�4��o#�pmrĝlj�Dn��!K|B�o�&�� �:\C      �      x������ � �      �   �   x�U���0E�ӏ1�Q(KMܨld�f�V�%C���1A�����̽�Y+g{�k���pz�h�XE�Ua_"D���Ϭ� W��11I5�����h�X��php�w�ڞ�?N �;_3���@,<)Uw�����	�ꥍ~w;�ָ��6��*U[>�$E傅8�t��&!I|G�c�� Zb      �      x������ � �     