PGDMP     1    8                y            DemoDB    14.1    14.1 !               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    24576    DemoDB    DATABASE     S   CREATE DATABASE "DemoDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE "DemoDB";
                postgres    false            �            1259    24687    areetematiche    TABLE     �   CREATE TABLE public.areetematiche (
    tipo character varying(30) NOT NULL,
    descrizione text,
    idcorso integer NOT NULL
);
 !   DROP TABLE public.areetematiche;
       public         heap    postgres    false            �            1259    24675    corsoformazione    TABLE     �   CREATE TABLE public.corsoformazione (
    nome character varying(30) NOT NULL,
    descrizione text,
    presenzemin integer NOT NULL,
    maxpartecipanti integer NOT NULL,
    idcorso integer NOT NULL,
    id character varying(15) NOT NULL
);
 #   DROP TABLE public.corsoformazione;
       public         heap    postgres    false            �            1259    24707    iscritto    TABLE     �   CREATE TABLE public.iscritto (
    data date NOT NULL,
    orario time without time zone,
    matricola character varying(15) NOT NULL,
    idcorso integer NOT NULL
);
    DROP TABLE public.iscritto;
       public         heap    postgres    false            �            1259    24697    lezione    TABLE       CREATE TABLE public.lezione (
    titolo character varying(30) NOT NULL,
    descrizione text,
    durata time without time zone,
    data date NOT NULL,
    orarioinizio time without time zone NOT NULL,
    idcorso integer NOT NULL,
    idlezione integer NOT NULL
);
    DROP TABLE public.lezione;
       public         heap    postgres    false            �            1259    24670 	   operatore    TABLE       CREATE TABLE public.operatore (
    nome character varying(30) NOT NULL,
    cognome character varying(30) NOT NULL,
    data date,
    id character varying(15) NOT NULL,
    cf character varying(16) NOT NULL,
    password character varying(30) NOT NULL
);
    DROP TABLE public.operatore;
       public         heap    postgres    false            �            1259    24720 	   partecipa    TABLE     �   CREATE TABLE public.partecipa (
    data date NOT NULL,
    orario time without time zone,
    presenza boolean NOT NULL,
    matricola character varying(15) NOT NULL,
    idlezione integer NOT NULL
);
    DROP TABLE public.partecipa;
       public         heap    postgres    false            �            1259    24661    studente    TABLE       CREATE TABLE public.studente (
    nome character varying(30) NOT NULL,
    cognome character varying(30) NOT NULL,
    data date,
    cf character varying(16) NOT NULL,
    matricola character varying(15) NOT NULL,
    password character varying(30) NOT NULL
);
    DROP TABLE public.studente;
       public         heap    postgres    false                      0    24687    areetematiche 
   TABLE DATA           C   COPY public.areetematiche (tipo, descrizione, idcorso) FROM stdin;
    public          postgres    false    212   (                 0    24675    corsoformazione 
   TABLE DATA           g   COPY public.corsoformazione (nome, descrizione, presenzemin, maxpartecipanti, idcorso, id) FROM stdin;
    public          postgres    false    211   �(                 0    24707    iscritto 
   TABLE DATA           D   COPY public.iscritto (data, orario, matricola, idcorso) FROM stdin;
    public          postgres    false    214   )                 0    24697    lezione 
   TABLE DATA           f   COPY public.lezione (titolo, descrizione, durata, data, orarioinizio, idcorso, idlezione) FROM stdin;
    public          postgres    false    213   l)                 0    24670 	   operatore 
   TABLE DATA           J   COPY public.operatore (nome, cognome, data, id, cf, password) FROM stdin;
    public          postgres    false    210   �)                 0    24720 	   partecipa 
   TABLE DATA           Q   COPY public.partecipa (data, orario, presenza, matricola, idlezione) FROM stdin;
    public          postgres    false    215   �)                 0    24661    studente 
   TABLE DATA           P   COPY public.studente (nome, cognome, data, cf, matricola, password) FROM stdin;
    public          postgres    false    209   �)       t           2606    24669    studente Studente_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.studente
    ADD CONSTRAINT "Studente_pkey" PRIMARY KEY (matricola);
 B   ALTER TABLE ONLY public.studente DROP CONSTRAINT "Studente_pkey";
       public            postgres    false    209            x           2606    24803    operatore UkCF 
   CONSTRAINT     I   ALTER TABLE ONLY public.operatore
    ADD CONSTRAINT "UkCF" UNIQUE (cf);
 :   ALTER TABLE ONLY public.operatore DROP CONSTRAINT "UkCF";
       public            postgres    false    210            v           2606    24805    studente UkCf 
   CONSTRAINT     H   ALTER TABLE ONLY public.studente
    ADD CONSTRAINT "UkCf" UNIQUE (cf);
 9   ALTER TABLE ONLY public.studente DROP CONSTRAINT "UkCf";
       public            postgres    false    209            ~           2606    24834    areetematiche UkCorso 
   CONSTRAINT     U   ALTER TABLE ONLY public.areetematiche
    ADD CONSTRAINT "UkCorso" UNIQUE (idcorso);
 A   ALTER TABLE ONLY public.areetematiche DROP CONSTRAINT "UkCorso";
       public            postgres    false    212            �           2606    24850    iscritto Ukstud 
   CONSTRAINT     Z   ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT "Ukstud" UNIQUE (matricola, idcorso);
 ;   ALTER TABLE ONLY public.iscritto DROP CONSTRAINT "Ukstud";
       public            postgres    false    214    214            |           2606    24681 $   corsoformazione corsoformazione_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.corsoformazione
    ADD CONSTRAINT corsoformazione_pkey PRIMARY KEY (idcorso);
 N   ALTER TABLE ONLY public.corsoformazione DROP CONSTRAINT corsoformazione_pkey;
       public            postgres    false    211            �           2606    24843    lezione lezione_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.lezione
    ADD CONSTRAINT lezione_pkey PRIMARY KEY (idlezione);
 >   ALTER TABLE ONLY public.lezione DROP CONSTRAINT lezione_pkey;
       public            postgres    false    213            z           2606    24674    operatore operatore_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.operatore
    ADD CONSTRAINT operatore_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.operatore DROP CONSTRAINT operatore_pkey;
       public            postgres    false    210            �           2606    24692    areetematiche FkCorso    FK CONSTRAINT     �   ALTER TABLE ONLY public.areetematiche
    ADD CONSTRAINT "FkCorso" FOREIGN KEY (idcorso) REFERENCES public.corsoformazione(idcorso) ON UPDATE CASCADE ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.areetematiche DROP CONSTRAINT "FkCorso";
       public          postgres    false    211    3196    212            �           2606    24702    lezione FkCorso    FK CONSTRAINT     �   ALTER TABLE ONLY public.lezione
    ADD CONSTRAINT "FkCorso" FOREIGN KEY (idcorso) REFERENCES public.corsoformazione(idcorso) ON UPDATE CASCADE ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public.lezione DROP CONSTRAINT "FkCorso";
       public          postgres    false    213    3196    211            �           2606    24715    iscritto FkCorso    FK CONSTRAINT     �   ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT "FkCorso" FOREIGN KEY (idcorso) REFERENCES public.corsoformazione(idcorso) ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.iscritto DROP CONSTRAINT "FkCorso";
       public          postgres    false    211    214    3196            �           2606    24844    partecipa FkLez    FK CONSTRAINT     �   ALTER TABLE ONLY public.partecipa
    ADD CONSTRAINT "FkLez" FOREIGN KEY (idlezione) REFERENCES public.lezione(idlezione) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ;   ALTER TABLE ONLY public.partecipa DROP CONSTRAINT "FkLez";
       public          postgres    false    3200    213    215            �           2606    24806    corsoformazione FkOp    FK CONSTRAINT     �   ALTER TABLE ONLY public.corsoformazione
    ADD CONSTRAINT "FkOp" FOREIGN KEY (id) REFERENCES public.operatore(id) ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.corsoformazione DROP CONSTRAINT "FkOp";
       public          postgres    false    3194    211    210            �           2606    24817    iscritto FkStud    FK CONSTRAINT     �   ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT "FkStud" FOREIGN KEY (matricola) REFERENCES public.studente(matricola) ON UPDATE CASCADE ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public.iscritto DROP CONSTRAINT "FkStud";
       public          postgres    false    214    3188    209            �           2606    24825    partecipa FkStud    FK CONSTRAINT     �   ALTER TABLE ONLY public.partecipa
    ADD CONSTRAINT "FkStud" FOREIGN KEY (matricola) REFERENCES public.studente(matricola) ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.partecipa DROP CONSTRAINT "FkStud";
       public          postgres    false    209    3188    215               R   x����0 �7L�&:�b�!AhZ�q{�}O�F�85�R��q��ւF�|��Ȟ*��Y4���I�t��6�D� ^y0            x�-�A� ��+��
(nտ��$N�@2��KD�=�h6׽ia�+ccㅻ�<��@�N1�U��W�#���s�3��a��)�<&Эif̺���V�s�	!�v(��"z9�Ǜ@s�ܝs?�/�         M   x�m�Q
�0���.�4uw�3�� ��<�DN��HXUtK'��D
N�/�"�I�H��i���_��߾�            x������ � �         H   x�K�/.��L�/.��4200�50�5��4445�41��\ ��������*s]#�*#�*K��=... J6;            x������ � �         `   x�5�K
�0 �uz�J���]\ZJPi�xk�ͬ��R(Z�]��"[t�}#��)���F��!�b��8�>=����Ȝ	8#0�9�c�+�C     