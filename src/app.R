library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
library(dplyr)
library(plotly)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

# for table
df = read.csv("data/processed/df_tidy.csv")
df["Delta_happy"] = df["Happiness_score"]

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
        dbcCol(htmlDiv(list(dccGraph(figure=render_map(df)))
     )),
        dbcCol(dccTextarea(id = "top_5_table"))
      )
    ),
    # Global metrics and individual country plots
    dbcRow(
      list(
        dbcCol(htmlH1("y axis dropdown")),
        dbcCol(htmlH1("line plot (year progression)")),
        dbcCol(htmlH1("bar chart"))
      )
    )
  )
))

###################################################################################

# App Callbacks

# Slider callback
#app$callback(
#  output = list(output(id = "top_5_table", property = "value")),
#                #output(id = "top_5_table", property = "columns"),
#  params = list(input(id = "slider_health", property = "value"),
#                input(id = "slider_free", property = "value"),
#                input(id = "slider_econ", property = "value")),
#  function(health_value, free_value, econ_value) {
#    df = read.csv("data/processed/df_tidy.csv")
#    data <- filter(df, Year == 2020)

    #Measure <- c("Life Expectancy", "Freedom", "GDP_per_capita") # create Measure column
    #Value <- c(health_value, free_value, econ_value) # create Value column
    #user_data <- data.frame(Measure, Value) # create user_data dataframe containing the inputted metrics

    #country_df <- user_data[order(-Value)] # sort values in user_data (descending) and put into new dataframe
    #col_name <- country_df[0,0] # extract the Measure with the highest importance
    #filtered_data <- data[order(col_name)] # order the data by the Measure
    #country_list <- filtered_data[0:10, 0] # get the list of ordered countries

#    return (data)
#  }
#)

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

###################################################################################



app$run_server(debug = F)