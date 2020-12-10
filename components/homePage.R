homePageUI <- 
  bootstrapPage(
      h2("Cost Effectiveness of Safe Injection Site Facilities (SIF)"),
      h3("presented by The CHOICE Institute"),
      hr(),
      fluidRow(
        column(9, 
        p("The primary aim of this analysis will be to estimate the cost-effectiveness of SIFs for injection drug use (IDU) among PWID using a cost-effectiveness analysis. 
        The model will compare SIFs to syringe services programs (SSPs), which provide a multi-day or multi-week supply of clean needles and syringes to PWID either freely or as exchanges for contaminated products. 
        Because SIFs are not funded by the health care system or payers of health care, the base-case analysis will take a modified societal perspective and a one-year time horizon. 
          We will also consider a health care payer perspective as a scenario analysis."),
        p("The model will focus on a community of PWID, specified by parameters for individual U.S. cities, 
        who could potentially utilize SIFs in locations where SSPs already exist, i.e., 
        based on clinical data and observations in prior published economic models. 
        The model will not track a single PWID cohort over time; rather, a population of PWID within a given community will be generated based on available data for each location and then outcomes for each community will be calculated per year. 
        The costs and outcomes will be summed over the one-year time horizon. We plan to model up to six different U.S. cities, based on local parameters, 
          in order to develop a tool that may be customized to provide cost effectiveness estimates for any U.S. city given the appropriate data."),
        p("PWID within a given community enter the model in either the SIF+SSP or SSP-only arm. Among the total population of PWID, the proportion of injections/month associated with each comparator will be calculated (A); the remainder of injections are assumed to occur without utilization of the SIF/SSP (B). 
        Given the proportions of injections utilizing and not utilizing each comparator, conditional probabilities will be used to calculate proportions of (A1) PWID who overdose, and (A2) PWID who are on or (A3) not on medication-assisted treatment (MAT). 
        Among PWID who are already on MAT, we will calculate the proportion per year who successfully stop IDU. 
        Among PWID who are not on MAT, we will calculate the proportion per year who start it. For PWID who overdose, 
        we will calculate the proportions that require emergency services such as ambulance utilization. 
        MAT uptake and success rates are assumed to be equivalent between comparators in the base case, 
        but increased MAT uptake and success rates due to a SIF will be explored in a scenario analysis. 
        These same outcomes will be calculated for B1-3 and totals for a given community will be estimated. 
        Community overdose mortality (C) will be estimated based on the proportion of injections in the SIF.")),
      column(3,
             div(img(src = "ICER.png"), style="text-align: center;"),
             box(
               width = 12,
               title = "Social Buttons",
               status = NULL,
               socialButton(
                 url = "https://github.com/btbeal",
                 type = "github"
               ),
               socialButton(
                 url = "https://twitter.com/icer_review",
                 type = "twitter"
               )
             )
             )
      )
      
      
  )

