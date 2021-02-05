app$layout(
  htmlDiv(
    list(
      htmlDiv(
        list(
        # left corner
        dbcCol(
            list(
              htmlH1("Dash Of Spice", style=list(color = 'white')),
              htmlBr()
            ),
            className = 'three columns',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%')
        ),
        # description
        htmlDiv(
            list(htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)"))
            ),
            className = 'three columns',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%')
        ),
        # sliders
        htmlDiv(
            list(
                dbcCol(
                    slider_list()
                )
            ),
            className = 'three columns',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%', 'height' = '100%', overflow = 'auto')

        )
        )
      ),
        # center Div:
        htmlDiv(
            list(
                htmlDiv(
                    # Logo
                    dbcCard(dbcCardImg(src="assets/logo.png"), style =list('width' = '10%'))
                ),
                htmlDiv(
                    # Title
                    htmlH1("The Happiness Navigator"),style=list("align" = "center")
                ),
                htmlDiv(
                    # Smiley
                    dbcCard(dbcCardImg(src="assets/smiley.gif"), style =list('width' = '10%'))
                )
            ),
            className = 'row',
            style = list(overflow = 'auto', padding = 20, height = '110vh', backgroundColor = '#ffd803b9')
        )
      )
    )
  #)
)

##################

# random shit idk it be working kinda looks whack

app$layout(
  htmlDiv(
    list(
        # top row:
      htmlDiv(
        list(
            # Logo
            dbcCol(dbcCard(dbcCardImg(src="assets/logo.png"), style =list('width' = '10%'))),
            # Title
            dbcCol(htmlH1("The Happiness Navigator"),style=list("align" = "center")),
            # Smiley
            dbcCol(dbcCard(dbcCardImg(src="assets/smiley.gif"), style =list('width' = '10%')))
        ),
        className = 'row',
        style = list(padding = 20, height = '10%', backgroundColor = '#ffd803b9')
      ),
      
      htmlDiv(
        list(
        # left corner
        htmlDiv(
            list(
              htmlH1("Dash Of Spice", style=list(color = 'white')),
              htmlBr(),
              htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)")),
              dbcCol(
                slider_list()
              )
            ),
            className = 'three columns',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%', 'height' = '100%', 'border' = '10px white solid')
        )#,
        # description
        #htmlDiv(
        #    list(htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)"))
        #    ),
        #    className = 'three columns',
        #    style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%')
        #),
        # sliders
        #htmlDiv(
        #    list(
        #        dbcCol(
        #            slider_list()
        #        )
        #    ),
        #    className = 'three columns',
        #    style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%', 'height' = '100%', overflow = 'auto', 'border' = '10px white solid')

        #)
        )
      )
      )
    )
  #)
)

#######################

# looks very good, now gotta figure out how to put the map and plots and table in

app$layout(
  htmlDiv(
    list(
        # top row:
      htmlDiv(
        list(
            # Logo
            dbcCol(dbcCard(dbcCardImg(src="assets/logo.png"), style =list('width' = '20%'))),
            # Title
            dbcCol(htmlH1("The Happiness Navigator"),style=list("align" = "center")),
            # Smiley
            dbcCol(dbcCard(dbcCardImg(src="assets/smiley.gif"), style =list('width' = '20%')))
        ),
        className = 'row',
        style = list(padding = 20, height = '10%', backgroundColor = '#ffd803b9')
      ),
      
      htmlDiv(
        list(
        # left panel
        htmlDiv(
            list(
              htmlH1("Dash Of Spice", style=list(color = 'white')),
              htmlBr(),
              htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)")),
              htmlBr(),
              dbcCol(
                slider_list()
              )
            ),
            className = 'three columns',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%', 'height' = '100%', 'border' = '20px white solid')
        )
        )
      )
    )
  )
)

########### updated the lookies

app$layout(
  htmlDiv(
    list(
        # top row:
      htmlDiv(
        list(
            # Logo
            htmlImg(src="assets/logo.png", style =list('width' = '5%')),
            # Title
            htmlH1(" The Happiness Navigator ",style=list('position' = 'relative', 'left' = '30%', 'border' = '7px white solid', 'border-style' = 'none none dashed')),          
            # Smiley
            htmlImg(src="assets/smiley.gif", style =list('width' = '5%', 'height' = '10%', 'position' = 'relative', 'left' = '60%', 'top' = '-4px'))
        ),
        className = 'row',
        style = list(padding = 20, height = '10%', backgroundColor = '#ffd803b9')
      ),
      
      # left panel
      htmlDiv(
        list(
        htmlDiv(
            list(
              htmlH1("Dash Of Spice", style=list(color = 'white')),
              htmlBr(),
              htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)")),
              htmlBr(),
              dbcCol(
                slider_list()
              )
            ),
            className = 'three columns',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%', 'height' = '100%', 'border' = '20px white solid')
        )
        )
      ),

      # Map
      htmlDiv(
        list(
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
                "width" = "50%",
                "height" = "20px",
                "margin" = "50px",
                'position' = 'relative',
                'top' = '100%',
                'left' = '13%'
                )          
              )
            ),
            className = 'three columns'
          )
        )
      )
    )
  )
)

############### let's try again
app$layout(
  dbcContainer(
    list(
      dbcRow(
        htmlDiv(
          list(
            # Logo
            htmlImg(src="assets/logo.png", style =list('width' = '5%')),
            # Title
            htmlH3(" The Happiness Navigator ",style=list('align' = 'center', 'position' = 'relative', 'left' = '30%', 'border' = '7px white solid', 'border-style' = 'none none dashed')),          
            # Smiley
            htmlImg(src="assets/smiley.gif", style =list('width' = '5%', 'height' = '10%', 'position' = 'relative', 'left' = '63%', 'top' = '-4px'))
          ),
          className = 'row',
          style = list(padding = '0%', height = '10%', backgroundColor = '#ffd803b9', 'min-width' = 'unset', display='flex', 'vertical-align' = 'top')
        )
      ),
      dbcCol(
        dbcRow(
          list(
            htmlDiv(
              list(
                htmlA(
                  children = list(htmlImg(src="assets/github_logo.png", style = list(width = '15%', height = '5%', 'position' = 'relative', 'left' = '40%'))),
                  href = 'https://github.com/UBC-MDS/dash_of_spice-R',
                  style = list(width = '10%', height = '10%')
                ),
                htmlBr(),
                htmlH2("Dash Of Spice", style=list(color = 'white')),
                htmlBr(),
                htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)")),
                htmlBr(),
                dbcCol(
                  slider_list()
                )
              ),
              #className = 'three columns',
              style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '30%', 'height' = '100%', 'border' = '20px white solid')
            )
          )
        ),
      #   dbcRow(
      #     list(
      #       htmlDiv(
      #         list(
      #           dccDropdown(
      #             options = options,
      #             value = list("Canada", "United States"),
      #             id = "country_drop_down",
      #             multi = TRUE,
      #             style=list(
      #             "verticalAlign" = "middle",
      #             "border-width"= "10",
      #             "width" = "90%",
      #             "height" = "20px",
      #             "margin" = "50px"
      #             )
      #           ) 
      #         )
      #       )
      #     )
      #   )
      ),
      dbcCol(
        list(
          dbcRow(
            list(
              htmlDiv(
                dccDropdown(
                  options = options,
                  value = list("Canada", "United States"),
                  #id = "country_drop_down",
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
            )
          )
        ),
        dbcRow(
          htmlH1("Hi")
        )  
      ),
      dbcCol(

      )
    )
  )
)


#################### container layout

app$layout(
  dbcContainer(
    list(
      dbcRow(
        list(
          htmlH1("single row - insert top bar")
        )
      ),
      dbcRow(
        list(
          dbcCol(htmlH1("left panel")),
          dbcCol(
            list(
              dbcRow(htmlH1("dropdown")),
              dbcRow(htmlH1("map")),
              dbcRow(htmlH1("choose your metrics")),
              dbcRow(htmlH1("line plot"))
            )
          ),
          dbcCol(
            list(
              dbcRow(htmlH1("top table")),
              dbcRow(htmlH1("bar plot"))
            )
          )
        )
      )
    )
  )
)

####

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
          dbcCol(
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
          ),
          dbcCol(
            list(
              dbcRow(htmlH1("dropdown")),
              dbcRow(htmlH1("map")),
              dbcRow(htmlH1("choose your metrics")),
              dbcRow(htmlH1("line plot"))
            )
          ),
          dbcCol(
            list(
              dbcRow(htmlH1("top table")),
              dbcRow(htmlH1("bar plot"))
            )
          )
        )
      )
    )
  )
)

#### MUST ADD HTML DIV!!!!!!

app$layout(
  dbcContainer(
    list(
      dbcRow(
        list(
          htmlH1("single row - insert top bar")
        )
      ),
      dbcRow(
        list(
          htmlDiv( list (

          
          dbcCol(htmlH1("left panel")),
          dbcCol(
            list(
              dbcRow(htmlH1("dropdown")),
              dbcRow(htmlH1("map")),
              dbcRow(htmlH1("choose your metrics")),
              dbcRow(htmlH1("line plot"))
            )
          )),style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '30%', 'height' = '100%', 'border' = '20px white solid')
          ),
          dbcCol(
            list(
              dbcRow(htmlH1("top table")),
              dbcRow(htmlH1("bar plot"))
            )
          )
        )
      )
    )
  )
)

####### new

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
          htmlDiv(
            list(
              dbcCol(
                list(
                  htmlA(children = list(htmlImg(src="assets/github_logo.png", style = list(width = '15%', height = '5%', 'position' = 'relative', 'left' = '40%'))),
                        href = 'https://github.com/UBC-MDS/dash_of_spice-R',
                        style = list(width = '10%', height = '10%')),
                  htmlBr(),
                  htmlBr(),
                  htmlH2("Dash Of Spice", style=list(color = 'white')),
                  htmlBr(),
                  htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-) The map is my true demise. There's a giant white box border surrounding it which is why nothing else fits into my grid layout. I think it's starting to look better with the more I write. Maybe we can fill this spot in with cute images. I learned how to insert html images today. The world is our oyster!")),
                  htmlBr(),
                  dbcCol(
                    slider_list()
                  )
                )
              )
            ), 
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '25%', 'height' = '100%', 'border' = '40px white solid')
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
                ), style = list('position' = 'relative', 'right' = '20%', 'bottom' = '40px')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccGraph(id = "map", figure=render_map(df), style = list('position' = 'relative', 'width' = '50%', 'height' = '45%', 'bottom' = '55px', 'padding' = 0))
                  )
                )
              ),
              dbcRow(
                htmlDiv(
                  list(
                    htmlH4("Choose your metrics:", style = list('position' = 'relative')),
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
                      #"margin" = "30px",
                      'position' = 'relative',
                      'bottom' = '20px',
                      'left' = '130px'
                    )
                  ),
                  dccGraph(id='country_plot', style = list('width' = 460, 'height' = '300'))
                )
              ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'bottom' = '30px')
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
                  style_table = list(width = "250px"),
                  style_cell = list(
                    textAlign = 'center',
                    backgroundColor = '#ffd803b9'
                  ),
                    style_header = list(
                      fontWeight = 'bold'
                    )
                    )
                  )
                ), style = list('position' = 'relative', 'left' = '100px')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccGraph(id='bar_plot', style = list('width' = '80%', 'height' = '80%'))
                  )
                ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'position' = 'relative', 'top' = '30px', 'left' = '30px')
              )
            )#, style = list('position' = 'relative', 'left' = '15%', 'width' = '10%', 'height' = '10%')
          )
        )
      )
    )
  )
)

## testing card

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
          htmlDiv(
            list(
              dbcCol(
                list(
                  htmlA(children = list(htmlImg(src="assets/github_logo.png", style = list(width = '15%', height = '5%', 'position' = 'relative', 'left' = '40%'))),
                        href = 'https://github.com/UBC-MDS/dash_of_spice-R',
                        style = list(width = '10%', height = '10%')),
                  htmlBr(),
                  htmlBr(),
                  htmlH2("Dash Of Spice", style=list(color = 'white')),
                  htmlBr(),
                  htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-) The map is my true demise. There's a giant white box border surrounding it which is why nothing else fits into my grid layout. I think it's starting to look better with the more I write. Maybe we can fill this spot in with cute images. I learned how to insert html images today. The world is our oyster!")),
                  htmlBr(),
                  dbcCol(
                    slider_list()
                  )
                )
              )
            ), 
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '25%', 'height' = '100%', 'border' = '40px white solid')
          ),
          dbcCol(
            list(
              dbcRow(
                dbcCard(
                  list(
                    dbcCardHeader(dccDropdown(
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
                    )), dbcCardBody(map)
                  ), color = 'warning', outline = 'True'  
                ), style = list('position' = 'relative', 'right' = '20%', 'bottom' = '40px', 'width' = '30rem')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    htmlH4("Choose your metrics:", style = list('position' = 'relative')),
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
                      #"margin" = "30px",
                      'position' = 'relative',
                      'bottom' = '20px',
                      'left' = '130px'
                    )
                  ),
                  dccGraph(id='country_plot', style = list('width' = 460, 'height' = '300'))
                )
              ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'bottom' = '30px')
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
                  style_table = list(width = "250px"),
                  style_cell = list(
                    textAlign = 'center',
                    backgroundColor = '#ffd803b9'
                  ),
                    style_header = list(
                      fontWeight = 'bold'
                    )
                    )
                  )
                ), style = list('position' = 'relative', 'left' = '100px')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccGraph(id='bar_plot', style = list('width' = '80%', 'height' = '80%'))
                  )
                ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'position' = 'relative', 'top' = '30px', 'left' = '30px')
              )
            )#, style = list('position' = 'relative', 'left' = '15%', 'width' = '10%', 'height' = '10%')
          )
        )
      )
    )
  )
)

##### everything works after consolidation

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
          htmlDiv(
            list(
              dbcCol(
                list(
                  htmlA(children = list(htmlImg(src="assets/github_logo.png", style = list(width = '15%', height = '5%', 'position' = 'relative', 'left' = '40%'))),
                        href = 'https://github.com/UBC-MDS/dash_of_spice-R',
                        style = list(width = '10%', height = '10%')),
                  htmlBr(),
                  htmlBr(),
                  htmlH2("Dash Of Spice", style=list(color = 'white')),
                  htmlBr(),
                  htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-) The map is my true demise. There's a giant white box border surrounding it which is why nothing else fits into my grid layout. I think it's starting to look better with the more I write. Maybe we can fill this spot in with cute images. I learned how to insert html images today. The world is our oyster!")),
                  htmlBr(),
                  dbcCol(
                    slider_list()
                  )
                )
              )
            ), 
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '25%', 'height' = '100%', 'border' = '40px white solid')
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
                ), style = list('position' = 'relative', 'right' = '20%', 'bottom' = '40px')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccGraph(id = "map", figure=render_map(df), style = list('position' = 'relative', 'width' = '50%', 'height' = '45%', 'bottom' = '55px', 'padding' = 0))
                  )
                )
              ),
              dbcRow(
                htmlDiv(
                  list(
                    htmlH4("Choose your metrics:", style = list('position' = 'relative')),
                    metrics_dropdown,
                  dccGraph(id='country_plot', style = list('width' = 460, 'height' = '300'))
                )
              ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'bottom' = '30px')
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
                  style_table = list(width = "250px"),
                  style_cell = list(
                    textAlign = 'center',
                    backgroundColor = '#ffd803b9'
                  ),
                    style_header = list(
                      fontWeight = 'bold'
                    )
                    )
                  )
                ), style = list('position' = 'relative', 'left' = '100px')
              ),
              dbcRow(
                htmlDiv(
                  list(
                    dccGraph(id='bar_plot', style = list('width' = '80%', 'height' = '80%'))
                  )
                ), style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'position' = 'relative', 'top' = '30px', 'left' = '30px')
              )
            )#, style = list('position' = 'relative', 'left' = '15%', 'width' = '10%', 'height' = '10%')
          )
        )
      )
    )
  )
)