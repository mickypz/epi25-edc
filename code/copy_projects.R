# create copies of REDCap projects using API calls
# operation requires Super API Token
source("config.R")

focal_to_copy_token <- focal_token_prod
super_token_conn <- redcapConnection(url = "https://redcap.uni.lu/redcap/api/",
                                     token = super_token)

copy_conn <- redcapConnection(url = "https://redcap.uni.lu/redcap/api/",
                               token = focal_to_copy_token)

xml_temp <- tempfile(file.ext = ".xml")
exportProjectXml(copy_conn,
                 # metadata with the data 
                 return_metadata_only = FALSE,
                 file = xml_temp)

xml_text <- paste0(read_lines(xml_temp),
                   collapse = " ")

createRedcapProject(super_token_conn,
                    project_title = "Copy of Epi25 Focal",
                    # metadata to import
                    xml = xml_text)