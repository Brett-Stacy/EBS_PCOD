#V3.30.18.00;_safe;_compile_date:_Sep 30 2021;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: BSPcod22_MAY.dat // Model_19_12.ctl
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
3 #_Nblock_Patterns
 1 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1976 1976
 1977 2007
 1977 1980
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
 0.1 1 0.429088 0 0 0 6 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 10 20 16.2452 0 0 0 5 0 1 1977 2021 5 0 0 # L_at_Amin_Fem_GP_1
 60 150 102.685 0 0 0 5 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.187834 0 0 0 5 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 10 0.887051 0 0 0 5 0 0 0 0 0 0 0 # Richards_Fem_GP_1
 0 10 3.23364 0 0 0 5 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 10.5644 0 0 0 5 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -10 10 5.30606e-06 0 0 0 -1 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -10 10 3.19723 0 0 0 -1 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
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
 1e-06 10 0.1804 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_se
 -0.99 0.99 0 0 0 0 -1 # L_at_Amin_Fem_GP_1_dev_autocorr
# -10 10 1 0 0 -1 -1 # Wtlen_1_Fem_GP_1_ENV_add
# -10 10 1 0 0 -1 -1 # Wtlen_2_Fem_GP_1_ENV_add
 -10 10 0.321643 0 0 0 1 # AgeKeyParm2_BLK2delta_1977
 -10 10 0.755955 0 0 0 1 # AgeKeyParm3_BLK2delta_1977
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
            12            16       13.7641             0             0             0          3          0          0          0          0          0          0          0 # SR_LN(R0)
           -10            10             1             0             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
           -10            10      0.607246             0             0             0          3          0          0          0          0          0          0          0 # SR_sigmaR
           -10            10             0             0             0             0         -1          0          0          0          0          0          1          1 # SR_regime
         -0.99          0.99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
# timevary SR parameters
 -10 10 -0.877831 0 -1 0 1 # SR_regime_BLK1add_1976
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
#  0.00372174 0.00246013 0.00306308 0.00398233 0.00433858 0.0025359 -0.00534906 -0.0262186 -0.0712843 -0.15398 -0.281133 -0.441577 -0.608841 -0.742119 -0.76726 -0.541221 0.300645 0.731299 -0.100917 1.22604 1.18049 0.505958 0.775847 -0.947042 -0.524182 1.18624 -0.672252 0.670503 0.0925479 -0.510865 -0.807489 -0.296246 0.399707 0.190578 -0.189238 0.638933 -0.564242 -0.597583 -0.368521 0.692503 0.113975 -0.0417156 0.326088 0.0226392 -0.7415 -0.318998 -0.485679 -0.639326 -0.668318 0.421536 0.0121408 0.911115 -0.643967 0.273429 0.978522 0.266825 1.15647 -0.345503 -0.0282553 -0.979835 -1.12278 0.634436 0.340701 -0.297646 0 0 0 0 0 0 0 0 0 0 0 0 0
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
 0 1 0.127073 0 0 0 1 # InitF_seas_1_flt_1Fishery
#
# F rates by fleet x season
# Yr:  1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Fishery 0.169707 0.206543 0.122855 0.0710823 0.0722855 0.0611101 0.0803751 0.100988 0.118837 0.109438 0.126054 0.16779 0.16458 0.1953 0.294428 0.301952 0.215967 0.294339 0.372625 0.376022 0.488749 0.385152 0.395724 0.364719 0.304614 0.279446 0.289522 0.31185 0.345315 0.386069 0.374735 0.481196 0.63379 0.568255 0.641937 0.647741 0.52064 0.540771 0.494692 0.458433 0.369306 0.249474 0.221674 0.223578 0.229668 0.414806 0.414806 0.404309 0.395453 0.400245 0.406586 0.410466 0.411951 0.412254 0.412199 0.41211 0.412061
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         2         1         0         1         0         0  #  Survey
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -1             1      -0.20016             0             0             0          4          0          2       1982       2021          1          0          0  #  LnQ_base_Survey(2)
             0            10     0.0930722             0             0             0          7          0          0          0          0          0          0          0  #  Q_extraSD_Survey(2)
# timevary Q parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type     PHASE  #  parm_name
         1e-06            10        0.0765             0             0             0      -9  # LnQ_base_Survey(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # LnQ_base_Survey(2)_dev_autocorr
# info on dev vectors created for Q parms are reported with other devs after tag parameter section 
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
            10            80       73.1661          -999          -999             0          1          0          0       1977       2021          0          0          0  #  Size_DblN_peak_Fishery(1)
           -10            10      -1.95359          -999          -999             0          1          0          0       1977       2021          0          0          0  #  Size_DblN_top_logit_Fishery(1)
           -10            10       5.94689          -999          -999             0          1          0          2       1977       2021          1          0          0  #  Size_DblN_ascend_se_Fishery(1)
           -10            10      -9.79532          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fishery(1)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fishery(1)
           -10            10       1.68973          -999          -999             0          1          0          2       1977       2021          1          0          0  #  Size_DblN_end_logit_Fishery(1)
# 2   Survey LenSelex
# 2   Survey LenSelex
            10            80       20.6187          -999          -999             0          3          0          1       1982       2021          3          0          0  #  Size_DblN_peak_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Survey(2)
           -10            10       3.44051          -999          -999             0          3          0          2       1982       2021          3          0          0  #  Size_DblN_ascend_se_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Survey(2)
           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Survey(2)
           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Survey(2)

# 1   Fishery AgeSelex
# 2   Survey AgeSelex
#           0.1            10       3.16013          -999          -999             0          1          0          2       1982       2021          1          0          0  #  Age_DblN_peak_Survey(2)
#           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_top_logit_Survey(2)
#           -10             5       1.57481          -999          -999             0          1          0          2       1982       2021          1          0          0  #  Age_DblN_ascend_se_Survey(2)
#           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_descend_se_Survey(2)
#           -10            10           -10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_start_logit_Survey(2)
#           -10            10            10          -999          -999             0         -3          0          0          0          0          0          0          0  #  Age_DblN_end_logit_Survey(2)
#_Dirichlet parameters
#_multiple_fleets_can_refer_to_same_parm;_but_list_cannot_have_gaps
           -10            10      0.900727             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_1
           -10            10       0.12819             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_2
           -10            10       1.28738             0          -999             0          4          0          0          0          0          0          0          0  #  ln(DM_theta)_3
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
         1e-06            10        0.1639             0             0             0      -9  # Size_DblN_ascend_se_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_ascend_se_Fishery(1)_dev_autocorr
         1e-06            10        0.7726             0             0             0      -9  # Size_DblN_end_logit_Fishery(1)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_end_logit_Fishery(1)_dev_autocorr
         1e-06            10        0.2092             0             0             0      -9  # Size_DblN_peak_Survey(2)_dev_se
         -0.99          0.99             0             0             0             0      -9  # Size_DblN_peak_Survey(2)_dev_autocorr
         1e-06            10         0.771             0             0             0      -9  # Size_DblN_ascend_se_Survey(2)_dev_se
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
#      1     2     1     0     0     0     0     1     1  1977  2021     5 -0.838009 -0.043732 -0.510096 0.023056 -0.367781 -0.332322 0.884802 0.580883 -0.641324 0.656821 0.47908 0.194462 -0.271985 0.194208 0.403249 0.323623 1.06098 -0.00607128 -0.639329 0.198247 0.432423 -0.11291 -0.0986892 0.235455 -0.0346119 0.63211 0.528918 0.650872 0.545549 -0.371476 -0.671009 0.980724 -0.645862 0.0926746 -0.708292 1.2002 0.322849 -0.165971 0.476626 -0.687538 -0.303045 -1.4649 0.625646 0.830716 -3.63921
#      1     8     3     0     0     2     2     0     0     0     0     0
#      1     9     4     0     0     2     3     0     0     0     0     0
#      1    16     5     2     3     0     0     0     0     0     0     0
#      1    17     6     2     3     0     0     0     0     0     0     0
#      2     4     7     1     1     0     0     0     0     0     0     0
#      3     1     8     0     0     0     0     2     2  1982  2021     1 0.217503 0.171029 -0.336653 -0.761707 -0.441055 -0.0390958 -0.356625 0.0157352 -0.524687 -0.923885 -0.984314 -0.168578 1.05224 0.383811 0.760312 0.221262 0.221598 0.00806071 -0.161349 0.184504 0.116554 0.214854 0.18486 0.378981 -0.321087 -0.893206 0.0277296 -0.593444 0.385384 0.0806817 0.30788 0.576829 0.821606 0.276522 0.574144 -1.10039 -0.0131034 -0.360301      0 0.797388
#      5     1    10     0     0     0     0     3     2  1977  2021     1 -0.412059 -0.648077 -0.560761 -0.261037 -0.134009 0.600371 0.479673 0.172072 -1.75054 -1.07578 2.25265 1.63161 1.29453 3.11368 -1.09891 0.785139 -0.87835 -0.46156 -1.31112 1.57141 1.90162 -2.03666 -0.204741 -0.510656 1.2526 -1.50104 -2.31403 -2.91964 -2.60505 -1.30924 -0.137607 -1.16499 -1.96874 2.9292 -1.20595 2.5765 0.291486 1.6128 0.555124 0.632289 1.30276 1.00656 0.326923 0.743764 -0.562078
#      5     2    12     0     0     0     0     4     2  1977  2021     1 -0.820314 -0.130299 -0.0811168 -0.176279 -0.21325 0.255704 0.974661 0.101958 -0.168995 -1.06428 0.454014 0.123026 0.158835 0.029832 0.0192289 -0.384572 0.218951 0.371211 -0.224249 0.098513 -0.380956 0.384328 0.127296 0.37887 -0.908211 0.492376 1.60018 -0.888124 0.629538 -0.923089 -0.522424 -1.56073 -1.16763 -0.225331 -0.582652 -0.175495 0.468334 0.48295 1.26179 0.603197 -0.499938 0.150061 1.28406 0.193385 0.235613
#      5     3    14     0     0     0     0     5     2  1977  2021     1 0.258878 -0.185822 -0.155515 0.380939 0.46587 0.0720454 0.19182 0.681284 0.463066 0.747033 0.479291 0.59898 0.365941 -0.147791 -0.208145 0.0672196 0.0781618 -0.0203408 0.0730181 -0.0603308 0.0403883 -0.383646 -0.246025 -0.234106 -0.210028 0.0427387 -0.143617 -0.0874841 -0.19743 -0.174091 0.0885664 0.0133306 -0.270032 0.0293342 -0.269236 -0.0367994 -0.0236975 -0.0994166 -0.391011 -0.502195 -0.478026 -0.209419 -0.11055 0.192546 -0.48555
#      5     6    16     0     0     0     0     6     2  1977  2021     1 -0.876433 -1.13023 -1.29547 0.247747 -0.134472 0.619689 0.206843 0.364454 -0.435658 -0.590067 0.852718 1.03818 1.31783 1.49749 1.08466 -0.180648 0.0894893 -0.611356 -0.337231 1.91928 0.302981 0.136509 -0.064797 0.320171 0.674823 -0.364861 -0.269675 -0.203534 0.070992 2.0351 1.85345 -0.190609 -1.41966 -1.77499 -0.093885 -0.876816 -1.36403 -1.4313 -1.12719 -0.890259 -0.165367 0.42296 -0.33336 0.945301 0.161248
#      5     7    18     0     0     0     0     7     2  1982  2021     1 2.38545 0.818413 1.30571 -0.970209 -1.34747 -0.0923596 -0.438445 2.77146 0.653777 -1.01377 -1.26898 -0.888633 -0.532264 -1.29027 -0.777485 0.0297263 -0.372535 1.15718 1.80312 -1.68376 0.100564 -0.538859 0.0291898 -0.471437 -2.12839 -2.36386 0.5705 -0.152067 0.514851 -0.39682 -0.114637 1.37971 1.49613 0.377375 1.91101 0.399651 0.214065 -1.65576      0 0.57999
#      5     9    20     0     0     0     0     8     2  1982  2021     1 0.970188 0.342073 0.75316 -0.387315 -2.2617 0.21315 -1.43163 0.665453 1.21473 -1.21622 -0.159538 -0.198207 0.224239 -2.11895 -1.65726 -0.469418 -1.32189 0.277423 0.999773 0.220734 -0.10878 -0.14475 -0.0623937 -0.107249 0.112555 0.0548043 0.506062 0.923291 -0.0421978 0.983633 0.36272 0.229467 1.01081 -0.0368665 0.741211 1.25829 0.380832 0.231529      0 -0.951605
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
      4      2         8
      5      2         1
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
#  0 #_CPUE/survey:_1
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

