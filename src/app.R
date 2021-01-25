library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)


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
        dbcCol(htmlH1("Sliders + reset")),
        dbcCol(htmlH1("Map + legend")),
        dbcCol(htmlH1("Top table"))
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
app$run_server(debug = T)