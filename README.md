# Eagle-449
<b>AN ATLAS COMPILATION FOR VESTIBULAR RESEARCH</b><br><br>
This collection of atlases is provided by the Post-Concussion Vestibular Dysfunction (PCVD) research group at the Emory University School of Medicine, Atlanta, Georgia, United States. It consists of seven source atlases at 1mm isotropic resolution which are customized to facilitate functional and structural connectivity analyses of the vestibular system. Each source atlas has been processed to ensure that there are no overlaps among the ROIs.

This atlas collection is intended for use with the CONN Toolbox (https://web.conn-toolbox.org). Simply import the GZipped NIfTI files and alert CONN that they are atlases by clicking the "Atlas" checkbox.

![social_preview](https://user-images.githubusercontent.com/104218418/164759058-cbcaff69-e14b-40a9-b6ae-178e9e8e78ef.png)

## Source Atlases
* Eickhoff and Indovina ROIs
* Brainnetome Atlas
* Diedrichsen SUIT Cerebellar Atlas
* Najdenovska Anatomical Thalamic Atlas
* Brainstem ROIs from Brainstem Navigator
* Diencephalon ROIs from Brainstem Navigator
* Neudorfer Anatomical Hypothalamus Atlas
## Files
<!--
* ".nii.gz" files contain the atlas ROIs
* "atlas...txt" files contain the ROI labels for use with the CONN Toolbox
* "roi_numbers.txt" files contain human-readable ROI labels, ROI values, and their descriptions
* "CONN suggested ROI order.txt" can be copied and pasted into CONN for connectome rendering, in order to sort ROIs by hemisphere, region, and function; also includes group labels such as SM (somatomotor), SS (somatosensory), VB (vestibular), BS-DE (brainstem-diencephalon), and CRB (cerebellum)
* "CONN suggested labels.txt" can be copied and pasted into CONN for connectome rendering: this removes the initial atlas source (e.g., "EI.[EI]") which CONN automatically prefixes and shortens ROI labels for rendering
-->
<table>
<tbody>
<tr style="vertical-align:top">
<th align="left">File</th>
<th>Usage</th>
</tr>
<tr style="vertical-align:top">
  <td><b>*.nii.gz</b></td>
<td>Contain the atlas ROIs</td>
</tr>
<tr style="vertical-align:top">
  <td><b>atlas*.txt</b></td>
<td>Contain the ROI labels for use with the CONN Toolbox</td>
</tr>
<tr style="vertical-align:top">
  <td><b>roi_numbers.txt</b></td>
<td>Contain human-readable ROI labels, ROI values, and their descriptions</td>
</tr>
<tr style="vertical-align:top">
  <td><b>CONN suggested ROI order.txt</b></td>
<td>Can be copied and pasted into CONN for connectome rendering, in order to sort ROIs by hemisphere, region, and function; also includes group labels such as SM (somatomotor), SS (somatosensory), VB (vestibular), BS-DE (brainstem-diencephalon), and CRB (cerebellum)</td>
</tr>
<tr style="vertical-align:top">
  <td><b>CONN suggested labels.txt</b></td>
<td>Can be copied and pasted into CONN for connectome rendering: this removes the initial atlas source (e.g., "EI.[EI]") which CONN automatically prefixes and shortens ROI labels for rendering</td>
</tr>
</tbody>
</table>

## References
If you leverage this atlas collection, in whole or in part, you MUST cite the following references in any publications.

<b>Primary reference</b>:
* Smith et al. (2022)

<b>Eickhoff-Julich-Fan</b>:
* Amunts K, Mohlberg H, Bludau S, Zilles K. Julich-Brain: A 3D probabilistic atlas of the human brain’s cytoarchitecture. Science. 2020 Aug 21;369(6506):988-92. https://doi.org/10.1126/science.abb4588
* Fan L, Li H, Zhuo J, Zhang Y, Wang J, Chen L, Yang Z, Chu C, Xie S, Laird AR, Fox PT. The human brainnetome atlas: a new brain atlas based on connectional architecture. Cerebral cortex. 2016 Aug 1;26(8):3508-26. https://doi.org/10.1093/cercor/bhw157

<b>Indovina</b> (posterior insular complex, PIC):
* Indovina I, Bosco G, Riccelli R, Maffei V, Lacquaniti F, Passamonti L, Toschi N. Structural connectome and connectivity lateralization of the multimodal vestibular cortical network. NeuroImage. 2020 Nov 15;222:117247. https://doi.org/10.1016/j.neuroimage.2020.117247

<b>Diedrichsen SUIT</b> (cerebellum):
* Diedrichsen J, Balsters JH, Flavell J, Cussans E, Ramnani N. A probabilistic MR atlas of the human cerebellum. Neuroimage. 2009 May 15;46(1):39-46. https://doi.org/10.1016/j.neuroimage.2009.01.045
* Diedrichsen J, Maderwald S, Küper M, Thürling M, Rabe K, Gizewski ER, Ladd ME, Timmann D. Imaging the deep cerebellar nuclei: a probabilistic atlas and normalization procedure. Neuroimage. 2011 Feb 1;54(3):1786-94. https://doi.org/10.1016/j.neuroimage.2010.10.035

<b>Najdenovska</b> (thalamus):
* Najdenovska, E., Alemán-Gómez, Y., Battistella, G. et al. In-vivo probabilistic atlas of human thalamic nuclei based on diffusion- weighted magnetic resonance imaging. Sci Data 5, 180270 (2018). https://doi.org/10.1038/sdata.2018.270

<b>Brainstem Navigator</b> (brainstem and diencephalon):
* Singh K, Cauzzo S, García-Gomar MG, Stauder M, Vanello N, Passino C, Bianciardi M. Functional connectome of arousal and motor brainstem nuclei in living humans by 7 Tesla resting-state fMRI. Neuroimage. 2022 Apr 1;249:118865. Epub 2022 Jan 12. PMID: 35031472; PMCID: PMC8856580. https://doi.org/10.1016/j.neuroimage.2021.118865
* Singh K, Indovina I, Augustinack JC, Nestor K, García-Gomar MG, Staab JP, Bianciardi M. Probabilistic Template of the Lateral Parabrachial Nucleus, Medial Parabrachial Nucleus, Vestibular Nuclei Complex, and Medullary Viscero-Sensory-Motor Nuclei Complex in Living Humans From 7 Tesla MRI. Front Neurosci. 2020 Jan 23;13:1425. PMID: 32038134; PMCID: PMC6989551. https://doi.org/10.3389/fnins.2019.01425

<b>Neudorfer</b> (hypothalamus):
* Neudorfer, C., Germann, J., Elias, G.J.B. et al. A high-resolution in vivo magnetic resonance imaging atlas of the human hypothalamic region. Sci Data 7, 305 (2020). https://doi.org/10.1038/s41597-020-00644-6

## PCVD Lab Contributors
(List lab members here.)

## PCVD Lab Funding
(List all funding here.)
