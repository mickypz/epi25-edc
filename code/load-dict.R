# Load data dictionaries
dict_col_names <- c("field_name", "form_name", "section_header", "field_type", "field_label", "select_choices_or_calculations", "field_note", "text_validation_type_or_show_slider_number", "text_validation_min", "text_validation_max", "identifier", "branching_logic", "required_field", "custom_alignment", "question_number", "matrix_group_name", "matrix_ranking", "field_annotation")

fp <- here("DataDictionaries")

# Focal
dict_focal <-read_csv(file = here(fp,  "Epi25Focal.csv"), 
                      col_types = c("ccccccccddcccciccc"))|> 
  set_names(dict_col_names)
