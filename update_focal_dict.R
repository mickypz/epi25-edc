# new dict for focal 
# the change- neuroimaging_findings includes 109 Encephalocele and 153 Gliomas 
neuroimaging_update <- tibble(field_name = "neuroimaging_findings",
                              select_choices_or_calculations = c("1, Normal | 2, Nonspecific abnormality, please specify | 3, Hippocampal sclerosis | 100, Malformation: Focal Cortical Dysplasia | 101, Malformation: Heterotopia | 102, Malformation: Peri-ventricular nodular heterotopia | 103, Malformation: Polymicrogyria | 104, Malformation: Lissencephaly | 105, Malformation: Double Cortex | 106, Malformation: Hypothalamic Hamartoma | 107, Malformation: Hemimegaencephaly | 108, Malformation: Schizencephaly | 109, Encephalocele | 150, Benign Tumor: DNET | 151, Benign Tumor: Ganglioglioma | 152, Benign Tumor: unknown | 153, Gliomas | 160, Traumatic Brain Injury | 170, Vascular and/or ischemic abnormalities: ischemic stroke | 171, Vascular and/or ischemic abnormalities: hypoxic ischemic injury | 172, Vascular and/or ischemic abnormalities: hemorrhage | 173, Vascular and/or ischemic abnormalities: cerebral angioma | 996, Other, please specify | 998, Unknown"))

dict_focal_new <- dict_focal |>
  left_join(neuroimaging_update,
            by = "field_name",
            suffix = c("_old", "_new")) |>
  mutate(
    select_choices_or_calculations = coalesce(
      select_choices_or_calculations_new,
      select_choices_or_calculations_old
    ),
    .after = field_label
  ) |>
  select(!ends_with("old") & !ends_with("_new"))

# WARN: to be done only once since it will replace the dictionary that is used as the starting point for the code
# if this is unwanted - rename the file
## write_csv(dict_focal_new, "DataDictionaries/Epi25Focal.csv")