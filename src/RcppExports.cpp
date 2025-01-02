// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// scan_ini_file
std::vector<std::string> scan_ini_file(const std::string& filename);
RcppExport SEXP _ConfigINI_scan_ini_file(SEXP filenameSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const std::string& >::type filename(filenameSEXP);
    rcpp_result_gen = Rcpp::wrap(scan_ini_file(filename));
    return rcpp_result_gen;
END_RCPP
}
// process_profile_name
std::vector<std::string> process_profile_name(const std::vector<std::string>& vec);
RcppExport SEXP _ConfigINI_process_profile_name(SEXP vecSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const std::vector<std::string>& >::type vec(vecSEXP);
    rcpp_result_gen = Rcpp::wrap(process_profile_name(vec));
    return rcpp_result_gen;
END_RCPP
}
// write_ini
void write_ini(Rcpp::List config_list, std::string filename);
RcppExport SEXP _ConfigINI_write_ini(SEXP config_listSEXP, SEXP filenameSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::List >::type config_list(config_listSEXP);
    Rcpp::traits::input_parameter< std::string >::type filename(filenameSEXP);
    write_ini(config_list, filename);
    return R_NilValue;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_ConfigINI_scan_ini_file", (DL_FUNC) &_ConfigINI_scan_ini_file, 1},
    {"_ConfigINI_process_profile_name", (DL_FUNC) &_ConfigINI_process_profile_name, 1},
    {"_ConfigINI_write_ini", (DL_FUNC) &_ConfigINI_write_ini, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_ConfigINI(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
