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
            htmlH2("Top 10 Countries"),  # table -------------------------------
            dashDataTable(
                 id = "top_5_table",
                 columns = lapply(colnames(df_table),
                                  function(colName){
                                    list(
                                      id = colName,
                                      name = colName
                                    )
                                  }),
                 data_previous = df_to_list(df_table),
                 style_table = list(width = "80%"),
                 style_cell = list(
                   textAlign = 'center',
                   backgroundColor = '#FFFF00'
                 ),
                 style_header = list(
                   fontWeight = 'bold' 
                 )
            )
          )
        )
      )
    ),
    # Global metrics and individual country plots
    dbcRow(
      list(
        dbcCol(htmlH1("y axis dropdown")),
        dbcCol(htmlH1("line plot (year progression)")),
        dbcCol(htmlH1("bar chart"), # bar chart---------------------------------
               list(
                 dccGraph(
                   id='bar-plot'
                 )
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
#  output = list(output(id = "top_5_table", property = "value")),
  output(id = "top_5_table", property = "data"),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value")),
  function(health_value, free_value, econ_value) {
#    df = read.csv("data/processed/df_tidy.csv")
    data <- filter(df, Year == 2020) %>%
      rename(Rank = Happiness_rank)
    
    Measure <- c("Life_expectancy", "Freedom", "GDP_per_capita") # create Measure column
    Value <- c(health_value, free_value, econ_value) # create Value column
    user_data <- data.frame(Measure, Value) # create user_data dataframe containing the inputted metrics
    
    
    country_df <- user_data %>% arrange(desc(Value)) # sort values in user_data (descending) and put into new dataframe
    col_name <- country_df[1,1] # extract the Measure with the highest importance
    if (col_name == 'Life_expectancy') {
      filtered_data <- data %>% arrange(desc(Life_expectancy))
    } else if (col_name == 'Freedom') {
      filtered_data <- data %>% arrange(desc(Freedom))
    } else if (col_name == 'GDP_per_capita') {
      filtered_data <- data %>% arrange(desc(GDP_per_capita))
    }
    country_list <- filtered_data %>%
      select(Rank, Country) %>%
      slice(1:10)
    
    return (country_list)
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

# Bar Chart Callback
#app$callback(
#  output('bar-plot', 'figure'),
#  list(input('plot-area', 'selectedData')),
#  function(selected_data) {
#    animal_names <- selected_data[[1]] %>% purrr::map_chr('text')
#    p <- ggplot(msleep %>% filter(name %in% animal_names)) +
#      aes(y = vore,
#          fill = vore) +
#      geom_bar(width = 0.6) +
#      ggthemes::scale_fill_tableau()
#    ggplotly(p, tooltip = 'text') %>% layout(dragmode = 'select')
#  }
#)

###################################################################################

app$run_server(debug = F)