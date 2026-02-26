--
-- PostgreSQL database dump
--

\restrict juwP0O06SlCvwe9lyNsoYIp3v6edTwLYDtxUWWYStjbpsBP78F6z4xPCJ4y3QeY

-- Dumped from database version 17.8 (6108b59)
-- Dumped by pg_dump version 17.7 (Ubuntu 17.7-3.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: UserStoryPriority; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public."UserStoryPriority" AS ENUM (
    'Low',
    'Medium',
    'High'
);


ALTER TYPE public."UserStoryPriority" OWNER TO neondb_owner;

--
-- Name: UserStoryStatus; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public."UserStoryStatus" AS ENUM (
    'BACKLOG',
    'TO_DO',
    'DOING',
    'TO_TEST',
    'ISSUE',
    'DONE'
);


ALTER TYPE public."UserStoryStatus" OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Sprint; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public."Sprint" (
    id integer NOT NULL,
    name text NOT NULL,
    goal text,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    status text DEFAULT 'planned'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Sprint" OWNER TO neondb_owner;

--
-- Name: Sprint_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public."Sprint_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Sprint_id_seq" OWNER TO neondb_owner;

--
-- Name: Sprint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public."Sprint_id_seq" OWNED BY public."Sprint".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    role text DEFAULT 'teammate'::text NOT NULL
);


ALTER TABLE public."User" OWNER TO neondb_owner;

--
-- Name: UserStory; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public."UserStory" (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    "userId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "sprintId" integer,
    status public."UserStoryStatus" DEFAULT 'BACKLOG'::public."UserStoryStatus" NOT NULL,
    priority public."UserStoryPriority" DEFAULT 'Medium'::public."UserStoryPriority" NOT NULL,
    "position" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."UserStory" OWNER TO neondb_owner;

--
-- Name: UserStory_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public."UserStory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserStory_id_seq" OWNER TO neondb_owner;

--
-- Name: UserStory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public."UserStory_id_seq" OWNED BY public."UserStory".id;


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO neondb_owner;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO neondb_owner;

--
-- Name: Sprint id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."Sprint" ALTER COLUMN id SET DEFAULT nextval('public."Sprint_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserStory id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."UserStory" ALTER COLUMN id SET DEFAULT nextval('public."UserStory_id_seq"'::regclass);


--
-- Data for Name: Sprint; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public."Sprint" (id, name, goal, "startDate", "endDate", status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public."User" (id, name, email, password, "createdAt", "updatedAt", role) FROM stdin;
2	tesT	test@test.com	$2b$10$B2dmvfpmkGlH8uTGbKqwe.67.iL9Yr/UVAvvJ2ZyX.oa4SfcMPB8a	2026-02-10 01:54:18.357	2026-02-10 01:54:18.357	tester
3	test01	test01@test01.com	$2b$10$1hRBSLZWznHQ5pSuRjZQluwSgspVvwrLGwVDTLbsrnF0/sOE2r51S	2026-02-10 02:37:30.655	2026-02-10 02:37:30.655	scrum master
4	ATTA	quant@quant.com	$2b$10$.wK8QY1pcn0DAAdJBPs5peojQ/uCCMioz.c4TAwlTv0giCxlYpK.K	2026-02-10 03:38:44.748	2026-02-10 03:38:44.748	teammate
5	testO2	test02@test.com	$2b$10$mfbAXyv3bCCYvB9HeHXs8.vdjuxkbUQJymvxv7es8O5drvSD6L/9y	2026-02-10 03:39:41.121	2026-02-10 03:39:41.121	teammate
1	Blabla	blabla@blabla.fr	$2b$10$z0/YbIfMlDKwg3wSxESD2.Fd1yUbCWnV.diBJoroUP4XK8CwK4hCa	2026-02-10 00:40:08.87	2026-02-10 04:22:42.444	developer
6	testv	testv@testv.com	$2b$10$0ixmmrGYQ2XGSqxJY0Ob0uHQw/KsgbXneBwIVB5DwzA.Gl5J6xkoG	2026-02-10 07:11:15.619	2026-02-10 07:11:15.619	teammate
7	testf	testf@testf.fr	$2b$10$.K70kAzftWc.h4yKB6rfxuVabdfxwJ5iqeK2JK2wxqWgf9t7DCgGG	2026-02-10 07:15:54.875	2026-02-10 07:15:54.875	teammate
8	blibli	blibli@blibli.fr	$2b$10$IXsALwHWC0vrlTBccLF2S.nvRuJJkZOYzRDrTbXUvaLstG79x1edK	2026-02-10 07:30:37.583	2026-02-10 07:30:37.583	teammate
10	Formateur	formateur@agilflow.app	$2b$10$ueimZ9GyqVevf2BJ.TQuvOkA8pk6BeZVP/PNH3fc8qXqlW1YKIUwK	2026-02-12 08:11:56.374	2026-02-12 08:11:56.374	administrator
11	Nofdf	testzod@zod.fr	$2b$10$27.PSovCw4LNNhb3D/ZurOzsx2PNCeJr59R2Zo9gJ.JkXL5A37XrG	2026-02-25 13:40:55.066	2026-02-25 13:40:55.066	teammate
12	jflsdkfjsdlk	sometest@test.test	$2b$10$TDtTVmWg24vaQz.7CQDcCOOEPcSpF8Up0Kl5Dt09CpaNu9C81vdSu	2026-02-25 18:21:00.627	2026-02-25 18:21:00.627	teammate
9	tester	test@test.test	$2b$10$hYe8dHQS/Udwscg0AusRK.QATbXh01UjgasjEg92cCgLNkMGGYXTi	2026-02-10 17:26:34.385	2026-02-25 18:31:34.861	tester
13	glalga	glalga@glagla.fr	$2b$10$h81BYPIlS.59QI77NUeEOuQ1up33y3DGTgrmJMToraPzwvZk2KAs.	2026-02-25 23:55:36.68	2026-02-25 23:55:36.68	scrum master
14	Glouglou	glouglou@glouglou.glou	$2b$10$nt94jJQRJmimqg.WUC9q1.cqo.4m82WldGS5mTXLJ8owe3qDzjDKO	2026-02-25 23:57:14.947	2026-02-26 00:03:46.587	product owner
\.


--
-- Data for Name: UserStory; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public."UserStory" (id, title, description, "userId", "createdAt", "updatedAt", "sprintId", status, priority, "position") FROM stdin;
3	3333333333"	333333333333333333333	1	2026-02-10 00:44:21.713	2026-02-10 00:44:21.713	\N	DONE	High	0
31	En tant que US de test, je veux US de test	Afin de US de test	9	2026-02-25 18:12:14.238	2026-02-26 09:34:49.403	\N	ISSUE	Low	0
1	1111111111111	1111111111111111111111	1	2026-02-10 00:41:59.545	2026-02-10 00:45:46.824	\N	TO_DO	Medium	0
2	222222222é	222222222222222	1	2026-02-10 00:42:14.438	2026-02-10 00:45:56.829	\N	DOING	High	0
4	44444444''	4444444444444'	1	2026-02-10 00:46:12.107	2026-02-10 00:46:12.107	\N	TO_DO	Low	0
6	666666	66666666666	1	2026-02-10 01:41:23.447	2026-02-10 01:41:23.447	\N	TO_DO	High	0
29	En tant que Admin, je veux hgksdsf	Afin de hgkjfsdkjfsdkf	11	2026-02-25 13:41:56.4	2026-02-25 13:43:39.551	\N	DONE	Medium	0
7	7777777777	7777777777777777777	1	2026-02-10 01:41:38.556	2026-02-10 01:41:38.556	\N	TO_DO	Low	0
8	88888888	88888888888888	1	2026-02-10 01:42:00.431	2026-02-10 01:42:00.431	\N	TO_DO	Low	0
9	99999999999999	99999999999999	1	2026-02-10 01:42:19.921	2026-02-10 01:42:19.921	\N	TO_DO	Medium	0
10	1000000000000	0100000000000	1	2026-02-10 01:42:35.075	2026-02-10 01:42:35.075	\N	DOING	Medium	0
32	En tant que admin, je veux vvv	Afin de vvv	12	2026-02-25 18:21:58.537	2026-02-25 18:29:50.13	\N	TO_DO	Medium	0
35	En tant que gdfghdg, je veux fdsgdfggsf	Afin de fdgdfgdfgd	14	2026-02-25 23:58:49.498	2026-02-25 23:59:14.484	\N	BACKLOG	Low	0
21	En tant que Utilisateur connecté, je veux Modifier les informations de mon profil (nom, avatar, bio)	Afin de Garder mes informations à jour dans la base de données	9	2026-02-10 17:29:06.886	2026-02-26 09:34:40.926	\N	TO_TEST	Low	0
11	1111111111111&	111111111111111111	1	2026-02-10 01:55:04.031	2026-02-10 01:55:04.031	\N	DONE	High	0
12	Cas de test 01 UPDATED	fhdskjfbzdk:fhsfqhfhfk:jsdf	1	2026-02-10 02:50:24.23	2026-02-10 02:51:37.221	\N	DOING	Low	0
14	ffsdfsd:fsd:f	sd;fnsd;fnsd;,fs	1	2026-02-10 02:54:43.724	2026-02-10 02:54:43.724	\N	DONE	Medium	0
15	sdfsdfsf	fsdgsdgsfsfsdfs	1	2026-02-10 02:54:57.57	2026-02-10 02:54:57.57	\N	DONE	Low	0
16	fdgfdgsgdq	fdfhdfgdfhf	1	2026-02-10 03:50:09.255	2026-02-10 03:50:09.255	\N	DOING	High	0
17	jdfsdfsdf;sn	1Y	1	2026-02-10 03:51:10.482	2026-02-10 03:51:10.482	\N	DONE	High	0
18	En tant que admin, je veux pouvoir contrôler les logs	Afin de vérifier que tout se passe comme prévu par le SI	1	2026-02-10 05:35:02.887	2026-02-10 05:35:59.399	\N	DONE	High	0
19	En tant que fsfsdgsdg, je veux fusdilgusdli	Afin de ieui	1	2026-02-10 11:08:07.583	2026-02-10 11:08:45.202	\N	DONE	High	0
25	En tant que utilisateur, je veux pouvoir me connecter via un formulaire securise	Afin de d'accéder à mon compte	10	2026-02-12 08:12:43.365	2026-02-12 08:12:55.581	\N	DONE	Medium	0
26	En tant que utilisateur, je veux pouvoir creer et gerer mes user stories	Afin de centraliser la gestion des tâches et suivre leur avancement en temps réel.	10	2026-02-12 08:13:37.631	2026-02-12 08:14:06.975	\N	DONE	High	0
20	En tant que Utilisateur inscrit, je veux Me connecter via un formulaire sécurisé (Email/Mot de passe)	Afin de Accéder à mon espace personnel et à mes données privées	9	2026-02-10 17:28:19.143	2026-02-25 13:24:49.353	\N	DONE	High	0
23	En tant que Développeur, je veux Implémenter des schémas de validation sur tous les formulaires d'entrée	Afin de Garantir l'intégrité des données avant leur insertion en base	9	2026-02-10 17:30:36.222	2026-02-25 13:47:45.909	\N	DOING	Medium	0
28	En tant que admin, je veux pouvoir monitorer tous les changements en un clin d'oeil	Afin de garantir la sécurité, la compliance RGPD et la MCO	9	2026-02-24 22:51:13.837	2026-02-25 13:47:56.496	\N	BACKLOG	Medium	0
22	En tant que Administrateur système, je veux Consulter les logs d'erreurs générés en format JSON	Afin de Détecter rapidement les tentatives d'intrusion ou les bugs critiques	9	2026-02-10 17:29:53.651	2026-02-25 13:48:01.284	\N	TO_DO	High	0
24	En tant que Administrateur système, je veux Limiter le pool de connexions à la base de données (max 5)	Afin de Éviter la saturation des ressources du serveur en environnement de test	9	2026-02-10 17:32:13.321	2026-02-25 13:48:28.766	\N	DONE	Low	0
34	En tant que kjfsdlkjfsdlkj, je veux jvslkfsdlkfsjdlfqjflk	Afin de jfsdlkvjdlkfsdlfkqjlfi	12	2026-02-25 18:24:10.465	2026-02-25 18:29:17.013	\N	TO_DO	Medium	0
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
3c27b1db-1d58-40b8-a474-6879635f1e9e	e7142f1229d80a711c2f70c01158b2a8344406d5ee8858a24485034fb6ef0bb5	2026-02-10 00:06:29.232893+00	20260210000628_init	\N	\N	2026-02-10 00:06:29.084119+00	1
2e83bc3b-654b-4c89-9735-ea0c22cfac2f	89f493313042f1fc2620ba9744a1a10a2eb7d73b30114f468313e4b16f35b522	2026-02-10 00:32:11.787991+00	20260210003211_add_user_role	\N	\N	2026-02-10 00:32:11.628889+00	1
0fb24f20-4473-4be5-8451-b2ed64790c4c	b2598d4d41521fb8af3567f17b7daf6979eb964692b1b7e35b3330fdc9536a9b	2026-02-10 08:02:05.680707+00	20260210080205_add_sprints	\N	\N	2026-02-10 08:02:05.489297+00	1
\.


--
-- Name: Sprint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public."Sprint_id_seq"', 1, false);


--
-- Name: UserStory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public."UserStory_id_seq"', 37, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public."User_id_seq"', 14, true);


--
-- Name: Sprint Sprint_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."Sprint"
    ADD CONSTRAINT "Sprint_pkey" PRIMARY KEY (id);


--
-- Name: UserStory UserStory_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."UserStory"
    ADD CONSTRAINT "UserStory_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: UserStory_sprintId_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX "UserStory_sprintId_idx" ON public."UserStory" USING btree ("sprintId");


--
-- Name: UserStory_userId_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX "UserStory_userId_idx" ON public."UserStory" USING btree ("userId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: idx_userstory_priority; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_userstory_priority ON public."UserStory" USING btree (priority);


--
-- Name: idx_userstory_status; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_userstory_status ON public."UserStory" USING btree (status);


--
-- Name: idx_userstory_status_position; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_userstory_status_position ON public."UserStory" USING btree (status, "position");


--
-- Name: UserStory UserStory_sprintId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."UserStory"
    ADD CONSTRAINT "UserStory_sprintId_fkey" FOREIGN KEY ("sprintId") REFERENCES public."Sprint"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: UserStory UserStory_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public."UserStory"
    ADD CONSTRAINT "UserStory_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict juwP0O06SlCvwe9lyNsoYIp3v6edTwLYDtxUWWYStjbpsBP78F6z4xPCJ4y3QeY

