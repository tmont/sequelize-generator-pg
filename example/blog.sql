--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.8
-- Dumped by pg_dump version 9.5.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = generator, pg_catalog;

ALTER TABLE IF EXISTS ONLY generator.post_category DROP CONSTRAINT IF EXISTS post_category_post_id_fk;
ALTER TABLE IF EXISTS ONLY generator.post_category DROP CONSTRAINT IF EXISTS post_category_category_id_fk;
ALTER TABLE IF EXISTS ONLY generator.post DROP CONSTRAINT IF EXISTS post_author_id_fk;
ALTER TABLE IF EXISTS ONLY generator.comment DROP CONSTRAINT IF EXISTS comment_post_id_fk;
ALTER TABLE IF EXISTS ONLY generator.comment DROP CONSTRAINT IF EXISTS comment_author_id_fk;
DROP INDEX IF EXISTS generator.post_title_uindex;
DROP INDEX IF EXISTS generator.category_name_uindex;
DROP INDEX IF EXISTS generator.author_name_uindex;
ALTER TABLE IF EXISTS ONLY generator.post DROP CONSTRAINT IF EXISTS post_pkey;
ALTER TABLE IF EXISTS ONLY generator.post_category DROP CONSTRAINT IF EXISTS post_category_category_id_post_id_pk;
ALTER TABLE IF EXISTS ONLY generator.comment DROP CONSTRAINT IF EXISTS comment_pkey;
ALTER TABLE IF EXISTS ONLY generator.category DROP CONSTRAINT IF EXISTS category_pkey;
ALTER TABLE IF EXISTS ONLY generator.author DROP CONSTRAINT IF EXISTS author_pkey;
ALTER TABLE IF EXISTS generator.post ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS generator.comment ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS generator.category ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS generator.author ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS generator.post_id_seq;
DROP TABLE IF EXISTS generator.post_category;
DROP TABLE IF EXISTS generator.post;
DROP SEQUENCE IF EXISTS generator.comment_id_seq;
DROP TABLE IF EXISTS generator.comment;
DROP SEQUENCE IF EXISTS generator.category_id_seq;
DROP TABLE IF EXISTS generator.category;
DROP SEQUENCE IF EXISTS generator.author_id_seq;
DROP TABLE IF EXISTS generator.author;
DROP SCHEMA IF EXISTS generator;
--
-- Name: generator; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA generator;


SET search_path = generator, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: author; Type: TABLE; Schema: generator; Owner: -
--

CREATE TABLE author (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: author_id_seq; Type: SEQUENCE; Schema: generator; Owner: -
--

CREATE SEQUENCE author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: author_id_seq; Type: SEQUENCE OWNED BY; Schema: generator; Owner: -
--

ALTER SEQUENCE author_id_seq OWNED BY author.id;


--
-- Name: category; Type: TABLE; Schema: generator; Owner: -
--

CREATE TABLE category (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: category_id_seq; Type: SEQUENCE; Schema: generator; Owner: -
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: generator; Owner: -
--

ALTER SEQUENCE category_id_seq OWNED BY category.id;


--
-- Name: comment; Type: TABLE; Schema: generator; Owner: -
--

CREATE TABLE comment (
    id integer NOT NULL,
    post_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    author_id integer NOT NULL
);


--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: generator; Owner: -
--

CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: generator; Owner: -
--

ALTER SEQUENCE comment_id_seq OWNED BY comment.id;


--
-- Name: post; Type: TABLE; Schema: generator; Owner: -
--

CREATE TABLE post (
    id integer NOT NULL,
    author_id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    published_at timestamp with time zone
);


--
-- Name: post_category; Type: TABLE; Schema: generator; Owner: -
--

CREATE TABLE post_category (
    post_id integer NOT NULL,
    category_id integer NOT NULL
);


--
-- Name: post_id_seq; Type: SEQUENCE; Schema: generator; Owner: -
--

CREATE SEQUENCE post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: generator; Owner: -
--

ALTER SEQUENCE post_id_seq OWNED BY post.id;


--
-- Name: id; Type: DEFAULT; Schema: generator; Owner: -
--

ALTER TABLE ONLY author ALTER COLUMN id SET DEFAULT nextval('author_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: generator; Owner: -
--

ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: generator; Owner: -
--

ALTER TABLE ONLY comment ALTER COLUMN id SET DEFAULT nextval('comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: generator; Owner: -
--

ALTER TABLE ONLY post ALTER COLUMN id SET DEFAULT nextval('post_id_seq'::regclass);


--
-- Name: author_pkey; Type: CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY author
    ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: post_category_category_id_post_id_pk; Type: CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY post_category
    ADD CONSTRAINT post_category_category_id_post_id_pk PRIMARY KEY (category_id, post_id);


--
-- Name: post_pkey; Type: CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: author_name_uindex; Type: INDEX; Schema: generator; Owner: -
--

CREATE UNIQUE INDEX author_name_uindex ON author USING btree (name);


--
-- Name: category_name_uindex; Type: INDEX; Schema: generator; Owner: -
--

CREATE UNIQUE INDEX category_name_uindex ON category USING btree (name);


--
-- Name: post_title_uindex; Type: INDEX; Schema: generator; Owner: -
--

CREATE UNIQUE INDEX post_title_uindex ON post USING btree (title);


--
-- Name: comment_author_id_fk; Type: FK CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_author_id_fk FOREIGN KEY (author_id) REFERENCES author(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_post_id_fk; Type: FK CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_post_id_fk FOREIGN KEY (post_id) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post_author_id_fk; Type: FK CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_author_id_fk FOREIGN KEY (author_id) REFERENCES author(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: post_category_category_id_fk; Type: FK CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY post_category
    ADD CONSTRAINT post_category_category_id_fk FOREIGN KEY (category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post_category_post_id_fk; Type: FK CONSTRAINT; Schema: generator; Owner: -
--

ALTER TABLE ONLY post_category
    ADD CONSTRAINT post_category_post_id_fk FOREIGN KEY (post_id) REFERENCES post(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

