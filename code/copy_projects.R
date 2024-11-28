# create copies of REDCap projects using API calls
# operation requires Super API Token
source("config.R")

focal_to_copy_token <- focal_token_prod
super_token_conn <- redcapConnection(url = "https://redcap.uni.lu/redcap/api/",
                                     token = super_token)

copy_conn <- redcapConnection(url = "https://redcap.uni.lu/redcap/api/",
                               token = focal_to_copy_token)

xml_temp <- tempfile(file.ext = ".xml")

# export metadata with data and without users
exportProjectXml(copy_conn,
                 # metadata with the data, contra intuitive but this takes the data too
                 return_metadata_only = TRUE,
                 file = xml_temp)

# needs in text format to import
xml_text <- paste0(read_lines(xml_temp),
                   collapse = " ")

# create a project and import metadata
# needs all the arguments present, else it doesn't work
createRedcapProject(super_token_conn,
                    project_title = "Copy of Epi25 Focal",
                    purpose = "Quality Improvement",
                    is_longitudinal = FALSE,
                    surveys_enabled = FALSE,
                    # metadata to import
                    xml = xml_text)