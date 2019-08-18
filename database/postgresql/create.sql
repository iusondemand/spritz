--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: judgement; Type: TABLE; Schema: public; Owner: dinogen
--

CREATE TABLE public.judgement (
    votation_id integer NOT NULL,
    jud_value integer NOT NULL,
    jud_name character varying(50) NOT NULL
);


ALTER TABLE public.judgement OWNER TO dinogen;

--
-- Name: option; Type: TABLE; Schema: public; Owner: dinogen
--

CREATE TABLE public.option (
    option_id integer NOT NULL,
    votation_id integer,
    option_name character varying(50) NOT NULL,
    description character varying(250) NOT NULL
);


ALTER TABLE public.option OWNER TO dinogen;

--
-- Name: option_id_seq; Type: SEQUENCE; Schema: public; Owner: dinogen
--

CREATE SEQUENCE public.option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.option_id_seq OWNER TO dinogen;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: dinogen
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO dinogen;

--
-- Name: votation; Type: TABLE; Schema: public; Owner: dinogen
--

CREATE TABLE public.votation (
    votation_id integer NOT NULL,
    promoter_user_id integer,
    votation_description character varying(500) NOT NULL,
    description_url character varying(500) NOT NULL,
    begin_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    votation_type character varying(10) NOT NULL,
    votation_status integer NOT NULL,
    list_voters integer NOT NULL
);


ALTER TABLE public.votation OWNER TO dinogen;

--
-- Name: votation_id_seq; Type: SEQUENCE; Schema: public; Owner: dinogen
--

CREATE SEQUENCE public.votation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.votation_id_seq OWNER TO dinogen;

--
-- Name: vote; Type: TABLE; Schema: public; Owner: dinogen
--

CREATE TABLE public.vote (
    vote_key character varying(128) NOT NULL,
    votation_id integer NOT NULL,
    option_id integer NOT NULL,
    jud_value integer NOT NULL
);


ALTER TABLE public.vote OWNER TO dinogen;

--
-- Name: voter; Type: TABLE; Schema: public; Owner: dinogen
--

CREATE TABLE public.voter (
    user_id integer NOT NULL,
    votation_id integer NOT NULL,
    voted integer
);


ALTER TABLE public.voter OWNER TO dinogen;

--
-- Name: votinguser; Type: TABLE; Schema: public; Owner: dinogen
--

CREATE TABLE public.votinguser (
    user_id integer NOT NULL,
    user_name character varying(200) NOT NULL,
    pass_word character varying(200) NOT NULL,
    email character varying(200),
    verified integer
);


ALTER TABLE public.votinguser OWNER TO dinogen;

--
-- Data for Name: judgement; Type: TABLE DATA; Schema: public; Owner: dinogen
--

COPY public.judgement (votation_id, jud_value, jud_name) FROM stdin;
\.


--
-- Data for Name: option; Type: TABLE DATA; Schema: public; Owner: dinogen
--

COPY public.option (option_id, votation_id, option_name, description) FROM stdin;
\.


--
-- Data for Name: votation; Type: TABLE DATA; Schema: public; Owner: dinogen
--

COPY public.votation (votation_id, promoter_user_id, votation_description, description_url, begin_date, end_date, votation_type, votation_status, list_voters) FROM stdin;
\.


--
-- Data for Name: vote; Type: TABLE DATA; Schema: public; Owner: dinogen
--

COPY public.vote (vote_key, votation_id, option_id, jud_value) FROM stdin;
\.


--
-- Data for Name: voter; Type: TABLE DATA; Schema: public; Owner: dinogen
--

COPY public.voter (user_id, votation_id, voted) FROM stdin;
\.


--
-- Data for Name: votinguser; Type: TABLE DATA; Schema: public; Owner: dinogen
--

COPY public.votinguser (user_id, user_name, pass_word, email, verified) FROM stdin;
1	aldo	aldo	\N	\N
2	beppe	beppe	\N	\N
3	carlo	carlo	\N	\N
4	dario	dario	\N	\N
5	ernesto	ernesto	\N	\N
6	fabio	fabio	\N	\N
\.


--
-- Name: option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dinogen
--

SELECT pg_catalog.setval('public.option_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dinogen
--

SELECT pg_catalog.setval('public.user_id_seq', 6, true);


--
-- Name: votation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dinogen
--

SELECT pg_catalog.setval('public.votation_id_seq', 1, false);


--
-- Name: judgement judgement_pkey; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.judgement
    ADD CONSTRAINT judgement_pkey PRIMARY KEY (votation_id, jud_value);


--
-- Name: option option_pkey; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.option
    ADD CONSTRAINT option_pkey PRIMARY KEY (option_id);


--
-- Name: option option_votation_id_option_name_key; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.option
    ADD CONSTRAINT option_votation_id_option_name_key UNIQUE (votation_id, option_name);


--
-- Name: votation votation_pkey; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.votation
    ADD CONSTRAINT votation_pkey PRIMARY KEY (votation_id);


--
-- Name: votation votation_votation_description_key; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.votation
    ADD CONSTRAINT votation_votation_description_key UNIQUE (votation_description);


--
-- Name: vote vote_pkey; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_pkey PRIMARY KEY (vote_key, votation_id, option_id);


--
-- Name: voter voter_pkey; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.voter
    ADD CONSTRAINT voter_pkey PRIMARY KEY (user_id, votation_id);


--
-- Name: votinguser votinguser_pkey; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.votinguser
    ADD CONSTRAINT votinguser_pkey PRIMARY KEY (user_id);


--
-- Name: votinguser votinguser_user_name_key; Type: CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.votinguser
    ADD CONSTRAINT votinguser_user_name_key UNIQUE (user_name);


--
-- Name: judgement judgement_votation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.judgement
    ADD CONSTRAINT judgement_votation_id_fkey FOREIGN KEY (votation_id) REFERENCES public.votation(votation_id);


--
-- Name: option option_votation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.option
    ADD CONSTRAINT option_votation_id_fkey FOREIGN KEY (votation_id) REFERENCES public.votation(votation_id);


--
-- Name: votation votation_promoter_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.votation
    ADD CONSTRAINT votation_promoter_user_id_fkey FOREIGN KEY (promoter_user_id) REFERENCES public.votinguser(user_id);


--
-- Name: vote vote_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_option_id_fkey FOREIGN KEY (option_id) REFERENCES public.option(option_id);


--
-- Name: vote vote_votation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_votation_id_fkey FOREIGN KEY (votation_id) REFERENCES public.votation(votation_id);


--
-- Name: voter voter_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.voter
    ADD CONSTRAINT voter_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.votinguser(user_id);


--
-- Name: voter voter_votation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dinogen
--

ALTER TABLE ONLY public.voter
    ADD CONSTRAINT voter_votation_id_fkey FOREIGN KEY (votation_id) REFERENCES public.votation(votation_id);


--
-- PostgreSQL database dump complete
--

