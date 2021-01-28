library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
library(dplyr)
library(dashTable)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

# for table (top 10 countries by default)
df <- read.csv("./data/processed/df_tidy.csv")
df_table <- df %>%
  filter(Year == "2020") %>%
  select(Happiness_rank, Country) %>%
  filter(Happiness_rank %in% c(1:10)) %>%
  rename(Rank = Happiness_rank)
df_table
#-----------------------------------------------------------------

app$layout(htmlDiv( 
  list(
    # Top screen (logo, years, smiley face)
    dbcRow(
      list(
        # Logo
        dbcCol(htmlH1("Logo")),
        # Title
        dbcCol(htmlH1("Title")),
        dbcCol(htmlH1(";)"))
      )
    ),
    # Search dropdown row
    dbcRow(
      list(
        dbcCol(htmlH1("Search dropdown"))
      )
    ),
    # Main screen layout
    dbcRow(
      list(
        dbcCol(
          list(
            htmlH2("Happiness Metrics:"),
            dbcLabel("Health"),
            dccSlider(
              id="slider_health",
              min=0,
              max=10,
              step=1,
              value=5,
              marks=list("0" = "0", "5" = "5", "10" = "10")
            ),
            dbcLabel("Freedom"),
            dccSlider(
              id="slider_free",
              min=0,
              max=10,
              step=1,
              value=5,
              marks=list("0" = "0", "5" = "5", "10" = "10")
            ),
            dbcLabel("Economy"),
            dccSlider(
              id="slider_econ",
              min=0,
              max=10,
              step=1,
              value=5,
              marks=list("0" = "0", "5" = "5", "10" = "10")
            ),
            htmlButton("Reset", id="reset_button", n_clicks=0)
          )
        ),
        dbcCol(htmlH1("Map + legend")),
        dbcCol(
          list(
            htmlH2("Top 10 Countries"),  # table -----------------------------------
            dashDataTable(
                 id = "table",
                 columns = lapply(colnames(df_table),
                                  function(colName){
                                    list(
                                      id = colName,
                                      name = colName
                                    )
                                  }),
                 data = df_to_list(df_table),
                 style_table = list(width = "70%"),
                 style_cell = list(
                   textAlign = 'center',
                   backgroundColor = '#FFFF00'
                 ),
                 style_header = list(
                   fontWeight = 'bold' 
                 )
            )
          ) #-----------------------------------------------------------------------
        )
      )
    ),
    # Global metrics and individual country plots
    dbcRow(
      list(
        dbcCol(htmlH1("y axis dropdown")),
        dbcCol(htmlH1("line plot (year progression)")),
        dbcCol(htmlH1("bar chart"),
               list(
               )
        )
      )
    )
  )
))

###################################################################################

# App Callbacks

# Slider callback
app$callback(
  output = list(output(id = "top_5_table", property = "value")),
  #output(id = "top_5_table", property = "columns"),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value")),
  function(health_value, free_value, econ_value) {
    df = read.csv("data/processed/df_tidy.csv")
    data <- filter(df, Year == 2020)
    
    #Measure <- c("Life Expectancy", "Freedom", "GDP_per_capita") # create Measure column
    #Value <- c(health_value, free_value, econ_value) # create Value column
    #user_data <- data.frame(Measure, Value) # create user_data dataframe containing the inputted metrics
    
    #country_df <- user_data[order(-Value)] # sort values in user_data (descending) and put into new dataframe
    #col_name <- country_df[0,0] # extract the Measure with the highest importance
    #filtered_data <- data[order(col_name)] # order the data by the Measure
    #country_list <- filtered_data[0:10, 0] # get the list of ordered countries
    
    return (data)
  }
)

# Reset Button Callback, reset back to 5
app$callback(
  output = list(output(id = "slider_health", property = "value"),
                output(id = "slider_free", property = "value"),
                output(id = "slider_econ", property = "value")),
  params = list(input(id = "reset_button", property = "n_clicks")),
  function(heath_value, free_value, econ_value) {
    return (list(5, 5, 5))
  }
)

app$callback(output = list(id = "giraffe", property = "figure"),
             params = list(input("graphTitle", "value")),
             function(newTitle) {
               
               rand1 <- sample(1:10, 1)
               
               rand2 <- sample(1:10, 1)
               rand3 <- sample(1:10, 1)
               rand4 <- sample(1:10, 1)
               
               x <- c(1,2,3)
               y <- c(3,6,rand1)
               y2 <- c(rand2,rand3,rand4)
               
               df = data.frame(x, y, y2)
               
               list(
                 data =
                   list(
                     list(
                       x = df$x,
                       y = df$y,
                       type = "bar"
                     ),
                     list(
                       x = df$x,
                       y = df$y2,
                       type = "scatter",
                       mode = "lines+markers",
                       line = list(width = 4)
                     )
                   ),
                 layout = list(title = newTitle)
               )
             }
)



###################################################################################

app$run_server(debug = F)