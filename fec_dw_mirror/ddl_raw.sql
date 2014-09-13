
-- TODO: file Blaze bug - Columns that are NUMBER(14,2) in Oracle come across as INTEGER!
-- ex: DESC SCHED_D - SEE OUTSTG_BAL_BOP
-- had to change _id and _sk integers to bigint, all others to numeric

CREATE EXTENSION oracle_fdw;
DROP SERVER oradb CASCADE;
CREATE SERVER oradb FOREIGN DATA WRAPPER oracle_fdw
          OPTIONS (dbserver '//172.16.129.22/PROCUAT.FEC.GOV');
GRANT USAGE ON FOREIGN SERVER oradb TO "ec2-user";

DROP USER MAPPING FOR "ec2-user" SERVER oradb;
CREATE USER MAPPING FOR "ec2-user" SERVER oradb
          OPTIONS (user 'READONLY', 
                   password 'password-not-really-in-version-control-of-course');

DROP SCHEMA frn;
CREATE SCHEMA frn;

CREATE FOREIGN TABLE frn.dimcand (
    cand_sk bigint NOT NULL,
    cand_id text,
    form_sk bigint,
    form_tp text,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMCAND');

SELECT * FROM frn.dimcand LIMIT 1;

CREATE FOREIGN TABLE frn.dimcandoffice (
    candoffice_sk bigint NOT NULL,
    cand_sk bigint,
    office_sk bigint,
    party_sk bigint,
    form_sk bigint,
    form_tp text,
    cand_election_yr numeric,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMCANDOFFICE');


ALTER TABLE public.dimcandoffice OWNER TO "ec2-user";

--
-- Name: dimcandproperties; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimcandproperties (
    candproperties_sk bigint NOT NULL,
    cand_sk bigint NOT NULL,
    form_sk bigint,
    form_tp text,
    cand_nm text,
    cand_l_nm text,
    cand_f_nm text,
    cand_m_nm text,
    cand_prefix text,
    cand_suffix text,
    cand_st1 text,
    cand_st2 text,
    cand_city text,
    cand_st text,
    cand_zip text,
    cand_status_cd text,
    cand_status_desc text,
    cand_ici_cd text,
    cand_ici_desc text,
    prim_pers_funds_decl numeric,
    gen_pers_funds_decl numeric,
    load_date timestamp without time zone,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMCANDPROPERTIES');


ALTER TABLE public.dimcandproperties OWNER TO "ec2-user";

--
-- Name: dimcandstatusici; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimcandstatusici (
    candstatusici_sk bigint NOT NULL,
    cand_sk bigint,
    election_yr number NOT NULL,
    ici_code text,
    cand_status text,
    cand_inactive_flg text,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMCANDSTATUSICI');


ALTER TABLE public.dimcandstatusici OWNER TO "ec2-user";

--
-- Name: dimcmte; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimcmte (
    cmte_sk bigint NOT NULL,
    cmte_id text,
    form_sk bigint,
    form_tp text,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMCMTE');


ALTER TABLE public.dimcmte OWNER TO "ec2-user";

--
-- Name: dimcmteproperties; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimcmteproperties (
    cmteproperties_sk bigint NOT NULL,
    cmte_sk bigint,
    form_sk bigint,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    cmte_st1 text,
    cmte_st2 text,
    cmte_city text,
    cmte_st text,
    cmte_st_desc text,
    cmte_zip text,
    cmte_fax text,
    cmte_email text,
    cmte_web_url text,
    party_cmte_type text,
    party_cmte_type_desc text,
    filing_freq text,
    qual_dt timestamp without time zone,
    cand_id text,
    org_tp text,
    org_tp_desc text,
    lobbyist_registrant_pac_flg text,
    leadership_pac text,
    cmte_treasurer_nm text,
    cmte_treasurer_l_nm text,
    cmte_treasurer_f_nm text,
    cmte_treasurer_m_nm text,
    cmte_treasurer_prefix text,
    cmte_treasurer_suffix text,
    cmte_treasurer_st1 text,
    cmte_treasurer_st2 text,
    cmte_treasurer_city text,
    cmte_treasurer_st text,
    cmte_treasurer_zip text,
    cmte_treasurer_title text,
    cmte_treasurer_ph_num text,
    cmte_custodian_nm text,
    cmte_custodian_l_nm text,
    cmte_custodian_f_nm text,
    cmte_custodian_m_nm text,
    cmte_custodian_prefix text,
    cmte_custodian_suffix text,
    cmte_custodian_st1 text,
    cmte_custodian_st2 text,
    cmte_custodian_city text,
    cmte_custodian_st text,
    cmte_custodian_zip text,
    cmte_custodian_title text,
    cmte_custodian_ph_num text,
    orig_registration_dt timestamp without time zone,
    fiftyfirst_cand_contbr_dt timestamp without time zone,
    affiliation_dt timestamp without time zone,
    affiliated_cmte_id text,
    affiliated_cmte_nm text,
    fst_cand_id text,
    fst_cand_nm text,
    fst_cand_office text,
    fst_cand_office_st text,
    fst_cand_office_district text,
    fst_cand_contb_dt timestamp without time zone,
    sec_cand_id text,
    sec_cand_nm text,
    sec_cand_office text,
    sec_cand_office_st text,
    sec_cand_office_district text,
    sec_cand_contb_dt timestamp without time zone,
    trd_cand_id text,
    trd_cand_nm text,
    trd_cand_office text,
    trd_cand_office_st text,
    trd_cand_office_district text,
    trd_cand_contb_dt timestamp without time zone,
    frth_cand_id text,
    frth_cand_nm text,
    frth_cand_office text,
    frth_cand_office_st text,
    frth_cand_office_district text,
    frth_cand_contb_dt timestamp without time zone,
    fith_cand_id text,
    fith_cand_nm text,
    fith_cand_office text,
    fith_cand_office_st text,
    fith_cand_office_district text,
    fith_cand_contb_dt timestamp without time zone,
    load_date timestamp without time zone,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMCMTEPROPERTIES');


ALTER TABLE public.dimcmteproperties OWNER TO "ec2-user";

--
-- Name: dimcmtetpdsgn; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimcmtetpdsgn (
    cmte_tpdgn_sk bigint NOT NULL,
    cmte_sk bigint NOT NULL,
    cmte_tp text,
    cmte_dsgn text,
    receipt_date timestamp without time zone,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMCMTETPDSGN');


ALTER TABLE public.dimcmtetpdsgn OWNER TO "ec2-user";

--
-- Name: dimdates; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimdates (
    date_sk bigint NOT NULL,
    dw_date timestamp without time zone,
    load_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMDATES');


ALTER TABLE public.dimdates OWNER TO "ec2-user";

--
-- Name: dimelectiontp; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimelectiontp (
    electiontp_sk bigint NOT NULL,
    election_type_id text NOT NULL,
    election_type_desc text,
    load_date timestamp without time zone,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMELECTIONTP');


ALTER TABLE public.dimelectiontp OWNER TO "ec2-user";

--
-- Name: dimlinkages; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimlinkages (
    linkages_sk bigint NOT NULL,
    cand_sk bigint NOT NULL,
    cmte_sk bigint NOT NULL,
    cand_id text,
    cand_election_yr numeric,
    cmte_id text,
    cmte_tp text,
    cmte_dsgn text,
    link_date timestamp without time zone,
    load_date timestamp without time zone,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMLINKAGES');


ALTER TABLE public.dimlinkages OWNER TO "ec2-user";

--
-- Name: dimoffice; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimoffice (
    office_sk bigint NOT NULL,
    office_tp text,
    office_tp_desc text,
    office_state text,
    office_district text,
    load_date timestamp without time zone,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMOFFICE');


ALTER TABLE public.dimoffice OWNER TO "ec2-user";

--
-- Name: dimparty; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimparty (
    party_sk bigint NOT NULL,
    party_affiliation text,
    party_affiliation_desc text,
    load_date timestamp without time zone,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMPARTY');


ALTER TABLE public.dimparty OWNER TO "ec2-user";

--
-- Name: dimreporttype; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimreporttype (
    reporttype_sk bigint NOT NULL,
    rpt_tp text,
    rpt_tp_desc text,
    load_date timestamp without time zone,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMREPORTTYPE');


ALTER TABLE public.dimreporttype OWNER TO "ec2-user";

--
-- Name: dimyears; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.dimyears (
    year_sk bigint NOT NULL,
    year numeric,
    load_date timestamp without time zone NOT NULL
) SERVER oradb OPTIONS (schema 'CFDM', table 'DIMYEARS');


ALTER TABLE public.dimyears OWNER TO "ec2-user";

--
-- Name: facthousesenate_f3; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.facthousesenate_f3 (
    facthousesenate_f3_sk bigint NOT NULL,
    form_3_sk bigint,
    cmte_sk bigint,
    reporttype_sk bigint,
    two_yr_period_sk bigint,
    transaction_sk bigint,
    cvg_start_dt_sk bigint,
    cvg_end_dt_sk bigint,
    electiontp_sk bigint,
    rpt_yr numeric,
    ttl_contb_per numeric,
    ttl_contb_ref_per numeric,
    net_contb_per numeric,
    ttl_op_exp_per numeric,
    ttl_offsets_to_op_exp_per numeric,
    net_op_exp_per numeric,
    coh_cop_i numeric,
    debts_owed_to_cmte numeric,
    debts_owed_by_cmte numeric,
    indv_item_contb_per numeric,
    indv_unitem_contb_per numeric,
    ttl_indv_contb_per numeric,
    pol_pty_cmte_contb_per numeric,
    other_pol_cmte_contb_per numeric,
    cand_contb_per numeric,
    ttl_contb_column_ttl_per numeric,
    tranf_from_other_auth_cmte_per numeric,
    loans_made_by_cand_per numeric,
    all_other_loans_per numeric,
    ttl_loans_per numeric,
    offsets_to_op_exp_per numeric,
    other_receipts_per numeric,
    ttl_receipts_per_i numeric,
    op_exp_per numeric,
    tranf_to_other_auth_cmte_per numeric,
    loan_repymts_cand_loans_per numeric,
    loan_repymts_other_loans_per numeric,
    ttl_loan_repymts_per numeric,
    ref_indv_contb_per numeric,
    ref_pol_pty_cmte_contb_per numeric,
    ref_other_pol_cmte_contb_per numeric,
    ttl_contb_ref_col_ttl_per numeric,
    other_disb_per numeric,
    ttl_disb_per_i numeric,
    coh_bop numeric,
    ttl_receipts_ii numeric,
    subttl_per numeric,
    ttl_disb_per_ii numeric,
    coh_cop_ii numeric,
    ttl_contb_ytd numeric,
    ttl_contb_ref_ytd numeric,
    net_contb_ytd numeric,
    ttl_op_exp_ytd numeric,
    ttl_offsets_to_op_exp_ytd numeric,
    net_op_exp_ytd numeric,
    ttl_indv_item_contb_ytd numeric,
    ttl_indv_unitem_contb_ytd numeric,
    ttl_indv_contb_ytd numeric,
    pol_pty_cmte_contb_ytd numeric,
    other_pol_cmte_contb_ytd numeric,
    cand_contb_ytd numeric,
    ttl_contb_col_ttl_ytd numeric,
    tranf_from_other_auth_cmte_ytd numeric,
    loans_made_by_cand_ytd numeric,
    all_other_loans_ytd numeric,
    ttl_loans_ytd numeric,
    offsets_to_op_exp_ytd numeric,
    other_receipts_ytd numeric,
    ttl_receipts_ytd numeric,
    op_exp_ytd numeric,
    tranf_to_other_auth_cmte_ytd numeric,
    loan_repymts_cand_loans_ytd numeric,
    loan_repymts_other_loans_ytd numeric,
    ttl_loan_repymts_ytd numeric,
    ref_indv_contb_ytd numeric,
    ref_pol_pty_cmte_contb_ytd numeric,
    ref_other_pol_cmte_contb_ytd numeric,
    ref_ttl_contb_col_ttl_ytd numeric,
    other_disb_ytd numeric,
    ttl_disb_ytd numeric,
    grs_rcpt_auth_cmte_prim numeric,
    agr_amt_contrib_pers_fund_prim numeric,
    grs_rcpt_min_pers_contrib_prim numeric,
    grs_rcpt_auth_cmte_gen numeric,
    agr_amt_pers_contrib_gen numeric,
    grs_rcpt_min_pers_contrib_gen numeric,
    begin_image_num numeric,
    end_image_num numeric,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FACTHOUSESENATE_F3');


ALTER TABLE public.facthousesenate_f3 OWNER TO "ec2-user";

--
-- Name: factpacsandparties_f3x; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.factpacsandparties_f3x (
    factpacsandparties_f3x_sk bigint NOT NULL,
    form_3x_sk bigint,
    cmte_sk bigint,
    reporttype_sk bigint,
    two_yr_period_sk bigint,
    transaction_sk bigint,
    cvg_start_dt_sk bigint,
    cvg_end_dt_sk bigint,
    electiontp_sk bigint,
    rpt_yr numeric,
    coh_bop numeric,
    ttl_receipts_sum_page_per numeric,
    subttl_sum_page_per numeric,
    ttl_disb_sum_page_per numeric,
    coh_cop numeric,
    debts_owed_to_cmte numeric,
    debts_owed_by_cmte numeric,
    indv_item_contb_per numeric,
    indv_unitem_contb_per numeric,
    ttl_indv_contb numeric,
    pol_pty_cmte_contb_per_i numeric,
    other_pol_cmte_contb_per_i numeric,
    ttl_contb_col_ttl_per numeric,
    tranf_from_affiliated_pty_per numeric,
    all_loans_received_per numeric,
    loan_repymts_received_per numeric,
    offsets_to_op_exp_per_i numeric,
    fed_cand_contb_ref_per numeric,
    other_fed_receipts_per numeric,
    tranf_from_nonfed_acct_per numeric,
    ttl_receipts_per numeric,
    ttl_fed_receipts_per numeric,
    shared_fed_op_exp_per numeric,
    shared_nonfed_op_exp_per numeric,
    other_fed_op_exp_per numeric,
    ttl_op_exp_per numeric,
    tranf_to_affliliated_cmte_per numeric,
    fed_cand_cmte_contb_per numeric,
    indt_exp_per numeric,
    coord_exp_by_pty_cmte_per numeric,
    loan_repymts_made_per numeric,
    loans_made_per numeric,
    indv_contb_ref_per numeric,
    pol_pty_cmte_contb_per_ii numeric,
    other_pol_cmte_contb_per_ii numeric,
    ttl_contb_ref_per_i numeric,
    other_disb_per numeric,
    ttl_disb_per numeric,
    ttl_fed_disb_per numeric,
    ttl_contb_per numeric,
    ttl_contb_ref_per_ii numeric,
    net_contb_per numeric,
    ttl_fed_op_exp_per numeric,
    offsets_to_op_exp_per_ii numeric,
    net_op_exp_per numeric,
    coh_begin_calendar_yr numeric,
    calendar_yr numeric,
    ttl_receipts_sum_page_ytd numeric,
    subttl_sum_ytd numeric,
    ttl_disb_sum_page_ytd numeric,
    coh_coy numeric,
    indv_item_contb_ytd numeric,
    indv_unitem_contb_ytd numeric,
    ttl_indv_contb_ytd numeric,
    pol_pty_cmte_contb_ytd_i numeric,
    other_pol_cmte_contb_ytd_i numeric,
    ttl_contb_col_ttl_ytd numeric,
    tranf_from_affiliated_pty_ytd numeric,
    all_loans_received_ytd numeric,
    loan_repymts_received_ytd numeric,
    offsets_to_op_exp_ytd_i numeric,
    fed_cand_cmte_contb_ytd numeric,
    other_fed_receipts_ytd numeric,
    tranf_from_nonfed_acct_ytd numeric,
    ttl_receipts_ytd numeric,
    ttl_fed_receipts_ytd numeric,
    shared_fed_op_exp_ytd numeric,
    shared_nonfed_op_exp_ytd numeric,
    other_fed_op_exp_ytd numeric,
    ttl_op_exp_ytd numeric,
    tranf_to_affilitated_cmte_ytd numeric,
    fed_cand_cmte_contb_ref_ytd numeric,
    indt_exp_ytd numeric,
    coord_exp_by_pty_cmte_ytd numeric,
    loan_repymts_made_ytd numeric,
    loans_made_ytd numeric,
    indv_contb_ref_ytd numeric,
    pol_pty_cmte_contb_ytd_ii numeric,
    other_pol_cmte_contb_ytd_ii numeric,
    ttl_contb_ref_ytd_i numeric,
    other_disb_ytd numeric,
    ttl_disb_ytd numeric,
    ttl_fed_disb_ytd numeric,
    ttl_contb_ytd numeric,
    ttl_contb_ref_ytd_ii numeric,
    net_contb_ytd numeric,
    ttl_fed_op_exp_ytd numeric,
    offsets_to_op_exp_ytd_ii numeric,
    net_op_exp_ytd numeric,
    tranf_from_nonfed_levin_per numeric,
    ttl_nonfed_tranf_per numeric,
    shared_fed_actvy_fed_shr_per numeric,
    shared_fed_actvy_nonfed_per numeric,
    non_alloc_fed_elect_actvy_per numeric,
    ttl_fed_elect_actvy_per numeric,
    tranf_from_nonfed_levin_ytd numeric,
    ttl_nonfed_tranf_ytd numeric,
    shared_fed_actvy_fed_shr_ytd numeric,
    shared_fed_actvy_nonfed_ytd numeric,
    non_alloc_fed_elect_actvy_ytd numeric,
    ttl_fed_elect_actvy_ytd numeric,
    begin_image_num numeric,
    end_image_num numeric,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FACTPACSANDPARTIES_F3X');


ALTER TABLE public.factpacsandparties_f3x OWNER TO "ec2-user";

--
-- Name: factpresidential_f3p; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.factpresidential_f3p (
    factpresidential_f3p_sk bigint NOT NULL,
    form_3p_sk bigint,
    cmte_sk bigint,
    reporttype_sk bigint,
    two_yr_period_sk bigint,
    transaction_sk bigint,
    cvg_start_dt_sk bigint,
    cvg_end_dt_sk bigint,
    electiontp_sk bigint,
    rpt_yr numeric,
    coh_bop numeric,
    ttl_receipts_sum_page_per numeric,
    subttl_sum_page_per numeric,
    ttl_disb_sum_page_per numeric,
    coh_cop numeric,
    debts_owed_to_cmte numeric,
    debts_owed_by_cmte numeric,
    exp_subject_limits numeric,
    net_contb_sum_page_per numeric,
    net_op_exp_sum_page_per numeric,
    fed_funds_per numeric,
    indv_contb_per numeric,
    pol_pty_cmte_contb_per numeric,
    other_pol_cmte_contb_per numeric,
    cand_contb_per numeric,
    ttl_contb_per numeric,
    tranf_from_affilated_cmte_per numeric,
    loans_received_from_cand_per numeric,
    other_loans_received_per numeric,
    ttl_loans_received_per numeric,
    offsets_to_op_exp_per numeric,
    offsets_to_fndrsg_exp_per numeric,
    offsets_to_legal_acctg_per numeric,
    ttl_offsets_to_op_exp_per numeric,
    other_receipts_per numeric,
    ttl_receipts_per numeric,
    op_exp_per numeric,
    tranf_to_other_auth_cmte_per numeric,
    fndrsg_disb_per numeric,
    exempt_legal_acctg_disb_per numeric,
    repymts_loans_made_by_cand_per numeric,
    repymts_other_loans_per numeric,
    ttl_loan_repymts_made_per numeric,
    ref_indv_contb_per numeric,
    ref_pol_pty_cmte_contb_per numeric,
    ref_other_pol_cmte_contb_per numeric,
    ttl_contb_ref_per numeric,
    other_disb_per numeric,
    ttl_disb_per numeric,
    items_on_hand_liquidated numeric,
    alabama_per numeric,
    alaska_per numeric,
    arizona_per numeric,
    arkansas_per numeric,
    california_per numeric,
    colorado_per numeric,
    connecticut_per numeric,
    delaware_per numeric,
    district_columbia_per numeric,
    florida_per numeric,
    georgia_per numeric,
    hawaii_per numeric,
    idaho_per numeric,
    illinois_per numeric,
    indiana_per numeric,
    iowa_per numeric,
    kansas_per numeric,
    kentucky_per numeric,
    louisiana_per numeric,
    maine_per numeric,
    maryland_per numeric,
    massachusetts_per numeric,
    michigan_per numeric,
    minnesota_per numeric,
    mississippi_per numeric,
    missouri_per numeric,
    montana_per numeric,
    nebraska_per numeric,
    nevada_per numeric,
    new_hampshire_per numeric,
    new_jersey_per numeric,
    new_mexico_per numeric,
    new_york_per numeric,
    north_carolina_per numeric,
    north_dakota_per numeric,
    ohio_per numeric,
    oklahoma_per numeric,
    oregon_per numeric,
    pennsylvania_per numeric,
    rhode_island_per numeric,
    south_carolina_per numeric,
    south_dakota_per numeric,
    tennessee_per numeric,
    texas_per numeric,
    utah_per numeric,
    vermont_per numeric,
    virginia_per numeric,
    washington_per numeric,
    west_virginia_per numeric,
    wisconsin_per numeric,
    wyoming_per numeric,
    puerto_rico_per numeric,
    guam_per numeric,
    virgin_islands_per numeric,
    ttl_per numeric,
    fed_funds_ytd numeric,
    indv_contb_ytd numeric,
    pol_pty_cmte_contb_ytd numeric,
    other_pol_cmte_contb_ytd numeric,
    cand_contb_ytd numeric,
    ttl_contb_ytd numeric,
    tranf_from_affiliated_cmte_ytd numeric,
    loans_received_from_cand_ytd numeric,
    other_loans_received_ytd numeric,
    ttl_loans_received_ytd numeric,
    offsets_to_op_exp_ytd numeric,
    offsets_to_fndrsg_exp_ytd numeric,
    offsets_to_legal_acctg_ytd numeric,
    ttl_offsets_to_op_exp_ytd numeric,
    other_receipts_ytd numeric,
    ttl_receipts_ytd numeric,
    op_exp_ytd numeric,
    tranf_to_other_auth_cmte_ytd numeric,
    fndrsg_disb_ytd numeric,
    exempt_legal_acctg_disb_ytd numeric,
    repymts_loans_made_cand_ytd numeric,
    repymts_other_loans_ytd numeric,
    ttl_loan_repymts_made_ytd numeric,
    ref_indv_contb_ytd numeric,
    ref_pol_pty_cmte_contb_ytd numeric,
    ref_other_pol_cmte_contb_ytd numeric,
    ttl_contb_ref_ytd numeric,
    other_disb_ytd numeric,
    ttl_disb_ytd numeric,
    alabama_ytd numeric,
    alaska_ytd numeric,
    arizona_ytd numeric,
    arkansas_ytd numeric,
    california_ytd numeric,
    colorado_ytd numeric,
    connecticut_ytd numeric,
    delaware_ytd numeric,
    district_columbia_ytd numeric,
    florida_ytd numeric,
    georgia_ytd numeric,
    hawaii_ytd numeric,
    idaho_ytd numeric,
    illinois_ytd numeric,
    indiana_ytd numeric,
    iowa_ytd numeric,
    kansas_ytd numeric,
    kentucky_ytd numeric,
    louisiana_ytd numeric,
    maine_ytd numeric,
    maryland_ytd numeric,
    massachusetts_ytd numeric,
    michigan_ytd numeric,
    minnesota_ytd numeric,
    mississippi_ytd numeric,
    missouri_ytd numeric,
    montana_ytd numeric,
    nebraska_ytd numeric,
    nevada_ytd numeric,
    new_hampshire_ytd numeric,
    new_jersey_ytd numeric,
    new_mexico_ytd numeric,
    new_york_ytd numeric,
    north_carolina_ytd numeric,
    north_dakota_ytd numeric,
    ohio_ytd numeric,
    oklahoma_ytd numeric,
    oregon_ytd numeric,
    pennsylvania_ytd numeric,
    rhode_island_ytd numeric,
    south_carolina_ytd numeric,
    south_dakota_ytd numeric,
    tennessee_ytd numeric,
    texas_ytd numeric,
    utah_ytd numeric,
    vermont_ytd numeric,
    virginia_ytd numeric,
    washington_ytd numeric,
    west_virginia_ytd numeric,
    wisconsin_ytd numeric,
    wyoming_ytd numeric,
    puerto_rico_ytd numeric,
    guam_ytd numeric,
    virgin_islands_ytd numeric,
    ttl_ytd numeric,
    begin_image_num numeric,
    end_image_num numeric,
    load_date timestamp without time zone NOT NULL,
    expire_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FACTPRESIDENTIAL_F3P');


ALTER TABLE public.factpresidential_f3p OWNER TO "ec2-user";

--
-- Name: form_105; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_105 (
    form_105_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    exp_dt timestamp without time zone,
    election_tp text,
    fec_election_tp_desc text,
    exp_amt numeric,
    loan_chk_flg text,
    amndt_ind text,
    tran_id text,
    image_num text,
    last_update_dt timestamp without time zone,
    receipt_dt timestamp without time zone,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_105');


ALTER TABLE public.form_105 OWNER TO "ec2-user";

--
-- Name: form_56; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_56 (
    form_56_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    entity_tp text,
    contbr_nm text,
    contbr_st1 text,
    contbr_st2 text,
    conbtr_city text,
    contbr_st text,
    contbr_zip text,
    contbr_employer text,
    contbr_occupation text,
    contb_dt timestamp without time zone,
    contb_amt numeric,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    conduit_cmte_id text,
    conduit_nm text,
    conduit_st1 text,
    conduit_st2 text,
    conduit_city text,
    conduit_st text,
    conduit_zip text,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    image_num text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_56');


ALTER TABLE public.form_56 OWNER TO "ec2-user";

--
-- Name: form_57; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_57 (
    form_57_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    entity_tp text,
    pye_nm text,
    pye_st1 text,
    pye_st2 text,
    pye_city text,
    pye_st text,
    pye_zip text,
    exp_purpose text,
    exp_dt timestamp without time zone,
    exp_amt numeric,
    s_o_ind text,
    s_o_cand_id text,
    s_o_cand_nm text,
    s_o_cand_office text,
    s_o_cand_office_st text,
    s_o_cand_office_district text,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    catg_cd text,
    exp_tp text,
    cal_ytd_ofc_sought numeric,
    catg_cd_desc text,
    exp_tp_desc text,
    election_tp text,
    election_tp_desc text,
    image_num text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_57');


ALTER TABLE public.form_57 OWNER TO "ec2-user";

--
-- Name: form_65; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_65 (
    form_65_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    entity_tp text,
    contbr_lender_nm text,
    contbr_lender_st1 text,
    contbr_lender_st2 text,
    contbr_lender_city text,
    contbr_lender_st text,
    contbr_lender_zip text,
    contbr_lender_employer text,
    contbr_lender_occupation text,
    contb_dt timestamp without time zone,
    contb_amt numeric,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    image_num text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_65');


ALTER TABLE public.form_65 OWNER TO "ec2-user";

--
-- Name: form_76; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_76 (
    form_76_sk bigint NOT NULL,
    form_tp text,
    org_id text,
    communication_tp text,
    communication_tp_desc text,
    communication_class text,
    communication_dt timestamp without time zone,
    s_o_ind text,
    s_o_cand_id text,
    s_o_cand_nm text,
    s_o_cand_office text,
    s_o_cand_office_st text,
    s_o_cand_office_district text,
    s_o_rpt_pgi text,
    communication_cost numeric,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    election_other_desc text,
    transaction_tp text,
    image_num text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_76');


ALTER TABLE public.form_76 OWNER TO "ec2-user";

--
-- Name: form_82; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_82 (
    form_82_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    cred_tp text,
    cred_nm text,
    cred_st1 text,
    cred_st2 text,
    cred_city text,
    cred_st text,
    cred_zip text,
    incurred_dt timestamp without time zone,
    amt_owed_cred numeric,
    amt_offered_settle numeric,
    terms_initial_extention_desc text,
    debt_repymt_efforts_desc text,
    steps_obtain_funds_desc text,
    similar_effort_flg text,
    similar_effort_desc text,
    terms_settlement_flg text,
    terms_of_settlement_desc text,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    add_cmte_id text,
    creditor_sign_nm text,
    creditor_sign_dt timestamp without time zone,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    entity_tp text,
    image_num text,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_82');


ALTER TABLE public.form_82 OWNER TO "ec2-user";

--
-- Name: form_83; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_83 (
    form_83_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    cred_tp text,
    cred_nm text,
    cred_st1 text,
    cred_st2 text,
    cred_city text,
    cred_st text,
    cred_zip text,
    disputed_debt_flg text,
    incurred_dt timestamp without time zone,
    amt_owed_cred numeric,
    amt_offered_settle numeric,
    add_cmte_id text,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    entity_tp text,
    image_num text,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_83');


ALTER TABLE public.form_83 OWNER TO "ec2-user";

--
-- Name: form_91; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_91 (
    form_91_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    shr_ex_ctl_ind_nm text,
    shr_ex_ctl_street1 text,
    shr_ex_ctl_street2 text,
    shr_ex_ctl_city text,
    shr_ex_ctl_st text,
    shr_ex_ctl_zip text,
    shr_ex_ctl_employ text,
    shr_ex_ctl_occup text,
    amndt_ind text,
    tran_id text,
    begin_image_num text,
    end_image_num text,
    receipt_dt timestamp without time zone,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_91');


ALTER TABLE public.form_91 OWNER TO "ec2-user";

--
-- Name: form_94; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.form_94 (
    form_94_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    election_tp text,
    fec_election_tp_desc text,
    amndt_ind text,
    tran_id text,
    back_ref_tran_id text,
    back_ref_sched_nm text,
    begin_image_num text,
    end_image_num text,
    form_slot text,
    receipt_dt timestamp without time zone,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'FORM_94');


ALTER TABLE public.form_94 OWNER TO "ec2-user";

--
-- Name: log_audit_dml; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.log_audit_dml (
    dml_id bigint NOT NULL,
    run_id bigint,
    audit_id bigint,
    dml_type text NOT NULL,
    target_table text NOT NULL,
    start_time timestamp without time zone NOT NULL,
    row_count numeric,
    dml_desc text,
    cpu_minutes numeric,
    elapsed_minutes numeric,
    start_cpu_time number NOT NULL,
    start_clock_time number NOT NULL
) SERVER oradb OPTIONS (schema 'CFDM', table 'LOG_AUDIT_DML');


ALTER TABLE public.log_audit_dml OWNER TO "ec2-user";

--
-- Name: log_audit_module; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.log_audit_module (
    audit_id bigint NOT NULL,
    run_id bigint,
    module_name text NOT NULL,
    start_time timestamp without time zone NOT NULL,
    input_parameters text,
    error_message text,
    cpu_minutes numeric,
    elapsed_minutes numeric,
    start_cpu_time number NOT NULL,
    start_clock_time number NOT NULL
) SERVER oradb OPTIONS (schema 'CFDM', table 'LOG_AUDIT_MODULE');


ALTER TABLE public.log_audit_module OWNER TO "ec2-user";

--
-- Name: log_audit_process; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.log_audit_process (
    run_id bigint NOT NULL,
    session_id bigint NOT NULL,
    process_name text,
    interface_name text NOT NULL,
    module_name text NOT NULL,
    start_time timestamp without time zone NOT NULL,
    input_parameters text,
    messages text,
    cpu_minutes numeric,
    elapsed_minutes numeric,
    start_cpu_time number NOT NULL,
    start_clock_time number NOT NULL
) SERVER oradb OPTIONS (schema 'CFDM', table 'LOG_AUDIT_PROCESS');


ALTER TABLE public.log_audit_process OWNER TO "ec2-user";

--
-- Name: sched_a; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_a (
    sched_a_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    entity_tp text,
    contbr_id text,
    contbr_nm text,
    contbr_st1 text,
    contbr_st2 text,
    contbr_city text,
    contbr_st text,
    contbr_zip text,
    election_tp text,
    election_tp_desc text,
    contbr_employer text,
    contbr_occupation text,
    contb_aggregate_ytd numeric,
    contb_receipt_dt timestamp without time zone,
    contb_receipt_amt numeric,
    receipt_tp text,
    receipt_desc text,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    memo_cd text,
    memo_text text,
    amndt_ind text,
    tran_id text,
    back_ref_tran_id text,
    back_ref_sched_nm text,
    national_cmte_nonfed_acct text,
    record_num text,
    rpt_tp text,
    rpt_pgi text,
    receipt_dt timestamp without time zone,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    increased_limit text,
    donor_cmte_nm text,
    orig_sub_id bigint,
    sub_id bigint NOT NULL,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    filing_form text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_A');


ALTER TABLE public.sched_a OWNER TO "ec2-user";

--
-- Name: sched_b; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_b (
    sched_b_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    entity_tp text,
    recipient_cmte_id text,
    recipient_nm text,
    recipient_st1 text,
    recipient_st2 text,
    recipient_city text,
    recipient_st text,
    recipient_zip text,
    disb_tp text,
    disb_desc text,
    election_tp text,
    election_tp_desc text,
    disb_dt timestamp without time zone,
    disb_amt numeric,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    memo_cd text,
    memo_text text,
    amndt_ind text,
    tran_id text,
    back_ref_tran_id text,
    back_ref_sched_id text,
    national_cmte_nonfed_acct text,
    rpt_tp text,
    record_num text,
    rpt_pgi text,
    receipt_dt timestamp without time zone,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    ref_disp_excess_flg text,
    catg_cd text,
    catg_cd_desc text,
    form_slot text,
    comm_dt timestamp without time zone,
    payee_employer text,
    payee_occupation text,
    benef_cmte_nm text,
    orig_sub_id bigint,
    semi_an_bundled_refund numeric,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    filing_form text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_B');


ALTER TABLE public.sched_b OWNER TO "ec2-user";

--
-- Name: sched_c; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_c (
    sched_c_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    entity_tp text,
    cmte_nm text,
    loan_src_nm text,
    loan_src_st1 text,
    loan_src_st2 text,
    loan_src_city text,
    loan_src_st text,
    loan_src_zip text,
    election_tp text,
    election_tp_desc text,
    orig_loan_amt numeric,
    pymt_to_dt numeric,
    loan_bal numeric,
    incurred_dt timestamp without time zone,
    due_dt_terms text,
    interest_rate_terms text,
    secured_ind text,
    fec_cmte_id text,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    record_num text,
    rpt_tp text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    sched_a_line_num text,
    pers_fund_yes_no text,
    memo_cd text,
    memo_text text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    filing_form text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_C');


ALTER TABLE public.sched_c OWNER TO "ec2-user";

--
-- Name: sched_c1; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_c1 (
    sched_c1_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    back_ref_tran_id text,
    entity_tp text,
    loan_src_nm text,
    loan_src_st1 text,
    loan_src_st2 text,
    loan_src_city text,
    loan_src_st text,
    loan_src_zip text,
    loan_amt numeric,
    interest_rate_pct text,
    incurred_dt timestamp without time zone,
    due_dt text,
    loan_restructured_flg text,
    orig_loan_dt timestamp without time zone,
    credit_amt_this_draw numeric,
    ttl_bal numeric,
    other_liable_pty_flg text,
    collateral_flg text,
    collateral_desc text,
    collateral_value numeric,
    perfected_interest_flg text,
    future_income_flg text,
    future_income_desc text,
    future_income_est_value numeric,
    depository_acct_est_dt timestamp without time zone,
    acct_loc_nm text,
    acct_loc_st1 text,
    acct_loc_st2 text,
    acct_loc_city text,
    acct_loc_st text,
    acct_loc_zip text,
    depository_acct_auth_dt timestamp without time zone,
    loan_basis_desc text,
    tres_sign_nm text,
    tres_sign_dt timestamp without time zone,
    auth_sign_nm text,
    auth_rep_title text,
    auth_sign_dt timestamp without time zone,
    receipt_dt timestamp without time zone,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    amndt_ind text,
    amndt_ind_desc text,
    tran_id text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    filing_form text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_C1');


ALTER TABLE public.sched_c1 OWNER TO "ec2-user";

--
-- Name: sched_c2; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_c2 (
    sched_c2_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    back_ref_tran_id text,
    guar_endr_nm text,
    guar_endr_st1 text,
    guar_endr_st2 text,
    guar_endr_city text,
    guar_endr_st text,
    guar_endr_zip text,
    guar_endr_employer text,
    guar_endr_occupation text,
    amt_guaranteed_outstg numeric,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    receipt_dt timestamp without time zone,
    amndt_ind text,
    amndt_ind_desc text,
    tran_id text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    filing_form text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_C2');


ALTER TABLE public.sched_c2 OWNER TO "ec2-user";

--
-- Name: sched_d; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_d (
    sched_d_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    entity_tp text,
    cred_dbtr_id text,
    cred_dbtr_nm text,
    cred_dbtr_st1 text,
    cred_dbtr_st2 text,
    cred_dbtr_city text,
    cred_dbtr_st text,
    cred_dbtr_zip text,
    nature_debt_purpose text,
    outstg_bal_bop numeric,
    amt_incurred_per numeric,
    pymt_per numeric,
    outstg_bal_cop numeric,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    amndt_ind text,
    tran_id text,
    receipt_dt timestamp without time zone,
    record_num text,
    rpt_tp text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    filing_form text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_D');


ALTER TABLE public.sched_d OWNER TO "ec2-user";

--
-- Name: sched_e; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_e (
    sched_e_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    entity_tp text,
    pye_nm text,
    pye_st1 text,
    pye_st2 text,
    pye_city text,
    pye_st text,
    pye_zip text,
    exp_tp text,
    exp_desc text,
    exp_dt timestamp without time zone,
    exp_amt numeric,
    s_o_ind text,
    s_o_cand_id text,
    s_o_cand_nm text,
    s_o_cand_office text,
    s_o_cand_office_st text,
    s_o_cand_office_district text,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    indt_sign_nm text,
    indt_sign_dt timestamp without time zone,
    notary_sign_nm text,
    notary_sign_dt timestamp without time zone,
    notary_commission_exprtn_dt timestamp without time zone,
    amndt_ind text,
    tran_id text,
    memo_cd text,
    memo_text text,
    back_ref_tran_id text,
    back_ref_sched_nm text,
    receipt_dt timestamp without time zone,
    record_num text,
    rpt_tp text,
    rpt_pgi text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    election_tp text,
    fec_election_tp_desc text,
    catg_cd text,
    cal_ytd_ofc_sought numeric,
    catg_cd_desc text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_E');


ALTER TABLE public.sched_e OWNER TO "ec2-user";

--
-- Name: sched_f; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_f (
    sched_f_sk bigint NOT NULL,
    form_tp text,
    cmte_id text,
    cmte_nm text,
    cmte_desg_coord_exp_ind text,
    desg_cmte_id text,
    desg_cmte_nm text,
    subord_cmte_id text,
    subord_cmte_nm text,
    subord_cmte_st1 text,
    subord_cmte_st2 text,
    subord_cmte_city text,
    subord_cmte_st text,
    subord_cmte_zip text,
    entity_tp text,
    pye_nm text,
    pye_st1 text,
    pye_st2 text,
    pye_city text,
    pye_st text,
    pye_zip text,
    aggregate_gen_election_exp numeric,
    exp_tp text,
    exp_purpose_desc text,
    exp_dt timestamp without time zone,
    exp_amt numeric,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    amndt_ind text,
    tran_id text,
    memo_cd text,
    memo_text text,
    back_ref_tran_id text,
    back_ref_sched_nm text,
    receipt_dt timestamp without time zone,
    rpt_tp text,
    rpt_pgi text,
    record_num text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    unlimited_spending_flg text,
    catg_cd text,
    unlimited_spending_flg_desc text,
    catg_cd_desc text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_F');


ALTER TABLE public.sched_f OWNER TO "ec2-user";

--
-- Name: sched_h1; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_h1 (
    sched_h1_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    filer_cmte_nm text,
    np_fixed_fed_pct numeric,
    hsp_min_fed_pct numeric,
    hsp_est_fed_dir_cand_supp_pct numeric,
    hsp_est_nonfed_cand_supp_pct numeric,
    hsp_actl_fed_dir_cand_supp_amt numeric,
    hsp_actl_nonfed_cand_supp_amt numeric,
    hsp_actl_fed_dir_cand_supp_pct numeric,
    ssf_fed_est_dir_cand_supp_pct numeric,
    ssf_nfed_est_dir_cand_supp_pct numeric,
    ssf_actl_fed_dir_cand_supp_amt numeric,
    ssf_actl_nonfed_cand_supp_amt numeric,
    ssf_actl_fed_dir_cand_supp_pct numeric,
    president_ind numeric,
    us_senate_ind numeric,
    us_congress_ind numeric,
    subttl_fed numeric,
    governor_ind numeric,
    other_st_offices_ind numeric,
    st_senate_ind numeric,
    st_rep_ind numeric,
    local_cand_ind numeric,
    extra_non_fed_point_ind numeric,
    subttl_non_fed numeric,
    ttl_fed_and_nonfed numeric,
    fed_alloctn numeric,
    amndt_ind text,
    tran_id text,
    record_num text,
    receipt_dt timestamp without time zone,
    rpt_tp text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    st_loc_pres_only text,
    st_loc_pres_sen text,
    st_loc_sen_only text,
    st_loc_nonpres_nonsen text,
    flat_min_fed_pct text,
    fed_pct numeric,
    non_fed_pct numeric,
    admin_ratio_chk text,
    gen_voter_drive_chk text,
    pub_comm_ref_pty_chk text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_H1');


ALTER TABLE public.sched_h1 OWNER TO "ec2-user";

--
-- Name: sched_h2; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_h2 (
    sched_h2_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    filer_cmte_nm text,
    evt_activity_nm text,
    fndsg_acty_flg text,
    exempt_acty_flg text,
    direct_cand_support_acty_flg text,
    ratio_cd text,
    fed_pct_amt numeric,
    nonfed_pct_amt numeric,
    amndt_ind text,
    tran_id text,
    record_num text,
    receipt_dt timestamp without time zone,
    rpt_tp text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_H2');


ALTER TABLE public.sched_h2 OWNER TO "ec2-user";

--
-- Name: sched_h3; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_h3 (
    sched_h3_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    filer_cmte_nm text,
    back_ref_tran_id text,
    acct_nm text,
    evt_nm text,
    evt_tp text,
    tranf_dt timestamp without time zone,
    tranf_amt numeric,
    ttl_tranf_amt numeric,
    amndt_ind text,
    tran_id text,
    record_num text,
    rpt_tp text,
    status numeric,
    chg_del_id bigint,
    receipt_dt timestamp without time zone,
    file_num numeric,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_H3');


ALTER TABLE public.sched_h3 OWNER TO "ec2-user";

--
-- Name: sched_h4; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_h4 (
    sched_h4_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    filer_cmte_nm text,
    entity_tp text,
    pye_nm text,
    pye_st1 text,
    pye_st2 text,
    pye_city text,
    pye_st text,
    pye_zip text,
    evt_purpose_nm text,
    evt_purpose_desc text,
    evt_purpose_dt timestamp without time zone,
    ttl_amt_disb numeric,
    evt_purpose_category_tp text,
    fed_share numeric,
    nonfed_share numeric,
    admin_voter_drive_acty_ind text,
    fndrsg_acty_ind text,
    exempt_acty_ind text,
    direct_cand_supp_acty_ind text,
    evt_amt_ytd numeric,
    add_desc text,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district text,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    amndt_ind text,
    tran_id text,
    memo_cd text,
    memo_text text,
    back_ref_tran_id text,
    back_ref_sched_id text,
    record_num text,
    receipt_dt timestamp without time zone,
    rpt_tp text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    admin_acty_ind text,
    gen_voter_drive_acty_ind text,
    catg_cd text,
    disb_tp text,
    catg_cd_desc text,
    disb_tp_desc text,
    pub_comm_ref_pty_chk text,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_H4');


ALTER TABLE public.sched_h4 OWNER TO "ec2-user";

--
-- Name: sched_h5; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_h5 (
    sched_h5_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    acct_nm text,
    tranf_dt timestamp without time zone,
    ttl_tranf_amt_voter_reg numeric,
    ttl_tranf_voter_id bigint,
    ttl_tranf_gotv numeric,
    ttl_tranf_gen_campgn_actvy numeric,
    ttl_tranf_amt numeric,
    amndt_ind text,
    tran_id text,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    record_num text,
    rpt_tp text,
    receipt_dt timestamp without time zone,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    orig_sub_id bigint,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_H5');


ALTER TABLE public.sched_h5 OWNER TO "ec2-user";

--
-- Name: sched_h6; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_h6 (
    sched_h6_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    entity_tp text,
    pye_nm text,
    pye_st1 text,
    pye_st2 text,
    pye_city text,
    pye_st text,
    pye_zip text,
    catg_cd text,
    disb_purpose text,
    disb_purpose_cat text,
    disb_dt timestamp without time zone,
    ttl_amt_disb numeric,
    fed_share numeric,
    levin_share numeric,
    voter_reg_yn_flg text,
    voter_id_yn_flg text,
    gotv_yn_flg text,
    gen_campgn_yn_flg text,
    evt_amt_ytd numeric,
    add_desc text,
    fec_committee_id text,
    cand_id text,
    cand_nm text,
    cand_office text,
    cand_office_st text,
    cand_office_district numeric,
    conduit_cmte_id text,
    conduit_cmte_nm text,
    conduit_cmte_st1 text,
    conduit_cmte_st2 text,
    conduit_cmte_city text,
    conduit_cmte_st text,
    conduit_cmte_zip text,
    amndt_ind text,
    tran_id text,
    memo_cd text,
    memo_text text,
    back_ref_tran_id text,
    back_ref_sched_id text,
    sub_id bigint,
    link_id bigint,
    line_num text,
    image_num text,
    record_num text,
    rpt_tp text,
    receipt_dt timestamp without time zone,
    status numeric,
    last_update_dt timestamp without time zone,
    chg_del_id bigint,
    file_num numeric,
    orig_sub_id bigint,
    rpt_yr numeric,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_H6');


ALTER TABLE public.sched_h6 OWNER TO "ec2-user";

--
-- Name: sched_i; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_i (
    sched_i_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    filer_cmte_nm text,
    acct_num text,
    acct_nm text,
    cvg_start_dt timestamp without time zone,
    cvg_end_dt timestamp without time zone,
    ttl_receipts_per numeric,
    tranf_to_fed_alloctn_per numeric,
    tranf_to_st_local_pty_per numeric,
    direct_st_local_cand_supp_per numeric,
    other_disb_per numeric,
    ttl_disb_per numeric,
    coh_bop numeric,
    receipts_per numeric,
    subttl_per numeric,
    disb_per numeric,
    coh_cop numeric,
    ttl_reciepts_ytd numeric,
    tranf_to_fed_alloctn_ytd numeric,
    tranf_to_st_local_pty_ytd numeric,
    direct_st_local_cand_supp_ytd numeric,
    other_disb_ytd numeric,
    ttl_disb_ytd numeric,
    coh_boy numeric,
    receipts_ytd numeric,
    subttl_ytd numeric,
    disb_ytd numeric,
    coh_coy numeric,
    amndt_ind text,
    other_acct_num text,
    tran_id text,
    receipt_dt timestamp without time zone,
    rpt_yr numeric,
    rpt_pgi text,
    rpt_tp text,
    status numeric,
    chg_del_id bigint,
    file_num numeric,
    orig_sub_id bigint,
    sub_id bigint,
    link_id bigint,
    line_num text,
    begin_image_num text,
    end_image_num text,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_I');


ALTER TABLE public.sched_i OWNER TO "ec2-user";

--
-- Name: sched_l; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE FOREIGN TABLE frn.sched_l (
    sched_l_sk bigint NOT NULL,
    form_tp text,
    filer_cmte_id text,
    acct_nm text,
    cvg_start_dt timestamp without time zone,
    cvg_end_dt timestamp without time zone,
    item_receipts_per_pers numeric,
    unitem_receipts_per_pers numeric,
    ttl_receipts_per_pers numeric,
    other_receipts_per numeric,
    ttl_receipts_per numeric,
    voter_reg_amt_per numeric,
    voter_id_amt_per numeric,
    gotv_amt_per numeric,
    generic_campaign_amt_per numeric,
    ttl_disb_sub_per numeric,
    other_disb_per numeric,
    ttl_disb_per numeric,
    coh_bop numeric,
    receipts_per numeric,
    subttl_per numeric,
    disb_per numeric,
    item_receipts_ytd_pers numeric,
    unitem_receipts_ytd_pers numeric,
    ttl_reciepts_ytd_pers numeric,
    other_receipts_ytd numeric,
    ttl_receipts_ytd numeric,
    voter_reg_amt_ytd numeric,
    voter_id_amt_ytd numeric,
    gotv_amt_ytd numeric,
    generic_campaign_amt_ytd numeric,
    ttl_disb_ytd_sub numeric,
    other_disb_ytd numeric,
    ttl_disb_ytd numeric,
    coh_boy numeric,
    receipts_ytd numeric,
    subttl_ytd numeric,
    disb_ytd numeric,
    coh_coy numeric,
    amndt_ind text,
    tran_id text,
    sub_id bigint,
    link_id bigint,
    line_num text,
    begin_image_num text,
    end_image_num text,
    rpt_tp text,
    receipt_dt timestamp without time zone,
    status numeric,
    last_update_dt timestamp without time zone,
    chg_del_id bigint,
    file_num numeric,
    other_acct_num text,
    rpt_yr numeric,
    coh_cop numeric,
    orig_sub_id bigint,
    transaction_id bigint,
    filing_type text,
    load_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
) SERVER oradb OPTIONS (schema 'CFDM', table 'SCHED_L');


ALTER TABLE public.sched_l OWNER TO "ec2-user";

--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

