PGDMP  1                
    |            project    16.3    16.3 7    3           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            4           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            5           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            6           1262    25039    project    DATABASE     z   CREATE DATABASE project WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
    DROP DATABASE project;
                postgres    false            �            1259    25076    firmy    TABLE     n   CREATE TABLE public.firmy (
    nazwafirmy character varying(100) NOT NULL,
    nip character(10) NOT NULL
);
    DROP TABLE public.firmy;
       public         heap    postgres    false            �            1259    25069    klienci    TABLE     �   CREATE TABLE public.klienci (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    nip character(10),
    telefon character(9) NOT NULL
);
    DROP TABLE public.klienci;
       public         heap    postgres    false            �            1259    25048    placowki    TABLE       CREATE TABLE public.placowki (
    placowkaid integer NOT NULL,
    miasto character varying(50) NOT NULL,
    ulica character varying(100) NOT NULL,
    numerbudynku integer NOT NULL,
    iloscsamochodow integer NOT NULL,
    iloscmiejscapozostalego integer NOT NULL
);
    DROP TABLE public.placowki;
       public         heap    postgres    false            �            1259    25047    placowki_placowkaid_seq    SEQUENCE     �   CREATE SEQUENCE public.placowki_placowkaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.placowki_placowkaid_seq;
       public          postgres    false    218            7           0    0    placowki_placowkaid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.placowki_placowkaid_seq OWNED BY public.placowki.placowkaid;
          public          postgres    false    217            �            1259    25122    podwykonawcy    TABLE     �   CREATE TABLE public.podwykonawcy (
    nippodwykonawcy character(10) NOT NULL,
    nazwa character varying(100) NOT NULL,
    specjalizacja character varying(50) NOT NULL
);
     DROP TABLE public.podwykonawcy;
       public         heap    postgres    false            �            1259    25054 
   pracownicy    TABLE       CREATE TABLE public.pracownicy (
    pesel character(11) NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    stanowiskoid integer NOT NULL,
    placowkaid integer NOT NULL,
    zarobki numeric(10,2) NOT NULL
);
    DROP TABLE public.pracownicy;
       public         heap    postgres    false            �            1259    25088 	   samochody    TABLE     w  CREATE TABLE public.samochody (
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
       public         heap    postgres    false            �            1259    25127    samochody_podwykonawcy    TABLE     {   CREATE TABLE public.samochody_podwykonawcy (
    vin character(17) NOT NULL,
    nippodwykonawcy character(10) NOT NULL
);
 *   DROP TABLE public.samochody_podwykonawcy;
       public         heap    postgres    false            �            1259    25041 
   stanowiska    TABLE     �   CREATE TABLE public.stanowiska (
    stanowiskoid integer NOT NULL,
    nazwastanowiska character varying(50) NOT NULL,
    minzarobki numeric(10,2) NOT NULL,
    maxzarobki numeric(10,2) NOT NULL,
    doswiadczenie character varying(50) NOT NULL
);
    DROP TABLE public.stanowiska;
       public         heap    postgres    false            �            1259    25040    stanowiska_stanowiskoid_seq    SEQUENCE     �   CREATE SEQUENCE public.stanowiska_stanowiskoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.stanowiska_stanowiskoid_seq;
       public          postgres    false    216            8           0    0    stanowiska_stanowiskoid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.stanowiska_stanowiskoid_seq OWNED BY public.stanowiska.stanowiskoid;
          public          postgres    false    215            �            1259    25099 
   zamowienia    TABLE     �   CREATE TABLE public.zamowienia (
    zamowienieid integer NOT NULL,
    kwota numeric(10,2) NOT NULL,
    pesel character(11) NOT NULL,
    vin character(17) NOT NULL,
    usluganaprawy boolean NOT NULL,
    pesel_pracownika character(11) NOT NULL
);
    DROP TABLE public.zamowienia;
       public         heap    postgres    false            �            1259    25098    zamowienia_zamowienieid_seq    SEQUENCE     �   CREATE SEQUENCE public.zamowienia_zamowienieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.zamowienia_zamowienieid_seq;
       public          postgres    false    224            9           0    0    zamowienia_zamowienieid_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.zamowienia_zamowienieid_seq OWNED BY public.zamowienia.zamowienieid;
          public          postgres    false    223            s           2604    25051    placowki placowkaid    DEFAULT     z   ALTER TABLE ONLY public.placowki ALTER COLUMN placowkaid SET DEFAULT nextval('public.placowki_placowkaid_seq'::regclass);
 B   ALTER TABLE public.placowki ALTER COLUMN placowkaid DROP DEFAULT;
       public          postgres    false    217    218    218            r           2604    25044    stanowiska stanowiskoid    DEFAULT     �   ALTER TABLE ONLY public.stanowiska ALTER COLUMN stanowiskoid SET DEFAULT nextval('public.stanowiska_stanowiskoid_seq'::regclass);
 F   ALTER TABLE public.stanowiska ALTER COLUMN stanowiskoid DROP DEFAULT;
       public          postgres    false    216    215    216            t           2604    25102    zamowienia zamowienieid    DEFAULT     �   ALTER TABLE ONLY public.zamowienia ALTER COLUMN zamowienieid SET DEFAULT nextval('public.zamowienia_zamowienieid_seq'::regclass);
 F   ALTER TABLE public.zamowienia ALTER COLUMN zamowienieid DROP DEFAULT;
       public          postgres    false    224    223    224            +          0    25076    firmy 
   TABLE DATA           0   COPY public.firmy (nazwafirmy, nip) FROM stdin;
    public          postgres    false    221   E       *          0    25069    klienci 
   TABLE DATA           F   COPY public.klienci (pesel, imie, nazwisko, nip, telefon) FROM stdin;
    public          postgres    false    220   FE       (          0    25048    placowki 
   TABLE DATA           u   COPY public.placowki (placowkaid, miasto, ulica, numerbudynku, iloscsamochodow, iloscmiejscapozostalego) FROM stdin;
    public          postgres    false    218   �E       /          0    25122    podwykonawcy 
   TABLE DATA           M   COPY public.podwykonawcy (nippodwykonawcy, nazwa, specjalizacja) FROM stdin;
    public          postgres    false    225   WF       )          0    25054 
   pracownicy 
   TABLE DATA           ^   COPY public.pracownicy (pesel, imie, nazwisko, stanowiskoid, placowkaid, zarobki) FROM stdin;
    public          postgres    false    219   tF       ,          0    25088 	   samochody 
   TABLE DATA           i   COPY public.samochody (vin, marka, model, rocznik, silnik, skrzynia, stan, cena, placowkaid) FROM stdin;
    public          postgres    false    222   �G       0          0    25127    samochody_podwykonawcy 
   TABLE DATA           F   COPY public.samochody_podwykonawcy (vin, nippodwykonawcy) FROM stdin;
    public          postgres    false    226   �H       &          0    25041 
   stanowiska 
   TABLE DATA           j   COPY public.stanowiska (stanowiskoid, nazwastanowiska, minzarobki, maxzarobki, doswiadczenie) FROM stdin;
    public          postgres    false    216   �H       .          0    25099 
   zamowienia 
   TABLE DATA           f   COPY public.zamowienia (zamowienieid, kwota, pesel, vin, usluganaprawy, pesel_pracownika) FROM stdin;
    public          postgres    false    224   �I       :           0    0    placowki_placowkaid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.placowki_placowkaid_seq', 1, false);
          public          postgres    false    217            ;           0    0    stanowiska_stanowiskoid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stanowiska_stanowiskoid_seq', 1, false);
          public          postgres    false    215            <           0    0    zamowienia_zamowienieid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.zamowienia_zamowienieid_seq', 1, false);
          public          postgres    false    223            �           2606    25082    firmy firmy_nip_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_nip_key UNIQUE (nip);
 =   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_nip_key;
       public            postgres    false    221            �           2606    25080    firmy firmy_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.firmy
    ADD CONSTRAINT firmy_pkey PRIMARY KEY (nazwafirmy);
 :   ALTER TABLE ONLY public.firmy DROP CONSTRAINT firmy_pkey;
       public            postgres    false    221            |           2606    25075    klienci klienci_nip_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_nip_key UNIQUE (nip);
 A   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_nip_key;
       public            postgres    false    220            ~           2606    25073    klienci klienci_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (pesel);
 >   ALTER TABLE ONLY public.klienci DROP CONSTRAINT klienci_pkey;
       public            postgres    false    220            x           2606    25053    placowki placowki_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.placowki
    ADD CONSTRAINT placowki_pkey PRIMARY KEY (placowkaid);
 @   ALTER TABLE ONLY public.placowki DROP CONSTRAINT placowki_pkey;
       public            postgres    false    218            �           2606    25126    podwykonawcy podwykonawcy_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.podwykonawcy
    ADD CONSTRAINT podwykonawcy_pkey PRIMARY KEY (nippodwykonawcy);
 H   ALTER TABLE ONLY public.podwykonawcy DROP CONSTRAINT podwykonawcy_pkey;
       public            postgres    false    225            z           2606    25058    pracownicy pracownicy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (pesel);
 D   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_pkey;
       public            postgres    false    219            �           2606    25092    samochody samochody_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_pkey PRIMARY KEY (vin);
 B   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_pkey;
       public            postgres    false    222            �           2606    25131 2   samochody_podwykonawcy samochody_podwykonawcy_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_pkey PRIMARY KEY (vin, nippodwykonawcy);
 \   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_pkey;
       public            postgres    false    226    226            v           2606    25046    stanowiska stanowiska_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.stanowiska
    ADD CONSTRAINT stanowiska_pkey PRIMARY KEY (stanowiskoid);
 D   ALTER TABLE ONLY public.stanowiska DROP CONSTRAINT stanowiska_pkey;
       public            postgres    false    216            �           2606    25104    zamowienia zamowienia_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (zamowienieid);
 D   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pkey;
       public            postgres    false    224            �           2606    25106    zamowienia zamowienia_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_key UNIQUE (vin);
 G   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_key;
       public            postgres    false    224            �           2606    25083    klienci fk_klienci_firmy    FK CONSTRAINT     t   ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT fk_klienci_firmy FOREIGN KEY (nip) REFERENCES public.firmy(nip);
 B   ALTER TABLE ONLY public.klienci DROP CONSTRAINT fk_klienci_firmy;
       public          postgres    false    221    220    4736            �           2606    25064 %   pracownicy pracownicy_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(placowkaid);
 O   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_placowkaid_fkey;
       public          postgres    false    218    4728    219            �           2606    25059 '   pracownicy pracownicy_stanowiskoid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_stanowiskoid_fkey FOREIGN KEY (stanowiskoid) REFERENCES public.stanowiska(stanowiskoid);
 Q   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pracownicy_stanowiskoid_fkey;
       public          postgres    false    4726    216    219            �           2606    25093 #   samochody samochody_placowkaid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody
    ADD CONSTRAINT samochody_placowkaid_fkey FOREIGN KEY (placowkaid) REFERENCES public.placowki(placowkaid);
 M   ALTER TABLE ONLY public.samochody DROP CONSTRAINT samochody_placowkaid_fkey;
       public          postgres    false    222    218    4728            �           2606    25137 B   samochody_podwykonawcy samochody_podwykonawcy_nippodwykonawcy_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey FOREIGN KEY (nippodwykonawcy) REFERENCES public.podwykonawcy(nippodwykonawcy);
 l   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_nippodwykonawcy_fkey;
       public          postgres    false    4746    226    225            �           2606    25132 6   samochody_podwykonawcy samochody_podwykonawcy_vin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.samochody_podwykonawcy
    ADD CONSTRAINT samochody_podwykonawcy_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin);
 `   ALTER TABLE ONLY public.samochody_podwykonawcy DROP CONSTRAINT samochody_podwykonawcy_vin_fkey;
       public          postgres    false    226    222    4740            �           2606    25107     zamowienia zamowienia_pesel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_fkey FOREIGN KEY (pesel) REFERENCES public.klienci(pesel);
 J   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_fkey;
       public          postgres    false    220    224    4734            �           2606    25117 +   zamowienia zamowienia_pesel_pracownika_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pesel_pracownika_fkey FOREIGN KEY (pesel_pracownika) REFERENCES public.pracownicy(pesel);
 U   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_pesel_pracownika_fkey;
       public          postgres    false    219    4730    224            �           2606    25112    zamowienia zamowienia_vin_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_vin_fkey FOREIGN KEY (vin) REFERENCES public.samochody(vin);
 H   ALTER TABLE ONLY public.zamowienia DROP CONSTRAINT zamowienia_vin_fkey;
       public          postgres    false    4740    224    222            +   (   x�s�,�MTp�4426153��4�r9q�E�b���� �~	�      *   ~   x�3426153��40��M,J�����/O����4��q!q��'r��g&g'"Tp�Y\�Ɯ.�E�ٜQ�YGZ�AF���L8�s��W�q"����Ҕ�;�83��)�(1d\�+F��� �0      (   s   x��1
�0���a�z�Ka�fPq1]���$�2݃�����zE�=l������{���k�4\��ͨ��Wt1�mΔĠ���C���7+����>=�:!8      /      x������ � �      )   Z  x�E��j�@�����$3�qi7�"� H7��4?I�8�ҷ�ct�m�{�Čn\|ܹ�܄�Tq�fsҒZ�3W]�)�/B̄��h�4L��"O�I[m��vz�ntq�I���Pњ[ʹ��y�uI
J9�QL/���N���RR���=�]B��lɴ�Z_�%���4�Uk/��͑��37s]4�q4i�3,z:pU �^���n��sZ��g{�yt���)�&癠-T#wf�m4
�j�aER*#�ck��i-=p�tq�>u׹1�Z��JC]kwi�i���q�rL͈�>�;�M!�Z�o<|�������]!Ȇ{<8��ۚۢ��w��Y���x      ,   �   x�uбn�0���y��>bF���-(��b$bK���5�c�ʒ�������yZJ9�r�Pk&��0(@��N�X��TzV����0���)F�bI�Vl�.��
�[g���q��ݹ �'sR��_{Q�x	/�,fa�=��[��CX�0�� N������e��!!)�W���~_�4��o#�pmrĝlj�Dn��!K|B�o�&�� �:\C      0      x������ � �      &   �   x�U���0E�ӏ1�Q(KMܨld�f�V�%C���1A�����̽�Y+g{�k���pz�h�XE�Ua_"D���Ϭ� W��11I5�����h�X��php�w�ڞ�?N �;_3���@,<)Uw�����	�ꥍ~w;�ָ��6��*U[>�$E傅8�t��&!I|G�c�� Zb      .      x������ � �     