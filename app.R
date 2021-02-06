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
first_pass <<- 0
# Load data
data_path = "data/processed/df_tidy.csv"
df <- read.csv(data_path)

unique_countries <- df %>%
    select(Country) %>%
    distinct() %>%
    pull(1)

# options for drop down country list
options = to_list(for (c in unique_countries) options = list(label = c, value = c))

df_table <- df %>%
  filter(Year == "2020") %>%
  select(Happiness, Country, Rank)

# Build a matrix for multiplying with slider vectors, 2020 only for now
df_weights <- read.csv("data/processed/df_weights.csv")
df_norm_metrics <- df_weights %>% 
  select(-bias) %>%
  as.matrix()

df_norm_bias <- df_weights %>%
  select(bias)

# Our happiness formula to map the slider changes to the original scores
compute_happiness <- function(slider_vector) {
  happiness <- round((10/6)*df_norm_metrics %*% (slider_vector*(6/sum(slider_vector))) + df_norm_bias, 3)
}



# margin customization to remove white box around it
m <- list(l = 0, r = 0, b = 0, t = 0, pad = 10)

render_map <- function(input_df, drop_down_list = list("United States", "Canada")) {
  # Need a dummy variable so one clicked country gets highlighted on the map
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
                 colorbar = list(title = 'Happiness', x = 1.0, y = 0.9),
                 z=~Happiness,
                 unselected = list(marker= list(opacity = 0.1)),
                 selectedpoints = array(highlighted_countries),
                 marker=list(line=list(color = 'black', width=0.2)
                 ))
  map %>% layout(geo = list(projection = list(type = "natural earth"), showframe = FALSE),
                 clickmode = 'event+select', autosize = FALSE, width = 700, height = 400, margin = m)#, dragmode = 'select')
}

update_table <- function(updated_df) {
  df_table_update <- updated_df %>% 
    arrange(desc(Happiness)) %>% 
    slice(1:10)
  
  return(df_table_update)
}

#-----------------------------------------------------------------

# consolidating everything

description <- "Welcome! Use the sliders to rank how important the different happiness metrics are to you, and we'll take care of the rest. Feel free to choose different countries to compare too!"

github <- htmlA(children = list(htmlImg(src="assets/github_logo.png", style = list(width = '15%', height = '5%', 'position' = 'relative', 'left' = '40%'))),
                href = 'https://github.com/UBC-MDS/dash_of_spice-R',
                style = list(width = '20%', height = '20%', 'position' = 'relative', 'left' = '32%'))

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
  ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 10, 'width' = '90%', 'height' = '0%', 'border' = '40px white solid')
)

country_dropdown <- dccDropdown(
                    options = options,
                    value = list("Canada", "United States"),
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

map <- htmlDiv(
    list(
        dccGraph(id = "map", figure=render_map(df))
    )
)

table <- 
          list(
            htmlH4("Top 10 Countries", style = list('position' = 'relative', 'left' = '25%', 'top' = '10px')), 
            htmlBr(),
            htmlP(paste("Countries ranked according to your most important values."), style = list('position' = 'relative', 'left' = '6.5%')),
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
              style_table = list(width = "300px", height = '900px', margin = 'auto'),
              style_cell = list(
                textAlign = 'center',
                backgroundColor = 'white'
              ),
              style_header = list(
                fontWeight = 'bold'
              ),
              css=list( # override default css for selected/focused table cells
                list(
                #'selector' = 'td.cell--selected, td.focused',
                #'rule' = 'background-color: white;'
                ), 
                list(
                #'selector' = 'td.cell--selected *, td.focused *',
                #'rule' = 'color: white !important;'
                )
              )
            ),
            htmlBr()
          )
        

metrics_dropdown <- dccDropdown(
              options=list(
                list(label="Health", value="Life_expectancy"),
                list(label="Freedom", value="Freedom"),
                list(label="Economy", value="GDP_per_capita"),
                list(label="Social Support", value="Social_support"),
                list(label="Generosity", value="Generosity"),
                list(label="Corruption", value="Corruption")
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

# actual layout

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
                    dbcCardBody(map)
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
          github    
        ), 
        style = list(padding = '1%', height = '10%', backgroundColor = '#ffd803b9', 'min-width' = 'unset', display='flex', 'vertical-align' = 'top')
      )
    )
  )
)


###################################################################################

# App Callbacks

# Slider Callbacks
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
    plot_data <- df %>%
      filter(Country %in% drop_down_list | Country %in% map_selections)
    
    # Remove _'s from y axis name on graph
    yaxis_title <- strsplit(ycol, "_")
    yaxis_title <- paste(yaxis_title[[1]], collapse = " ")

    country_plot <- plot_data %>%
      ggplot(aes(x = Year, color = Country)) +
          geom_line(aes_string(y = ycol)) +
          labs(y = yaxis_title, color = "")


    if(length(drop_down_list) == 0) {
      country_plot <- df %>%
        ggplot(aes(x = Year)) +
          stat_summary(fun = 'mean', aes_string(y = ycol), geom = 'line') +
          labs(y = "Global Average", color = "")
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

# Bar plot callback
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
    
    if (nrow(country_list) == 1) {
      
      df_table_all <- df %>%
        select(Happiness, Country, Rank, Year)%>%
        filter(Country %in% drop_down_list | Country %in% map_selections) %>%
        arrange(Year)
      
      # Bar plot for one country
      bar_fig <- ggplot(data=df_table_all, aes(x=Happiness, y=reorder(Year, Country), fill=Happiness, label = Rank)) +
        geom_bar(position = position_dodge(width = 0.1), stat = "identity") +
        ggtitle(paste0("Happiness trend for ", df_table_all$Country)) +
        labs(x = 'Happiness Score') +
        scale_fill_gradient(low = "khaki3", high = "yellow1") +
        scale_x_continuous(limits = c(0, 8)) +
        theme_bw() +
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
 #       coord_fixed(ratio = 2.5) +
        labs(fill = "Rank", x = 'Happiness Score') +
        scale_fill_gradient(low = "slategray2", high = "yellow1") +
        scale_x_continuous(limits = c(0, 10)) +
        theme_bw() +
        theme(axis.text = element_text(size = 10),
              legend.title = element_text(size = 9),
              legend.text = element_text(size = 8),
              axis.title.y = element_blank(),
              panel.border = element_blank())      
      
      return(ggplotly(bar_fig, tooltip = "label"))
    }
  }
)

app$run_server(debug = F)
#app$run_server(host = '0.0.0.0') # for deploying on heroku