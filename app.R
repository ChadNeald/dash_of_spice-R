# Load libraries
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
library(ggthemes)

# Initialize app, use bootstrap layout theme
app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)
app$title("Happy Navvy")

# Load tidy data
data_path = "data/processed/df_tidy.csv"
df <- read.csv(data_path)

# Get full list of unique countries
unique_countries <- df %>%
    select(Country) %>%
    distinct() %>%
    pull(1)

# options for drop down country list
options = to_list(for (c in unique_countries) options = list(label = c, value = c))

# Filter the table to show important columns for 2020
df_table <- df %>%
  filter(Year == "2020") %>%
  select(Happiness, Country, Rank)

# Build a matrix for multiplying with slider vectors in happiness formula, 2020 only
df_weights <- read.csv("data/processed/df_weights.csv")
df_norm_metrics <- df_weights %>% 
  select(-bias) %>%
  as.matrix()

# Extract the bias from the weights to add to happiness formula to map to original data
df_norm_bias <- df_weights %>%
  select(bias)

#' The true meaning of happiness! Our happiness function to convert the happiness
#' slider choices into a single score biased to match the input data starting value.
#'
#' @param slider_vector A vector of the weights of each of the 6 happiness slider value
#'
#' @return A vector of recalculated happiness scores for each country
#'
compute_happiness <- function(slider_vector) {
  happiness <- round((10/6)*df_norm_metrics %*% (slider_vector*(6/sum(slider_vector))) + df_norm_bias, 3)
}

#' The app callback of the reset button to reset the slider values and by extension map.
#'
#' @param updated_df An input dataframe with updated happiness scores
#' @param drop_down_list An input list of selected countries from the search dropdown
#'
#' @return A wrangled dataframe for loading into the datatable component
#'
render_map <- function(input_df, drop_down_list = list()) {
  # Need a dummy variable so one clicked country gets highlighted on the map,
  # this is a known issue with plotly choropleth
  dummy_variable = list(-1)
  highlighted_countries <- which(input_df$Country %in% drop_down_list) - 1
  
  if (length(highlighted_countries) == 1) {
      highlighted_countries <- c(highlighted_countries, dummy_variable)
  }
  
  map <- plot_ly(input_df, 
                 type='choropleth', 
                 locations=~Country, 
                 locationmode='country names',
                 colorscale = 'Portland',
                 zmin = 0,
                 zmax = 10,
                 width = 700,
                 height = 400,
                 colorbar = list(title = 'Happiness', 
                                 x = 1.0, 
                                 y = 0.9,
                                 len = 0.8, 
                                 lenmode = 'fraction'),
                 z=~Happiness,
                 unselected = list(marker= list(opacity = 0.2)),
                 selectedpoints = array(highlighted_countries),
                 marker=list(line=list(color = 'black', width=0.2)
                 ))

  # margin customization to remove white box around it
  m <- list(l = 0, r = 0, b = 0, t = 0, pad = 10)

  map %>% layout(geo = list(projection = list(type = "natural earth"), showframe = FALSE),
                 clickmode = 'event+select', autosize = FALSE, margin = m)#, dragmode = 'select')
}

#' The app callback of the reset button to reset the slider values and by extension map.
#'
#' @param updated_df An input dataframe with updated happiness scores
#'
#' @return A wrangled dataframe for loading into the datatable component
#'
update_table <- function(updated_df) {
  df_table_update <- updated_df %>% 
    arrange(desc(Happiness)) %>% 
    slice(1:10)
  
  return(df_table_update)
}

#-----------------------------------------------------------------

# App components: The app components are defined here to keep our layout tidy

# The description string under the heading
description <- "Welcome! Use the sliders to rank how important the different happiness metrics are to you, and we'll take care of the rest. Feel free to choose different countries to compare too!"

# The icon link to our GitHub repo
github <- htmlA(children = list(htmlImg(src="assets/github_logo.png", style = list(width = '15%', height = '5%', 'position' = 'relative', 'left' = '40%'))),
                href = 'https://github.com/UBC-MDS/dash_of_spice-R',
                style = list(width = '20%', height = '20%', 'position' = 'relative', 'left' = '32%'))

# The happiness slider metrics component
sliders <- htmlDiv(
  list(
            htmlH4("Happiness Metrics:"),
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
        dbcLabel("Minimal Corruption"),
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
  ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 10, 'width' = '90%', 'height' = '0%', 'border' = '40px white solid')
)

# The country search bar dropdown component
country_dropdown <- dccDropdown(
                    options = options,
                    value = list(),
                    id = "country_drop_down",
                    multi = TRUE,
                    style=list(
                    "verticalAlign" = "middle",
                    "border-width"= "10",
                    "width" = "84%",
                    "height" = "20px",
                    "margin" = "3px", 
                    'position' = 'relative',
                    'left' = '15%',
                    'top' = '11px'
                    )
                    )

# The rendered map HTML graph component
map <- htmlDiv(
    list(
        dccGraph(id = "map", figure=render_map(df))
    )
)

# The top 10 result data table component
table <- 
          list(
            htmlH4("Top 10 Countries", style = list('position' = 'relative', 'left' = '25%', 'top' = '10px')), 
            htmlBr(),
            htmlP(paste("Countries ranked according to your most important values."), style = list('position' = 'relative', 'left' = '6.5%', width = '250px')),
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
              style_table = list(width = "250px", height = '900px', margin = 'auto'),
              style_cell = list(
                textAlign = 'center',
                backgroundColor = 'white'
              ),
              style_header = list(
                fontWeight = 'bold'
              ),
              style_cell_conditional = list(
                list(
                  'if' = list('state' = 'selected'),
                  backgroundColor = 'white',
                  border = '0.000001px solid grey80'
                )
              )
            ),
            htmlBr()
          )
        
# The country metric trend plot dropdown component
metrics_dropdown <- dccDropdown(
              options=list(
                list(label="Health", value="Life_expectancy"),
                list(label="Freedom", value="Freedom"),
                list(label="Economy", value="GDP_per_capita"),
                list(label="Social Support", value="Social_support"),
                list(label="Generosity", value="Generosity"),
                list(label="Minimal Corruption", value="Corruption")
              ),
              value = "Freedom",
              id = "yaxis_feature",
              style = list(
                "border-width"= "10",
                "width" = "200px",
                "height" = "20px",
                #"margin" = "30px",
                'position' = 'relative',
                'bottom' = '20px',
                'left' = '120px'
              )
            )


#' The Dash app layout
#'
#' @param An HTML div hierarchy of the app layout using bootstrap rows/columns

#' @return Dash React HTML object
#'
app$layout(
  htmlDiv(
    list(
      dbcRow(
        list(
          # Logo
          htmlImg(src="assets/logo.png", style =list('width' = '5%', 'position' = 'relative', 'left' = '3%')),
          # Title
          htmlH1(" The Happiness Navigator ",style=list('align' = 'center', 'position' = 'relative', 'left' = '30%', 'border' = '7px white solid', 'border-style' = 'none none dashed')),
          # Smiley
          htmlImg(src="assets/smiley.gif", style =list('width' = '5%', 'height' = '10%', 'position' = 'relative', 'left' = '57%', 'top' = '-4px'))
        ),
        style = list(padding = '0%', height = '10%', backgroundColor = '#ffd803b9', 'min-width' = 'unset', display='flex', 'vertical-align' = 'top')
      ),
      dbcRow(
        list(
          dbcCol(
            list(
              htmlP(paste(description), style = list('position' = 'relative', 'left' = '6.5%'))
            ), style = list(padding = '0%', height = '10%', backgroundColor = '#ffd803b9', 'min-width' = 'unset', display='flex', 'vertical-align' = 'top')

          )
        )
      ),
      dbcRow(
        list(
          dbcCol(
            list(
              htmlDiv(
                list(
                  sliders
                )
              )
            )
          ),
          dbcCol(
            list(
              htmlDiv(
                dbcCard(
                  list(
                    dbcCardHeader(list(country_dropdown, htmlH4("Choose your countries: "))),
                    dbcCardBody(map, style = list('position' = 'relative', 'left' = '90px'))
                  ), color = 'warning', outline = 'True' 
                ), style = list('position' = 'relative', 'right' = '50px', 'top' = '6%', 'width' = '60rem')
              )
            )
          )
        ) 
      ),
      htmlDiv(
        dbcRow(
          list(
            dbcCol(
              htmlDiv(
                table
              ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 10, 'width' = '50px', 'height' = '567px', 'border' = '40px white solid', 'position' = 'relative', 'bottom' = '43px', 'left' = '15px')
            ),
            dbcCol(
              htmlDiv(
                list(
                  dccGraph(id='bar_plot', style = list('width' = '100%', 'height' = '0%', 'position' = 'relative'))
                )
              ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '100%', 'height' = '5%', 'position' = 'relative', 'border' = '20px white solid', 'right' = '23px', 'bottom' = '25px')
            ),
            dbcCol(
              htmlDiv(
                list(
                  htmlH4("Choose your metrics:", style = list('position' = 'relative')),
                  metrics_dropdown,
                  dccGraph(id='country_plot', style = list('width' = 450, 'height' = 395))
                )
              ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '100%', 'height' = '100%', 'position' = 'relative', 'border' = '20px white solid', 'right' = '36px', 'bottom' = '27px')
            )
          )
        )
      ),
      dbcRow(
        list(
          htmlH1("Dash Of Spice", style=list(color = 'black', 'align' = 'center', 'position' = 'relative', 'left' = '39%')),
          github,
          htmlP(paste("the secret spice ☺ "), style = list(color = 'white', 'position' = 'relative', 'left' = '5%', 'bottom' = '60px')) # a secret 🌶️
        ), 
        style = list(padding = '1%', height = '10%', backgroundColor = '#ffd803b9', 'min-width' = 'unset', display='flex', 'vertical-align' = 'top')
      )
    ), style = list(overflow = 'hidden')
  )
)


###################################################################################

# App Callbacks

#' The app callback of the reset button to reset the slider values and by extension map.
#'
#' @param health_value The health slider value
#' @param free_value The freedom slider value
#' @param econ_value The economy slider value
#' @param ss_value The social support slider value
#' @param gen_value The generosity slider value
#' @param corr_value The corruption slider value
#' @param drop_down_list A list of selected countries from the country dropdown
#'
#' @return A plotly choropleth map with updated happiness values/coloring
#' @return An updated dataframe to populate the datatable
#'
app$callback(
  output = list(output(id = "map", property = "figure"),
                output(id = "top_5_table", property = "data")),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value"),
                input(id = "slider_ss", property = "value"),
                input(id = "slider_gen", property = "value"),
                input(id = "slider_corr", property = "value"),
                input(id = "country_drop_down", property = "value")),
  function(health_value, free_value, econ_value, ss_value, gen_value, corr_value, drop_down_list) {
    slider_weights <- c(health_value, free_value, econ_value, ss_value, gen_value, corr_value) # create slider value vector
    
    df_update <- df_table %>% 
      select(Country, Rank)
    df_update[, "Happiness"] <- compute_happiness(slider_weights)

    return <- list(render_map(df_update, drop_down_list), update_table(df_update))
  }
)

#' The app callback of the reset button to reset the slider values and by extension map.
#'
#' @param health_value The health slider value
#' @param free_value The freedom slider value
#' @param econ_value The economy slider value
#' @param ss_value The social support slider value
#' @param gen_value The generosity slider value
#' @param corr_value The corruption slider value
#'
#' @return a list of standard slider weights (5 is mean) for each slider
#''
#' @examples
#' ((5,5,5,5,5,5))
#'
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

#' The app callback to update the yearly trends with the selected countries
#'
#' @param ycol The happiness metric to display from the dropdown
#' @param country_drop_down a list of countries selected from the country dropdown
#' @param selected_data a list of countries selected using the map
#'
#' @return a plotly plot of the yearly metric trend of the chosen countries
#'
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
    plot_data <- df %>%
      filter(Country %in% drop_down_list | Country %in% map_selections)
    
    # Remove _'s from y axis name on graph
    yaxis_title <- strsplit(ycol, "_")
    yaxis_title <- paste(yaxis_title[[1]], collapse = " ")


country_plot <- plot_data %>%
      ggplot(aes(x = Year, color = Country)) + theme_few() +
          geom_line(aes_string(y = ycol)) +
          labs(y = yaxis_title, color = "")


    if(length(drop_down_list) == 0) {
      df_global <- df
      df_global$GlobalAverage = 'Global Average'
      country_plot <- df_global %>%
        ggplot(aes(x = Year, color = GlobalAverage)) +
          stat_summary(fun = 'mean', aes_string(y = ycol), geom = 'line') + theme_few() +
          labs(y = yaxis_title, color = "")
    }

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

#' The app callback to update the dropdown with selected map values
#'
#' @param selected_data a list of countries selected using the map
#'
#' @return a list of country selections to populate the dropdown
#'
#' @examples
#' (('Canada', 'Denmark', 'Poland'), ('Belarus', 'Lebanon'))
app$callback(
  output = list(output(id = "country_drop_down", property = "value")),
  params = list(input(id = "map", property = "selectedData")),
  function(selected_data) {
    map_selections <- (list(toString(selected_data[[1]] %>% map_chr('location'))))
    map_selections <- strsplit(map_selections[[1]], ", ")
    map_selections <- map_selections[[1]]
    
    return <- list(map_selections)
  }
)

#' Creates a bar-plot based on data from the map and the map dropdown menu
#'
#' @param drop_down_list a list of countries selected using the dropdown menu
#' @param selected_data a list of countries selected using the map
#'
#' @return a bar plot
#'
#' @examples
#' (('Canada', 'Denmark', 'Poland'), ('Belarus', 'Lebanon'))
app$callback(
  output = output(id = "bar_plot", property = "figure"),
  
  params = list(input(id = "country_drop_down", property = "value"),
                input(id = "map", property = "selectedData")),
  
  function(drop_down_list, selected_data) {
    # Getting the selected contries from the map into a nice format
    map_selections <- (list(toString(selected_data[[1]] %>% map_chr('location'))))
    map_selections <- strsplit(map_selections[[1]], ", ")
    map_selections <- map_selections[[1]]
    
    # Filter by drop down countries and map selection countries
    country_list <- df_table %>%
      filter(Country %in% drop_down_list | Country %in% map_selections)%>%
      arrange(Rank)
    
    # Plot global average bar chart when no countries are selected
    if(length(drop_down_list) == 0){
      df_bar_global <- df %>%
        group_by(Year) %>%
        summarize(mean_happiness = mean(Happiness))
      df_bar_global$Year = as.factor(df_bar_global$Year)
      df_bar_global$Year <- fct_rev(df_bar_global$Year)
      df_bar_global$Score <- df_bar_global$mean_happiness

      bar_fig_global <- df_bar_global %>%
          ggplot(aes(x=mean_happiness, y=Year, fill=mean_happiness, label = Score)) +
          geom_bar(stat = 'identity') +
          coord_cartesian(xlim = c(2,8)) +
          labs(x = "Mean Happiness Score",
               title = "Global Average Happiness Score", fill = "Happiness") +
               scale_fill_gradient(low = "khaki3", high = "yellow1") +
               theme_bw() +
               theme(axis.text = element_text(size = 10),
                     legend.title = element_text(size = 9),
                     legend.text = element_text(size = 8),
                     axis.title.y = element_blank(),
                     panel.border = element_blank())  

      return(ggplotly(bar_fig_global, tooltip = "Score"))
    }

    if (nrow(country_list) == 1) {
      
      df_table_all <- df %>%
        select(Happiness, Country, Rank, Year)%>%
        filter(Country %in% drop_down_list | Country %in% map_selections) %>%
        arrange(Year)
      
      # Bar plot for one country
      bar_fig <- ggplot(data=df_table_all, aes(x=Happiness, y=reorder(-Year, Country), fill=Happiness, label = Rank)) +
        geom_bar(position = position_dodge(width = 0.1), stat = "identity") +
        ggtitle(paste0("Happiness trend for ", df_table_all$Country)) +
        labs(x = 'Happiness Score') +
        scale_fill_gradient(low = "khaki3", high = "yellow1") +
        coord_cartesian(xlim = c(2, 8)) +
        theme_few() +
        theme(plot.title = element_text(size = 12),
              axis.text = element_text(size = 10),
              legend.title = element_text(size = 9),
              legend.text = element_text(size = 8),
              axis.title.y = element_blank(),
              panel.border = element_blank())
      
    return(ggplotly(bar_fig, tooltip = "label"))
      
    } else {
      # Bar plot for more than one country
      bar_fig <- ggplot(data=country_list, aes(x=Happiness, y=reorder(Country, Happiness), fill=-Rank, label = Rank)) +
        geom_bar(stat="summary") +
        labs(fill = "Rank", x = 'Happiness Score', title = "2020 Happiness Scores") +
        scale_fill_gradient(low = "slategray2", high = "yellow1") +
        scale_x_continuous(limits = c(0, 10)) +
        theme_few() +
        theme(axis.text = element_text(size = 10),
              legend.title = element_text(size = 9),
              legend.text = element_text(size = 8),
              axis.title.y = element_blank(),
              panel.border = element_blank())      
      
      return(ggplotly(bar_fig, tooltip = "label"))
    }
  }
)

#app$run_server(debug = F)
app$run_server(host = '0.0.0.0') # for deploying on heroku