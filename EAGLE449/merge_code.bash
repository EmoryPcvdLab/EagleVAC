#!/bin/bash

#============================ OVERRIDES ============================
# NOTE 2022 Apr 2 -- Switched these overrides to OFF because the
#   results all look good (except hypothalamus). See TO DO notes
#   below. - JLS.

do_eickhoff=0
do_indovina=0
do_brainnetome=0
do_suit=0
do_thalamus=0
do_brainstem=0
do_dienceph=0
do_hypothal=0

reset_eickhoff=0
reset_indovina=0
reset_brainnetome=0
reset_suit=0
reset_thalamus=0
reset_brainstem=0
reset_dienceph=0
reset_hypothal=0
#===================================================================

BDIR=~/path/to/parcellations

SDIR_EICKHOFF=${BDIR}/EICKHOFF
SDIR_INDOVINA=${BDIR}/unmatched_to_MNI152_RPI
SDIR_BRAINNETOME=${BDIR}/base_parcellations/Brainnetome/BNA_FSL/Brainnetome
SDIR_SUIT=${BDIR}/SUIT
SDIR_THALAMUS=${BDIR}/THALAMUS_DWI
SDIR_BRAINSTEM=${BDIR}/BrainstemNavigator/BRAINSTEM
SDIR_DIENCEPH=${BDIR}/BrainstemNavigator/DIENCEPH/labels_thresholded_binary_0.35
SDIR_HYPOTHALAMUS=${BDIR}/HYPOTHALAMUS

TDIR_EICKHOFF=${BDIR}/ATLAS_MERGE/MNI152/EICKHOFF
TDIR_INDOVINA=${BDIR}/ATLAS_MERGE/MNI152/INDOVINA
TDIR_BRAINNETOME=${BDIR}/ATLAS_MERGE/MNI152/BRAINNETOME
TDIR_SUIT=${BDIR}/ATLAS_MERGE/MNI152/SUIT
TDIR_THALAMUS=${BDIR}/ATLAS_MERGE/MNI152/THALAMUS
TDIR_BRAINSTEM=${BDIR}/ATLAS_MERGE/MNI152/BRAINSTEM
TDIR_DIENCEPH=${BDIR}/ATLAS_MERGE/MNI152/DIENCEPH
TDIR_HYPOTHALAMUS=${BDIR}/ATLAS_MERGE/MNI152/HYPOTHALAMUS

TEMPLATE=${BDIR}/ATLAS_MERGE/MNI152/MNI152_T1_2009c.nii

AFNI_NIFTI_TYPE_WARN=NO # Turns off F64 -> F32 warnings

#====================================================================
# Step 1: Get all ROIs in same orientation and grid
#====================================================================

#-- Do Indovina ROIs first
if [ ${do_indovina} == 1 ] ; then
    if [ ${reset_indovina} == 1 ] ; then rm ${TDIR_INDOVINA}/* ; fi
    for x in PIC_L PIC_R ; do
	IN=${SDIR_INDOVINA}/${x}.nii.gz
	OUT=${TDIR_INDOVINA}/${x}.nii.gz
	3dresample -master ${TEMPLATE} -inset ${IN} -prefix ${OUT} \
	    && 3drefit -view 'tlrc' -space MNI ${OUT} \
	    && echo "New ROI: ${OUT}" \
	    && 3dinfo -d3 -space -orient -ni -nj -nk ${OUT} \
	    && echo ""
    done
fi

#--Do Eickhoff ROIs
if [ ${do_eickhoff} == 1 ] ; then
    if [ ${reset_eickhoff} == 1 ] ; then rm ${TDIR_EICKHOFF}/* ; fi
    for x in \
	Left_Operculum_OP2 Right_Operculum_OP2 \
	Left_IPL_PFcm Right_IPL_PFcm \
	Left_IPL_PF Right_IPL_PF \
	Left_AIPS_IP3 Right_AIPS_IP3 \
	Left_PSC_2 Right_PSC_2 \
	Left_PSC_3a Left_PSC_3b \
	Right_PSC_3a Right_PSC_3b \
	Left_Visual_hOc5 Right_Visual_hOc5 \
	Left_Hippocampus_CA Right_Hippocampus_CA \
	Left_Hippocampus_DG Right_Hippocampus_DG \
	Left_Hippocampus_EC Right_Hippocampus_EC \
	Left_Hippocampus_HATA Right_Hippocampus_HATA \
	Left_Hippocampus_Subc Right_Hippocampus_Subc \
	Left_Insula_Ig1 Right_Insula_Ig1 \
	Left_Insula_Ig2 Right_Insula_Ig2 \
	Left_Insula_Id1 Right_Insula_Id1 \
	Left_Insula_Id7 Right_Insula_Id7 \
	Left_Operculum_OP1 \
	Left_Operculum_OP3 \
	Left_Operculum_OP4 \
	Left_Operculum_OP8 \
	Left_Operculum_OP9 \
	Right_Operculum_OP1 \
	Right_Operculum_OP3 \
	Right_Operculum_OP4 \
	Right_Operculum_OP8 \
	Right_Operculum_OP9 \
	Left_Visual_FG1 \
	Left_Visual_FG2 \
	Left_Visual_FG3 \
	Left_Visual_FG4 \
	Left_Visual_hOc1 \
	Left_Visual_hOc2 \
	Left_Visual_hOc3d \
	Left_Visual_hOc3v \
	Left_Visual_hOc4d \
	Left_Visual_hOc4la \
	Left_Visual_hOc4lp \
	Left_Visual_hOc4v \
	Left_Visual_hOc6 \
	Right_Visual_FG1 \
	Right_Visual_FG2 \
	Right_Visual_FG3 \
	Right_Visual_FG4 \
	Right_Visual_hOc1 \
	Right_Visual_hOc2 \
	Right_Visual_hOc3d \
	Right_Visual_hOc3v \
	Right_Visual_hOc4d \
	Right_Visual_hOc4la \
	Right_Visual_hOc4lp \
	Right_Visual_hOc4v \
	Right_Visual_hOc6 \
	Left_Cingulum_p32 \
	Left_Cingulum_s32 \
	Right_Cingulum_p32 \
	Right_Cingulum_s32 \
	Left_Cingulum_p24ab \
	Left_Cingulum_p24c \
	Left_Cingulum_s24 \
	Right_Cingulum_p24ab \
	Right_Cingulum_p24c \
	Right_Cingulum_s24 \
	Left_Amygdala_CM \
	Left_Amygdala_IF \
	Left_Amygdala_LB \
	Left_Amygdala_MF \
	Left_Amygdala_SF \
	Left_Amygdala_VTM \
	Right_Amygdala_CM \
	Right_Amygdala_IF \
	Right_Amygdala_LB \
	Right_Amygdala_MF \
	Right_Amygdala_SF \
	Right_Amygdala_VTM \
	Left_OFC_Fo1 \
	Left_OFC_Fo2 \
	Left_OFC_Fo3 \
	Right_OFC_Fo1 \
	Right_OFC_Fo2 \
	Right_OFC_Fo3 \
	Left_Cingulum_25 \
	Right_Cingulum_25 ; do
	IN=${SDIR_EICKHOFF}/${x}.nii.gz
	OUT=${TDIR_EICKHOFF}/${x}.nii.gz
	3dresample -master ${TEMPLATE} -inset ${IN} -prefix ${OUT} \
	    && 3drefit -view 'tlrc' -space MNI ${OUT} \
	    && echo "New ROI: ${OUT}" \
	    && 3dinfo -d3 -space -orient -ni -nj -nk ${OUT} \
	    && echo ""
    done
fi

#-- Do Brainnetome
if [ ${do_brainnetome} == 1 ] ; then
    if [ ${reset_brainnetome} == 1 ] ; then rm ${TDIR_BRAINNETOME}/* ; fi
    for x in BNA-maxprob-thr0-1mm ; do
	IN=${SDIR_BRAINNETOME}/${x}.nii.gz
	OUT=${TDIR_BRAINNETOME}/${x}.nii.gz
	3dresample -master ${TEMPLATE} -inset ${IN} -prefix ${OUT} \
	    && 3drefit -view 'tlrc' -space MNI ${OUT} \
	    && echo "New ROI: ${OUT}" \
	    && 3dinfo -d3 -space -orient -ni -nj -nk ${OUT} \
	    && echo ""
    done
    #-- Copy LUT
    cp \
	${BDIR}/base_parcellations/Brainnetome/BNA_FSL/BNA-thr0-1mm.xml \
	${TDIR_BRAINNETOME}/
fi

#-- Do SUIT
if [ ${do_suit} == 1 ] ; then
    if [ ${reset_suit} == 1 ] ; then rm ${TDIR_SUIT}/* ; fi
    for x in atl-Anatom_space-MNI_dseg ; do
	IN=${SDIR_SUIT}/${x}.nii
	OUT=${TDIR_SUIT}/${x}.nii.gz
	3dresample -master ${TEMPLATE} -inset ${IN} -prefix ${OUT} \
	    && 3drefit -view 'tlrc' -space MNI ${OUT} \
	    && echo "New ROI: ${OUT}" \
	    && 3dinfo -d3 -space -orient -ni -nj -nk ${OUT} \
	    && echo ""
    done
    #-- Copy LUT
    cp \
	${SDIR_SUIT}/atl-Anatom.lut \
	${TDIR_SUIT}/atl-Anatom.xml
fi

#-- Do Najdenovska thalamus
if [ ${do_thalamus} == 1 ] ; then
    if [ ${reset_thalamus} == 1 ] ; then rm ${TDIR_THALAMUS}/* ; fi
    for x in Thalamus_Nuclei-HCP-MaxProb ; do
	IN=${SDIR_THALAMUS}/${x}.nii.gz
	OUT=${TDIR_THALAMUS}/${x}.nii.gz
	3dresample -master ${TEMPLATE} -inset ${IN} -prefix ${OUT} \
	    && 3drefit -view 'tlrc' -space MNI ${OUT} \
	    && echo "New ROI: ${OUT}" \
	    && 3dinfo -d3 -space -orient -ni -nj -nk ${OUT} \
	    && echo ""
    done
    #-- Copy LUT
    cp \
	${SDIR_THALAMUS}/Thalamic_Nuclei-ColorLUT.txt \
	${TDIR_THALAMUS}/
fi

#-- Do BrainstemNavigator brainstem
if [ ${do_brainstem} == 1 ] ; then
    if [ ${reset_brainstem} == 1 ] ; then rm ${TDIR_BRAINSTEM}/* ; fi
    for x in $(/bin/ls -1 ${SDIR_BRAINSTEM}/*.nii) ; do
	IN=${x}
	y=$(basename ${x} .nii | sed 's/blabel_//g')
	OUT=${TDIR_BRAINSTEM}/${y}.nii.gz
	3dresample -master ${TEMPLATE} -inset ${IN} -prefix ${OUT} \
	    && 3drefit -view 'tlrc' -space MNI ${OUT} \
	    && echo "New ROI: ${OUT}" \
	    && 3dinfo -d3 -space -orient -ni -nj -nk ${OUT} \
	    && echo ""
    done
    #-- Copy LUT
    cp \
	${BDIR}/BrainstemNavigator/ListofNuclei.docx \
	${TDIR_BRAINSTEM}/
fi

#-- Do BrainstemNavigator diencephalon
if [ ${do_dienceph} == 1 ] ; then
    if [ ${reset_dienceph} == 1 ] ; then rm ${TDIR_DIENCEPH}/* ; fi
    for x in $(/bin/ls -1 ${SDIR_DIENCEPH}/*.nii.gz) ; do
	IN=${x}
	OUT=${TDIR_DIENCEPH}/$(basename ${x})
	3dresample -master ${TEMPLATE} -inset ${IN} -prefix ${OUT} \
	    && 3drefit -view 'tlrc' -space MNI ${OUT} \
	    && echo "New ROI: ${OUT}" \
	    && 3dinfo -d3 -space -orient -ni -nj -nk ${OUT} \
	    && echo ""
    done
    #-- Copy LUT
    cp \
	${BDIR}/BrainstemNavigator/ListofNuclei.docx \
	${TDIR_DIENCEPH}/
fi

#-- Do Neudorfer hypothalamus
#== NOTE THAT this is more difficult as we have to resample from a
#== 0.5mm to 1mm grid, which means using 3dfractionize

# I ended up combining several of the ROIs in 0.5mm space and THEN using
# 3dfractionize at various cliplevels to determine the best match to the
# original grid. The best match was a cliplevel=0.4. This was copied along
# with its LUT to ${TDIR_HYPOTHALAMUS}.
#
# Analysis record follows:
#
# VAL=1 ; IND=9 ; PFIX="MB-R" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<${IND}..${IND}>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
# VAL=2 ; IND=10 ; PFIX="MB-L" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<${IND}..${IND}>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
# VAL=3 ; IND=33 ; PFIX="BNST-R" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<${IND}..${IND}>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
# VAL=4 ; IND=34 ; PFIX="BNST-L" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<${IND}..${IND}>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
 # VAL=5 ; IND=35 ; PFIX="NBasalis-R" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<${IND}..${IND}>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
# VAL=6 ; IND=36 ; PFIX="NBasalis-L" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<${IND}..${IND}>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
# VAL=7 ; PFIX="Hthal-R" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<19,21,23,25,27,29,31,37,45,47,49,51,53>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
# VAL=8 ; PFIX="Hthal-L" ; 3dcalc -a hypothalamus_0.5mm_grid_ShortDatum.nii.gz"<20,22,24,26,28,30,32,38,46,48,50,52,54>" -expr "${VAL}*ispositive(a)" -prefix ROIs0.5mm/${PFIX}.nii && echo "${PFIX}" >> ROIs0.5mm/atlas_b4_labels.txt
# fslmaths BNST-L.nii -add BNST-R.nii -add Hthal-L.nii -add Hthal-R.nii -add MB-L.nii -add MB-R.nii -add NBasalis-L.nii -add NBasalis-R.nii atlas_b4_0.5mm
# 3dcalc -a atlas_b4_0.5mm.nii.gz -expr 'a' -datum short -prefix atlas_b4_0.5mm_ShortDatum.nii.gz
# for cliplevel in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 ; do OUT=atlas_b4_1mm_cliplevel${cliplevel}.nii.gz ; 3dfractionize -template ../../MNI152/MNI152_T1_2009c.nii -input atlas_b4_0.5mm_ShortDatum.nii.gz -clip ${cliplevel} -vote -prefix ${OUT} && 3drefit -view 'tlrc' -space MNI ${OUT} ; done
#
# Inspected cliplevels vs 0.5mm original in fsleyes, selected best cliplevel (0.4), and saved it as ${TDIR_HYPOTHALAMUS}/atlas_b4.nii.gz.
# Interim data moved to ${TDIR_HYPOTHALAMUS}/DEPRECATED.
# The results of the first pass (what I tried before), using the code below, was also moved to DEPRECATED.

#.............................. this is deprecated ..............................
#if [ ${do_hypothal} == 1 ] ; then
#    if [ ${reset_hypothal} == 1 ] ; then rm ${TDIR_HYPOTHALAMUS}/* ; fi
#    for x in MNI152b_atlas_labels_0.5mm ; do
#	IN=${SDIR_HYPOTHALAMUS}/${x}.nii.gz
#	# 3dfractionize requires SHORT-valued data
#	3dcalc -a ${IN} -expr 'a' -datum short -prefix ${TDIR_HYPOTHALAMUS}/hypothalamus_0.5mm_grid_ShortDatum.nii.gz
#	IN=${TDIR_HYPOTHALAMUS}/hypothalamus_0.5mm_grid_ShortDatum.nii.gz
#	for VOTE in "NO" "YES" ; do
#	    for cliplevel in 0.1 0.2 0.3 ; do
#		OUT=${TDIR_HYPOTHALAMUS}/hypothalamus_1mm_grid_vote${VOTE}_cliplevel${cliplevel}.nii.gz
#		if [ "${VOTE}" == "YES" ] ; then
#		    3dfractionize \
#			-template ${TEMPLATE} \
#			-input ${IN} \
#			-clip ${cliplevel} \
#			-vote \
#			-prefix ${OUT} \
#			&& 3drefit -view 'tlrc' -space MNI ${OUT} \
#			&& echo "New ROI: ${OUT}" \
#			&& 3dinfo -d3 -space -orient -ni -nj -nk ${OUT}
#		else
#		    3dfractionize \
#			-template ${TEMPLATE} \
#			-input ${IN} \
#			-clip ${cliplevel} \
#			-prefix ${OUT} \
#			&& 3drefit -view 'tlrc' -space MNI ${OUT} \
#			&& echo "New ROI: ${OUT}" \
#			&& 3dinfo -d3 -space -orient -ni -nj -nk ${OUT}
#		fi
#	    done
#	done
 #   done
 #   #-- Copy LUT
 #   cp \
#	${SDIR_HYPOTHALAMUS}/Volumes_names-labels.csv \
#	${TDIR_HYPOTHALAMUS}/
#fi


#====================================================================
#                            TO DO 2022 Apr 2:
#
# Fractionizing the 0.5mm-res hypothalamus atlas does not yield
#   satisfactory results. Everything else looks good. SELECT SPECIFIC
#   NON-TRACT AREAS FROM NEUDORFER ATLAS which do not overlap with
#   (Thal-(Bstem+Dienceph)) and create GENERAL MASK of Hthal nuclei,
#   mammilary bodies, substantia nigra, red nucleus, BNST & nucleus
#   basalis --> ATLAS b3
#
# 1 - Subtract Indovina PIC from Eickhoff
# 2 - Generate temporary mask of (Eick + Indo)
# 3 - Subtract temporary mask from Brainnetome
# 4 - Create atlases and LUTs a1-a3:
#     a1: Eickhoff/Indovina
#     a2: Brainnetome less Eickhoff/Indovina
#     a3: SUIT cerebellum
#
# --- Brainstem Navigator (brainstem and diencephalon) do NOT overlap
#     but Brainstem Navigator and thalamus DO. So
# 1 - Generate temporary mask of (bstem + dienceph)
# 2 - Subtract temporary mask from thalamus
# 3 - Create atlases and LUTs b1-b2:
#     b1: thalamus less bstem/dienceph
#     b2: brainstem and diencephalon
# 4 - Select the following areas and ensure they do not overlap with
#     b1 or b2. These areas will constitute atlas b3:
#     * Mammillary bodies (R 9, L 10)
#     * Subst. nigra (R 15, L 16) XXX IN BSTEM NAV XXX
#     * Red n. (R 17, L 18) XXX IN BSTEM NAV XXX
#     * BNST (R 33, L 34)
#     * N. basalis (R 35, L 36)
#     * R hthal NOS: 19, 21, 23, 25, 27, 29, 31, 37, 45, 47, 49,
#       51, 53
#     * L hthal NOS: 20, 22, 24, 26, 28, 30, 32, 38, 46, 48, 50,
#       52, 54
#====================================================================


#====================================================================
# Step 2: Generate atlases
#====================================================================

LPIC=${TDIR_INDOVINA}/PIC_L.nii.gz
RPIC=${TDIR_INDOVINA}/PIC_R.nii.gz
BRAINNETOME=${TDIR_BRAINNETOME}/BNA-maxprob-thr0-1mm.nii.gz 
THAL=${TDIR_THALAMUS}/Thalamus_Nuclei-HCP-MaxProb.nii.gz
SUIT=${TDIR_SUIT}/atl-Anatom_space-MNI_dseg.nii.gz
# EICKHOFF DIR IS ${TDIR_EICKHOFF}
# DIENCPH DIR IS ${TDIR_DIENCEPH}
# BSTEM DIR IS ${TDIR_BRAINSTEM}
# HYPOTHALAMUS is already DONE (see notes above)



A1DIR=${BDIR}/ATLAS_MERGE/atlas_a1 # Vestibular (Eickhoff and Indovina)
A2DIR=${BDIR}/ATLAS_MERGE/atlas_a2 # Brainnetome (no vestibular)
A3DIR=${BDIR}/ATLAS_MERGE/atlas_a3 # Cerebellum (SUIT)
B1DIR=${BDIR}/ATLAS_MERGE/atlas_b1 # Thalamus
B2DIR=${BDIR}/ATLAS_MERGE/atlas_b2 # Brainstem
B3DIR=${BDIR}/ATLAS_MERGE/atlas_b3 # Diencephalon
B4DIR=${BDIR}/ATLAS_MERGE/atlas_b4 # Hypothalamus
TEMPDIR=${BDIR}/ATLAS_MERGE/TEMP   # Working directory

for D in ${TEMPDIR} ${A1DIR} ${A2DIR} ${A3DIR} ${B1DIR} ${B2DIR} ${B3DIR} ${B4DIR} ; do
    if [ ! -d ${D} ] ; then mkdir -p ${D} ] ; else rm -R ${D}/* ; fi
done


HERE=$(pwd) ; cd ${TEMPDIR}


#=========================== Do SUIT (A3DIR) ===================
echo '_________________________________________________________________________'
echo "CEREBELLUM (ATLAS A3)"
echo '_________________________________________________________________________'
SuitNuclei=( \
    [1]="[CB] I-IV L" \
    [2]="[CB] I-IV R" \
    [3]="[CB] V L" \
    [4]="[CB] V R" \
    [5]="[CB] VI L" \
    [6]="[CB] vermis-VI" \
    [7]="[CB] VI R" \
    [8]="[CB] crus1 L" \
    [9]="[CB] vermis-crus1" \
    [10]="[CB] crus1 R" \
    [11]="[CB] crus2 L" \
    [12]="[CB] vermis-crus2" \
    [13]="[CB] crus2 R" \
    [14]="[CB] VIIb L" \
    [15]="[CB] vermis-VIIb" \
    [16]="[CB] VIIb R" \
    [17]="[CB] VIIIa L" \
    [18]="[CB] vermis-VIIIa" \
    [19]="[CB] VIIIa R" \
    [20]="[CB] VIIIb L" \
    [21]="[CB] vermis-VIIIb" \
    [22]="[CB] VIIIb R" \
    [23]="[CB] IX L" \
    [24]="[CB] vermis-IX" \
    [25]="[CB] IX R" \
    [26]="[CB] X L" \
    [27]="[CB] vermis-X" \
    [28]="[CB] X R" \
    [29]="[CB] dentateN L" \
    [30]="[CB] dentateN R" \
    [31]="[CB] interpN L" \
    [32]="[CB] interpN R" \
    [33]="[CB] fastigN L" \
    [34]="[CB] fastigN R" \
    )
#-- Gather separate nuclei into TEMPDIR using 3dcalc and
#   generate LUT
echo "Creating atlas a3 (SUIT)..."
if [ -e ${A3DIR}/atlas_a3_labels.txt ] ; then rm ${A3DIR}/atlas_a3_labels.txt ; fi
touch ${A3DIR}/atlas_a3_labels.txt

for x in $(seq 1 34) ; do
    LBL="" ; LBL=${SuitNuclei[${x}]}
    3dcalc \
	-a ${SUIT}"<${x}..${x}>" \
	-expr "${x}*ispositive(a)" \
	-prefix ${TEMPDIR}/${x}.nii
    echo "${LBL}" >> ${A3DIR}/atlas_a3_labels.txt
done

#-- Merge into ${A3DIR}/atlas_a3.nii.gz using fslmerge
echo "  -- Merging individual files..."
FSLOUTPUTTYPE=NIFTI_GZ
fslmaths 1.nii -add 2.nii -add 3.nii -add 4.nii -add 5.nii -add 6.nii -add 7.nii -add 8.nii -add 9.nii -add 10.nii \
    -add 11.nii -add 12.nii -add 13.nii -add 14.nii -add 15.nii -add 16.nii -add 17.nii -add 18.nii -add 19.nii -add 20.nii \
    -add 21.nii -add 22.nii -add 23.nii -add 24.nii -add 25.nii -add 26.nii -add 27.nii -add 28.nii -add 29.nii -add 30.nii \
    -add 31.nii -add 32.nii -add 33.nii -add 34.nii \
    ${A3DIR}/atlas_a3 

echo '------------------------------------------------------------------------'
echo '                             SANITY CHECK'
echo '------------------------------------------------------------------------'
OUTFILE=${A3DIR}/atlas_a3.nii.gz
LUTFILE=${A3DIR}/atlas_a3_labels.txt
EXPECTED=$(cat ${LUTFILE} | wc -l)
echo "ATLAS NAME: CEREBELLUM (atlas A3)"
echo "ATLAS FILE: ${OUTFILE}"
echo "LABEL FILE: ${LUTFILE}"
for x in $(seq 1 $(3dinfo -dmax ${OUTFILE})) ; do
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${OUTFILE}"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	LAB=""
	if [ ${x} -gt ${EXPECTED} ] ; then 
	    LAB="UNKNOWN"
	else
	    LAB=$(sed "${x}q;d" ${LUTFILE})
	fi
	printf "${LAB}\t${voxcount}\n"
    else
	echo "  - Value ${x} (${LAB}) has 0 voxels"
    fi
done
if [ ${x} -ne ${EXPECTED} ] ; then
    OK='***ERROR***'
else
    OK='OK'
fi

echo '=========================================================================' 
echo "Completed CEREBELLAR (ATLAS A3):" 
ls ${A3DIR} 
echo "Max voxel value in atlas a3: $(3dinfo -dmax ${A3DIR}/atlas_a3.nii.gz)" 
echo "Expected max value: ${EXPECTED} (${OK})"
echo '========================================================================='

#-- Clear TEMPDIR for next step
rm ${TEMPDIR}/*

#======== Thal (b1), Bstem (b2), Dien (b3) & Hthal (b4) ========
# (These will need to be turned into a single mask and subtract-
# ed from Brainnetome along with the Eickhoff-Indovina mask)

#---------------------- Do brainstem (B2DIR) -------------------
echo '_________________________________________________________________________'
echo "BRAINSTEM (ATLAS B2)"
echo '_________________________________________________________________________'
BstemNuclei=(${TDIR_BRAINSTEM}/CLi_RLi.nii.gz:"CRlinRaphe" \
    ${TDIR_BRAINSTEM}/CnF_l.nii.gz:"CuneiformN L" \
    ${TDIR_BRAINSTEM}/CnF_r.nii.gz:"CuneiformN R" \
    ${TDIR_BRAINSTEM}/DR.nii.gz:"DRaphe" \
    ${TDIR_BRAINSTEM}/IC_l.nii.gz:"InfCollic L" \
    ${TDIR_BRAINSTEM}/IC_r.nii.gz:"InfCollic R" \
    ${TDIR_BRAINSTEM}/iMRtl_l.nii.gz:"latIMRF L" \
    ${TDIR_BRAINSTEM}/iMRtl_r.nii.gz:"latIMRF R" \
    ${TDIR_BRAINSTEM}/iMRtm_l.nii.gz:"medIMRF L" \
    ${TDIR_BRAINSTEM}/iMRtm_r.nii.gz:"medIMRF R" \
    ${TDIR_BRAINSTEM}/ION_l.nii.gz:"InfOlivN L" \
    ${TDIR_BRAINSTEM}/ION_r.nii.gz:"InfOlivN R" \
    ${TDIR_BRAINSTEM}/isRT_l.nii.gz:"isthRF L" \
    ${TDIR_BRAINSTEM}/isRT_r.nii.gz:"isthRF R" \
    ${TDIR_BRAINSTEM}/LC_l.nii.gz:"LocCoeruleus L" \
    ${TDIR_BRAINSTEM}/LC_r.nii.gz:"LocCoeruleus R" \
    ${TDIR_BRAINSTEM}/LDTg_CGPn_l.nii.gz:"latDorTegN L" \
    ${TDIR_BRAINSTEM}/LDTg_CGPn_r.nii.gz:"latDorTegN R" \
    ${TDIR_BRAINSTEM}/LPB_l.nii.gz:"latPBN L" \
    ${TDIR_BRAINSTEM}/LPB_r.nii.gz:"latPBN R" \
    ${TDIR_BRAINSTEM}/MiTg_PBG_l.nii.gz:"mcTegN L" \
    ${TDIR_BRAINSTEM}/MiTg_PBG_r.nii.gz:"mvTegN R" \
    ${TDIR_BRAINSTEM}/MnR.nii.gz:"medRaphe" \
    ${TDIR_BRAINSTEM}/MPB_l.nii.gz:"medPBN L" \
    ${TDIR_BRAINSTEM}/MPB_r.nii.gz:"medPBN R" \
    ${TDIR_BRAINSTEM}/mRTA_l.nii.gz:"antMesRF L" \
    ${TDIR_BRAINSTEM}/mRTA_r.nii.gz:"antMesRF R" \
    ${TDIR_BRAINSTEM}/mRtd_l.nii.gz:"dorsMesRF L" \
    ${TDIR_BRAINSTEM}/mRtd_r.nii.gz:"dorsMesRF R" \
    ${TDIR_BRAINSTEM}/mRtl_l.nii.gz:"latMesRF L" \
    ${TDIR_BRAINSTEM}/mRtl_r.nii.gz:"latMesRF R" \
    ${TDIR_BRAINSTEM}/PAG.nii.gz:"PAG" \
    ${TDIR_BRAINSTEM}/PCRtA_l.nii.gz:"aParvReticN L" \
    ${TDIR_BRAINSTEM}/PCRtA_r.nii.gz:"aParvReticN R" \
    ${TDIR_BRAINSTEM}/PMnR.nii.gz:"ParamedN" \
    ${TDIR_BRAINSTEM}/PnO_PnC_l.nii.gz:"PontReticN L" \
    ${TDIR_BRAINSTEM}/PnO_PnC_r.nii.gz:"PontReticN R" \
    ${TDIR_BRAINSTEM}/PTg_l.nii.gz:"PedPontineN L" \
    ${TDIR_BRAINSTEM}/PTg_r.nii.gz:"PedPontine R" \
    ${TDIR_BRAINSTEM}/RMg.nii.gz:"RapheMagN" \
    ${TDIR_BRAINSTEM}/RN1_l.nii.gz:"RedN1 L" \
    ${TDIR_BRAINSTEM}/RN1_r.nii.gz:"RedN1 R" \
    ${TDIR_BRAINSTEM}/RN2_l.nii.gz:"RedN2 L" \
    ${TDIR_BRAINSTEM}/RN2_r.nii.gz:"RedN2 R" \
    ${TDIR_BRAINSTEM}/ROb.nii.gz:"RapheObscN" \
    ${TDIR_BRAINSTEM}/RPa.nii.gz:"RaphePallN" \
    ${TDIR_BRAINSTEM}/SC_l.nii.gz:"SupCollic L" \
    ${TDIR_BRAINSTEM}/SC_r.nii.gz:"SupCollic R" \
    ${TDIR_BRAINSTEM}/sMRtl_l.nii.gz:"latSupMedulRF L" \
    ${TDIR_BRAINSTEM}/sMRtl_r.nii.gz:"latSupMedulRF R" \
    ${TDIR_BRAINSTEM}/sMRtm_l.nii.gz:"medSupMedulRF L" \
    ${TDIR_BRAINSTEM}/sMRtm_r.nii.gz:"medSupMedulRF R" \
    ${TDIR_BRAINSTEM}/SN1_l.nii.gz:"SubstNigRetic L" \
    ${TDIR_BRAINSTEM}/SN1_r.nii.gz:"SubstNigRetic R" \
    ${TDIR_BRAINSTEM}/SN2_l.nii.gz:"SubstNigComp L" \
    ${TDIR_BRAINSTEM}/SN2_r.nii.gz:"SubstNigComp R" \
    ${TDIR_BRAINSTEM}/SOC_l.nii.gz:"SupOlivCompl L" \
    ${TDIR_BRAINSTEM}/SOC_r.nii.gz:"SupOlivCompl R" \
    ${TDIR_BRAINSTEM}/SubC_l.nii.gz:"SubCoeruleus L" \
    ${TDIR_BRAINSTEM}/SubC_r.nii.gz:"SubCoeruleus R" \
    ${TDIR_BRAINSTEM}/Ve_l.nii.gz:"VestibN L" \
    ${TDIR_BRAINSTEM}/Ve_r.nii.gz:"VestibB R" \
    ${TDIR_BRAINSTEM}/VSM_l.nii.gz:"ViscSensMotN L" \
    ${TDIR_BRAINSTEM}/VSM_r.nii.gz:"ViscSensMotN R" \
    ${TDIR_BRAINSTEM}/VTA_PBP_l.nii.gz:"ventTegArea L" \
    ${TDIR_BRAINSTEM}/VTA_PBP_r.nii.gz:"ventTegArea R")

# Should not have to do this, but just in case:
cd ${TEMPDIR}
echo "Creating brainstem atlas (b2)..."
if [ -e ${B2DIR}/atlas_b2_labels.txt ] ; then rm ${B2DIR}/atlas_b2_labels.txt ; fi
touch ${B2DIR}/atlas_b2_labels.txt
OUTTYPE_OLD=${FSLOUTPUTTYPE}
FSLOUTPUTTYPE=NIFTI
x=1
for TOK in "${BstemNuclei[@]}" ; do
    FN=$(echo "${TOK}" | awk -F ':' '{print $1}')
    LBL=$(echo "${TOK}" | awk -F ':' '{print $2}')
    3dcalc -a ${FN} -expr "${x}*ispositive(a)" -datum short -prefix ${TEMPDIR}/${x}.nii
    echo "[BS] ${LBL}" >> ${B2DIR}/atlas_b2_labels.txt
    x=$((${x} + 1))
done
FSLOUTPUTTYPE=${OUTTYPE_OLD}

#-- Check for overlaps, since we're getting a very high max voxel value
echo ""
echo '----------------------------------------------------------------'
echo 'Checking for overlaps...'
echo '----------------------------------------------------------------'
for x in $(seq 1 $((${#BstemNuclei[@]} - 1))) ; do
    LBL=$(echo "${BstemNuclei[${x}]}" | awk -F ':' '{print $2}')
    for y in $(seq $((${x} + 1)) 66) ; do
	voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/${x}.nii ${TEMPDIR}/${y}.nii)
	if [ ${voxcount} -ne 0 ] && [ ${x} -lt 66 ] ; then
	    LBLY=$(echo "${BstemNuclei[${y}]}" | awk -F ':' '{print $2}')
	    echo "File ${x} (${LBL}) overlaps with file ${y} (${LBLY}): ${voxcount} voxels!"
	    echo "  -- Trimming..."
	    #-- Trim x using y and reassess overlap
	    mv ${TEMPDIR}/${x}.nii ${TEMPDIR}/${x}_temp.nii
	    3dcalc -a ${TEMPDIR}/${x}_temp.nii -b ${TEMPDIR}/${y}.nii \
		-expr 'a*ispositive((ispositive(a)-ispositive(b)))' \
		-prefix ${TEMPDIR}/${x}.nii \
		&& rm ${TEMPDIR}/${x}_temp.nii
	    voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/${x}.nii ${TEMPDIR}/${y}.nii)
	    echo "  -- New overlap: ${voxcount} voxels."
	fi
    done
done

echo "  -- Merging individual files with fslmerge..."
FSLOUTPUTTYPE=NIFTI_GZ
fslmaths 1.nii -add 2.nii -add 3.nii -add 4.nii -add 5.nii -add 6.nii -add 7.nii -add 8.nii -add 9.nii -add 10.nii \
    -add 11.nii -add 12.nii -add 13.nii -add 14.nii -add 15.nii -add 16.nii -add 17.nii -add 18.nii -add 19.nii -add 20.nii \
    -add 21.nii -add 22.nii -add 23.nii -add 24.nii -add 25.nii -add 26.nii -add 27.nii -add 28.nii -add 29.nii -add 30.nii \
    -add 31.nii -add 32.nii -add 33.nii -add 34.nii -add 35.nii -add 36.nii -add 37.nii -add 38.nii -add 39.nii -add 40.nii \
    -add 41.nii -add 42.nii -add 43.nii -add 44.nii -add 45.nii -add 46.nii -add 47.nii -add 48.nii -add 49.nii -add 50.nii \
    -add 51.nii -add 52.nii -add 53.nii -add 54.nii -add 55.nii -add 56.nii -add 57.nii -add 58.nii -add 59.nii -add 60.nii \
    -add 61.nii -add 62.nii -add 63.nii -add 64.nii -add 65.nii \
    -add 66.nii \
    ${B2DIR}/atlas_b2 \
    && echo "Atlas created:" \
    && ls ${B2DIR}
echo "Max voxel value in atlas b2 at this step: $(3dinfo -dmax ${B2DIR}/atlas_b2.nii.gz)"

#-- Clear TEMPDIR for next step
rm ${TEMPDIR}/*

#--------------------- Do diencephalon (B3DIR) -----------------
echo '_________________________________________________________________________'
echo "DIENCEPHALON (ATLAS B3)"
echo '_________________________________________________________________________'
DienNuclei=(${TDIR_DIENCEPH}/LG_l.nii.gz:'LGN L' \
    ${TDIR_DIENCEPH}/LG_r.nii.gz:'LGN R' \
    ${TDIR_DIENCEPH}/MG_l.nii.gz:'MGN L' \
    ${TDIR_DIENCEPH}/MG_r.nii.gz:'MGN R' \
    ${TDIR_DIENCEPH}/STh_l.nii.gz:'SubthalN L' \
    ${TDIR_DIENCEPH}/STh_r.nii.gz:'SubthalN R')

echo "Creating diencephalon atlas (b3)..."
if [ -e ${B3DIR}/atlas_b3_labels.txt ] ; then rm ${B3DIR}/atlas_b3_labels.txt ; fi
touch ${B3DIR}/atlas_b3_labels.txt
x=1
for TOK in "${DienNuclei[@]}" ; do
    FN=$(echo "${TOK}" | awk -F ':' '{print $1}')
    LBL=$(echo "${TOK}" | awk -F ':' '{print $2}')
    echo "Source: ${FN} (${LBL})"
    3dcalc -a ${FN} -expr "${x}*ispositive(a)" -prefix ${TEMPDIR}/${x}.nii
    echo "[DE] ${LBL}" >> ${B3DIR}/atlas_b3_labels.txt
    x=$((${x} + 1))
done
echo "  -- Merging individual files with fslmerge..."
FSLOUTPUTTYPE=NIFTI_GZ
fslmaths 1.nii -add 2.nii -add 3.nii -add 4.nii -add 5.nii -add 6.nii \
    ${B3DIR}/atlas_b3 \
    && echo "Atlas created:" \
    && ls ${B3DIR}

echo '------------------------------------------------------------------------'
echo '                             SANITY CHECK'
echo '------------------------------------------------------------------------'
OUTFILE=${B3DIR}/atlas_b3.nii.gz
LUTFILE=${B3DIR}/atlas_b3_labels.txt
EXPECTED=$(cat ${LUTFILE} | wc -l)
echo "ATLAS NAME: DIENCEPHALON (atlas B3)"
echo "ATLAS FILE: ${OUTFILE}"
echo "LABEL FILE: ${LUTFILE}"
for x in $(seq 1 $(3dinfo -dmax ${OUTFILE})) ; do
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${OUTFILE}"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	LAB=""
	if [ ${x} -gt ${EXPECTED} ] ; then 
	    LAB="UNKNOWN"
	else
	    LAB=$(sed "${x}q;d" ${LUTFILE})
	fi
	printf "${LAB}\t${voxcount}\n"
    else
	echo "  - Value ${x} (${LAB}) has 0 voxels"
    fi
done
if [ ${x} -ne ${EXPECTED} ] ; then
    OK='***ERROR***'
else
    OK='OK'
fi

echo '========================================================================='
echo "Completed DIENCEPHALON (ATLAS B3):" ; ls ${B3DIR}
echo "Max voxel value in b3 atlas: $(3dinfo -dmax ${B3DIR}/atlas_b3.nii.gz)"
echo "Expected max value: ${EXPECTED} (${OK})"
echo '========================================================================='

echo "Subtracting diencephalon from brainstem..."
3dcalc -a ${B2DIR}/atlas_b2.nii.gz -b ${B3DIR}/atlas_b3.nii.gz \
    -expr 'a*(ispositive(a)-ispositive(b))' \
    -prefix ${B2DIR}/atlas_b2_temp.nii.gz \
    && rm ${B2DIR}/atlas_b2.nii.gz \
    && mv ${B2DIR}/atlas_b2_temp.nii.gz ${B2DIR}/atlas_b2.nii.gz
echo "  -- Complete."

echo '------------------------------------------------------------------------'
echo '                             SANITY CHECK'
echo '------------------------------------------------------------------------'
OUTFILE=${B2DIR}/atlas_b2.nii.gz
LUTFILE=${B2DIR}/atlas_b2_labels.txt
EXPECTED=$(cat ${LUTFILE} | wc -l)
echo "ATLAS NAME: BRAINSTEM (atlas B2)"
echo "ATLAS FILE: ${OUTFILE}"
echo "LABEL FILE: ${LUTFILE}"
for x in $(seq 1 $(3dinfo -dmax ${OUTFILE})) ; do
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${OUTFILE}"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	LAB=""
	if [ ${x} -gt ${EXPECTED} ] ; then 
	    LAB="UNKNOWN"
	else
	    LAB=$(sed "${x}q;d" ${LUTFILE})
	fi
	printf "${LAB}\t${voxcount}\n"
    else
	echo "  - Value ${x} (${LAB}) has 0 voxels"
    fi
done
if [ ${x} -ne ${EXPECTED} ] ; then
    OK='***ERROR***'
else
    OK='OK'
fi

echo '========================================================================='
echo "Completed BRAINSTEM (ATLAS B2):" ; ls ${B2DIR}
echo "Max voxel value in b2 atlas: $(3dinfo -dmax ${B2DIR}/atlas_b2.nii.gz)"
echo "Expected max value: ${EXPECTED} (${OK})"
echo '========================================================================='

#-- Clear TEMPDIR for next step
rm ${TEMPDIR}/*

#----------- Subtract Bstem+Diencph mask from thalamus ---------
echo '_________________________________________________________________________'
echo "THALAMUS (ATLAS B1) and HYPOTHALAMUS (ATLAS B4)"
echo '_________________________________________________________________________'

echo "Creating brainstem and diencephalon masks..."
3dcalc -a ${B3DIR}/atlas_b3.nii.gz -expr 'ispositive(a)' -datum short -prefix ${TEMPDIR}/atlas_b3_mask.nii.gz
3dcalc -a ${B2DIR}/atlas_b2.nii.gz -expr 'ispositive(a)' -datum short -prefix ${TEMPDIR}/atlas_b2_mask.nii.gz

#===================== Copy Hthal (b4) to ${B4DIR} ============
# and mask with brainstem and diencephalon
echo "Copying hypothalamus LUT to ${B4DIR}..."
cp ${TDIR_HYPOTHALAMUS}/atlas_b4_labels.txt ${B4DIR}/
echo "Removing diencephalon and brainstem from hypothalamus..."
3dcalc \
    -a ${TDIR_HYPOTHALAMUS}/atlas_b4.nii.gz \
    -b ${TEMPDIR}/atlas_b3_mask.nii.gz \
    -c ${TEMPDIR}/atlas_b2_mask.nii.gz \
    -expr 'a*ispositive(ispositive(a)-(ispositive(b)+ispositive(c)))' \
    -prefix ${B4DIR}/atlas_b4.nii.gz

echo '------------------------------------------------------------------------'
echo '                             SANITY CHECK'
echo '------------------------------------------------------------------------'
OUTFILE=${B4DIR}/atlas_b4.nii.gz
LUTFILE=${B4DIR}/atlas_b4_labels.txt
EXPECTED=$(cat ${LUTFILE} | wc -l)
echo "ATLAS NAME: HYPOTHALAMUS (atlas B4)"
echo "ATLAS FILE: ${OUTFILE}"
echo "LABEL FILE: ${LUTFILE}"
for x in $(seq 1 $(3dinfo -dmax ${OUTFILE})) ; do
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${OUTFILE}"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	LAB=""
	if [ ${x} -gt ${EXPECTED} ] ; then 
	    LAB="UNKNOWN"
	else
	    LAB=$(sed "${x}q;d" ${LUTFILE} | sed 's/-/ /g')
	    LAB="[HT] ${LAB}"
	    echo "${LAB}" >> ${B4DIR}/atlas_b4_labels_corrected.txt
	fi
	printf "${LAB}\t${voxcount}\n"
    else
	echo "  - Value ${x} (${LAB}) has 0 voxels"
    fi
done
if [ ${x} -ne ${EXPECTED} ] ; then
    OK='***ERROR***'
else
    OK='OK'
fi

rm ${B4DIR}/atlas_b4_labels.txt
mv ${B4DIR}/atlas_b4_labels_corrected.txt ${B4DIR}/atlas_b4_labels.txt

echo '========================================================================='
echo "Completed HYPOTHALAMUS (ATLAS B4):" ; ls ${B4DIR}
echo "Max voxel value in atlas b4: $(3dinfo -dmax ${B4DIR}/atlas_b4.nii.gz)"
echo "Max voxel value expected: ${EXPECTED} (${OK})"
echo '========================================================================='

3dcalc -a ${B4DIR}/atlas_b4.nii.gz -expr 'ispositive(a)' -datum short -prefix ${TEMPDIR}/atlas_b4_mask.nii.gz
echo "Checking overlaps among masks:"
echo "Hypothalamus (b4)"
voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/atlas_b4_mask.nii.gz ${TEMPDIR}/atlas_b3_mask.nii.gz)
echo "  -- vs diencephalon (b3): ${voxcount} voxels"
voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/atlas_b4_mask.nii.gz ${TEMPDIR}/atlas_b2_mask.nii.gz)
echo "  -- vs brainstem (b2):    ${voxcount} voxels"
echo "Diencephalon (b3)"
voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/atlas_b3_mask.nii.gz ${TEMPDIR}/atlas_b2_mask.nii.gz)
echo "  -- vs brainstem (b2):    ${voxcount} voxels"
voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/atlas_b4_mask.nii.gz ${TEMPDIR}/atlas_b2_mask.nii.gz)
echo "  -- vs hypothalamus (b4): ${voxcount} voxels"

echo "Subtracting brainstem and diencephalon from thalamus..."
3dcalc -a ${THAL} -b ${TEMPDIR}/atlas_b3_mask.nii.gz -c ${TEMPDIR}/atlas_b2_mask.nii.gz -d ${TEMPDIR}/atlas_b4_mask.nii.gz \
    -expr 'a*((ispositive(a)-(ispositive(b)+ispositive(c)+ispositive(d))))' \
    -prefix ${TEMPDIR}/thalamus_atlas_temp.nii
echo "  -- Checking for success: brainstem..."
voxcount=$(3dBrickStat -count -non-zero -mask ${B2DIR}/atlas_b2.nii.gz ${TEMPDIR}/thalamus_atlas_temp.nii)
if [ ${voxcount} -ne 0 ] ; then
    echo "ERROR: ${voxcount} overlapping voxels!"
    exit 1
fi
echo "  -- Checking for success: diencephalon..."
voxcount=$(3dBrickStat -count -non-zero -mask ${B3DIR}/atlas_b3.nii.gz ${TEMPDIR}/thalamus_atlas_temp.nii)
if [ ${voxcount} -ne 0 ] ; then
    echo "ERROR: ${voxcount} overlapping voxels!"
    exit 1
fi
echo " -- Checking for success: hypothalamus..."
voxcount=$(3dBrickStat -count -non-zero -mask ${B4DIR}/atlas_b4.nii.gz ${TEMPDIR}/thalamus_atlas_temp.nii)
if [ ${voxcount} -ne 0 ] ; then
    echo "ERROR: ${voxcount} overlapping voxels!"
    exit 1
fi

#---------------------- Do thalamus (B1DIR) --------------------
ThalNuclei=([1]="[TH] Pulvinar L" \
    [2]="[TH] AntPulvinar L" \
    [3]="[TH] Mediodorsal L" \
    [4]="[TH] VLdorsal L" \
    [5]="[TH] MedPulvinar L" \
    [6]="[TH] VAnt L" \
    [7]="[TH] VLventral L" \
    [8]="[TH] Pulvinar R" \
    [9]="[TH] AntPulvinar R" \
    [10]="[TH] Mediodorsal R" \
    [11]="[TH] VLdorsal R" \
    [12]="[TH] MedPulvinar R" \
    [13]="[TH] VAnt R" \
    [14]="[TH] VLventral R")
if [ -e ${B1DIR}/atlas_b1_labels.txt ] ; then rm ${B1DIR}/atlas_b1_labels.txt ; fi
touch ${B1DIR}/atlas_b1_labels.txt

for x in $(seq 1 14) ; do
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${TEMPDIR}/thalamus_atlas_temp.nii"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	LAB=""
	LAB=${ThalNuclei[${x}]}
	# get label and save to (new) LUT
	printf "${LAB}\t${voxcount}\n"
	echo "${LAB}" >> ${B1DIR}/atlas_b1_labels.txt
    else
	echo "  - Value ${x} (${LAB}) has 0 voxels"
    fi
done

3dcalc -a ${TEMPDIR}/thalamus_atlas_temp.nii -expr 'a' -prefix ${B1DIR}/atlas_b1.nii.gz
rm ${TEMPDIR}/*


echo '------------------------------------------------------------------------'
echo '                             SANITY CHECK'
echo '------------------------------------------------------------------------'
OUTFILE=${B1DIR}/atlas_b1.nii.gz
LUTFILE=${B1DIR}/atlas_b1_labels.txt
EXPECTED=$(cat ${LUTFILE} | wc -l)
echo "ATLAS NAME: THALAMUS (atlas B1)"
echo "ATLAS FILE: ${OUTFILE}"
echo "LABEL FILE: ${LUTFILE}"
for x in $(seq 1 $(3dinfo -dmax ${OUTFILE})) ; do
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${OUTFILE}"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	LAB=""
	if [ ${x} -gt ${EXPECTED} ] ; then 
	    LAB="UNKNOWN"
	else
	    LAB=$(sed "${x}q;d" ${LUTFILE})
	fi
	printf "${LAB}\t${voxcount}\n"
    else
	echo "  - Value ${x} (${LAB}) has 0 voxels"
    fi
done
if [ ${x} -ne ${EXPECTED} ] ; then
    OK='***ERROR***'
else
    OK='OK'
fi

echo '========================================================================='
echo "Completed THALAMUS (ATLAS B1):" ; ls ${B1DIR}
echo "Max voxel value in atlas b1: $(3dinfo -dmax ${B1DIR}/atlas_b1.nii.gz)"
echo "Expected max value: ${EXPECTED} (${OK})"
echo '========================================================================='

rm ${TEMPDIR}/*

#====================== EICKHOFF-INDOVINA ======================
echo '_________________________________________________________________________'
echo "EICKHOFF-INDOVINA (ATLAS A1)"
echo '_________________________________________________________________________'

if [ -e ${A1DIR}/atlas_a1_labels.txt ] ; then rm ${A1DIR}/atlas_a1_labels.txt ; fi
touch ${A1DIR}/atlas_a1_labels.txt

echo "Creating masks from atlases a3, b1, and b2..."


echo "Creating individual files..."
x=0
for FN in ${LPIC} ${RPIC} ${TDIR_EICKHOFF}/*.nii.gz ; do
    x=$((${x} + 1))
    LBLIN="$(basename ${FN} .nii.gz | sed 's/_/ /g')"
    if [ $(basename ${FN} .nii.gz) != "PIC_L" ] && [ $(basename ${FN} .nii.gz) != "PIC_R" ] ; then
	#-- If ROI is OTHER THAN PIC_L or PIC_R, subtract PIC_L and PIC_R from it
	#   and assign the value ${x} to that ROI
	3dcalc -a ${FN} -b ${LPIC} -c ${RPIC} \
	    -expr "${x}*ispositive(ispositive(a)-(ispositive(b)+(ispositive(c))))" \
	    -datum short -prefix ${TEMPDIR}/${x}.nii
    else
	#-- If it IS PIC_L or PIC_R, just assign the value ${x}
	3dcalc -a ${FN} \
	    -expr "${x}*ispositive(a)" \
	    -datum short -prefix ${TEMPDIR}/${x}.nii
    fi
    echo "${LBLIN}" >> ${A1DIR}/atlas_a1_labels.txt
done
echo "  -- Found ${x} individual files."

#-- Check for overlaps
echo "  -- Checking for overlaps..."
for y1 in $(seq 1 $((${x} - 2))) ; do
    for y2 in $(seq $((${y1} + 1)) $((${x} - 1))) ; do
	voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/${y1}.nii ${TEMPDIR}/${y2}.nii)
	if [ ${voxcount} -ne 0 ] ; then echo "${y1}.nii overlaps with ${y2}.nii: ${voxcount} voxels!" ; fi
    done
done

echo "  -- Collecting individual files into atlas..."
FSLOUTPUTTYPE=NIFTI_GZ
fslmaths \
    ${TEMPDIR}/1.nii \
    $(for y in $(seq 2 $((${x} - 1))) ; do printf -- " -add ${TEMPDIR}/${y}.nii " ; done) \
    -add ${TEMPDIR}/${x}.nii \
    ${A1DIR}/atlas_a1
echo '------------------------------------------------------------------------'
echo '                             SANITY CHECK'
echo '------------------------------------------------------------------------'
OUTFILE=${A1DIR}/atlas_a1.nii.gz
LUTFILE=${A1DIR}/atlas_a1_labels.txt
EXPECTED=$(cat ${LUTFILE} | wc -l)
echo "ATLAS NAME: EICKHOFF-INDOVINA (atlas A1)"
echo "ATLAS FILE: ${OUTFILE}"
echo "LABEL FILE: ${LUTFILE}"
for x in $(seq 1 $(3dinfo -dmax ${OUTFILE}) ) ; do
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${OUTFILE}"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	LAB=""
	if [ ${x} -gt ${EXPECTED} ] ; then 
	    LAB="UNKNOWN"
	else
	    LAB=$(sed "${x}q;d" ${LUTFILE})
	    case "${LAB}" in
		*Amygdala*) LAB=$(echo "${LAB}" | sed 's/Amygdala/Amg/g') ;;
		*Cingulum*) LAB=$(echo "${LAB}" | sed 's/Cingulum/Cing/g') ;;
		*Hippocampus*) LAB=$(echo "${LAB}" | sed 's/Hippocampus/HC/g') ;;
		*Insula*) LAB=$(echo "${LAB}" | sed 's/Insula/Ins/g') ;;
		*Operculum*) LAB=$(echo "${LAB}" | sed 's/Operculum //g') ;;
		*Visual*) LAB=$(echo "${LAB}" | sed 's/Visual/Vis/g') ;;
	    esac
	    case "${LAB}" in
		*Left*) LAB=$(echo "${LAB}" | sed 's/Left //g') ; LAB="[EI] ${LAB} L" ;;
		*Right*) LAB=$(echo "${LAB}" | sed 's/Right //g') ; LAB="[EI] ${LAB} R" ;;
	    esac
	    echo "${LAB}" >> ${A1DIR}/atlas_a1_labels_corrected.txt
	fi
	printf "${LAB}\t${voxcount}\n"
    else
	echo "  - Value ${x} (${LAB}) has 0 voxels"
    fi
done

rm ${A1DIR}/atlas_a1_labels.txt
mv ${A1DIR}/atlas_a1_labels_corrected.txt ${A1DIR}/atlas_a1_labels.txt

if [ ${x} -ne ${EXPECTED} ] ; then
    OK='***ERROR***'
else
    OK='OK'
fi
echo '========================================================================='
echo "Completed EICKHOFF-INDOVINA (ATLAS A1):" ; ls ${A1DIR}
echo "Max voxel value in atlas a1: $(3dinfo -dmax ${A1DIR}/atlas_a1.nii.gz)"
echo "Expected max value: ${EXPECTED} (${OK})"
echo '========================================================================='
rm ${TEMPDIR}/*
#========================= BRAINNETOME =========================

echo '_________________________________________________________________________'
echo "BRAINNETOME (ATLAS A2)"
echo '_________________________________________________________________________'
echo "Creating masks from previous atlases..."

for x in \
    ${A1DIR}/atlas_a1.nii.gz \
    ${A3DIR}/atlas_a3.nii.gz \
    ${B1DIR}/atlas_b1.nii.gz \
    ${B2DIR}/atlas_b2.nii.gz \
    ${B3DIR}/atlas_b3.nii.gz ; do

    3dcalc -a ${x} -expr 'ispositive(a)' -prefix ${TEMPDIR}/$(basename ${x} .nii.gz)_mask.nii.gz
done



##########################################################################
# NOTE TO SELF 6 APR 2022
#
# a1 (EI) overlaps with a3 (SUIT) by 1556 vox
#                   and b1 (THAL) by 76 vox
# a3 (SUIT) o/laps with b2 (BSTM) by 75 vox
#
# - Subtract SUIT (a3) from EI (a1)
# - Subtract SUIT (a3) from BSTM (b2)
# - Subtract EI (a1) from THAL (b1)
##########################################################################
echo "Doing final touch-ups on other atlases..."
#-- Subtract SUIT (a3) from EI (a1)
echo "  -- EI-SUIT..."
3dcalc \
    -a ${A1DIR}/atlas_a1.nii.gz \
    -b ${TEMPDIR}/atlas_a3_mask.nii.gz \
    -expr 'a*ispositive((ispositive(a)-ispositive(b)))' \
    -prefix ${A1DIR}/atlas_a1_trimmed.nii.gz \
    && rm ${A1DIR}/atlas_a1.nii.gz \
    && mv ${A1DIR}/atlas_a1_trimmed.nii.gz ${A1DIR}/atlas_a1.nii.gz
#-- Subtract SUIT (a3) from BSTM (b2)
echo "  -- BSTM-SUIT..."
3dcalc \
    -a ${B2DIR}/atlas_b2.nii.gz \
    -b ${TEMPDIR}/atlas_a3_mask.nii.gz \
    -expr 'a*ispositive((ispositive(a)-ispositive(b)))' \
    -prefix ${B2DIR}/atlas_b2_trimmed.nii.gz \
    && rm ${B2DIR}/atlas_b2.nii.gz \
    && mv ${B2DIR}/atlas_b2_trimmed.nii.gz ${B2DIR}/atlas_b2.nii.gz
#-- Subtract EI (a1) from THAL (b1)
echo "  -- THAL-EI..."
3dcalc \
    -a ${B1DIR}/atlas_b1.nii.gz \
    -b ${TEMPDIR}/atlas_a1_mask.nii.gz \
    -expr 'a*ispositive((ispositive(a)-ispositive(b)))' \
    -prefix ${B1DIR}/atlas_b1_trimmed.nii.gz \
    && rm ${B1DIR}/atlas_b1.nii.gz \
    && mv ${B1DIR}/atlas_b1_trimmed.nii.gz ${B1DIR}/atlas_b1.nii.gz


echo "  -- Atlases trimmed. Checking atlas masks for overlaps..."
echo "     Re-creating masks from previous atlases..."

rm ${TEMPDIR}/atlas_??_mask.nii.gz

for x in \
    ${A1DIR}/atlas_a1.nii.gz \
    ${A3DIR}/atlas_a3.nii.gz \
    ${B1DIR}/atlas_b1.nii.gz \
    ${B2DIR}/atlas_b2.nii.gz \
    ${B3DIR}/atlas_b3.nii.gz ; do

    3dcalc -a ${x} -expr 'ispositive(a)' -prefix ${TEMPDIR}/$(basename ${x} .nii.gz)_mask.nii.gz
done

OLAPS=0
for x in a1 a3 b1 b2 b3 ; do
    for y in a1 a3 b1 b2 b3 ; do
	if [ "${x}" != "${y}" ] ; then
	    voxcount=$(3dBrickStat -count -non-zero -mask ${TEMPDIR}/atlas_${x}_mask.nii.gz ${TEMPDIR}/atlas_${y}_mask.nii.gz)
	    if [ ${voxcount} -ne 0 ] ; then 
		echo "${x} mask overlaps with ${y} mask: ${voxcount} voxels!" 
		OLAPS=$((${OLAPS} + 1))
	    fi
	fi
    done
done

if [ ${OLAPS} -ne 0 ] ; then
    echo "  -- Counted ${OLAPS} overlaps!"
    exit 1
else
    echo "  -- No overlaps detected. Proceeding."
fi



echo "Subtracting other atlases from Brainnetome..."
3dcalc \
    -a ${BRAINNETOME} \
    -b ${TEMPDIR}/atlas_a1_mask.nii.gz \
    -c ${TEMPDIR}/atlas_a3_mask.nii.gz \
    -d ${TEMPDIR}/atlas_b1_mask.nii.gz \
    -e ${TEMPDIR}/atlas_b2_mask.nii.gz \
    -f ${TEMPDIR}/atlas_b3_mask.nii.gz \
    -expr 'a*(ispositive(ispositive(a)-(ispositive(b)+ispositive(c)+ispositive(d)+ispositive(e)+ispositive(f))))' \
    -datum short \
    -prefix ${A2DIR}/atlas_a2_withThal.nii.gz
echo "Atlas generated as: ${A2DIR}/atlas_a2_withThal.nii.gz"
echo "Subtracting labels 230 and up (ie, greater than 229)..."
3dcalc \
    -a ${A2DIR}/atlas_a2_withThal.nii.gz \
    -expr 'a*(ispositive(a)-step(a-229))' \
    -datum short \
    -prefix ${A2DIR}/atlas_a2.nii.gz
echo "Sanity check: greatest value in atlas: $(3dinfo -dmax ${A2DIR}/atlas_a2.nii.gz)"

################################################ DEPRECATED ##############################################
#-- Get Eick + Indo mask and subtract it from Brainnetome:
# 1 - Create Eick + Indo mask using fslmaths
#FSLOUTPUTTYPE=NIFTI
#-- Gather separate nuclei into TEMPDIR
#cp ${LPIC} ${RPIC} ${TDIR_EICKHOFF}/*.nii.gz ${TEMPDIR}/
#fslmaths Left_Operculum_OP2.nii.gz -add Right_Operculum_OP2.nii.gz -add PIC_L.nii.gz -add PIC_R.nii.gz -add Left_IPL_PFcm.nii.gz -add Right_IPL_PFcm.nii.gz -add Left_IPL_PF.nii.gz -add Right_IPL_PF.nii.gz -add Left_AIPS_IP3.nii.gz -add Right_AIPS_IP3.nii.gz -add Left_PSC_2.nii.gz -add Right_PSC_2.nii.gz -add Left_PSC_3a.nii.gz -add Left_PSC_3b.nii.gz -add Right_PSC_3a.nii.gz -add Right_PSC_3b.nii.gz -add Left_Visual_hOc5.nii.gz -add Right_Visual_hOc5.nii.gz -add Left_Hippocampus_CA.nii.gz -add Right_Hippocampus_CA.nii.gz -add Left_Hippocampus_DG.nii.gz -add Right_Hippocampus_DG.nii.gz -add Left_Hippocampus_EC.nii.gz -add Right_Hippocampus_EC.nii.gz -add Left_Hippocampus_HATA.nii.gz -add Right_Hippocampus_HATA.nii.gz -add Left_Hippocampus_Subc.nii.gz -add Right_Hippocampus_Subc.nii.gz -add Left_Insula_Ig1.nii.gz -add Right_Insula_Ig1.nii.gz -add Left_Insula_Ig2.nii.gz -add Right_Insula_Ig2.nii.gz -add Left_Insula_Id1.nii.gz -add Right_Insula_Id1.nii.gz -add Left_Insula_Id7.nii.gz -add Right_Insula_Id7.nii.gz -add Left_Operculum_OP1.nii.gz -add Left_Operculum_OP3.nii.gz -add Left_Operculum_OP4.nii.gz -add Left_Operculum_OP8.nii.gz -add Left_Operculum_OP9.nii.gz -add Right_Operculum_OP1.nii.gz -add Right_Operculum_OP3.nii.gz -add Right_Operculum_OP4.nii.gz -add Right_Operculum_OP8.nii.gz -add Right_Operculum_OP9.nii.gz -add Left_Visual_FG1.nii.gz -add Left_Visual_FG2.nii.gz -add Left_Visual_FG3.nii.gz -add Left_Visual_FG4.nii.gz -add Left_Visual_hOc1.nii.gz -add Left_Visual_hOc2.nii.gz -add Left_Visual_hOc3d.nii.gz -add Left_Visual_hOc3v.nii.gz -add Left_Visual_hOc4d.nii.gz -add Left_Visual_hOc4la.nii.gz -add Left_Visual_hOc4lp.nii.gz -add Left_Visual_hOc4v.nii.gz -add Left_Visual_hOc6.nii.gz -add Right_Visual_FG1.nii.gz -add Right_Visual_FG2.nii.gz -add Right_Visual_FG3.nii.gz -add Right_Visual_FG4.nii.gz -add Right_Visual_hOc1.nii.gz -add Right_Visual_hOc2.nii.gz -add Right_Visual_hOc3d.nii.gz -add Right_Visual_hOc3v.nii.gz -add Right_Visual_hOc4d.nii.gz -add Right_Visual_hOc4la.nii.gz -add Right_Visual_hOc4lp.nii.gz -add Right_Visual_hOc4v.nii.gz -add Right_Visual_hOc6.nii.gz -add Left_Cingulum_p32.nii.gz -add Left_Cingulum_s32.nii.gz -add Right_Cingulum_p32.nii.gz -add Right_Cingulum_s32.nii.gz -add Left_Cingulum_p24ab.nii.gz -add Left_Cingulum_p24c.nii.gz -add Left_Cingulum_s24.nii.gz -add Right_Cingulum_p24ab.nii.gz -add Right_Cingulum_p24c.nii.gz -add Right_Cingulum_s24.nii.gz -add Left_Amygdala_CM.nii.gz -add Left_Amygdala_IF.nii.gz -add Left_Amygdala_LB.nii.gz -add Left_Amygdala_MF.nii.gz -add Left_Amygdala_SF.nii.gz -add Left_Amygdala_VTM.nii.gz -add Right_Amygdala_CM.nii.gz -add Right_Amygdala_IF.nii.gz -add Right_Amygdala_LB.nii.gz -add Right_Amygdala_MF.nii.gz -add Right_Amygdala_SF.nii.gz -add Right_Amygdala_VTM.nii.gz -add Left_OFC_Fo1.nii.gz -add Left_OFC_Fo2.nii.gz -add Left_OFC_Fo3.nii.gz -add Right_OFC_Fo1.nii.gz -add Right_OFC_Fo2.nii.gz -add Right_OFC_Fo3.nii.gz -add Left_Cingulum_25.nii.gz -add Right_Cingulum_25.nii.gz ./EickIndoMask && rm *.nii.gz
###########################################################################################################

#=====================================================================================================
# EDITING: Remove remnant edge voxels which were not contiguous with in-plane clusters or clusters in
#          adjacent slices; clusters located in white matter; or outside the MNI template. Large 
#          clusters were retained even if they represented edge regions of a homologous (but non-
#          overlapping) area of the Eickhoff or Indovina atlases. Consequently, some brain areas, such
#          as the fusiform gyrus and temporal pole, are included in both atlas a1 and atlas a2. These
#          regions do not overlap either within or across atlases.
#=====================================================================================================

echo "  -- Resampling GM, WM, and brain mask to match template ($(basename ${TEMPLATE})..."
GREY_MASK=~/smith_share/NEUROINFORMATICS/MNI/1MM/avg152T1_gray_regto_MNI152_T1_2009c.nii.gz
WHITE_MASK=~/smith_share/NEUROINFORMATICS/MNI/1MM/avg152T1_white_regto_MNI152_T1_2009c.nii.gz
BRAIN_MASK=~/smith_share/NEUROINFORMATICS/MNI/1MM/MNI152_T1_1mm_brain_mask.nii.gz 
3dresample -master ${TEMPLATE} -inset ${GREY_MASK} -prefix ${A2DIR}/grey_mask.nii.gz \
    && 3drefit -view 'tlrc' -space MNI ${A2DIR}/grey_mask.nii.gz
3dresample -master ${TEMPLATE} -inset ${BRAIN_MASK} -prefix ${A2DIR}/brain_mask.nii.gz \
    && 3drefit -view 'tlrc' -space MNI ${A2DIR}/brain_mask.nii.gz 
3dresample -master ${TEMPLATE} -inset ${WHITE_MASK} -prefix ${A2DIR}/white_mask.nii.gz \
    && 3drefit -view 'tlrc' -space MNI ${A2DIR}/white_mask.nii.gz
echo "  -- Masking with brain mask..."
3dcalc -a ${A2DIR}/atlas_a2.nii.gz -b ${A2DIR}/brain_mask.nii.gz  -expr 'a*ispositive(b)' \
    -prefix ${A2DIR}/atlas_a2_brainmasked.nii.gz \
    && rm ${A2DIR}/brain_mask.nii.gz
echo "  -- Masking with GM mask..."
3dcalc -a ${A2DIR}/atlas_a2_brainmasked.nii.gz -b ${A2DIR}/grey_mask.nii.gz \
    -expr 'a*ispositive(b)' -prefix ${A2DIR}/atlas_a2_brainmasked_GMmasked.nii.gz \
    && rm ${A2DIR}/grey_mask.nii.gz
echo "  -- Masking with WM mask..."
3dcalc -a ${A2DIR}/atlas_a2_brainmasked_GMmasked.nii.gz -b ${A2DIR}/white_mask.nii.gz \
    -expr 'a*ispositive(b)' -prefix ${A2DIR}/atlas_a2_brainmasked_GMmasked_WMmasked.nii.gz \
    && rm ${A2DIR}/white_mask.nii.gz
echo "  -- Clustering to remove orphaned voxels..."
3dmerge -dxyz=1 -1clust 1.7 100 -isovalue \
    -prefix ${A2DIR}/atlas_a2_brainmasked_GMmasked_WMmasked_clustered.nii.gz \
    ${A2DIR}/atlas_a2_brainmasked_GMmasked_WMmasked.nii.gz

echo "" ; echo "" ; echo ""
echo '                               ****** WARNING ******'
echo "There are orphan voxels in ${A2DIR}/atlas_a2_brainmasked_GMmasked_WMmasked_clustered.nii.gz!"
echo "...Please edit this atlas before continuing!"
echo "...IMPORTANT: SAVE THE RESULT AS: ${A2DIR}/atlas_a2_edited.nii.gz!"
echo "" ; echo "" ; echo ""
cp ${TEMPLATE} ${A2DIR}/
afni ${A2DIR}
echo "Press [ENTER] to continue...." ; read YN

go=0
while [ ! -e ${A2DIR}/atlas_a2_edited.nii.gz ] ; do
    echo "${A2DIR}/atlas_a2_edited.nii.gz does not exist. Please edit and save."
    echo "Press [ENTER] to continue." ; read YN
done

# Generate atlas a2 LUT
echo "Initializing ${A2DIR}/atlas_a2_labels.txt..."
if [ -e ${A2DIR}/atlas_a2_labels.txt ] ; then rm ${A2DIR}/atlas_a2_labels.txt ; fi 
touch ${A2DIR}/atlas_a2_labels.txt

LUT=${TDIR_BRAINNETOME}/BNA-thr0-1mm.xml
minval=$(($(3dinfo -dmin ${BRAINNETOME}) + 1))
maxval=$(3dinfo -dmax ${BRAINNETOME})

echo "Generating labels: min and max vals in atlas: ${minval} and ${maxval}..."
printf "LBL\tvox\n"
printf "===\t===\n"

for x in $(seq ${minval} ${maxval}) ; do
    IND=$((${x} - 1)) # Label in XML LUT
    voxcount=0 ; voxcount=$(3dBrickStat -count -non-zero ${A2DIR}/atlas_a2.nii.gz"<${x}..${x}>")
    if [ ${voxcount} -ne 0 ] ; then
	# get token
	TOK=""
	TOK=$(cat ${LUT} | grep "<label index=\"${IND}\"")
	# get label and save to (new) LUT
	LAB=$(echo "${TOK}" | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' | sed 's/_/ /g')
	LAB="[BN] ${LAB}"
	printf "${LAB}\t${voxcount}\n"
	echo "${LAB}" >> ${A2DIR}/atlas_a2_labels.txt
    else
	echo "  - Value ${x} (XML label ${IND}) has 0 voxels"
    fi
done
echo ""
echo "Atlas a2 label generation complete. $(cat ${A2DIR}/atlas_a2_labels.txt | wc -l) lines in final file."
echo ""
#-- Relabel label files for CONN
for x in a1 a2 a3 b1 b2 b3 b4 ; do
    cp ${BDIR}/ATLAS_MERGE/atlas_${x}/atlas_${x}_labels.txt ${BDIR}/ATLAS_MERGE/atlas_${x}/atlas_${x}.txt
done

echo "" ; echo ""

cd ${HERE}
