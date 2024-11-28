super_token_conn <- redcapConnection(url = "https://luxparktest.lcsb.uni.lu/redcap/api/",
                                     token = "7161CE2A8FA521383A8FDEB0D520D01ADBC67E9A440232FA3AEBF94C9C3A4AD5")

copy_conn <- redcapConnection(url = "https://luxparktest.lcsb.uni.lu/redcap/api/",
                              token = "C0CBA0A7F8F7277E8CF2F4D9E2144738")

xml_temp <- tempfile(fileext = ".xml")

exportProjectXml(copy_conn,
                 # metadata with the data 
                 return_metadata_only = TRUE,
                # file = xml_temp)
                file = "xmp_file.xml")

xml_text <- paste0(read_lines("xmp_file.xml"),
                   collapse = " ")


createRedcapProject(super_token_conn,
                    project_title = "Copy of Epi25 Focal",
                   purpose = "Quality Improvement",
                   is_longitudinal = FALSE,
                   surveys_enabled = FALSE,
                    # metadata to import
                    xml = xml_text)
