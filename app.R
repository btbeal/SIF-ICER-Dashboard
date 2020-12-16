source("components/homePage.R")

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(shinyBS)
library(highcharter)
library(tidyverse)

shinyApp(
    ui = dashboardPagePlus(
        tags$style(".well {background-color: #e6ccff ;}"),
        skin = "purple",
        header = dashboardHeaderPlus(
            title = tagList(
                span(class = "logo-lg", "Cost-Effectiveness of Supervised Injection Facilities"), 
                icon("capsules")),
            #title = "Cost-Effectiveness of Supervised Injection Facilities",
            titleWidth = 500
        ),
        sidebar = dashboardSidebar(
            sidebarMenu(
                menuItem(tabName = "mod", "Model"),
                menuItem(tabName = "intro", "About Us")

            )
        ),
        body = dashboardBody(
            tabItems(
                # --------------------------------------------------------------------------------------------- #
                # --------------------------------------- Begin Model # --------------------------------------- #
                # --------------------------------------------------------------------------------------------- #
                
                tabItem("mod",
                        fluidRow(
                            column(width = 12,
                                   shinydashboardPlus::boxPlus(
                                       width = 12,
                                       closable = TRUE,
                                       collapsible = FALSE,
                                       homePageUI)),
                            column(width = 12,
                                   uiOutput(outputId = "icer_val")
                            ),
                            column(width = 4, 
                                   # ----  City Characteristics ---- #
                                   
                                   shinydashboardPlus::boxPlus(
                                       title = "City Characteristics", 
                                       closable = TRUE, 
                                       width = 12,
                                       solidHeader = TRUE, 
                                       collapsible = TRUE,
                                       collapsed = TRUE,
                                       enable_dropdown = TRUE,
                                       wellPanel(
                                           "City Characteristics",
                                           autonumericInput(
                                               label = "Number of PWID within city limits",
                                               inputId = "pwid",
                                               minimumValue = 0,
                                               value =29500
                                           ),
                                           autonumericInput(
                                               label = "Cost of living ratio (compared to Vancouver, BC)",
                                               inputId = "col",
                                               minimumValue = 0,
                                               value = 1.24
                                           ),
                                           autonumericInput(
                                               label = "Population Density",
                                               inputId = "popd",
                                               minimumValue = 0,
                                               value = 13943,
                                               currencySymbol = " people/sq. mi.",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Commercial property value",
                                               inputId = "propv",
                                               minimumValue = 0,
                                               value = 550,
                                               currencySymbol = " $/sq. ft.",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Commercial mortgage loan rates",
                                               inputId = "loans",
                                               minimumValue = 0,
                                               value = 7, # Needs dividing by 100
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           )
                                       )
                                   ),
                                   
                                   # ----  Primary Outcomes ---- #
                                   
                                   shinydashboardPlus::boxPlus(
                                       width = 12,
                                       title = "Primary outcomes", 
                                       closable = TRUE,
                                       solidHeader = TRUE, 
                                       collapsible = TRUE,
                                       collapsed = TRUE,
                                       enable_dropdown = TRUE,
                                       wellPanel(
                                           "Overdose Mortality Metrics",
                                           autonumericInput(
                                               label = "Mortality reduction within 0.25 miles of SIF",
                                               inputId = "odm_redx_in",
                                               minimumValue = 0,
                                               value = 35, # Needs dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Reduction beyond 0.25 miles of SIF",
                                               inputId = "odm_redx_out",
                                               minimumValue = 0,
                                               value = 9.3, # Needs dividing  by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Ppn. of city OD deaths within 0.25 miles of SIF",
                                               inputId = "ppn_odd_sif",
                                               minimumValue = 0,
                                               value = 5, # Needs dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           )
                                       ),   # End "Overdose Metrics" well
                                       wellPanel(
                                           "Overdose Deaths Per Year",
                                           autonumericInput(
                                               label = "Number of overdose deaths per year in your municipality",
                                               inputId = "odd",
                                               minimumValue = 0,
                                               value = 250                                           )
                                       ), # End "Overdose Deaths per Year"
                                       wellPanel(
                                           "SIF Injection Metrics",
                                           autonumericInput(
                                               label = "Total annual injections in the SIF",
                                               inputId = "injs_sif",
                                               minimumValue = 0,
                                               value = 180000
                                           ),
                                           autonumericInput(
                                               label = "Number of unique SIF clients/month",
                                               inputId = "clients_sif",
                                               minimumValue = 0,
                                               value = 2100
                                            ),
                                           autonumericInput(
                                               label = "Percent of injections at SIF resulting in and overdose",
                                               inputId = "ods_sif",
                                               minimumValue = 0,
                                               value = 0.95, # Needs dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           )
                                       ), # End "SIF Injection Metrics"
                                       wellPanel(
                                           "Emergency Services Metrics",
                                           autonumericInput(
                                               label = "Ppn. of SIF ODs resulting in an ambulance",
                                               inputId = "amb_sif",
                                               minimumValue = 0,
                                               value = 0.79, # needs dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Ppn. of SIF ODs resulting in ED visit",
                                               inputId = "ed_sif",
                                               minimumValue = 0,
                                               value = 0.79, # needss dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Ppn. of No SIF ODs resulting in ambulance",
                                               inputId = "amb_nosif",
                                               minimumValue = 0,
                                               value = 46, # Needs dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Ppn. of No SIF ODs resulting in ED visit",
                                               inputId = "ed_nosif",
                                               minimumValue = 0,
                                               value = 33, # Needs dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Ppn. of No SIF ODs resulting in ambulance",
                                               inputId = "hosp_post_ed",
                                               minimumValue = 0,
                                               value = 48, # Need dividing by 100
                                               maximumValue = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           )
                                       ) # End "Emergency Services Metrics"
                                   ),
                                   
                                   
                                   
                                   # ---- Costs  ---- #
                                   shinydashboardPlus::boxPlus(
                                       title = "Costs", 
                                       closable = TRUE, 
                                       width = 12,
                                       solidHeader = TRUE, 
                                       collapsible = TRUE,
                                       collapsed = TRUE,
                                       enable_dropdown = TRUE,
                                       wellPanel(
                                           "Fixed Costs",
                                           autonumericInput(
                                               label = "Insite Annual Operating Cost",
                                               inputId = "opercost_insite",
                                               minimumValue = 0,
                                               value = 1687286,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           ),
                                           autonumericInput(
                                               label = "Term of Commercial Loans",
                                               inputId = "loan_term",
                                               minimumValue = 0,
                                               value = 15,
                                               decimalPlaces = 1,
                                               currencySymbol = " years",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "SIF square footage",
                                               inputId = "sif_sqft",
                                               minimumValue = 0,
                                               value = 1000,
                                               decimalPlaces = 1,
                                               currencySymbol = " sq. ft.",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "First Year SSP Cost",
                                               inputId = "cost_ssp",
                                               minimumValue = 0,
                                               value = 1641277, # This number based on additional math 
                                               decimalPlaces = 2,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           )
                                           
                                           # ---- May need to consider the Naloxone trt cost here.
                                       ),
                                       wellPanel(
                                           "Variable Costs",
                                           autonumericInput(
                                               label = "Ambulance ride",
                                               inputId = "cost_amb",
                                               minimumValue = 0,
                                               value = 523,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           ),
                                           autonumericInput(
                                               label = "Emergency dept visit",
                                               inputId = "cost_ed",
                                               minimumValue = 0,
                                               value = 3451,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           ),
                                           autonumericInput(
                                               label = "Hospitalizations",
                                               inputId = "cost_hosp",
                                               minimumValue = 0,
                                               value = 8379,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           )
                                       ) # End "Variable Cost" well
                                   ), # End "Cost" box
                                   
                                   
                                   # ----  Scenario Analysis ---- #
                                   
                                   shinydashboardPlus::boxPlus(
                                       title = "Scenario Analysis Parameters", 
                                       closable = TRUE, 
                                       width = 12,
                                       solidHeader = TRUE, 
                                       collapsible = TRUE,
                                       collapsed = TRUE,
                                       enable_dropdown = TRUE,
                                       wellPanel(
                                           "HIV/HCV Infection Reduction Metrics",
                                           autonumericInput(
                                               label = "Odds Ratio: SIF reduction in needle sharing",
                                               inputId = "or_need_redx",
                                               minimumValue = 0,
                                               value = 0.30
                                           ),
                                           autonumericInput(
                                               label = "Prob. of HIV infection from single injection",
                                               inputId = "inf_hiv_prob",
                                               minimumValue = 0,
                                               value = 0.67, # Needs dividing by 100
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s",
                                               maximumValue = 100
                                           ),
                                           autonumericInput(
                                               label = "Prob. of HCV infection from single injection",
                                               inputId = "inf_hcv_prop",
                                               minimumValue = 0,
                                               value = 3, # Needs dividing by 100
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s",
                                               maximumValue = 100
                                           ),
                                           autonumericInput(
                                               label = "Needle sharing rate",
                                               inputId = "inf_sharing",
                                               minimumValue = 0,
                                               value = 0.011,
                                               decimalPlaces = 4,
                                               maximumValue = 100
                                           ),
                                           autonumericInput(
                                               label = "Ppn. unbleached needles",
                                               inputId = "inf_unbleached",
                                               minimumValue = 0,
                                               maximumValue = 100, # needs to divide by 100
                                               value = 100,
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s",
                                           ),
                                           autonumericInput(
                                               label = "Number of nedle sharing partners",
                                               inputId = "inf_n_partners",
                                               minimumValue = 0,
                                               value = 1.69,
                                               currencySymbol = " partners",
                                               currencySymbolPlacement = "s"
                                           )),
                                       wellPanel(
                                           "Population Parameters",
                                           autonumericInput(
                                               label = "Ppn. of PWID who are HIV positive",
                                               inputId = "inf_hiv",
                                               minimumValue = 0,
                                               value = 17, # This value is 0.17 in excel (need to div by 100 in input)
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Ppn. of PWID who are HCV positive",
                                               inputId = "inf_hcv",
                                               minimumValue = 0,
                                               value = 25, # This value is 0.25 in excel (need to div by 100 in input)
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Number of needles in circulation",
                                               inputId = "inf_needles",
                                               minimumValue = 0,
                                               value = 2806017,
                                           )
                                       ),
                                       wellPanel(
                                           "Infection Treatment Costs",
                                           autonumericInput(
                                               label = "Cost of 1 year HIV treatment",
                                               inputId = "cost_hiv",
                                               minimumValue = 0,
                                               value = 0,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           ),
                                           autonumericInput(
                                               label = "Cost of 1 year HCV treatment",
                                               inputId = "cost_hcv",
                                               minimumValue = 0,
                                               value = 0,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           ),
                                           autonumericInput(
                                               label = "Avg. hospital cost per day (C)",
                                               inputId = "cost_hosp2",
                                               minimumValue = 0,
                                               value = 0,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           )
                                       ),
                                       wellPanel(
                                           "Medicaation-Assisted Treatment",
                                           autonumericInput(
                                               label = "Ppn. SIF Users who access MAT",
                                               inputId = "mat_uptake_sif",
                                               minimumValue = 0,
                                               value = 5.78, # Needs dividing by 100
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Ppn. Non-SIF Users who access MAT",
                                               inputId = "mat_uptake_nosif",
                                               minimumValue = 0,
                                               value = 5.78, # Needs dividing by 100
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Treatment retention factor at SIF",
                                               inputId = "mat_success_sif",
                                               minimumValue = 0,
                                               value = 50, # Needs dividing by 100
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Treatment retention factor at SIF",
                                               inputId = "mat_success_nosif",
                                               minimumValue = 0,
                                               value = 50, # Needs dividing by 100
                                               currencySymbol = "%",
                                               currencySymbolPlacement = "s"
                                           ),
                                           autonumericInput(
                                               label = "Cost of MAT",
                                               inputId = "mat_cost",
                                               minimumValue = 0,
                                               value = 0,
                                               currencySymbol = "$",
                                               currencySymbolPlacement = "p"
                                           )
                                       )# End "Medication-Assisted Treatment",
                                   ) # End Third Box
                                   
                            ), # End column width = 4
                        column(width = 8,
                               shinydashboardPlus::boxPlus(
                                   width = 12,
                                   title = "Costs",
                                   solidHeader = TRUE,
                                   dropdown_icon = "fa fa-usd",
                                   collapsible = TRUE,
                                   status = "success",
                                   highchartOutput(outputId = "cost_chart"),
                                   footer = 
                                       actionBttn(
                                           inputId = "action",
                                           label = "Update Costs", 
                                           style = "minimal",
                                           color = "success"
                                                   )
                                               ),
                              shinydashboardPlus::boxPlus(
                                   width = 12,
                                   title = "Resource Utilization",
                                   solidHeader = TRUE,
                                   status = "success",
                                   icon = "fa fa-user-md",
                                   collapsible = TRUE,
                                   highchartOutput(outputId = "utilization_chart"),
                                   footer = 
                                       actionBttn(
                                           inputId = "action_utilization",
                                           label = "Update Utilization", 
                                           style = "minimal",
                                           color = "success"
                                       )
                               )
                        ) # End column width = 8
                    )
                ), # end tabItem
                # --------------------------------------------------------------------------------------------- #
                # --------------------------------------- Begin Intro # --------------------------------------- #
                # --------------------------------------------------------------------------------------------- #
                
                tabItem("intro",
                         widgetUserBox(
                            title = "Ryan Hansen",
                            subtitle = HTML("Assistant Professor, <br>Comparative Health Outcomes, Policy, and Economics (CHOICE) Institute, <br> Model Lead"),
                            type = 2,
                            width = 12,
                            src = "Hansen.png",
                            collapsed = TRUE,
                            closable = TRUE,
                            HTML("Dr. Hansen is research assistant professor of pharmacy. His primary research interests focus on the comparative safety of prescription medications, health technology assessment, and health care system efficiency. He received his Bachelor of Arts from Carroll College, and his Doctor of Pharmacy and Doctor of Philosophy from the University of Washington.<br><br>
                            Hansen is a fellow in the American College of Apothecaries, and a member of the International Society for Pharmacoeconomics and Outcomes Research and the Washington State Pharmacy Association. He was also an Agency for Healthcare Research and Quality/UW K12 Patient Centered Outcomes Research Scholar, an ARCS Foundation Scholar, and was selected as a Distinguished Alumnus of the UW School of Pharmacy. 
                                          Hansen has served as a journal referee for “JAMA Internal Medicine,” “Pediatrics,” “Value in Health,” and “The Journal of Pain.” He is also an active pharmacy practitioner in a community practice setting. In this role, he applies his research skills in order to improve the practice of pharmacy."),
                            
                            footer = shinydashboardPlus::socialButton(
                                url = "https://www.linkedin.com/in/pharmacyryanhansen/",
                                type = "linkedin"
                            )
                        ),
                        widgetUserBox(
                            title = "Greg Guzauskas",
                            subtitle =  HTML("Research Scientist, <br>Comparative Health Outcomes, Policy, and Economics (CHOICE) Institute, <br> Model Lead"),
                            type = 2,
                            width = 12,
                            src = "Guzauskas.png",
                            color = "gray",
                            collapsed = TRUE,
                            closable = TRUE,
                            HTML("Dr. Guzauskas is a health economist at the Comparative Health Outcomes, Policy, and Economics (CHOICE) Institute at the University of Washington in Seattle and also the senior health economist leading the U.S. operations branch for HCD Economics. He has been a lead and/or co-author on multiple health economic models and related publications, 
                                 including reports by the Institute for Clinical and Economic Review (ICER) on topics such as NSCLC, osteoporosis, hemophilia A, prostate cancer, peanut allergy, and NASH. Guzauskas is an accomplished decision modeler with proficiency in budget impact analyses, cost-effectiveness analyses including Markov, partitioned survival, and microsimulation models, and advanced value of information (VOI) modeling."),
                            footer = 
                            shinydashboardPlus::socialButton(
                                url = "https://www.linkedin.com/in/greg-guzauskas-msph-phd/",
                                type = "linkedin"
                            )
                        ),
                        widgetUserBox(
                            title = "Brennan Beal",
                            subtitle = HTML("Post-doctoral Fellow, <br>Comparative Health Outcomes, Policy, and Economics (CHOICE) Institute, <br> Dashboard Designer"),
                            type = 2,
                            width = 12,
                            src = "Beal.png",
                            color = "purple",
                            collapsed = TRUE,
                            closable = TRUE,
                            HTML("Brennan is a second-year postdoctoral fellow at the Comparative Health Outcomes, Policy, and Economics (CHOICE) Institute. 
                                 He specializes in cost-effectiveness modeling, healthcare resource utilization, and all things R!"),
                            footer = list(shinydashboardPlus::socialButton(
                                url = "https://github.com/btbeal",
                                type = "github"
                            ),
                            shinydashboardPlus::socialButton(
                                url = "https://www.linkedin.com/in/btbeal/",
                                type = "linkedin"
                            ))
                        )
                )
            ) # Close tabItems
        ) #close dashboard body
        ), # close dashboard page plus),

     server = function(input, output, session) {
         
         
         

         
         data_list <- reactive({
             
             # ----------------- Utilization ----------------- #
             
             # od within 0.25 mi
             # ---- these are the same (no facility in the "nosif" scenario)
             nosif_od_within <- input$injs_sif*(input$ods_sif/100)
             sif_od_within <- input$injs_sif*(input$ods_sif/100)
             
             #odd deaths within 0.25 miles
             nosif_odd <- input$odd*(input$ppn_odd_sif/100)
             sif_odd <- nosif_odd-((input$odm_redx_in/100)-(input$odm_redx_out/100))*(input$ppn_odd_sif/100)*input$odd
             
             # amb rides
             nosif_amb <- nosif_od_within*(input$amb_nosif/100)
             sif_amb <- sif_od_within*(input$amb_sif/100)
             
             # ed
             nosif_ed <- nosif_od_within*(input$ed_nosif/100)
             sif_ed <- sif_od_within*(input$ed_sif/100)
             
             # hospitalizations
             nosif_hosp <- nosif_ed*(input$hosp_post_ed/100)
             sif_hosp <- sif_ed*(input$hosp_post_ed/100)
             
             # hiv cases
             nosif_hiv_cases <- (1-(input$inf_hiv/100))*input$inf_needles*input$inf_sharing*(input$inf_unbleached/100)*(1-(1-(input$inf_hiv/100)*(input$inf_hiv_prob/100))^input$inf_n_partners)
             sif_hiv_cases   <- nosif_hiv_cases*((input$pwid-input$clients_sif)+(1-(1-input$or_need_redx))*input$clients_sif)/input$pwid
             
             #HCV Cases
             nosif_hcv_cases <- (1-(input$inf_hcv/100))*input$inf_needles*input$inf_sharing*(input$inf_unbleached/100)*(1-(1-(input$inf_hcv/100)*(input$inf_hcv_prop/100))^input$inf_n_partners)
             sif_hcv_cases   <- nosif_hcv_cases*((input$pwid-input$clients_sif)+(1-(1-input$or_need_redx))*input$clients_sif)/input$pwid
             
             #mat uptake
             nosif_mat_uptake <- input$clients_sif*(input$mat_uptake_nosif/100)
             sif_mat_uptake   <- input$clients_sif*(input$mat_uptake_sif/100)
             
             #mat success
             nosif_mat_success <- (input$mat_success_nosif/100)*nosif_mat_uptake
             sif_mat_success   <- (input$mat_success_sif/100)*sif_mat_uptake
             
             utilization_components <- c("mat_success", "mat_uptake", "hcv", "hiv", "hospital", "ED", "ambulance", "odd", "od_within")
             
             utilization_frame <- data.frame(
                 intervention = rep(c("SIF + SSP", "SSP"), 9), # Repeat the intervention alternating as they're entered below
                 utilization = c(
                          sif_mat_success, nosif_mat_success, # MAT success
                          sif_mat_uptake, nosif_mat_uptake, # MAT uptake
                          sif_hcv_cases, nosif_hcv_cases, # HCV Costs
                          sif_hiv_cases, nosif_hiv_cases, # HIV Costs
                          sif_hosp, nosif_hosp, # HOSP
                          sif_ed, nosif_ed, # ED
                          sif_amb, nosif_amb, # AMB
                          sif_odd, nosif_odd, # Overdose Deaths
                          sif_od_within, nosif_od_within # Overdose within 0.25
                 ),
                 utilization_type = c(
                     unlist(lapply(utilization_components, function(x){rep(x, 2)}))
                 )
             )
             # ----------------- COSTS ----------------- #
             # Upfront Loan
             nosif_upfront_loan <- 0
             sif_upfront_loan <- input$propv*input$sif_sqft
             # annual payment
             nosif_loan_annual <- 0
             sif_loan_annual <- ((input$loans/100)*sif_upfront_loan)/(1-(1+(input$loans)/100)^(-input$loan_term))
             
             # Operating Costs
             nosif_op_cost <- 0
             sif_op_cost <- input$opercost_insite*input$col
             
             # Annual Cost
             sif_annual_cost <- sif_op_cost+sif_loan_annual
             nosif_annual_cost <- input$cost_ssp
             
             # Ambulance Costs
             nosif_amb_cost <- nosif_amb*input$cost_amb 
             sif_amb_cost <- sif_amb*input$cost_amb
             
             # ED Visit Costs
             nosif_ed_cost <- nosif_ed*input$cost_ed
             sif_ed_cost <- sif_ed*input$cost_ed
             
             # Hospitalization Costs
             nosif_hosp_cost <- nosif_hosp*input$cost_hosp
             sif_hosp_cost <- sif_hosp*input$cost_hosp
             
             # HIV cost
             nosif_hiv_cost <- nosif_hiv_cases*input$cost_hiv
             sif_hiv_cost <- sif_hiv_cases*input$cost_hiv
             
             # HCV cost
             nosif_hcv_cost <- nosif_hcv_cases*input$cost_hcv
             sif_hcv_cost <- sif_hcv_cases*input$cost_hcv
             
             # MAT cost
             nosif_mat_cost <- nosif_mat_uptake*input$mat_cost
             sif_mat_cost <- sif_mat_uptake*input$mat_cost
             
             # TOTAL COSTS
             nosif_total_cost <- nosif_mat_cost + nosif_hcv_cost + nosif_hiv_cost + nosif_hosp_cost + nosif_ed_cost + nosif_amb_cost + nosif_annual_cost
             sif_total_cost <- sif_mat_cost + sif_hcv_cost + sif_hiv_cost + sif_hosp_cost + sif_ed_cost + sif_amb_cost + sif_annual_cost
             
             
             cost_components <- c("total", "mat", "hcv", "hiv", "hospital", "ED", "ambulance", "facility_cost", "operating_costs", "annual_loan", "upfront_loan")
             cost_frame <- data.frame(
                 intervention = rep(c("SIF + SSP", "SSP"), 11), # Repeat the intervention alternating as they're entered below
                 cost = c(
                     sif_total_cost, nosif_total_cost, # TOTAL COSTS
                     sif_mat_cost, nosif_mat_cost, # MAT Costs
                     sif_hcv_cost, nosif_hcv_cost, # HCV Costs
                     sif_hiv_cost, nosif_hiv_cost, # HIV Costs
                     sif_hosp_cost, nosif_hosp_cost, # HOSP Costs
                     sif_ed_cost, nosif_ed_cost, # ED Costs
                     sif_amb_cost, nosif_amb_cost, # AMB Costs
                     sif_annual_cost, nosif_annual_cost, # Annual Costs
                     sif_op_cost, nosif_op_cost, # Operating Costs
                     sif_loan_annual, nosif_loan_annual, # Annual Loan
                     sif_upfront_loan, nosif_upfront_loan # Upfront Loan
                 ),
                 cost_type = c(
                     unlist(lapply(cost_components, function(x){rep(x, 2)}))
                 )
             )
            
             
             
             return(list(cost_frame, utilization_frame))
             
             
         })
         
         
         
         
         
         
         # --------------------------------------------------------------------------------- #
         # --------------------------------------------------------------------------------- #
         # -----------------  Utilization ChartJS & Incremental Cost Box ------------------- #
         # --------------------------------------------------------------------------------- #
         # --------------------------------------------------------------------------------- #
         observeEvent(input$action, {
             c_data <- data_list()[[1]]
             u_data <- data_list()[[2]]
             
             # Calculating cost savings and turning to text
             inc_cost <- c_data$cost[c_data$cost_type == 'total' & c_data$intervention == "SSP"] -
                 c_data$cost[c_data$cost_type == 'total' & c_data$intervention == 'SIF + SSP']
             incremental_cost <- paste0("$", formatC(as.numeric(inc_cost), format="f", digits=2, big.mark=","))
             # -- Color
             if(inc_cost < 0){
                 c_color <- "red"
             } else {
                 c_color <- "green"
             }
             
             
             # Overdoses deaths
             death_avoided <- u_data$utilization[u_data$utilization_type == 'odd' & u_data$intervention == "SSP"] -
                 u_data$utilization[u_data$utilization_type == 'odd' & u_data$intervention == "SIF + SSP"]
             de_avoided <- as.character(round(death_avoided))
             # -- color
             if(death_avoided < 0){
                 u_color <- "red"
             } else {
                 u_color <- "green"
             }
             

             output$cost_chart <- renderHighchart({
                 
                 highchart() %>% 
                     # Data
                     hc_add_series(
                         c_data %>% filter(cost_type %in% c("mat", "hcv", "hiv", "hospital", "ED", "ambulance", "facility_cost")), 
                         "column",
                         hcaes(
                             x = 'intervention',
                             y = "cost",
                             group = 'cost_type'
                         ),
                         name = c("Ambulance Cost", "ED Visit Cost", "Facility Cost", "HCV Inf.", "HIV Inf.", "Hospital Visit Cost", "MAT Cost")
                    ) %>%
                     hc_yAxis(
                             labels = list(
                                 formatter = JS(paste0(
                                     "function() {
                                     return '$' + this.value / 1000000 + 'M';}"
                                 )) 
                             )
                     ) %>% 
                     hc_xAxis(
                         categories = c_data$intervention
                     ) %>% 
                     hc_plotOptions(column = list(stacking = "normal")) %>% 
                     hc_tooltip(
                         valueDecimals = 2,
                         valuePrefix = '$',
                         valueSuffix = ' USD'
                     ) %>% 
                     hc_title(
                         text = "Annual Cost of SIF vs. SIF + SSP Program",
                         align = "left"
                     ) %>% 
                     hc_caption(
                         text = 
                         '<b>Instructions</b> Hover over each cost component to view the annual contribution. If one wishes to compare
                         individual components in isolation, they may click off each unwanted item in the legend.</br>
                         <b>Abbreviations</b> ED: emergency department; HIV: human immunodeficiency virus;
                         HCV: hepatitis C virus; Inf.: infection; MAT: medication assisted treatment;
                         SIF: supervised injection facility; 
                         SSP: syringe services program.</br>
                         <b>Notes</b> Facility Costs are comprised of annual operating costs and the annual loan payment.',
                         useHTML = TRUE
                     ) %>% 
                     hc_add_theme(hc_theme_flat()) %>% 
                     hc_chart(backgroundColor = 'transparent')
             })
             
             
             
              #----------- ICER Output BOX ---------- # (not there are no real effectiveness denominators here)
             output$icer_val <- renderUI({

                shinydashboard::box(
                     solidHeader = FALSE,
                     title = "Summary",
                     background = NULL,
                     width = 12,
                     status = "success",
                     footer = fluidRow(
                         column(
                             width = 6,
                             descriptionBlock(
                                 number = incremental_cost,
                                 numberColor = c_color,
                                 text = "INCREMENTAL SAVINGS"
                             )
                         ),
                         column(
                             width = 6,
                             descriptionBlock(
                                 number = de_avoided, 
                                 numberColor = u_color, 
                                 text = "DEATHS AVOIDED WITHIN 0.25 Mi OF SIF", 
                                 rightBorder = FALSE
                             )
                         )
                     )
                 ) 
                 })
             
             
             
             
         }, ignoreNULL = FALSE)
         
         
         
         
         # ---------------------------------------------------------- #
         # ---------------------------------------------------------- #
         # -----------------  Utilization ChartJS ------------------- #
         # ---------------------------------------------------------- #
         # ---------------------------------------------------------- #
         observeEvent(input$action_utilization, {
             u_data <- data_list()[[2]]
             output$utilization_chart <- renderHighchart({
                 
                 highchart() %>% 
                     # Data
                     hc_add_series(
                         u_data, 
                         "column",
                         hcaes(
                             x = 'intervention',
                             y = 'utilization',
                             group = 'utilization_type'
                         ),
                         name = c("Ambulance Trips",
                                  "ED Visits",
                                  "HCV Cases",
                                  "HIV Cases",
                                  "Hospital Visits",
                                  "MAT Successes",
                                  "MAT Uptake",
                                  "OD Within 0.25 Miles of Facility",
                                  "OD Deaths")
                     ) %>% 
                     hc_xAxis(
                         categories = u_data$intervention
                     ) %>% 
                     hc_title(text = "Annual Resource Utilization of SIF vs SIF + SSP",
                              align = "left") %>%
                     hc_caption(
                         text = '<b>Instructions</b> Hover over each component to view the annual contribution. If one wishes to compare
                         individual components in isolation, they may click off each unwanted item in the legend.</br>
                         <b>Abbreviations</b> ED: emergency department; HIV: human immunodeficiency virus;
                         HCV: hepatitis C virus; Inf.: infection; MAT: medication assisted treatment; OD: overdoses;
                         SIF: supervised injection facility; 
                         SSP: syringe services program.</br>',
                         useHTML = TRUE
                     ) %>% 
                     hc_add_theme(hc_theme_flat()) %>% 
                     hc_chart(backgroundColor = 'transparent')
             })
             
             
         }, ignoreNULL = FALSE)

         
         
         
         
         
         
     }
)