library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
library(dplyr)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

# for table
df = read.csv("data/processed/df_tidy.csv")
df["Delta_happy"] = df["Happiness_score"]

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
        dbcCol(htmlH1("Map + legend")),
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