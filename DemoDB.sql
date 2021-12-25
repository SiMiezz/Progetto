PGDMP     0    ;                y            DemoDB    14.1    14.1 (    "           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            #           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            $           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            %           1262    24576    DemoDB    DATABASE     S   CREATE DATABASE "DemoDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
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
    id character varying(15) NOT NULL,
    idcorso integer NOT NULL
);
 #   DROP TABLE public.corsoformazione;
       public         heap    postgres    false            �            1259    24851    corsoformazione_idcorso_seq    SEQUENCE     �   CREATE SEQUENCE public.corsoformazione_idcorso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.corsoformazione_idcorso_seq;
       public          postgres    false    211            &           0    0    corsoformazione_idcorso_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.corsoformazione_idcorso_seq OWNED BY public.corsoformazione.idcorso;
          public          postgres    false    216            �            1259    24707    iscritto    TABLE     �   CREATE TABLE public.iscritto (
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
       public         heap    postgres    false            �            1259    24861    lezione_idlezione_seq    SEQUENCE     �   CREATE SEQUENCE public.lezione_idlezione_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.lezione_idlezione_seq;
       public          postgres    false    213            '           0    0    lezione_idlezione_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.lezione_idlezione_seq OWNED BY public.lezione.idlezione;
          public          postgres    false    217            �            1259    24670 	   operatore    TABLE       CREATE TABLE public.operatore (
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
       public         heap    postgres    false            u           2604    24852    corsoformazione idcorso    DEFAULT     �   ALTER TABLE ONLY public.corsoformazione ALTER COLUMN idcorso SET DEFAULT nextval('public.corsoformazione_idcorso_seq'::regclass);
 F   ALTER TABLE public.corsoformazione ALTER COLUMN idcorso DROP DEFAULT;
       public          postgres    false    216    211            v           2604    24862    lezione idlezione    DEFAULT     v   ALTER TABLE ONLY public.lezione ALTER COLUMN idlezione SET DEFAULT nextval('public.lezione_idlezione_seq'::regclass);
 @   ALTER TABLE public.lezione ALTER COLUMN idlezione DROP DEFAULT;
       public          postgres    false    217    213                      0    24687    areetematiche 
   TABLE DATA           C   COPY public.areetematiche (tipo, descrizione, idcorso) FROM stdin;
    public          postgres    false    212   0                 0    24675    corsoformazione 
   TABLE DATA           g   COPY public.corsoformazione (nome, descrizione, presenzemin, maxpartecipanti, id, idcorso) FROM stdin;
    public          postgres    false    211   0                 0    24707    iscritto 
   TABLE DATA           D   COPY public.iscritto (data, orario, matricola, idcorso) FROM stdin;
    public          postgres    false    214   �0                 0    24697    lezione 
   TABLE DATA           f   COPY public.lezione (titolo, descrizione, durata, data, orarioinizio, idcorso, idlezione) FROM stdin;
    public          postgres    false    213   �0                 0    24670 	   operatore 
   TABLE DATA           J   COPY public.operatore (nome, cognome, data, id, cf, password) FROM stdin;
    public          postgres    false    210   �0                 0    24720 	   partecipa 
   TABLE DATA           G   COPY public.partecipa (data, orario, matricola, idlezione) FROM stdin;
    public          postgres    false    215   :1                 0    24661    studente 
   TABLE DATA           P   COPY public.studente (nome, cognome, data, cf, matricola, password) FROM stdin;
    public          postgres    false    209   W1       (           0    0    corsoformazione_idcorso_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.corsoformazione_idcorso_seq', 12, true);
          public          postgres    false    216            )           0    0    lezione_idlezione_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.lezione_idlezione_seq', 1, false);
          public          postgres    false    217            x           2606    24669    studente Studente_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.studente
    ADD CONSTRAINT "Studente_pkey" PRIMARY KEY (matricola);
 B   ALTER TABLE ONLY public.studente DROP CONSTRAINT "Studente_pkey";
       public            postgres    false    209            |           2606    24803    operatore UkCF 
   CONSTRAINT     I   ALTER TABLE ONLY public.operatore
    ADD CONSTRAINT "UkCF" UNIQUE (cf);
 :   ALTER TABLE ONLY public.operatore DROP CONSTRAINT "UkCF";
       public            postgres    false    210            z           2606    24805    studente UkCf 
   CONSTRAINT     H   ALTER TABLE ONLY public.studente
    ADD CONSTRAINT "UkCf" UNIQUE (cf);
 9   ALTER TABLE ONLY public.studente DROP CONSTRAINT "UkCf";
       public            postgres    false    209            �           2606    24850    iscritto Ukstud 
   CONSTRAINT     Z   ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT "Ukstud" UNIQUE (matricola, idcorso);
 ;   ALTER TABLE ONLY public.iscritto DROP CONSTRAINT "Ukstud";
       public            postgres    false    214    214            �           2606    24859 $   corsoformazione corsoformazione_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.corsoformazione
    ADD CONSTRAINT corsoformazione_pkey PRIMARY KEY (idcorso);
 N   ALTER TABLE ONLY public.corsoformazione DROP CONSTRAINT corsoformazione_pkey;
       public            postgres    false    211            �           2606    24869    lezione lezione_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.lezione
    ADD CONSTRAINT lezione_pkey PRIMARY KEY (idlezione);
 >   ALTER TABLE ONLY public.lezione DROP CONSTRAINT lezione_pkey;
       public            postgres    false    213            ~           2606    24674    operatore operatore_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.operatore
    ADD CONSTRAINT operatore_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.operatore DROP CONSTRAINT operatore_pkey;
       public            postgres    false    210            �           2606    24875    iscritto FkCorso    FK CONSTRAINT     �   ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT "FkCorso" FOREIGN KEY (idcorso) REFERENCES public.corsoformazione(idcorso) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 <   ALTER TABLE ONLY public.iscritto DROP CONSTRAINT "FkCorso";
       public          postgres    false    211    214    3200            �           2606    24880    areetematiche FkCorso    FK CONSTRAINT     �   ALTER TABLE ONLY public.areetematiche
    ADD CONSTRAINT "FkCorso" FOREIGN KEY (idcorso) REFERENCES public.corsoformazione(idcorso) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 A   ALTER TABLE ONLY public.areetematiche DROP CONSTRAINT "FkCorso";
       public          postgres    false    211    3200    212            �           2606    24885    lezione FkCorso    FK CONSTRAINT     �   ALTER TABLE ONLY public.lezione
    ADD CONSTRAINT "FkCorso" FOREIGN KEY (idcorso) REFERENCES public.corsoformazione(idcorso) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ;   ALTER TABLE ONLY public.lezione DROP CONSTRAINT "FkCorso";
       public          postgres    false    213    211    3200            �           2606    24870    partecipa FkLez    FK CONSTRAINT     �   ALTER TABLE ONLY public.partecipa
    ADD CONSTRAINT "FkLez" FOREIGN KEY (idlezione) REFERENCES public.lezione(idlezione) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ;   ALTER TABLE ONLY public.partecipa DROP CONSTRAINT "FkLez";
       public          postgres    false    3202    215    213            �           2606    24806    corsoformazione FkOp    FK CONSTRAINT     �   ALTER TABLE ONLY public.corsoformazione
    ADD CONSTRAINT "FkOp" FOREIGN KEY (id) REFERENCES public.operatore(id) ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.corsoformazione DROP CONSTRAINT "FkOp";
       public          postgres    false    211    210    3198            �           2606    24817    iscritto FkStud    FK CONSTRAINT     �   ALTER TABLE ONLY public.iscritto
    ADD CONSTRAINT "FkStud" FOREIGN KEY (matricola) REFERENCES public.studente(matricola) ON UPDATE CASCADE ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public.iscritto DROP CONSTRAINT "FkStud";
       public          postgres    false    3192    214    209            �           2606    24825    partecipa FkStud    FK CONSTRAINT     �   ALTER TABLE ONLY public.partecipa
    ADD CONSTRAINT "FkStud" FOREIGN KEY (matricola) REFERENCES public.studente(matricola) ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.partecipa DROP CONSTRAINT "FkStud";
       public          postgres    false    209    215    3192                  x������ � �         b   x�M�A
� ����aB���f�If��$�>�o�<�G�DU�Uto��6�=�x�|3TV%��fF.Q�J�����~`Q����%�G\'�	�n#1            x������ � �            x������ � �         `   x�%�K�  �u�����ō��4KD��f6�ԇ!K-�i	�	��#�j7��Y��ve�Zh(~k*%�]��t�·b$jr��R�$�            x������ � �         `   x�-�K
�0E�q���k5��8,%���������6=��ڽ*% ����A�r�B�q�v9��Ep0RL��xQ���������ُws��(�-     