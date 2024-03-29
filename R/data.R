#' Parton distribution function sensitivity experiments
#'
#' @description Data from Wang et al., 2018 to compare embedding approaches to a
#' tour path.
#'
#' @details Data were obtained from CT14HERA2 parton distribution function
#' fits as used in Laa et al., 2018. There are 28 directions in the parameter
#' space of parton distribution function fit, each point in the variables
#' labelled X1-X56 indicate moving +- 1 standard devation from the 'best'
#' (maximum likelihood estimate) fit of the function. Each observation has
#' all predictions of the corresponding measurement from an experiment.
#'
#' (see table 3 in that paper for more explicit details).
#'
#'  The remaining columns are:
#'
#' * InFit: A flag indicating whether an observation entered the fit of
#'   CT14HERA2 parton distribution function
#' * Type: First number of ID
#' * ID: contains the identifier of experiment, 1XX/2XX/5XX correpsonds
#' to Deep Inelastic Scattering (DIS) / Vector Boson Production (VBP) /
#'  Strong Interaction (JET). Every ID points to an experimental paper.
#' * pt: the per experiment observational id
#' * x,mu: the kinematics of a parton. x is the parton momentum fraction, and
#' mu is the factorisation scale.
#'
#' @references
#' Wang, B.-T., Hobbs, T. J., Doyle, S., Gao, J., Hou, T.-J., Nadolsky, P. M.,
#' & Olness, F. I. (2018). PDFSense: Mapping the sensitivity of
#' hadronic experiments to nucleon structure.
#' Retrieved from [http://arxiv.org/abs/1808.07470](http://arxiv.org/abs/1808.07470)
#'
#' Cook, D., Laa, U., & Valencia, G. (2018).
#' Dynamical projections for the visualization of PDFSense data.
#' The European Physical Journal C, 78(9), 742.
#' [https://doi.org/10.1140/epjc/s10052-018-6205-2](https://doi.org/10.1140/epjc/s10052-018-6205-2)
#'
#'
#' @source [http://www.physics.smu.edu/botingw/PDFsense_web_histlogy](http://www.physics.smu.edu/botingw/PDFsense_web_histlogy)
"pdfsense"


#' Sketches from Quickdraw
#' 6000 random images from six categories in the QuickDraw 
#' 
#' The columns correspond to grayscale pixel values (V1-V784) of a 28 pixel
#' by 28 pixel image, alongside the word (category) and the identifier for 
#' the image.
#' 
#' @source https://github.com/huizezhang-sherry/quickdraw, https://quickdraw.withgoogle.com/data
"sketches"