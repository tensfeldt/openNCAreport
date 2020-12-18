# function lifted from {NCATools}, will create the nca_dependency_list
function ()
{
  m1sd <- "M1SD"
  m1ss <- "M1SS"
  m2sd <- "M2SD"
  m2ss <- "M2SS"
  m3sd <- "M3SD"
  m3ss <- "M3SS"
  m4sd <- "M4SD"
  m4ss <- "M4SS"
  uclass_time <- "TIMEU"
  uclass_amount <- "AMOUNTU"
  uclass_dose <- "DOSEU"
  uclass_volume <- "VOLUMEU"
  uclass_amtvol <- "CONCU"
  uclass_slope <- "KELU"
  uclass_cl <- "CLU"
  uclass_auc <- "AUCU"
  uclass_aumc <- "AUMCU"
  uclass_aucnorm <- "AUCNORMU"
  uclass_aurc <- "AURCU"
  uclass_concnorm <- "CONCNORMU"
  uclass_rate <- "RATEU"
  uclass_volwnorm <- "VOLUMEWU"
  uclass_clwnorm <- "CLWU"
  uclass_ratio <- "RATIOU"
  uclass_percent <- "PERCENTU"
  uclass_none <- "NONEU"
  dependency_list <- list()
  dependency_list[["AE"]] <- list(parameter_label = c("AE"),
                                  cdisc_label = c("RCAMINT"), callfun = c("ae"), regex = "^AE$",
                                  unit_class = c(uclass_amount), valid_models = c(m4sd,
                                                                                  m4ss), display_list_models = c(m4sd, m4ss), predecessors = c())
  dependency_list[["AEPCT"]] <- list(parameter_label = c("AEPCT"),
                                     cdisc_label = c("RCPCINT"), callfun = c("aepct"), regex = "^AEPCT$",
                                     unit_class = c(uclass_percent), valid_models = c(m4sd),
                                     display_list_models = c(m4sd, m4ss), predecessors = c("AE",
                                                                                           "DOSEC"))
  dependency_list[["AEPCTi"]] <- list(parameter_label = c("AEPCTi"),
                                      cdisc_label = c("RCPCINT"), callfun = c("aepct"), regex = "^AEPCT(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_percent), valid_models = c(m4ss),
                                      display_list_models = c(m4ss), predecessors = c("AE",
                                                                                      "DOSEC", "DOSECi"))
  dependency_list[["AET"]] <- list(parameter_label = c("AET"),
                                   cdisc_label = c("RCAMINT"), callfun = c("aet"), regex = "^(AET|AE(.[0-9]+?.[0-9]+?))$",
                                   unit_class = c(uclass_amount), valid_models = c(m4sd,
                                                                                   m4ss), display_list_models = c(m4sd, m4ss), predecessors = c("DOSEC",
                                                                                                                                                "DOSECi"))
  dependency_list[["AETAUi"]] <- list(parameter_label = c("AETAU"),
                                      cdisc_label = c("RCAMTAU"), callfun = c("aetau"), regex = "^AETAU(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_amount), valid_models = c(m4ss),
                                      display_list_models = c(m4ss), predecessors = c("TOLDi",
                                                                                      "TAUi", "AET"))
  dependency_list[["AETAUPTi"]] <- list(parameter_label = c("AETAUPCT"),
                                        cdisc_label = c("RCPCTAU"), callfun = c("aetpct"), regex = "^AETAUPT(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_percent), valid_models = c(m4ss),
                                        display_list_models = c(m4ss), predecessors = c("AETAUi",
                                                                                        "DOSECi"))
  dependency_list[["AETPCT"]] <- list(parameter_label = c("AETPCT"),
                                      cdisc_label = c("RCPINT"), callfun = c("aetpct"), regex = "^(AETPCT|AEPCT(.[0-9]+?.[0-9]+?))$",
                                      unit_class = c(uclass_percent), valid_models = c(m4sd),
                                      display_list_models = c(m4sd, m4ss), predecessors = c("AET",
                                                                                            "DOSEC"))
  dependency_list[["AETPCTi"]] <- list(parameter_label = c("AETPCT"),
                                       cdisc_label = c("RCPINT"), callfun = c("aetpct"), regex = "^(AETPCT(i{1}?)|AEPCT(.[0-9]+?.[0-9]+?))$",
                                       unit_class = c(uclass_percent), valid_models = c(m4ss),
                                       display_list_models = c(m4sd, m4ss), predecessors = c("AET",
                                                                                             "DOSECi", "DOSEC"))
  dependency_list[["AT"]] <- list(parameter_label = c(), cdisc_label = c(),
                                  callfun = c("at"), regex = "^(AT|AMT(.[0-9]+?.[0-9]+?)*?)$",
                                  unit_class = c(uclass_amount), valid_models = c(m4sd,
                                                                                  m4ss), display_list_models = c(m4sd, m4ss), predecessors = c())
  dependency_list[["AUCALL"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c("auc_all"), regex = "^AUCALL$",
                                      unit_class = c(uclass_auc), valid_models = c(m1sd, m1ss,
                                                                                   m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                      predecessors = c("TMAX", "TMAXi"))
  dependency_list[["AUCALLDN"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c("auc_dn"), regex = "^AUCALLDN([0-9]*?)$",
                                        unit_class = c(uclass_aucnorm), valid_models = c(m1sd,
                                                                                         m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                        predecessors = c("AUCALL", "DOSEC", "DOSECi"))
  dependency_list[["AUCDN"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c("auc_dn"), regex = "^AUCDN$",
                                     unit_class = c(uclass_aucnorm), valid_models = c(m1sd,
                                                                                      m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                     predecessors = c("AUCALL"))
  dependency_list[["AUCINFO"]] <- list(parameter_label = c("AUCINF"),
                                       cdisc_label = c("AUCIFO"), callfun = c("auc_inf_o"),
                                       regex = "^AUCINFO$", unit_class = c(uclass_auc), valid_models = c(m1sd,
                                                                                                         m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                       predecessors = c("CLAST", "AUCLAST", "KEL", "SPANRATIO",
                                                        "CLASTi", "AUCLASTi"))
  dependency_list[["AUCINFOC"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c("auc_inf_oc"), regex = "^AUCINFOC$",
                                        unit_class = c(uclass_auc), valid_models = c(m1sd, m2sd,
                                                                                     m3sd), display_list_models = c(), predecessors = c("AUCINFO",
                                                                                                                                        "C0", "KEL"))
  dependency_list[["AUCINFODN"]] <- list(parameter_label = c("AUCINFDN"),
                                         cdisc_label = c("AUCIFOD"), callfun = c("auc_dn"), regex = "^AUCINFODN$",
                                         unit_class = c(uclass_aucnorm), valid_models = c(m1sd,
                                                                                          m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                         predecessors = c("AUCINFO", "DOSEC"))
  dependency_list[["AUCINFOi"]] <- list(parameter_label = c("AUCINF"),
                                        cdisc_label = c("AUCIFO"), callfun = c("auc_inf_o"),
                                        regex = "^AUCINFO(i{1}?|[0-9]+?)$", unit_class = c(uclass_auc),
                                        valid_models = c(m1ss, m2ss, m3ss), display_list_models = c(),
                                        predecessors = c("CLASTi", "AUCLASTi", "KEL", "SPANRATIO",
                                                         "TAUi", "TOLDi"))
  dependency_list[["AUCINFOCi"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c("auc_inf_oc"), regex = "^AUCINFOC(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_auc), valid_models = c(m1ss, m2ss,
                                                                                      m3ss), display_list_models = c(), predecessors = c("CLASTi",
                                                                                                                                         "AUCLASTi", "KEL"))
  dependency_list[["AUCINFODNi"]] <- list(parameter_label = c("AUCINFDN"),
                                          cdisc_label = c(), callfun = c("auc_dn"), regex = "^AUCINFODN(i{1}?|[0-9]+?)$",
                                          unit_class = c(uclass_aucnorm), valid_models = c(m1ss,
                                                                                           m2ss, m3ss), display_list_models = c(), predecessors = c("AUCINFOi",
                                                                                                                                                    "DOSECi"))
  dependency_list[["AUCINFP"]] <- list(parameter_label = c("AUCINF"),
                                       cdisc_label = c("AUCIFP"), callfun = c("auc_inf_p"),
                                       regex = "^AUCINFP$", unit_class = c(uclass_auc), valid_models = c(m1sd,
                                                                                                         m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m1sd,
                                                                                                                                                                m2sd, m3sd), predecessors = c("TLAST", "CEST", "KEL",
                                                                                                                                                                                              "KELC0", "AUCLAST", "SPANRATIO", "TLASTi", "AUCLASTi"))
  dependency_list[["AUCINFPC"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c("auc_inf_pc"), regex = "^AUCINFPC$",
                                        unit_class = c(uclass_auc), valid_models = c(m1sd, m2sd,
                                                                                     m3sd), display_list_models = c(), predecessors = c("AUCINFP",
                                                                                                                                        "C0", "KEL"))
  dependency_list[["AUCINFPDN"]] <- list(parameter_label = c("AUCINFDN"),
                                         cdisc_label = c("AUCIFPD"), callfun = c("auc_dn"), regex = "^AUCINFPDN$",
                                         unit_class = c(uclass_aucnorm), valid_models = c(m1sd,
                                                                                          m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                         predecessors = c("AUCINFP", "DOSEC"))
  dependency_list[["AUCINFPi"]] <- list(parameter_label = c("AUCINF"),
                                        cdisc_label = c("AUCIFP"), callfun = c("auc_inf_p"),
                                        regex = "^AUCINFP(i{1}?|[0-9]+?)$", unit_class = c(uclass_auc),
                                        valid_models = c(m1ss, m2ss, m3ss), display_list_models = c(),
                                        predecessors = c("TLASTi", "CEST", "KEL", "KELC0", "AUCLASTi",
                                                         "SPANRATIO", "TAUi", "TOLDi"))
  dependency_list[["AUCINFPCi"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c("auc_inf_pc"), regex = "^AUCINFPC(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_auc), valid_models = c(m1ss, m2ss,
                                                                                      m3ss), display_list_models = c(), predecessors = c("AUCINFPi",
                                                                                                                                         "C0", "KEL"))
  dependency_list[["AUCINFPDNi"]] <- list(parameter_label = c("AUCINFDN"),
                                          cdisc_label = c("AUCIFP"), callfun = c("auc_dn"), regex = "^AUCINFPDN(i{1}?|[0-9]+?)$",
                                          unit_class = c(uclass_aucnorm), valid_models = c(m1ss,
                                                                                           m2ss, m3ss), display_list_models = c(), predecessors = c("AUCINFPi",
                                                                                                                                                    "DOSECi"))
  dependency_list[["AUCLAST"]] <- list(parameter_label = c("AUCLAST"),
                                       cdisc_label = c("AUCLST"), callfun = c("auc_last"),
                                       regex = "^AUCLAST$", unit_class = c(uclass_auc), valid_models = c(m1sd,
                                                                                                         m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m1sd,
                                                                                                                                                                m2sd, m3sd), predecessors = c("TLAST", "TMAX", "TLASTi",
                                                                                                                                                                                              "TMAXi"))
  dependency_list[["AUCLASTi"]] <- list(parameter_label = c("AUCLAST"),
                                        cdisc_label = c("AUCLST"), callfun = c("auc_last"),
                                        regex = "^AUCLAST(i{1}?|[0-9]+?)$", unit_class = c(uclass_auc),
                                        valid_models = c(m1ss, m2ss, m3ss), display_list_models = c(m1ss,
                                                                                                    m3ss), predecessors = c("TLASTi", "TMAXi", "TAUi",
                                                                                                                            "TOLDi"))
  dependency_list[["AUCLASTC"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c("auc_lastc"), regex = "^AUCLASTC$",
                                        unit_class = c(uclass_auc), valid_models = c(m1sd, m2sd,
                                                                                     m3sd), display_list_models = c(), predecessors = c("AUCLAST",
                                                                                                                                        "C0", "KEL", "TLAST"))
  dependency_list[["AUCLASTCi"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c("auc_lastc"), regex = "^AUCLASTC(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_auc), valid_models = c(m1ss, m2ss,
                                                                                      m3ss), display_list_models = c(), predecessors = c("AUCLASTi",
                                                                                                                                         "C0", "TLAST", "KEL", "TAUi", "TOLDi"))
  dependency_list[["AUCLASTDN"]] <- list(parameter_label = c("AUCLSTDN"),
                                         cdisc_label = c("AUCLSTD"), callfun = c("auc_dn"), regex = "^AUCLASTDN$",
                                         unit_class = c(uclass_aucnorm), valid_models = c(m1sd,
                                                                                          m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                         predecessors = c("AUCLAST", "DOSEC"))
  dependency_list[["AUCLASTDNi"]] <- list(parameter_label = c("AUCLSTDN"),
                                          cdisc_label = c("AUCLSTD"), callfun = c("auclasti_dn"),
                                          regex = "^AUCLASTDN(i{1}?|[0-9]+?)$", unit_class = c(uclass_aucnorm),
                                          valid_models = c(m1ss, m2ss, m3ss), display_list_models = c(),
                                          predecessors = c("AUCLASTi", "DOSECi"))
  dependency_list[["AUCT"]] <- list(parameter_label = c("AUCT"),
                                    cdisc_label = c("AUCINT"), callfun = c("auc_t1_t2"),
                                    regex = "^AUC(T|[0-9]+?)$", unit_class = c(uclass_auc),
                                    valid_models = c(m1sd, m1ss, m2sd, m2ss, m3sd, m3ss),
                                    display_list_models = c(), predecessors = c("TMAX",
                                                                                "TMAXi", "DOSEC", "DOSECi"))
  dependency_list[["AUCT1_T2"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c("auc_t1_t2"), regex = "^AUC(T1|[0-9]+?)_(T2|[0-9]+?)$",
                                        unit_class = c(uclass_auc), valid_models = c(m1sd, m1ss,
                                                                                     m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                        predecessors = c("TMAX", "TMAXi", "AUCT"))
  dependency_list[["AUCTAUDNi"]] <- list(parameter_label = c("AUCTAUDN"),
                                         cdisc_label = c("AUCTAUD"), callfun = c("auc_dn"), regex = "^AUCTAUDN(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_aucnorm), valid_models = c(m1ss,
                                                                                          m2ss, m3ss), display_list_models = c(), predecessors = c("AUCTAUi",
                                                                                                                                                   "AUCTAU", "DOSECi"))
  dependency_list[["AUCTAUi"]] <- list(parameter_label = c("AUCTAU"),
                                       cdisc_label = c("AUCTAU"), callfun = c("auc_all"), regex = "^AUCTAU(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_auc), valid_models = c(m1ss, m2ss,
                                                                                    m3ss), display_list_models = c(m1ss, m3ss), predecessors = c("TMAXi",
                                                                                                                                                 "TAUi", "TOLDi", "KEL", "AUCLASTi"))
  dependency_list[["AUCTDN"]] <- list(parameter_label = c("AUCTDN"),
                                      cdisc_label = c("AUCINTD"), callfun = c("auc_dn"), regex = "^AUC(T|[0-9]+?)DN$",
                                      unit_class = c(uclass_aucnorm), valid_models = c(m1sd,
                                                                                       m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                      predecessors = c("AUCT", "DOSEC", "DOSECi"))
  dependency_list[["AUCXPCTO"]] <- list(parameter_label = c("AUCXPPCT"),
                                        cdisc_label = c("AUCPEO"), callfun = c(), regex = "^AUCXPCTO$",
                                        unit_class = c(uclass_percent), valid_models = c(m1sd,
                                                                                         m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                        predecessors = c("AUCINFO", "AUCLAST"))
  dependency_list[["AUCXPCTOi"]] <- list(parameter_label = c("AUCXPPCT"),
                                         cdisc_label = c("AUCPEO"), callfun = c(), regex = "^AUCXPCTO(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_percent), valid_models = c(m1ss,
                                                                                          m2ss, m3ss), display_list_models = c(), predecessors = c("AUCINFOi",
                                                                                                                                                   "AUCLASTi", "TAUi", "TOLDi"))
  dependency_list[["AUCXPCTP"]] <- list(parameter_label = c("AUCXPPCT"),
                                        cdisc_label = c("AUCPEP"), callfun = c(), regex = "^AUCXPCTP$",
                                        unit_class = c(uclass_percent), valid_models = c(m1sd,
                                                                                         m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m1sd,
                                                                                                                                                m2sd, m3sd), predecessors = c("AUCINFP", "AUCLAST"))
  dependency_list[["AUCXPCTPi"]] <- list(parameter_label = c("AUCXPPCT"),
                                         cdisc_label = c("AUCPEP"), callfun = c(), regex = "^AUCXPCTP(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_percent), valid_models = c(m1ss,
                                                                                          m2ss, m3ss), display_list_models = c(m1ss, m3ss),
                                         predecessors = c("AUCINFPi", "AUCLASTi", "TAUi", "TOLDi"))
  dependency_list[["AUCXBPCTO"]] <- list(parameter_label = c("AUCXBPCTO"),
                                         cdisc_label = c(), callfun = c(), regex = "^AUCXBPCTO$",
                                         unit_class = c(uclass_percent), valid_models = c(m2sd,
                                                                                          m2ss), display_list_models = c(m2sd, m2ss), predecessors = c("AUCINFO",
                                                                                                                                                       "C0"))
  dependency_list[["AUCXBPCTP"]] <- list(parameter_label = c("AUCXBPCTP"),
                                         cdisc_label = c(), callfun = c(), regex = "^AUCXBPCTP$",
                                         unit_class = c(uclass_percent), valid_models = c(m2sd,
                                                                                          m2ss), display_list_models = c(m2sd, m2ss), predecessors = c("AUCINFP",
                                                                                                                                                       "C0"))
  dependency_list[["AUMCINFO"]] <- list(parameter_label = c("AUMCIFO"),
                                        cdisc_label = c("AUMCIFO"), callfun = c(), regex = "^AUMCINFO$",
                                        unit_class = c(uclass_aumc), valid_models = c(m1sd,
                                                                                      m2sd, m3sd), display_list_models = c(), predecessors = c("AUMCLAST",
                                                                                                                                               "CLAST", "TLAST", "KEL"))
  dependency_list[["AUMCINFOi"]] <- list(parameter_label = c("AUMCIFO"),
                                         cdisc_label = c("AUMCIFO"), callfun = c(), regex = "^AUMCINFO(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_aumc), valid_models = c(m1ss,
                                                                                       m2ss, m3ss), display_list_models = c(), predecessors = c("CLASTi",
                                                                                                                                                "TLASTi", "AUMCLASTi", "KEL", "TAUi", "TOLDi"))
  dependency_list[["AUMCINFP"]] <- list(parameter_label = c("AUMCIFP"),
                                        cdisc_label = c("AUMCIFP"), callfun = c(), regex = "^AUMCINFP$",
                                        unit_class = c(uclass_aumc), valid_models = c(m1sd,
                                                                                      m2sd, m3sd), display_list_models = c(), predecessors = c("CEST",
                                                                                                                                               "TLAST", "AUMCLAST", "KEL"))
  dependency_list[["AUMCINFPi"]] <- list(parameter_label = c("AUMCIFP"),
                                         cdisc_label = c("AUMCIFP"), callfun = c(), regex = "^AUMCINFP(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_aumc), valid_models = c(m1ss,
                                                                                       m2ss, m3ss), display_list_models = c(), predecessors = c("CEST",
                                                                                                                                                "TLASTi", "AUMCLASTi", "KEL", "TAUi", "TOLDi"))
  dependency_list[["AUMCLAST"]] <- list(parameter_label = c("AUMCLST"),
                                        cdisc_label = c("AUMCLST"), callfun = c(), regex = "^AUMCLAST$",
                                        unit_class = c(uclass_aumc), valid_models = c(m1sd,
                                                                                      m2sd, m3sd), display_list_models = c(), predecessors = c("TMAX"))
  dependency_list[["AUMCLASTi"]] <- list(parameter_label = c("AUMCLST"),
                                         cdisc_label = c("AUMCLST"), callfun = c("aumclasti"),
                                         regex = "^AUMCLAST(i{1}?|[0-9]+?)$", unit_class = c(uclass_aumc),
                                         valid_models = c(m1ss, m2ss, m3ss), display_list_models = c(),
                                         predecessors = c("TMAXi", "TAUi", "TOLDi"))
  dependency_list[["AUMCTAUi"]] <- list(parameter_label = c("AUMCTAUi"),
                                        cdisc_label = c(), callfun = c(), regex = "^AUMCTAU(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_aumc), valid_models = c(m1ss,
                                                                                      m2ss, m3ss), display_list_models = c(), predecessors = c("TMAXi",
                                                                                                                                               "TAUi", "TOLDi"))
  dependency_list[["AUMCXPTO"]] <- list(parameter_label = c("AUMCXPTO"),
                                        cdisc_label = c(), callfun = c(), regex = "^AUMCXPTO$",
                                        unit_class = c(uclass_percent), valid_models = c(m1sd,
                                                                                         m2sd, m3sd), display_list_models = c(), predecessors = c("AUMCINFO",
                                                                                                                                                  "AUMCLAST"))
  dependency_list[["AUMCXPTOi"]] <- list(parameter_label = c("AUMCXPTOi"),
                                         cdisc_label = c(), callfun = c(), regex = "^AUMCXPTO(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_percent), valid_models = c(m1ss,
                                                                                          m2ss, m3ss), display_list_models = c(), predecessors = c("AUMCINFOi",
                                                                                                                                                   "AUMCLASTi", "TAUi", "TOLDi"))
  dependency_list[["AUMCXPTP"]] <- list(parameter_label = c("AUMCXPTP"),
                                        cdisc_label = c(), callfun = c(), regex = "^AUMCXPTP$",
                                        unit_class = c(uclass_percent), valid_models = c(m1sd,
                                                                                         m2sd, m3sd), display_list_models = c(), predecessors = c("AUMCINFP",
                                                                                                                                                  "AUMCLAST"))
  dependency_list[["AUMCXPTPi"]] <- list(parameter_label = c("AUMCXPTPi"),
                                         cdisc_label = c(), callfun = c(), regex = "^AUMCXPTP(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_percent), valid_models = c(m1ss,
                                                                                          m2ss, m3ss), display_list_models = c(), predecessors = c("AUMCINFPi",
                                                                                                                                                   "AUMCLASTi", "TAUi", "TOLDi"))
  dependency_list[["AURCALL"]] <- list(parameter_label = c("AURCALL"),
                                       cdisc_label = c(), callfun = c("auc_all"), regex = "^AURCALL$",
                                       unit_class = c(uclass_aurc), valid_models = c(m4sd,
                                                                                     m4ss), display_list_models = c(), predecessors = c("TMAXRATE"))
  dependency_list[["AURCINFO"]] <- list(parameter_label = c("AURCINFO"),
                                        cdisc_label = c(), callfun = c("auc_inf_o"), regex = "^AURCINFO$",
                                        unit_class = c(uclass_aurc), valid_models = c(m4sd,
                                                                                      m4ss), display_list_models = c(), predecessors = c("AURCLAST",
                                                                                                                                         "RATELAST", "KEL"))
  dependency_list[["AURCINFP"]] <- list(parameter_label = c("AURCINFP"),
                                        cdisc_label = c(), callfun = c("auc_inf_p"), regex = "^AURCINFP$",
                                        unit_class = c(uclass_aurc), valid_models = c(m4sd,
                                                                                      m4ss), display_list_models = c(), predecessors = c("AURCLAST",
                                                                                                                                         "MIDPTLAST", "KEL"))
  dependency_list[["AURCLAST"]] <- list(parameter_label = c("AURCLAST"),
                                        cdisc_label = c(), callfun = c("auc_last"), regex = "^AURCLAST$",
                                        unit_class = c(uclass_aurc), valid_models = c(m4sd,
                                                                                      m4ss), display_list_models = c(), predecessors = c("MIDPTLAST",
                                                                                                                                         "TMAXRATE", "MIDPTLASTi", "TMAXRATEi"))
  dependency_list[["AURCT"]] <- list(parameter_label = c("AURCT"),
                                     cdisc_label = c(), callfun = c("auc_t1_t2"), regex = "^AURC(T|[0-9]+?)$",
                                     unit_class = c(uclass_aurc), valid_models = c(m4sd,
                                                                                   m4ss), display_list_models = c(), predecessors = c("TMAXRATE"))
  dependency_list[["AURCT1_T2"]] <- list(parameter_label = c("AURCT1_T2"),
                                         cdisc_label = c(), callfun = c("auc_t1_t2"), regex = "^AURC(T1|[0-9]+?)_(T2|[0-9]+?)$",
                                         unit_class = c(uclass_aurc), valid_models = c(m4sd,
                                                                                       m4ss), display_list_models = c(), predecessors = c("TMAXRATE"))
  dependency_list[["AURCXPCTO"]] <- list(parameter_label = c("AURCXPCTO"),
                                         cdisc_label = c(), callfun = c(), regex = "^AURCXPCTO$",
                                         unit_class = c(uclass_percent), valid_models = c(m4sd,
                                                                                          m4ss), display_list_models = c(), predecessors = c("AURCINFO",
                                                                                                                                             "AURCLAST"))
  dependency_list[["AURCXPCTP"]] <- list(parameter_label = c("AURCXPCTP"),
                                         cdisc_label = c(), callfun = c(), regex = "^AURCXPCTP$",
                                         unit_class = c(uclass_percent), valid_models = c(m4sd,
                                                                                          m4ss), display_list_models = c(), predecessors = c("AURCINFP",
                                                                                                                                             "AURCLAST"))
  dependency_list[["C0"]] <- list(parameter_label = c("C0"),
                                  cdisc_label = c("C0"), callfun = c(), regex = "^C0$",
                                  unit_class = c(uclass_amtvol), valid_models = c(m1sd,
                                                                                  m1ss, m2sd, m2ss), display_list_models = c(m2sd),
                                  predecessors = c())
  dependency_list[["CAVi"]] <- list(parameter_label = c("CAV"),
                                    cdisc_label = c("CAVG"), callfun = c(), regex = "^CAV(i{1}?|[0-9]+?)$",
                                    unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                    m2ss, m3ss), display_list_models = c(m1ss, m3ss),
                                    predecessors = c("AUCTAUi", "TAUi", "TOLDi"))
  dependency_list[["CAVDNi"]] <- list(parameter_label = c("CAVDN"),
                                      cdisc_label = c("CAVGD"), callfun = c(), regex = "^CAV(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                      m2ss, m3ss), display_list_models = c(m1ss, m3ss),
                                      predecessors = c("AUCTAUi", "TAUi", "TOLDi"))
  dependency_list[["CENDINF"]] <- list(parameter_label = c(),
                                       cdisc_label = c(), callfun = c(), regex = "^CENDINF$",
                                       unit_class = c(uclass_amtvol), valid_models = c(m3sd),
                                       display_list_models = c(m3sd), predecessors = c("DOF",
                                                                                       "CMAX"))
  dependency_list[["CENDINFi"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^CENDINF(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_amtvol), valid_models = c(m3ss),
                                        display_list_models = c(m3ss), predecessors = c("DOFi",
                                                                                        "TAUi", "TOLDi", "CMAXi"))
  dependency_list[["CENDINFDN"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c(), regex = "^CENDINFDN$",
                                         unit_class = c(uclass_concnorm), valid_models = c(m3sd),
                                         display_list_models = c(), predecessors = c("CENDINF",
                                                                                     "DOSEC"))
  dependency_list[["CENDINFDNi"]] <- list(parameter_label = c(),
                                          cdisc_label = c(), callfun = c(), regex = "^CENDINFDN(i{1}?|[0-9]+?)$",
                                          unit_class = c(uclass_concnorm), valid_models = c(m3ss),
                                          display_list_models = c(), predecessors = c("CENDINFi",
                                                                                      "DOSECi"))
  dependency_list[["CEST"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^CEST$",
                                    unit_class = c(uclass_amtvol), valid_models = c(m1sd,
                                                                                    m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                    predecessors = c("TLAST", "KEL", "KELC0"))
  dependency_list[["CLAST"]] <- list(parameter_label = c("CLAST"),
                                     cdisc_label = c(), callfun = c(), regex = "^CLAST$",
                                     unit_class = c(uclass_amtvol), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                     predecessors = c())
  dependency_list[["CLASTi"]] <- list(parameter_label = c("CLASTi"),
                                      cdisc_label = c(), callfun = c(), regex = "^CLAST(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                      m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                               "TOLDi"))
  dependency_list[["CLFO"]] <- list(parameter_label = c("CLFO"),
                                    cdisc_label = c("CLFO"), callfun = c(), regex = "^CLFO$",
                                    unit_class = c(uclass_cl), valid_models = c(m1sd), display_list_models = c(),
                                    predecessors = c("AUCINFO", "DOSEC"))
  dependency_list[["CLFOW"]] <- list(parameter_label = c("CLFOW"),
                                     cdisc_label = c("CLFOW"), callfun = c(), regex = "^CLFOW$",
                                     unit_class = c(uclass_clwnorm), valid_models = c(m1sd),
                                     display_list_models = c(), predecessors = c("CLFO"))
  dependency_list[["CLFP"]] <- list(parameter_label = c("CLFP"),
                                    cdisc_label = c("CLFP"), callfun = c(), regex = "^CLFP$",
                                    unit_class = c(uclass_cl), valid_models = c(m1sd), display_list_models = c(m1sd),
                                    predecessors = c("AUCINFP", "DOSEC"))
  dependency_list[["CLFPW"]] <- list(parameter_label = c("CLFPW"),
                                     cdisc_label = c("CLFPW"), callfun = c(), regex = "^CLFPW$",
                                     unit_class = c(uclass_clwnorm), valid_models = c(m1sd),
                                     display_list_models = c(), predecessors = c("CLFP"))
  dependency_list[["CLFTAUi"]] <- list(parameter_label = c("CLFTAU"),
                                       cdisc_label = c("CLFTAU"), callfun = c(), regex = "^CLFTAU(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_cl), valid_models = c(m1ss), display_list_models = c(m1ss),
                                       predecessors = c("AUCTAUi", "DOSECi", "TAUi", "TOLDi"))
  dependency_list[["CLFTAUWi"]] <- list(parameter_label = c("CLFTAUW"),
                                        cdisc_label = c("CLFTAUW"), callfun = c(), regex = "^CLFTAUW(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_clwnorm), valid_models = c(m1ss),
                                        display_list_models = c(), predecessors = c("CLFTAUi",
                                                                                    "TAUi", "TOLDi"))
  dependency_list[["CL"]] <- list(parameter_label = c("CL"),
                                  cdisc_label = c("CLP"), callfun = c(), regex = "^CLO$",
                                  unit_class = c(uclass_cl), valid_models = c(m2sd, m3sd),
                                  display_list_models = c(), predecessors = c("AUCINFO",
                                                                              "DOSEC"))
  dependency_list[["CLO"]] <- list(parameter_label = c("CLO"),
                                   cdisc_label = c("CLO"), callfun = c(), regex = "^CLO$",
                                   unit_class = c(uclass_cl), valid_models = c(m2sd, m3sd),
                                   display_list_models = c(), predecessors = c("AUCINFO",
                                                                               "DOSEC"))
  dependency_list[["CLOW"]] <- list(parameter_label = c("CLOW"),
                                    cdisc_label = c("CLOW"), callfun = c(), regex = "^CLOW$",
                                    unit_class = c(uclass_clwnorm), valid_models = c(m2sd,
                                                                                     m3sd), display_list_models = c(), predecessors = c("CLO"))
  dependency_list[["CLP"]] <- list(parameter_label = c("CLP"),
                                   cdisc_label = c("CLP"), callfun = c(), regex = "^CLP$",
                                   unit_class = c(uclass_cl), valid_models = c(m2sd, m3sd),
                                   display_list_models = c(m2sd, m3sd), predecessors = c("AUCINFP",
                                                                                         "DOSEC"))
  dependency_list[["CLPW"]] <- list(parameter_label = c("CLPW"),
                                    cdisc_label = c("CLPW"), callfun = c(), regex = "^CLPW$",
                                    unit_class = c(uclass_clwnorm), valid_models = c(m2sd,
                                                                                     m3sd), display_list_models = c(), predecessors = c("CLP"))
  dependency_list[["CLR"]] <- list(parameter_label = c("CLR"),
                                   cdisc_label = c("RENALCL"), callfun = c(), regex = "^CLR$",
                                   unit_class = c(uclass_cl), valid_models = c(m4sd), display_list_models = c(),
                                   predecessors = c("AE", "AUCINFP"))
  dependency_list[["CLRT"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^CLRT$",
                                    unit_class = c(uclass_cl), valid_models = c(m4sd), display_list_models = c(),
                                    predecessors = c("AET", "AUCT"))
  dependency_list[["CLRTAUi"]] <- list(parameter_label = c("CLRTAU"),
                                       cdisc_label = c("RENCLTAU"), callfun = c(), regex = "^CLRTAU(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_cl), valid_models = c(m4ss), display_list_models = c(),
                                       predecessors = c("AETAUi", "AUCTAUi"))
  dependency_list[["CLTAUi"]] <- list(parameter_label = c("CLTAU"),
                                      cdisc_label = c("CLTAU"), callfun = c(), regex = "^CLTAU(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_cl), valid_models = c(m2ss, m3ss),
                                      display_list_models = c(m3ss), predecessors = c("AUCTAUi",
                                                                                      "DOSECi"))
  dependency_list[["CLTAUWi"]] <- list(parameter_label = c("CLTAUW"),
                                       cdisc_label = c("CLTAUW"), callfun = c(), regex = "^CLTAUW(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_clwnorm), valid_models = c(m2ss,
                                                                                        m3ss), display_list_models = c(), predecessors = c("CLTAUi"))
  dependency_list[["CMAX"]] <- list(parameter_label = c("CMAX"),
                                    cdisc_label = c("CMAX"), callfun = c(), regex = "^CMAX$",
                                    unit_class = c(uclass_amtvol), valid_models = c(m1sd,
                                                                                    m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m1sd,
                                                                                                                                           m1ss, m3sd, m3ss), predecessors = c())
  dependency_list[["CMAXi"]] <- list(parameter_label = c("CMAX"),
                                     cdisc_label = c("CMAX"), callfun = c(), regex = "^CMAX(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                     m2ss, m3ss), display_list_models = c(m1ss, m3ss),
                                     predecessors = c("TAUi", "TOLDi"))
  dependency_list[["CMAXC"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^CMAXC$",
                                     unit_class = c(uclass_amtvol), valid_models = c(m2sd,
                                                                                     m2ss), display_list_models = c(), predecessors = c("CMAX",
                                                                                                                                        "TMAX", "C0"))
  dependency_list[["CMAXCi"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c(), regex = "^CMAXC(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                      m2ss), display_list_models = c(), predecessors = c("CMAXi",
                                                                                                                                         "TMAXi", "C0", "TAUi", "TOLDi"))
  dependency_list[["CMAXDN"]] <- list(parameter_label = c("CMAXDN"),
                                      cdisc_label = c("CMAXD"), callfun = c(), regex = "^CMAXDN$",
                                      unit_class = c(uclass_concnorm), valid_models = c(m1sd,
                                                                                        m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                      predecessors = c("CMAX", "DOSEC"))
  dependency_list[["CMAXDNi"]] <- list(parameter_label = c("CMAXDNi"),
                                       cdisc_label = c(), callfun = c(), regex = "^CMAXDN(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_concnorm), valid_models = c(m1ss,
                                                                                         m2ss, m3ss), display_list_models = c(), predecessors = c("CMAXi",
                                                                                                                                                  "TAUi", "TOLDi", "DOSECi"))
  dependency_list[["CMIN"]] <- list(parameter_label = c("CMIN"),
                                    cdisc_label = c("CMIN"), callfun = c(), regex = "^CMIN$",
                                    unit_class = c(uclass_amtvol), valid_models = c(m1sd,
                                                                                    m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m1ss),
                                    predecessors = c())
  dependency_list[["CMINi"]] <- list(parameter_label = c("CMIN"),
                                     cdisc_label = c("CMIN"), callfun = c(), regex = "^CMIN(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                     m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                              "TOLDi"))
  dependency_list[["CMINDN"]] <- list(parameter_label = c("CMINDN"),
                                      cdisc_label = c("CMIND"), callfun = c(), regex = "^CMINDN$",
                                      unit_class = c(uclass_concnorm), valid_models = c(m1sd,
                                                                                        m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                      predecessors = c("CMIN", "DOSEC"))
  dependency_list[["CMINDNi"]] <- list(parameter_label = c("CMINDN"),
                                       cdisc_label = c("CMIND"), callfun = c(), regex = "^CMINDN(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_concnorm), valid_models = c(m1ss,
                                                                                         m2ss, m3ss), display_list_models = c(), predecessors = c("CMINi",
                                                                                                                                                  "DOSECi"))
  dependency_list[["CTOLDesti"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c(), regex = "^CTOLDest(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_amtvol), valid_models = c(m1sd,
                                                                                         m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                         predecessors = c("TAUi", "TOLDi"))
  dependency_list[["CTROUGHi"]] <- list(parameter_label = c("CTROUGH"),
                                        cdisc_label = c("CTROUGH"), callfun = c(), regex = "^CTROUGH(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                        m2ss, m3ss), display_list_models = c(m1ss), predecessors = c("TAUi",
                                                                                                                                                     "TOLDi"))
  dependency_list[["CTROUGHENDi"]] <- list(parameter_label = c(),
                                           cdisc_label = c(), callfun = c(), regex = "^CTROUGHEND(i{1}?|[0-9]+?)$",
                                           unit_class = c(uclass_amtvol), valid_models = c(m1ss,
                                                                                           m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                                    "TOLDi"))
  dependency_list[["DIi"]] <- list(parameter_label = c(),
                                   cdisc_label = c(), callfun = c(), regex = "^DI(i{1}?|[0-9]+?)$",
                                   unit_class = c(uclass_none), valid_models = c(m1ss,
                                                                                 m2ss, m3ss, m4ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                                "TOLDi"))
  dependency_list[["DOFi"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^DOF(i{1}?|[0-9]*?)$",
                                    unit_class = c(uclass_time), valid_models = c(m3sd,
                                                                                  m3ss), display_list_models = c(), predecessors = c())
  dependency_list[["DOSE"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^DOSE$",
                                    unit_class = c(uclass_dose), valid_models = c(m1sd,
                                                                                  m2sd, m3sd, m4sd), display_list_models = c(), predecessors = c())
  dependency_list[["DOSEi"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^DOSE(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_dose), valid_models = c(m1ss,
                                                                                   m2ss, m3ss, m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["DOSEC"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^DOSEC$",
                                     unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                        m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(),
                                     predecessors = c())
  dependency_list[["DOSECi"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c(), regex = "^DOSEC(i{1}?|[0-9]+?)$",
                                      unit_class = c(), valid_models = c(m1ss, m2ss, m3ss,
                                                                         m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["F"]] <- list(parameter_label = c(), cdisc_label = c(),
                                 callfun = c(), regex = "^F$", unit_class = c(uclass_ratio),
                                 valid_models = c(m1sd, m2sd, m3sd), display_list_models = c(),
                                 predecessors = c("AUCINFP"))
  dependency_list[["FREL"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^FREL$",
                                    unit_class = c(uclass_ratio), valid_models = c(m1sd,
                                                                                   m2sd, m3sd), display_list_models = c(), predecessors = c("AUCINFP"))
  dependency_list[["FRELLAST"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^FRELLAST$",
                                        unit_class = c(uclass_ratio), valid_models = c(m1sd,
                                                                                       m2sd, m3sd), display_list_models = c(), predecessors = c("AUCLAST"))
  dependency_list[["FRELLASTi"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c(), regex = "^FRELLAST(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                        m2ss, m3ss), display_list_models = c(), predecessors = c("AUCLASTi",
                                                                                                                                                 "TAUi", "TOLDi"))
  dependency_list[["FA"]] <- list(parameter_label = c(), cdisc_label = c(),
                                  callfun = c(), regex = "^FA$", unit_class = c(uclass_percent),
                                  valid_models = c(m4sd), display_list_models = c(), predecessors = c("AE",
                                                                                                      "AEPCT"))
  dependency_list[["FTAUi"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^FTAU(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                    m2ss, m3ss), display_list_models = c(), predecessors = c("AUCTAUi",
                                                                                                                                             "AUCINFPi", "AUCINFP", "TAUi", "TOLDi"))
  dependency_list[["KEL"]] <- list(parameter_label = c("KEL"),
                                   cdisc_label = c("LAMZ"), callfun = c(), regex = "^KEL$",
                                   unit_class = c(uclass_slope), valid_models = c(m1sd,
                                                                                  m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(m1sd,
                                                                                                                                                     m1ss, m2sd, m3sd, m3ss), predecessors = c())
  dependency_list[["KELC0"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^KELC0$",
                                     unit_class = c(uclass_amtvol), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                     predecessors = c("KEL"))
  dependency_list[["KELNOPT"]] <- list(parameter_label = c("KELNOPT"),
                                       cdisc_label = c("LAMZNPT"), callfun = c(), regex = "^KELNOPT$",
                                       unit_class = c(uclass_none), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(m1sd,
                                                                                                                                                        m1ss, m2sd, m3sd, m3ss), predecessors = c("KEL"))
  dependency_list[["KELR"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^KELR$",
                                    unit_class = c(uclass_none), valid_models = c(m1sd,
                                                                                  m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(),
                                    predecessors = c())
  dependency_list[["KELRSQ"]] <- list(parameter_label = c("KELRSQ"),
                                      cdisc_label = c("R2"), callfun = c(), regex = "^KELRSQ$",
                                      unit_class = c(uclass_none), valid_models = c(m1sd,
                                                                                    m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(m1sd,
                                                                                                                                                       m1ss, m2sd, m3sd, m3ss), predecessors = c("KELR"))
  dependency_list[["KELRSQA"]] <- list(parameter_label = c(),
                                       cdisc_label = c(), callfun = c(), regex = "^KELRSQA$",
                                       unit_class = c(uclass_none), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(),
                                       predecessors = c("KELR"))
  dependency_list[["KELTMHI"]] <- list(parameter_label = c("KELTMHI"),
                                       cdisc_label = c("LAMZUL"), callfun = c(), regex = "^KELTMLO$",
                                       unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(m1sd,
                                                                                                                                                        m1ss, m2sd, m3sd, m3ss), predecessors = c("KEL"))
  dependency_list[["KELTMLO"]] <- list(parameter_label = c("KELTMLO"),
                                       cdisc_label = c("LAMZLL"), callfun = c(), regex = "^KELTMHI$",
                                       unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(m1sd,
                                                                                                                                                        m1ss, m2sd, m3sd, m3ss), predecessors = c("KEL"))
  dependency_list[["LASTTIME"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^LASTTIME$",
                                        unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                      m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                        predecessors = c())
  dependency_list[["LASTTIMEi"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c(), regex = "^LASTTIME(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                       m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                                "TOLDi"))
  dependency_list[["MAXRATE"]] <- list(parameter_label = c(),
                                       cdisc_label = c(), callfun = c(), regex = "^MAXRATE$",
                                       unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                     m4ss), display_list_models = c(), predecessors = c("RATE"))
  dependency_list[["MAXRATEi"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^MAXRATE(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_rate), valid_models = c(m4ss),
                                        display_list_models = c(), predecessors = c("TAUi",
                                                                                    "TOLDi", "RATEi"))
  dependency_list[["MIDPT"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^MIDPT$",
                                     unit_class = c(uclass_time), valid_models = c(m4sd,
                                                                                   m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["MIDPTA"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c(), regex = "^(MIDPT)([0-9]*?|A)$",
                                      unit_class = c(uclass_time), valid_models = c(m4sd,
                                                                                    m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["MIDPTN"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c(), regex = "^(MIDPT)([0-9]*?|N)$",
                                      unit_class = c(uclass_time), valid_models = c(m4sd,
                                                                                    m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["MIDPTLAST"]] <- list(parameter_label = c("MIDPTLAST"),
                                         cdisc_label = c(), callfun = c(), regex = "^MIDPTLAST$",
                                         unit_class = c(uclass_time), valid_models = c(m4sd,
                                                                                       m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["MIDPTLASTi"]] <- list(parameter_label = c("MIDPTLASTi"),
                                          cdisc_label = c(), callfun = c(), regex = "^MIDPTLAST(i{1}?|[0-9]+?)$",
                                          unit_class = c(uclass_time), valid_models = c(m4ss),
                                          display_list_models = c(), predecessors = c("TAUi",
                                                                                      "TOLDi"))
  dependency_list[["MRAUCINFO"]] <- list(parameter_label = c("MRAUCINF"),
                                         cdisc_label = c(), callfun = c(), regex = "^MRAUCINFO$",
                                         unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                            m2ss, m3sd, m3ss), display_list_models = c(), predecessors = c("AUCINFO"))
  dependency_list[["MRAUCINFP"]] <- list(parameter_label = c("MRAUCINF"),
                                         cdisc_label = c(), callfun = c(), regex = "^MRAUCINFP$",
                                         unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                            m2ss, m3sd, m3ss), display_list_models = c(), predecessors = c("AUCINFP"))
  dependency_list[["MRAUCLAST"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c(), regex = "^MRAUCLAST$",
                                         unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                            m2ss, m3sd, m3ss), display_list_models = c(), predecessors = c("AUCLAST"))
  dependency_list[["MRAUCTAUi"]] <- list(parameter_label = c("MRAUCTAU"),
                                         cdisc_label = c(), callfun = c(), regex = "^MRAUCTAU(i{1}?|[0-9]+?)$",
                                         unit_class = c(), valid_models = c(m1ss, m2ss, m3ss),
                                         display_list_models = c(), predecessors = c("AUCTAUi"))
  dependency_list[["MRCMAX"]] <- list(parameter_label = c("MRCMAX"),
                                      cdisc_label = c(), callfun = c(), regex = "^MRCMAX$",
                                      unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                         m2ss, m3sd, m3ss), display_list_models = c(), predecessors = c("CMAX"))
  dependency_list[["MRCMAXi"]] <- list(parameter_label = c("MRCMAXi"),
                                       cdisc_label = c(), callfun = c(), regex = "^MRCMAX(i{1}?|[0-9]+?)$",
                                       unit_class = c(), valid_models = c(m1ss, m2ss, m3ss),
                                       display_list_models = c(), predecessors = c("CMAXi"))
  dependency_list[["MRTEVIFO"]] <- list(parameter_label = c("MRTEVIFO"),
                                        cdisc_label = c("MRTEVIFO"), callfun = c(), regex = "^MRTEVIFO$",
                                        unit_class = c(uclass_time), valid_models = c(m1sd),
                                        display_list_models = c(), predecessors = c("AUCINFO",
                                                                                    "AUMCINFO", "AUMCLAST"))
  dependency_list[["MRTEVIFOi"]] <- list(parameter_label = c("MRTEVIFO"),
                                         cdisc_label = c("MRTEVIFO"), callfun = c(), regex = "^MRTEVIFO(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                       m2ss), display_list_models = c(), predecessors = c("AUCINFOi",
                                                                                                                                          "AUMCINFOi", "AUMCLASTi", "AUCTAUi", "AUMCTAUi",
                                                                                                                                          "TAUi", "TOLDi"))
  dependency_list[["MRTEVIFP"]] <- list(parameter_label = c("MRTEVIFP"),
                                        cdisc_label = c("MRTEVIFP"), callfun = c(), regex = "^MRTEVIFP$",
                                        unit_class = c(uclass_time), valid_models = c(m1sd),
                                        display_list_models = c(), predecessors = c("AUCINFP",
                                                                                    "AUMCINFP", "AUMCLAST"))
  dependency_list[["MRTEVIFPi"]] <- list(parameter_label = c("MRTEVIFP"),
                                         cdisc_label = c("MRTEVIFP"), callfun = c(), regex = "^MRTEVIFP(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_time), valid_models = c(m1ss),
                                         display_list_models = c(), predecessors = c("AUCINFPi",
                                                                                     "AUMCINFPi", "AUMCLASTi", "AUCTAUi", "AUMCTAUi",
                                                                                     "TAUi", "TOLDi"))
  dependency_list[["MRTIVIFO"]] <- list(parameter_label = c("MRTIVIFO"),
                                        cdisc_label = c("MRTIVIFO"), callfun = c(), regex = "^MRTIVIFO$",
                                        unit_class = c(uclass_time), valid_models = c(m2sd,
                                                                                      m3sd), display_list_models = c(), predecessors = c("AUCINFO",
                                                                                                                                         "AUMCINFO", "AUMCLAST"))
  dependency_list[["MRTIVIFOi"]] <- list(parameter_label = c("MRTIVIFO"),
                                         cdisc_label = c("MRTIVIFO"), callfun = c(), regex = "^MRTIVIFO(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_time), valid_models = c(m2ss,
                                                                                       m3ss), display_list_models = c(), predecessors = c("AUCINFOi",
                                                                                                                                          "AUMCINFOi", "AUMCLASTi", "AUCTAUi", "AUMCTAUi",
                                                                                                                                          "TAUi", "TOLDi"))
  dependency_list[["MRTIVIFP"]] <- list(parameter_label = c("MRTIVIFP"),
                                        cdisc_label = c("MRTIVIFP"), callfun = c(), regex = "^MRTIVIFP$",
                                        unit_class = c(uclass_time), valid_models = c(m2sd,
                                                                                      m3sd), display_list_models = c(m3sd, m3sd), predecessors = c("AUCINFP",
                                                                                                                                                   "AUMCINFP", "AUMCLAST"))
  dependency_list[["MRTIVIFPi"]] <- list(parameter_label = c("MRTIVIFP"),
                                         cdisc_label = c("MRTIVIFP"), callfun = c(), regex = "^MRTIVIFP(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_time), valid_models = c(m2ss,
                                                                                       m3ss), display_list_models = c(m3ss, m3ss), predecessors = c("AUCINFPi",
                                                                                                                                                    "AUMCINFPi", "AUMCLASTi", "AUCTAUi", "AUMCTAUi",
                                                                                                                                                    "TAUi", "TOLDi"))
  dependency_list[["MRTLAST"]] <- list(parameter_label = c("MRTLAST"),
                                       cdisc_label = c(), callfun = c(), regex = "^MRTLAST$",
                                       unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m3sd,
                                                                                                                                            m3ss), predecessors = c("AUCLAST", "AUMCLAST", "DOF"))
  dependency_list[["MRTLASTi"]] <- list(parameter_label = c("MRTLASTi"),
                                        cdisc_label = c(), callfun = c(), regex = "^MRTLAST(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                      m2ss, m3ss), display_list_models = c(), predecessors = c("AUCLASTi",
                                                                                                                                               "AUMCLASTi", "DOF", "TAUi", "TOLDi"))
  dependency_list[["PTF"]] <- list(parameter_label = c("PTF"),
                                   cdisc_label = c("FLUCP"), callfun = c(), regex = "^PTF$",
                                   unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                  m2ss, m3ss), display_list_models = c(m1ss), predecessors = c("CMAX",
                                                                                                                                               "CMIN", "CAV", "TAUi", "TOLDi"))
  dependency_list[["PTFi"]] <- list(parameter_label = c("PTF"),
                                    cdisc_label = c("FLUCP"), callfun = c(), regex = "^PTF(i{1}?|[0-9]+?)$",
                                    unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                   m2ss, m3ss), display_list_models = c(m1ss), predecessors = c("CMAXi",
                                                                                                                                                "CMINi", "CAVi", "TAUi", "TOLDi"))
  dependency_list[["PTR"]] <- list(parameter_label = c("PTR"),
                                   cdisc_label = c("PCMINR"), callfun = c(), regex = "^PTR$",
                                   unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                  m2ss, m3ss), display_list_models = c(m1ss), predecessors = c("CMAX",
                                                                                                                                               "CMIN", "TAUi", "TOLDi"))
  dependency_list[["PTRi"]] <- list(parameter_label = c("PTR"),
                                    cdisc_label = c("PCMINR"), callfun = c(), regex = "^PTR(i{1}?|[0-9]+?)$",
                                    unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                   m2ss, m3ss), display_list_models = c(m1ss), predecessors = c("CMAXi",
                                                                                                                                                "CMINi", "TAUi", "TOLDi"))
  dependency_list[["PTROUGHRi"]] <- list(parameter_label = c("PTROUGHR"),
                                         cdisc_label = c("PTROUGHR"), callfun = c(), regex = "^PTROUGHR(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                        m2ss, m3ss), display_list_models = c(), predecessors = c("CMAXi",
                                                                                                                                                 "CTROUGHi"))
  dependency_list[["PTROUGHRENDi"]] <- list(parameter_label = c(),
                                            cdisc_label = c(), callfun = c(), regex = "^PTROUGHREND(i{1}?|[0-9]+?)$",
                                            unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                           m2ss, m3ss), display_list_models = c(), predecessors = c("CMAXi",
                                                                                                                                                    "CTROUGHENDi"))
  dependency_list[["RACi"]] <- list(parameter_label = c("RAC"),
                                    cdisc_label = c("ARAUC"), callfun = c(), regex = "^RAC(i{1}?|[0-9]+?)$",
                                    unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                   m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                            "TOLDi"))
  dependency_list[["RACCMAXi"]] <- list(parameter_label = c("RACCMAX"),
                                        cdisc_label = c("ARCMAX"), callfun = c(), regex = "^RACCMAX(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                       m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                                "TOLDi"))
  dependency_list[["RACCMINi"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^RACCMIN(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_ratio), valid_models = c(m1ss,
                                                                                       m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                                "TOLDi"))
  dependency_list[["RATELAST"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^RATELAST$",
                                        unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                      m4ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                         "TOLDi"))
  dependency_list[["RATELASTi"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c(), regex = "^RATELAST(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_rate), valid_models = c(m4ss),
                                         display_list_models = c(), predecessors = c("TAUi",
                                                                                     "TOLDi"))
  dependency_list[["RATE"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^RATE$",
                                    unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                  m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["RATEi"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^RATE(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                   m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["RATEA"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^(RATE)([0-9]*?|A)$",
                                     unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                   m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["RATEAi"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c(), regex = "^(RATE)([0-9]*?|A|i{1}?)$",
                                      unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                    m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["RATEN"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^(RATE)([0-9]*?|N)$",
                                     unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                   m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["RATENi"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c(), regex = "^(RATE)([0-9]*?|N|i{1}?)$",
                                      unit_class = c(uclass_rate), valid_models = c(m4sd,
                                                                                    m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["TAU"]] <- list(parameter_label = c(),
                                   cdisc_label = c(), callfun = c(), regex = "^TAU(i{1}?|[0-9]+?)$",
                                   unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                 m2sd, m3sd), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                          "TOLDi"))
  dependency_list[["TAUi"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^TAU(i{1}?|[0-9]+?)$",
                                    unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                  m2ss, m3ss, m4ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                                 "TOLDi"))
  dependency_list[["TENDINF"]] <- list(parameter_label = c(),
                                       cdisc_label = c(), callfun = c(), regex = "^TENDINF$",
                                       unit_class = c(uclass_time), valid_models = c(m3sd),
                                       display_list_models = c(), predecessors = c("TMAX",
                                                                                   "DOF"))
  dependency_list[["TENDINFi"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^TENDINF(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_time), valid_models = c(m3ss),
                                        display_list_models = c(), predecessors = c("TAUi",
                                                                                    "TOLDi", "TMAXi", "DOF"))
  dependency_list[["THALF"]] <- list(parameter_label = c("THALF"),
                                     cdisc_label = c("LAMZHL"), callfun = c(), regex = "^THALF$",
                                     unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                   m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(m1sd,
                                                                                                                                                      m1ss, m2sd, m3sd, m3ss), predecessors = c("KEL"))
  dependency_list[["THALFF"]] <- list(parameter_label = c(),
                                      cdisc_label = c(), callfun = c(), regex = "^THALFF$",
                                      unit_class = c(uclass_ratio), valid_models = c(m1sd,
                                                                                     m1ss, m2sd, m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(),
                                      predecessors = c("THALF", "KELTMHI", "KELTMLO"))
  dependency_list[["TLAG"]] <- list(parameter_label = c("TLAG"),
                                    cdisc_label = c("TLAG"), callfun = c(), regex = "^TLAG$",
                                    unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                  m1ss, m4sd, m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["TLAST"]] <- list(parameter_label = c("TLAST"),
                                     cdisc_label = c("TLST"), callfun = c(), regex = "^TLAST$",
                                     unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                   m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m1sd,
                                                                                                                                          m1ss, m2sd, m3sd, m3ss), predecessors = c())
  dependency_list[["TLASTi"]] <- list(parameter_label = c("TLAST"),
                                      cdisc_label = c("TLST"), callfun = c(), regex = "^TLAST(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                    m2ss, m3ss), display_list_models = c(m1ss, m3ss),
                                      predecessors = c("TAUi", "TOLDi"))
  dependency_list[["TMAX"]] <- list(parameter_label = c("TMAX"),
                                    cdisc_label = c("TMAX"), callfun = c(), regex = "^TMAX$",
                                    unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                  m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(m1sd,
                                                                                                                                         m3sd), predecessors = c())
  dependency_list[["TMAXi"]] <- list(parameter_label = c("TMAX"),
                                     cdisc_label = c("TMAX"), callfun = c(), regex = "^TMAX(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                   m2ss, m3ss), display_list_models = c(m1ss, m3ss),
                                     predecessors = c("TAUi", "TOLDi"))
  dependency_list[["TMAXRATE"]] <- list(parameter_label = c(),
                                        cdisc_label = c(), callfun = c(), regex = "^TMAXRATE$",
                                        unit_class = c(uclass_time), valid_models = c(m4sd,
                                                                                      m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["TMAXRATEi"]] <- list(parameter_label = c(),
                                         cdisc_label = c(), callfun = c(), regex = "^TMAXRATE(i{1}?|[0-9]+?)$",
                                         unit_class = c(uclass_time), valid_models = c(m4ss),
                                         display_list_models = c(), predecessors = c("TAUi",
                                                                                     "TOLDi"))
  dependency_list[["TMIN"]] <- list(parameter_label = c("TMIN"),
                                    cdisc_label = c("TMIN"), callfun = c(), regex = "^TMIN$",
                                    unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                  m1ss, m2sd, m2ss, m3sd, m3ss), display_list_models = c(),
                                    predecessors = c())
  dependency_list[["TMINi"]] <- list(parameter_label = c("TMIN"),
                                     cdisc_label = c("TMIN"), callfun = c(), regex = "^TMIN(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                   m2ss, m3ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                            "TOLDi"))
  dependency_list[["TOLD"]] <- list(parameter_label = c(),
                                    cdisc_label = c(), callfun = c(), regex = "^TOLD(i{1}?|[0-9]+?)$",
                                    unit_class = c(uclass_time), valid_models = c(m1sd,
                                                                                  m2sd, m3sd), display_list_models = c(), predecessors = c())
  dependency_list[["TOLDi"]] <- list(parameter_label = c(),
                                     cdisc_label = c(), callfun = c(), regex = "^TOLD(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_time), valid_models = c(m1ss,
                                                                                   m2ss, m3ss, m4ss), display_list_models = c(), predecessors = c("TAUi",
                                                                                                                                                  "TOLDi"))
  dependency_list[["V0"]] <- list(parameter_label = c("V0"),
                                  cdisc_label = c(), callfun = c(), regex = "^V0$", unit_class = c(uclass_volume),
                                  valid_models = c(m2sd, m2ss), display_list_models = c(m2sd,
                                                                                        m2ss), predecessors = c("C0", "DOSEC", "DOSECi"))
  dependency_list[["VOLSUM"]] <- list(parameter_label = c("VOLSUM"),
                                      cdisc_label = c(), callfun = c(), regex = "^VOLSUM$",
                                      unit_class = c(uclass_volume), valid_models = c(m4sd,
                                                                                      m4ss), display_list_models = c(), predecessors = c())
  dependency_list[["VSSP"]] <- list(parameter_label = c("VSSP"),
                                    cdisc_label = c("VSSP"), callfun = c("vssp"), regex = "^VSSP$",
                                    unit_class = c(uclass_volume), valid_models = c(m2sd,
                                                                                    m3sd), display_list_models = c(m3sd), predecessors = c("CLP",
                                                                                                                                           "MRTIVIFP"))
  dependency_list[["VSSPi"]] <- list(parameter_label = c("VSSP"),
                                     cdisc_label = c("VSSP"), callfun = c("vssp"), regex = "^VSSP(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_volume), valid_models = c(m2ss,
                                                                                     m3ss), display_list_models = c(m3ss), predecessors = c("CLTAUi",
                                                                                                                                            "MRTIVIFPi", "TAUi", "TOLDi"))
  dependency_list[["VSSPW"]] <- list(parameter_label = c("VSSPW"),
                                     cdisc_label = c("VSSPW"), callfun = c("vsspw"), regex = "^VSSPW$",
                                     unit_class = c(uclass_volwnorm), valid_models = c(m2sd,
                                                                                       m3sd), display_list_models = c(m3sd), predecessors = c("VSSP"))
  dependency_list[["VSSPWi"]] <- list(parameter_label = c("VSSPW"),
                                      cdisc_label = c("VSSPW"), callfun = c("vsspw"), regex = "^VSSPW(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_volwnorm), valid_models = c(m2ss,
                                                                                        m3ss), display_list_models = c(m3ss), predecessors = c("VSSPi"))
  dependency_list[["VSSO"]] <- list(parameter_label = c("VSSO"),
                                    cdisc_label = c("VSSO"), callfun = c("vsso"), regex = "^VSSO$",
                                    unit_class = c(uclass_volume), valid_models = c(m2sd,
                                                                                    m3sd), display_list_models = c(), predecessors = c("CLO",
                                                                                                                                       "MRTIVIFO"))
  dependency_list[["VSSOW"]] <- list(parameter_label = c("VSSOW"),
                                     cdisc_label = c("VSSOW"), callfun = c("vssow"), regex = "^VSSOW$",
                                     unit_class = c(uclass_volwnorm), valid_models = c(m2sd,
                                                                                       m3sd), display_list_models = c(), predecessors = c("VSSO"))
  dependency_list[["VSSOi"]] <- list(parameter_label = c("VSSO"),
                                     cdisc_label = c("VSSO"), callfun = c("vsso"), regex = "^VSSO(i{1}?|[0-9]+?)$",
                                     unit_class = c(uclass_volume), valid_models = c(m2ss,
                                                                                     m3ss), display_list_models = c(), predecessors = c("CLTAUi",
                                                                                                                                        "MRTIVIFOi", "TAUi", "TOLDi"))
  dependency_list[["VSSOWi"]] <- list(parameter_label = c("VSSOW"),
                                      cdisc_label = c("VSSOW"), callfun = c("vssow"), regex = "^VSSOW(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_volwnorm), valid_models = c(m2ss,
                                                                                        m3ss), display_list_models = c(), predecessors = c("VSSOi"))
  dependency_list[["VZFO"]] <- list(parameter_label = c("VZFO"),
                                    cdisc_label = c("VZFO"), callfun = c(), regex = "^VZFO$",
                                    unit_class = c(uclass_volume), valid_models = c(m1sd),
                                    display_list_models = c(), predecessors = c("KEL", "AUCINFO",
                                                                                "DOSEC"))
  dependency_list[["VZFOW"]] <- list(parameter_label = c("VZFOW"),
                                     cdisc_label = c("VZFOW"), callfun = c(), regex = "^VZFOW$",
                                     unit_class = c(uclass_volwnorm), valid_models = c(m1sd),
                                     display_list_models = c(), predecessors = c("VZFO"))
  dependency_list[["VZFP"]] <- list(parameter_label = c("VZFP"),
                                    cdisc_label = c("VZFP"), callfun = c(), regex = "^VZFP$",
                                    unit_class = c(uclass_volume), valid_models = c(m1sd),
                                    display_list_models = c(m1sd, m1ss), predecessors = c("KEL",
                                                                                          "AUCINFP", "DOSEC"))
  dependency_list[["VZFPW"]] <- list(parameter_label = c("VZFPW"),
                                     cdisc_label = c("VZFPW"), callfun = c("VZFPW"), regex = "^VZFPW$",
                                     unit_class = c(uclass_volwnorm), valid_models = c(m1sd),
                                     display_list_models = c(), predecessors = c("VZFP"))
  dependency_list[["VZFTAUi"]] <- list(parameter_label = c("VZFTAU"),
                                       cdisc_label = c("VZFTAU"), callfun = c(), regex = "^VZFTAU(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_volume), valid_models = c(m1ss),
                                       display_list_models = c(), predecessors = c("KEL", "AUCTAUi",
                                                                                   "DOSECi", "TAUi", "TOLDi"))
  dependency_list[["VZFTAUWi"]] <- list(parameter_label = c("VZFTAUW"),
                                        cdisc_label = c("VZFTAUW"), callfun = c(), regex = "^VZFTAUW(i{1}?|[0-9]+?)$",
                                        unit_class = c(uclass_volwnorm), valid_models = c(m1ss),
                                        display_list_models = c(), predecessors = c("VZFTAUi",
                                                                                    "TAUi", "TOLDi"))
  dependency_list[["VZO"]] <- list(parameter_label = c("VZO"),
                                   cdisc_label = c("VZO"), callfun = c(), regex = "^VZO$",
                                   unit_class = c(uclass_volume), valid_models = c(m2sd,
                                                                                   m3sd), display_list_models = c(), predecessors = c("KEL",
                                                                                                                                      "AUCINFO", "DOSEC"))
  dependency_list[["VZOW"]] <- list(parameter_label = c("VZOW"),
                                    cdisc_label = c("VZOW"), callfun = c(), regex = "^VZOW$",
                                    unit_class = c(uclass_volwnorm), valid_models = c(m2sd,
                                                                                      m3sd), display_list_models = c(), predecessors = c("VZO"))
  dependency_list[["VZP"]] <- list(parameter_label = c("VZP"),
                                   cdisc_label = c("VZP"), callfun = c(), regex = "^VZP$",
                                   unit_class = c(uclass_volume), valid_models = c(m2sd,
                                                                                   m3sd), display_list_models = c(m2sd, m3sd), predecessors = c("KEL",
                                                                                                                                                "AUCINFP", "DOSEC"))
  dependency_list[["VZPW"]] <- list(parameter_label = c("VZPW"),
                                    cdisc_label = c("VZPW"), callfun = c(), regex = "^VZPW$",
                                    unit_class = c(uclass_volwnorm), valid_models = c(m2sd,
                                                                                      m3sd), display_list_models = c(), predecessors = c("VZP"))
  dependency_list[["VZTAUi"]] <- list(parameter_label = c("VZTAU"),
                                      cdisc_label = c("VZTAU"), callfun = c(), regex = "^VZTAU(i{1}?|[0-9]+?)$",
                                      unit_class = c(uclass_volume), valid_models = c(m2ss,
                                                                                      m3ss), display_list_models = c(), predecessors = c("KEL",
                                                                                                                                         "AUCTAUi", "DOSECi", "TAUi", "TOLDi"))
  dependency_list[["VZTAUWi"]] <- list(parameter_label = c("VZTAUW"),
                                       cdisc_label = c("VZTAUW"), callfun = c(), regex = "^VZTAUW(i{1}?|[0-9]+?)$",
                                       unit_class = c(uclass_volwnorm), valid_models = c(m2ss,
                                                                                         m3ss), display_list_models = c(), predecessors = c("VZTAUi",
                                                                                                                                            "TAUi", "TOLDi"))
  dependency_list[["FLGACCEPTPREDOSE"]] <- list(parameter_label = c(),
                                                cdisc_label = c(), callfun = c(), regex = "^FLGACCEPTPREDOSE$",
                                                unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                                   m2ss, m3sd, m3ss), display_list_models = c(), predecessors = c("CMAX",
                                                                                                                                                  "CMAXi"))
  dependency_list[["FLGACCEPTTMAX"]] <- list(parameter_label = c(),
                                             cdisc_label = c(), callfun = c(), regex = "^FLGACCEPTTMAX$",
                                             unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                                m2ss, m3sd, m3ss), display_list_models = c(), predecessors = c("TMAX",
                                                                                                                                               "TMAXi", "DOSE", "DOSEi"))
  dependency_list[["FLGACCEPTKEL"]] <- list(parameter_label = c(),
                                            cdisc_label = c(), callfun = c(), regex = "^FLGACCEPTKEL$",
                                            unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                               m2ss, m3sd, m3ss, m4sd, m4ss), display_list_models = c(),
                                            predecessors = c("KEL", "KELNOPT", "AUCXPCTO", "AUCXPCTP"))
  dependency_list[["FLGACCEPTTAU"]] <- list(parameter_label = c(),
                                            cdisc_label = c(), callfun = c(), regex = "^FLGACCEPTTAU$",
                                            unit_class = c(), valid_models = c(m1sd, m1ss, m2sd,
                                                                               m2ss, m3sd, m3ss), display_list_models = c(), predecessors = c("LASTTIME"))
  return(dependency_list)
}
