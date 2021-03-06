% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_popularity_bias.R
\name{ligand_activity_performance_top_i_removed}
\alias{ligand_activity_performance_top_i_removed}
\title{Calculate ligand activity performance without considering evaluation datasets belonging to the top i most frequently cited ligands}
\usage{
ligand_activity_performance_top_i_removed(i, importances, ncitations)
}
\arguments{
\item{i}{Indicate the number of most popular ligands for which the corresponding datasets will be removed for performance calculation.}

\item{importances}{Data frame containing the ligand importance measures for every ligand-dataset combination. See \code{get_single_ligand_importances} and \code{get_multi_ligand_importances}.}

\item{ncitations}{A data frame denoting the number of times a gene is mentioned in the Pubmed literature. Should at least contain following variables: 'symbol' and 'ncitations'. Default: ncitations (variable contained in this package). See function \code{get_ncitations_genes} for a function that makes this data frame from current Pubmed information.}
}
\value{
A data.frame in which you can find several evaluation metrics of the ligand activity prediction performance and an indication of what percentage of most popular ligands has not been considered ($popularity_index).
}
\description{
\code{ligand_activity_performance_top_i_removed}: calculates ligand activity performance (given ligand importances measures) without considering evaluation datasets belonging to the top i most frequently cited ligands.
}
\examples{
\dontrun{
library(dplyr)
settings = lapply(expression_settings_validation[1:5],convert_expression_settings_evaluation)
settings_ligand_pred = convert_settings_ligand_prediction(settings, all_ligands = unlist(extract_ligands_from_settings(settings,combination = FALSE)), validation = TRUE, single = TRUE)

weighted_networks = construct_weighted_networks(lr_network, sig_network, gr_network, source_weights_df)
ligands = extract_ligands_from_settings(settings_ligand_pred,combination = FALSE)
ligand_target_matrix = construct_ligand_target_matrix(weighted_networks, ligands)
ligand_importances = dplyr::bind_rows(lapply(settings_ligand_pred,get_single_ligand_importances,ligand_target_matrix))

ligand_activity_popularity_bias = lapply(0:3,ligand_activity_performance_top_i_removed, ligand_importances, ncitations) \%>\% bind_rows()
# example plot
# ligand_activity_popularity_bias \%>\% ggplot(aes(popularity_index,aupr)) + geom_smooth(method = "lm") + geom_point()

}

}
