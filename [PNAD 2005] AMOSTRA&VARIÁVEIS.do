**************************[PNAD 2005] VARIÁVEIS

*Gênero 
gen mulher=1 if v0302==4
replace mulher=0 if v0302==2

*Etnia
gen branco=1 if v0404==2 | v0404==6
replace branco=0 if v0404==4 | v0404==8 | v0404==0

*Educação do chefe da família
recode v4703 17=.
gen educa=v4703 - 1
gen educa_ens_fund_ch=1 if educa<=8 & v0401==1
replace educa_ens_fund_ch=0 if educa>8  & v0401==1

gen educa_ens_medio_ch=1 if educa>=9 & educa<=11 & v0401==1
replace educa_ens_medio_ch=0 if (educa<9 | educa>11) & v0401==1

gen educa_ens_super_ch=1 if educa>=12 & v0401==1
replace educa_ens_super_ch=0 if educa<12 & v0401==1


***criar chave para domicílio***

egen chave = concat (uf v0102 v0103), format (%16.0f)
destring, replace
format chave %16.0f




sort chave
*Anos de estudo dos chefes por domicílio
by chave: egen chefe_ens_fund= max (educa_ens_fund_ch)
by chave: egen chefe_ens_medio= max (educa_ens_medio_ch)
by chave: egen chefe_ens_super= max (educa_ens_super_ch)

*Rendimento domiciliar per capita
recode v4742 999999999999=.
gen menos_1_sm_e_meio=1 if v4742<=450
replace menos_1_sm_e_meio=0 if v4742>450

*Cursando o ensino superior
gen cursando_grad=1 if v0603==05
replace cursando_grad=0 if v0603==01 | v0603==02 | v0603==03 | v0603==04 | v0603==06 | v0603==07 | v0603==08 | v0603==09 | v0603==10


**************************[PNAD 2005] AMOSTRA

*MANTER APENAS MS
keep if uf==50

*MANTER APENAS REGIÃO URBANA
keep if v4728==1 | v4728==2 | v4728==3

*MANTER APENAS DEMANDA POTENCIAL POR ENSINO SUPERIOR
keep if educa>=11 & educa<=14
rename v8005 idade
keep if idade>=16 & idade<=35

*MANTER APENAS QUEM É FILHO NO DOMICÍLIO
keep if v0401==3


tab mulher
tab branco
tab chefe_ens_fund
tab chefe_ens_medio
tab chefe_ens_super
tab menos_1_sm_e_meio

*Matriculados
tab mulher if cursando_grad==1
tab branco if cursando_grad==1
tab chefe_ens_fund if cursando_grad==1
tab chefe_ens_medio if cursando_grad==1
tab chefe_ens_super if cursando_grad==1
tab menos_1_sm_e_meio if cursando_grad==1

*PESO DA AMOSTRA
tab mulher [fw=v4729]

*GRUPOS
gen grupo_1=1 if mulher==0 & branco==1 & chefe_ens_fund==1 & menos_1_sm_e_meio==1

gen grupo_2=1 if mulher==0 & branco==1 & chefe_ens_fund==1 & menos_1_sm_e_meio==0

gen grupo_3=1 if mulher==0 & branco==1 & chefe_ens_medio==1 & menos_1_sm_e_meio==1

gen grupo_4=1 if mulher==0 & branco==1 & chefe_ens_medio==1 & menos_1_sm_e_meio==0

gen grupo_5=1 if mulher==0 & branco==1 & chefe_ens_super==1 & menos_1_sm_e_meio==1

gen grupo_6=1 if mulher==0 & branco==1 & chefe_ens_super==1 & menos_1_sm_e_meio==0

gen grupo_7=1 if mulher==0 & branco==0 & chefe_ens_fund==1 & menos_1_sm_e_meio==1

gen grupo_8=1 if mulher==0 & branco==0 & chefe_ens_fund==1 & menos_1_sm_e_meio==0

gen grupo_9=1 if mulher==0 & branco==0 & chefe_ens_medio==1 & menos_1_sm_e_meio==1

gen grupo_10=1 if mulher==0 & branco==0 & chefe_ens_medio==1 & menos_1_sm_e_meio==0

gen grupo_11=1 if mulher==0 & branco==0 & chefe_ens_super==1 & menos_1_sm_e_meio==1

gen grupo_12=1 if mulher==0 & branco==0 & chefe_ens_super==1 & menos_1_sm_e_meio==0

gen grupo_13=1 if mulher==1 & branco==1 & chefe_ens_fund==1 & menos_1_sm_e_meio==1

gen grupo_14=1 if mulher==1 & branco==1 & chefe_ens_fund==1 & menos_1_sm_e_meio==0

gen grupo_15=1 if mulher==1 & branco==1 & chefe_ens_medio==1 & menos_1_sm_e_meio==1

gen grupo_16=1 if mulher==1 & branco==1 & chefe_ens_medio==1 & menos_1_sm_e_meio==0

gen grupo_17=1 if mulher==1 & branco==1 & chefe_ens_super==1 & menos_1_sm_e_meio==1

gen grupo_18=1 if mulher==1 & branco==1 & chefe_ens_super==1 & menos_1_sm_e_meio==0

gen grupo_19=1 if mulher==1 & branco==0 & chefe_ens_fund==1 & menos_1_sm_e_meio==1

gen grupo_20=1 if mulher==1 & branco==0 & chefe_ens_fund==1 & menos_1_sm_e_meio==0

gen grupo_21=1 if mulher==1 & branco==0 & chefe_ens_medio==1 & menos_1_sm_e_meio==1

gen grupo_22=1 if mulher==1 & branco==0 & chefe_ens_medio==1 & menos_1_sm_e_meio==0

gen grupo_23=1 if mulher==1 & branco==0 & chefe_ens_super==1 & menos_1_sm_e_meio==1

gen grupo_24=1 if mulher==1 & branco==0 & chefe_ens_super==1 & menos_1_sm_e_meio==0

gen soma_grupo=1 if grupo_1 & grupo_2 & grupo_3 & grupo_4 & grupo_5 & grupo_6 & grupo_7 & grupo_8 & grupo_9 & grupo_10 & grupo_11 & grupo_12 & grupo_13 & grupo_14 & grupo_15 & grupo_16 &  grupo_17 & grupo_18 & grupo_19 & grupo_20 & grupo_21 & grupo_22 & grupo_23 & grupo_24   


*PESOS
tab grupo_1
tab grupo_2
tab grupo_3
tab grupo_4
tab grupo_5
tab grupo_6
tab grupo_7
tab grupo_8
tab grupo_9
tab grupo_10
tab grupo_11
tab grupo_12
tab grupo_13
tab grupo_14
tab grupo_15
tab grupo_16
tab grupo_17
tab grupo_18
tab grupo_19
tab grupo_20
tab grupo_21
tab grupo_22
tab grupo_23
tab grupo_24

tab soma_grupo

replace cursando_grad=0 if cursando_grad==.
logit cursando_grad mulher branco chefe_ens_medio chefe_ens_super menos_1_sm_e_meio, rob

*CRIAR PROBABILIDADES
predict prob

sum prob

sum prob if grupo_1==1
sum prob if grupo_2==1
sum prob if grupo_3==1
sum prob if grupo_4==1
sum prob if grupo_5==1
sum prob if grupo_6==1
sum prob if grupo_7==1
sum prob if grupo_8==1
sum prob if grupo_9==1
sum prob if grupo_10==1
sum prob if grupo_11==1
sum prob if grupo_12==1
sum prob if grupo_13==1
sum prob if grupo_14==1
sum prob if grupo_15==1
sum prob if grupo_16==1
sum prob if grupo_17==1
sum prob if grupo_18==1
sum prob if grupo_19==1
sum prob if grupo_20==1
sum prob if grupo_21==1
sum prob if grupo_22==1
sum prob if grupo_23==1
sum prob if grupo_24==1










