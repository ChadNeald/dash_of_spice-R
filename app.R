library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
library(dplyr)
library(dashTable)
library(ggplot2)
library(plotly)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

# for table (top 10 countries skeleton)
df <- read.csv("./data/processed/df_tidy.csv")
df_table <- df %>%
  filter(Year == "2020") %>%
  select(Happiness_rank, Country) %>%
  filter(Happiness_rank %in% c(1:5)) %>%
  rename(Rank = Happiness_rank)
df_table

render_map <- function(input_df) {
  map <- plot_ly(df, 
    type='choropleth', 
    locations=~Country, 
    locationmode='country names',
    colorscale = 'Portland',
    zmin = 0,
    zmax = 10,
    colorbar = list(title = 'Happiness', x = 1.0, y = 0.9),
    z=~Happiness_score,
    unselected = list(marker= list(opacity = 0.1)),
    marker=list(line=list(color = 'black', width=0.2)
  ))
  map %>% layout(geo = list(projection = list(type = "natural earth"), showframe = FALSE),
                 clickmode = 'event+select', autosize = FALSE, width = 650, height = 450)#, dragmode = 'select')
}
#-----------------------------------------------------------------

app$layout(htmlDiv(
  list(
    # Top screen (logo, years, smiley face)
    dbcRow(
      list(
        # Logo
        #dbcCol(htmlImg("assets/logo.png")),
        #dbcCol(htmlH1("Logo")),
        dbcCol(dbcCard(dbcCardImg(src="assets/logo.png"), style =list('width' = '10%'))),
        # Title
        dbcCol(htmlH1("The Happiness Navigator")),
        dbcCol(dbcCard(dbcCardImg(src="assets/smiley.gif"), style =list('width' = '10%')))
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
            htmlButton("Reset", id="reset_button", n_clicks=0, style=list('width' = '95%', 'backgroundColor' = 'yellow'))
          )
        ),
        dbcCol(htmlDiv(list(dccGraph(figure=render_map(df))))),
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
        dbcCol(htmlH2("bar chart"), # bar chart---------------------------------
               list(
                 dccGraph(
                   id='bar_plot',
                   style = list(width = "60%")
                 )
               )
        )
      )
    )
  )
))

###################################################################################

# App Callbacks

# Slider - Table Callback
app$callback(
  output(id = "top_5_table", property = "data"),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value")),
  function(health_value, free_value, econ_value) {
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

    return(country_list)
  }
)

# Slider callback

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

# Slider - Bar chart Callback
app$callback(
  output(id = "bar_plot", property = "figure"),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value")),
  function(health_value, free_value, econ_value) {
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
      slice(1:5)

    bar_fig <- ggplot(country_list) +
      aes(y = Country,
          fill = Country) +
      geom_bar(width = 0.4)# +
#      theme(plot.margin = unit(c(2,2,2,2),"cm"))

    return(bar_fig)
  }
)

###################################################################################

#app$run_server(debug = F)
app$run_server(host = '0.0.0.0') # for deploying on heroku
