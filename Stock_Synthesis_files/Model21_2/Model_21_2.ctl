#V3.30.18.00;_safe;_compile_date:_Sep 30 2021;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: Base_2_plus_fishery_CPUE_1.dat // 21_2_11.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
 1 2 #_blocks_per_pattern 
# begin and end years of blocks
 1976 1976
 1977 2007 2008 2021
#
# controls for all timevary parameters 
3 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity
  #_no additional input for selected M option; read 1P per morph
#
2 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
1.5 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
2 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0 1 0.351429 0 0 0 1 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 10 20 15.0456 0 0 0 2 0 1 1977 2021 2 0 0 # L_at_Amin_Fem_GP_1
 60 150 113.162 0 0 0 2 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.114378 0 0 0 2 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 10 1.47343 0 0 0 2 0 0 0 0 0 0 0 # Richards_Fem_GP_1
 0 10 3.53432 0 0 0 2 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 9.81418 0 0 0 2 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -10 10 5.40706e-06 0 0 0 -1 202 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -10 10 3.19601 0 0 0 -1 203 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 -10 100 58 0 0 0 -1 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -10 10 -0.132 0 0 0 -1 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -10 10 1 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
 -10 10 1 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm1
 -10 10 0 0 0 0 -1 0 0 0 0 0 2 3 # AgeKeyParm2
 -10 10 0 0 0 0 -1 0 0 0 0 0 2 3 # AgeKeyParm3
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm4
 -10 10 0.085 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm5
 -10 10 1.692 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm6
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm7
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 1e-06 10 0.1749 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_se
 -0.99 0.99 0 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_autocorr
 -10 10 1 0 0 -1 -1 # Wtlen_1_Fem_GP_1_ENV_add
 -10 10 1 0 0 -1 -1 # Wtlen_2_Fem_GP_1_ENV_add
 -10 10 0.345875 0 0 0 2 # AgeKeyParm2_BLK2delta_1977
 -10 10 0.0104436 0 0 0 2 # AgeKeyParm2_BLK2delta_2008
 -10 10 1.02996 0 0 0 2 # AgeKeyParm3_BLK2delta_1977
 -10 10 -1.92572 0 0 0 2 # AgeKeyParm3_BLK2delta_2008
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
            12            16       13.1945             0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           -10            10             1             0             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
           -10            10        0.6453             0             0             0         -1          0          0          0          0          0          0          0 # SR_sigmaR
           -10            10             0             0             0             0         -1          0          0          0          0          0          1          1 # SR_regime
         -0.99          0.99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
# timevary SR parameters
 -10 10 -0.843757 0 -1 0 1 # SR_regime_BLK1add_1976
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1977 # first year of main recr_devs; early devs can preceed this era
2020 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 -20 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 1 #_recdev_early_phase
 -1 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1900 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1901 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2020 #_last_yr_fullbias_adj_in_MPD
 2021 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 1 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975E 1976E 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F
#  -0.0175598 -0.00972764 -0.0145714 -0.0221017 -0.0333027 -0.0497285 -0.0734321 -0.106705 -0.151966 -0.210963 -0.284147 -0.369513 -0.461174 -0.546409 -0.597462 -0.55238 -0.271936 0.179838 -0.0717684 0.671702 1.00721 0.615642 0.621833 -0.695512 -0.690334 0.864723 -0.440978 0.794805 0.00230365 -0.611398 -1.68262 -0.261755 0.411756 0.395783 -0.0539655 0.903194 -0.160628 -0.279723 -0.43252 0.699987 -0.185638 -0.426425 0.469459 0.248283 -0.566874 0.0979832 0.0372887 -0.354485 -0.190024 0.736544 -0.298192 0.99447 -0.983326 0.499032 0.735218 -0.0217865 0.962647 -0.722833 -0.343729 -0.623984 -1.09982 0.607517 -0.502612 -0.0765189 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.2 # F ballpark value in units of annual_F
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
3 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 1
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 0 1 0.10925 0 0 0 1 # InitF_seas_1_flt_1Fishery
#
# F rates by fleet x season
# Yr:  1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Fishery 0.158545 0.197394 0.141606 0.145195 0.110133 0.0872352 0.105 0.142598 0.157834 0.152684 0.175032 0.203454 0.189249 0.211957 0.353243 0.394224 0.268675 0.362586 0.442938 0.39671 0.433512 0.344112 0.343378 0.314702 0.35532 0.356453 0.429097 0.450379 0.468005 0.394609 0.3301 0.33775 0.362714 0.331311 0.462724 0.476628 0.502902 0.609649 0.613956 0.55429 0.560159 0.382731 0.379634 0.356775 0.343673 0.284578 0.306701 0.305686 0.302429 0.313394 0.329938 0.342453 0.349052 0.351668 0.352373 0.352389 0.352253
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         0         0         0  #  Fishery
         2         1         0         0         0         0  #  Survey
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -10            -3      -9.20497             0             0             0          1          0          0          0          0          0          0          0  #  LnQ_base_Fishery(1)
            -3             3    -0.0946638             0             0             0          1          0          0          0          0          0          0          0  #  LnQ_base_Survey(2)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_2;  parm=6; modification of pattern 24 with improved sex-specific offset
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 Fishery
 24 0 0 0 # 2 Survey
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 0 0 0 0 # 1 Fishery
 0 0 0 0 # 2 Survey
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   Fishery LenSelex
            10            80       74.9718          -999          -999             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fishery(1)
           -10            10      -9.92461          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fishery(1)
           -10            10       5.91256          -999          -999             0          3          0          2       1977       2021          3          0          0  #  Size_DblN_ascend_se_Fishery(1)
           -10            10      -9.41991          -999          -999             0          3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fishery(1)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fishery(1)
           -10            10       1.80348          -999          -999             0          3          0          2       1977       2021          3          0          0  #  Size_DblN_end_logit_Fishery(1)
# 2   Survey LenSelex
            10            80       21.0059          -999          -999             0          3          0          1       1982       2021          3          0          0  #  Size_DblN_peak_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Survey(2)
           -10            10        3.5516          -999          -999             0          3          0          2       1982       2021          3          0          0  #  Size_DblN_ascend_se_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Survey(2)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Survey(2)
# 1   Fishery AgeSelex
# 2   Survey AgeSelex
#_Dirichlet parameters
#_multiple_fleets_can_refer_to_same_parm;_but_list_cannot_have_gaps
           -10            10       9.98905             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_1
           -10            10       9.98175             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_2
           -10            10      -0.57406             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_3
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
         1e-06            10        0.1903             0             0             0      -9  # Size_DblN_ascend_se_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_ascend_se_Fishery(1)_dev_autocorr
         1e-06            10        1.3913             0             0             0      -9  # Size_DblN_end_logit_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_end_logit_Fishery(1)_dev_autocorr
         1e-06            10        0.2031             0             0             0      -9  # Size_DblN_peak_Survey(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_peak_Survey(2)_dev_autocorr
         1e-06            10        0.7418             0             0             0      -9  # Size_DblN_ascend_se_Survey(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_ascend_se_Survey(2)_dev_autocorr
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      1     2     1     0     0     0     0     1     1  1977  2021     2 0.502916 -0.112984 0.590498 -0.0458453 -0.9223 -0.814375 0.526811 0.260789 -1.39928 -0.00260286 -0.642625 -0.957196 -0.826085 -0.254272 0.233158 -0.0878258 0.423609 -0.308377 -0.384268 -0.166401 -0.330052 -0.709202 -1.24796 0.635524 0.000458667 0.263622 -0.114414 1.03092 -0.418837 -0.407232 -0.947264 -1.08856 -0.615513 0.256849 -0.961686 -0.0730546 -0.336715 -0.157155 1.20118 1.44265 1.43025 2.03363 -1.11157 1.70417 2.90661
#      1     8     3     0     0     2     2     0     0     0     0     0
#      1     9     4     0     0     2     3     0     0     0     0     0
#      1    16     5     2     3     0     0     0     0     0     0     0
#      1    17     7     2     3     0     0     0     0     0     0     0
#      2     4     9     1     1     0     0     0     0     0     0     0
#      5     3    10     0     0     0     0     2     2  1977  2021     3 0.156256 0.153259 0.430739 0.384938 1.15455 -0.0780165 0.170389 0.879026 -0.0789925 0.597191 -0.0977053 2.28891 1.15609 0.238973 0.103834 -0.171197 1.31975 0.369531 0.664279 0.0992952 1.23629 0.221673 0.286009 0.424995 -0.400367 0.738657 -0.205983 -0.451695 -0.827293 -0.535471 -0.291901 0.267065 0.358622 0.472167 -0.0381969 0.334035 0.162724 -0.933385 -1.33728 -1.30994 -2.59104 -1.35118 -1.33638 -0.88523 -1.74796
#      5     6    12     0     0     0     0     3     2  1977  2021     3 -0.173304 -0.38403 -0.355592 0.00814798 -0.0279981 0.124961 0.407525 0.60746 0.272461 -0.0450596 0.143571 0.127678 0.461624 0.968035 0.570421 -0.150008 -0.0409422 -0.0586173 0.0556987 1.09311 0.932799 0.562533 -0.357023 0.433651 -1.32142 -0.751725 -1.17282 -1.11769 -1.09453 1.05318 1.13339 1.04466 1.25112 1.32423 0.47284 -0.365251 -0.990043 -1.1788 -0.998326 -0.300031 -1.118 -0.694902 -1.00611 -0.293933 0.947104
#      5     7    14     0     0     0     0     4     1  1982  2021     3 -0.241764 -0.432658 1.14278 0.472188 -0.484901 -0.067136 0.057028 0.454267 -0.35074 0.921073 -0.0668291 0.201205 0.329509 0.594656 0.281644 0.703166 1.81826 0.37288 -0.703267 -0.880439 0.120622 0.390689 0.33831 0.0280743 -1.35325 -2.36937 -1.47076 -0.799726 -0.414571 -0.205968 -2.40039 0.735536 -0.226838 0.273367 1.06212 1.39573 0.810297 -1.31601      0 1.2809
#      5     9    16     0     0     0     0     5     2  1982  2021     3 -0.552167 0.28419 0.786903 0.671029 -0.106387 -0.158421 -0.158731 0.0671138 0.0735891 1.21522 -0.041238 0.744319 0.366148 0.348541 -0.275371 0.758446 1.94374 0.405383 -0.788689 -0.526975 -0.00810224 0.248911 0.126362 -0.0620668 -1.13083 -2.41838 -1.55618 0.392221 -0.61326 -0.198578 -1.91913 0.829883 -0.213101 0.221739 0.574934 1.0067 -0.244452 -1.29347      0 1.20021
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      4      1         1
      4      2         1
      5      1         1
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 #_CPUE/survey:_1
#  1 #_CPUE/survey:_2
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  0 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

