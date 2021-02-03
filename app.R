library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
library(dplyr)
library(dashTable)
library(ggplot2)
library(plotly)
library(tidyr)
library(tidyverse)
library(comprehenr)
library(purrr)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

# Load data and find unique country names for drop down
data_path = "data/processed/df_tidy.csv"
data_country_plots = read.csv(data_path)
unique_countries <- data_country_plots %>%
    select(Country) %>%
    distinct() %>%
    pull(1)

# options for drop down country list
options = to_list(for (c in unique_countries) options = list(label = c, value = c))

# for table (top 10 countries skeleton)
df <- read.csv("./data/processed/df_tidy.csv")

# Build a matrix for multiplying with slider vectors, 2020 only for now
df_norm_metrics <- df %>% 
  filter(Year == "2020") %>% 
  select(life_norm, free_norm, gdp_norm, social_norm, gen_norm, corruption_norm) %>% 
  as.matrix()

df_norm_bias <- df %>% 
  filter(Year == "2020") %>% 
  select(Country_bias)

df <- df %>% 
  select(-(gdp_norm:Country_bias))

df_table <- df %>%
  filter(Year == "2020") %>%
  mutate(Happiness = Happiness_score) %>% 
  select(Happiness, Country)

# Our happiness formula to map the slider changes to the original scores
compute_happiness <- function(slider_vector) {
  happiness <- round((10/6)*df_norm_metrics %*% (slider_vector*(6/sum(slider_vector))) + df_norm_bias, 3)
}

slider_list <- function(){
      list(
        htmlH5("Happiness Metrics:"),
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
        dbcLabel("Social support"),
        dccSlider(
          id="slider_ss",
          min=0,
          max=10,
          step=1,
          value=5,
          marks=list("0" = "0", "5" = "5", "10" = "10")
        ),
        dbcLabel("Generosity"),
        dccSlider(
          id="slider_gen",
          min=0,
          max=10,
          step=1,
          value=5,
          marks=list("0" = "0", "5" = "5", "10" = "10")
        ),
        dbcLabel("Corruption"),
        dccSlider(
          id="slider_corr",
          min=0,
          max=10,
          step=1,
          value=5,
          marks=list("0" = "0", "5" = "5", "10" = "10")
        ),
        htmlBr(),
        htmlButton("Reset", id="reset_button", n_clicks=0, style=list('width' = '95%', 'backgroundColor' = 'white'))
        )
  
}

# margin customization to remove white box around it
m <- list(l = 0, r = 0, b = 0, t = 0, pad = 10)

render_map <- function(input_df) {
  map <- plot_ly(input_df, 
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
  map %>% layout(geo = list(projection = list(type = "natural earth"), showframe = TRUE),
                 clickmode = 'event+select', autosize = FALSE, width = 400, height = 400, margin = m)#, dragmode = 'select')
}

#-----------------------------------------------------------------

app$layout(
  dbcContainer(
    list(
      dbcRow(
        list(
          # Logo
          htmlImg(src="assets/logo.png", style =list('width' = '5%')),
          # Title
          htmlH3(" The Happiness Navigator ",style=list('align' = 'center', 'position' = 'relative', 'left' = '30%', 'border' = '7px white solid', 'border-style' = 'none none dashed')),          
          # Smiley
          htmlImg(src="assets/smiley.gif", style =list('width' = '5%', 'height' = '10%', 'position' = 'relative', 'left' = '63%', 'top' = '-4px'))
        ),
        style = list(padding = '0%', height = '10%', backgroundColor = '#ffd803b9', 'min-width' = 'unset', display='flex', 'vertical-align' = 'top')
      ),
      dbcRow(
        list(
          htmlDiv(
            list(
              dbcCol(
                list(
                  htmlA(children = list(htmlImg(src="assets/github_logo.png", style = list(width = '15%', height = '5%', 'position' = 'relative', 'left' = '40%'))),
                        href = 'https://github.com/UBC-MDS/dash_of_spice-R',
                        style = list(width = '10%', height = '10%')),
                  htmlBr(),
                  htmlH2("Dash Of Spice", style=list(color = 'white')),
                  htmlBr(),
                  htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)")),
                  htmlBr(),
                  dbcCol(
                    slider_list()
                  )
                )
              )
            ), 
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '30%', 'height' = '100%', 'border' = '20px white solid')
          ),
          dbcCol(
            list(
              dbcRow(
                htmlDiv(
                  list(
                    dccDropdown(
                    options = options,
                    value = list("Canada", "United States"),
                    id = "country_drop_down",
                    multi = TRUE,
                    style=list(
                    "verticalAlign" = "middle",
                    "border-width"= "10",
                    "width" = "90%",
                    "height" = "20px",
                    "margin" = "50px"
                    )
                    )
                  )  
                ), style = list('position' = 'relative', 'right' = '20%', 'bottom' = '2%')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccGraph(id = "map", figure=render_map(df), style = list('position' = 'relative', 'width' = '50%', 'height' = '50%', 'top' = '10%'))
                  )
                )
              ),
              dbcRow(
                htmlDiv(
                  list(
                    htmlH3("Choose your metrics:")
                  )
                )
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccDropdown(
                      options=list(
                      list(label="Happiness Score", value="Happiness_score"),
                      list(label="GDP Per Capita", value="GDP_per_capita"),
                      list(label="Social Support", value="Social_support"),
                      list(label="Life Expectancy", value="Life_expectancy"),
                      list(label="Freedom", value="Freedom"),
                      list(label="Generosity", value="Generosity"),
                      list(label="Corruption", value="Corruption")
                      ),
                    value = "Freedom",
                    id = "yaxis_feature",
                    style = list(
                      "border-width"= "10",
                      "width" = "200px",
                      "height" = "20px",
                      "margin" = "30px"
                    )
                  ),
                  dccGraph(id='country_plot', style = list('width' = 500, 'height' = '500'))
                )
              )
            )
          )
        ),
        dbcCol(
          list(
            dbcRow(
              htmlDiv(
                list(
                  htmlH5("Top 10 Countries"), 
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
                  style_table = list(width = "100%"),
                  style_cell = list(
                    textAlign = 'center',
                    backgroundColor = '#ffd803b9'
                  ),
                    style_header = list(
                      fontWeight = 'bold'
                    )
                    )
                  )
                )#,
                #style = list('position' = 'relative')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccGraph(id='bar_plot', style = list('width' = '85%', 'height' = '90%'))
                  )
                )
              )
            ), style = list('position' = 'relative', 'left' = '15%', 'width' = '10%', 'height' = '10%')
          )
        )
      )
    )
  )
)

###################################################################################

# App Callbacks

# Slider - Table Callback
app$callback(
  output(id = "top_5_table", property = "data"),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value"),
                input(id = "slider_ss", property = "value"),
                input(id = "slider_gen", property = "value"),
                input(id = "slider_corr", property = "value")),
  function(health_value, free_value, econ_value, ss_value, gen_value, corr_value) {
    
    measure <- c("Life_expectancy", "Freedom", "GDP_per_capita","Social_support", "Generosity", "Corruption") # create Measure column
    value <- c(health_value, free_value, econ_value, ss_value, gen_value, corr_value) # create slider value vector
    
    df_table_update <- df_table %>% 
      select(Country)
    df_table_update[ , "Happiness"] <- compute_happiness(value)
    df_table_update <- df_table_update %>% 
      arrange(desc(Happiness)) %>% 
      slice(1:10)
    
    return(df_table_update)
  }
)

# Slider callback

# Reset Button Callback, reset back to 5
app$callback(
  output = list(output(id = "slider_health", property = "value"),
                output(id = "slider_free", property = "value"),
                output(id = "slider_econ", property = "value"),
                output(id = "slider_ss", property = "value"),
                output(id = "slider_gen", property = "value"),
                output(id = "slider_corr", property = "value")),
  params = list(input(id = "reset_button", property = "n_clicks")),
  function(heath_value, free_value, econ_value, ss_value, gen_value, corr_value) {
    return (list(5, 5, 5, 5, 5, 5))
  }
)

# Slider - Map Callback
app$callback(
  output = output(id = "map", property = "figure"),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value"),
                input(id = "slider_ss", property = "value"),
                input(id = "slider_gen", property = "value"),
                input(id = "slider_corr", property = "value")),
  function(health_value, free_value, econ_value, ss_value, gen_value, corr_value) {
    data <- filter(df, Year == 2020) %>%
      rename(Rank = Happiness_rank)
    
    measure <- c("Life_expectancy", "Freedom", "GDP_per_capita", "Social_support", "Generosity", "Corruption") # create Measure column
    value <- c(health_value, free_value, econ_value, ss_value, gen_value, corr_value) # create slider value vector
    
    data <- df_table %>% 
      select(Country)
    data[ , "Happiness_score"] <- compute_happiness(value)
    
    return(render_map(data))
  }
)

# Slider - Bar chart Callback
app$callback(
  output = output(id = "bar_plot", property = "figure"),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value"),
                input(id = "slider_ss", property = "value"),
                input(id = "slider_gen", property = "value"),
                input(id = "slider_corr", property = "value")),
  function(health_value, free_value, econ_value, ss_value, gen_value, corr_value) {
    data <- filter(df, Year == 2020) %>%
      rename(Rank = Happiness_rank)
    
    measure <- c("Life_expectancy", "Freedom", "GDP_per_capita", "Social_support", "Generosity", "Corruption") # create Measure column
    value <- c(health_value, free_value, econ_value, ss_value, gen_value, corr_value) # create slider value vector
    
    data[ , "Happiness"] <- compute_happiness(value)
    country_list <- data %>%
      arrange(desc(Happiness)) %>% 
      slice(1:10) %>% 
      select(Rank, Country) %>% 
      arrange(Rank)

    bar_fig <- ggplot(data=country_list, aes(x=Rank, y=reorder(Country, -Rank), fill=-Rank, label = Rank)) +
      geom_bar(stat="identity") +
      labs(fill = "Rank") +
      scale_fill_gradient2(low="grey", mid="yellow", high="green") +
      theme_bw() +
      labs(x=NULL, y=NULL) + # supposedly removes the margins
      theme(axis.title.y = element_blank(),
            panel.border = element_blank())
    
    return(ggplotly(bar_fig, tooltip = "label"))
  }
)


###################################################################################

# Yearly trends plot
app$callback(
  output = output(id = "country_plot", property = "figure"),
                
  params = list(input(id = "yaxis_feature", property = "value"),
                input(id = "country_drop_down", property = "value"),
                input(id = "map", property = "selectedData")),
  
  function(ycol, drop_down_list, selected_data) {
    # Getting the selected contries from the map into a nice format 
    map_selections <- (list(toString(selected_data[[1]] %>% map_chr('location'))))
    map_selections <- strsplit(map_selections[[1]], ", ")
    map_selections <- map_selections[[1]]
    
    # Filter by drop down countries and map selection countries
    plot_data <- data_country_plots %>%
      filter(Country %in% drop_down_list | Country %in% map_selections)
    
    # Remove _'s from y axis name on graph
    yaxis_title <- strsplit(ycol, "_")
    yaxis_title <- paste(yaxis_title[[1]], collapse = " ")

country_plot <- plot_data %>%
      ggplot(aes(x = Year, color = Country)) +
          geom_line(aes_string(y = ycol)) +
          labs(y = yaxis_title, color = "")
    plotly_country <- ggplotly(country_plot)
    plotly_country <- plotly_country %>%
      layout(
        legend = list(
        orientation = "h"#,
        #x = -0.5
      )
    )

  return (plotly_country)
  }
)

#app$run_server(debug = F)
app$run_server(host = '0.0.0.0') # for deploying on heroku