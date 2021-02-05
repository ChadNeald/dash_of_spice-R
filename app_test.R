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

############################################################################################################################## FULL THING - feb 5, 2:45pm

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

render_map <- function(input_df) {
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

render_bar_plot <- function(updated_df) {
  country_list <- updated_df %>%
    arrange(desc(Happiness)) %>% 
    slice(1:10) %>% 
    select(Rank, Country) %>% 
    arrange(Rank)
  
  bar_fig <- ggplot(data=country_list, aes(x=Rank, y=reorder(Country, -Rank), fill=-Rank, label = Rank)) +
    geom_bar(stat="identity") +
    labs(fill = "Rank") +
    scale_fill_gradient2(low="grey", mid="yellow", high="green") +
    theme_bw() +
    theme(axis.title.y = element_blank(),
          panel.border = element_blank())
  
  return(ggplotly(bar_fig, tooltip = "label"))
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
                output(id = "top_5_table", property = "data"),
                output(id = "bar_plot", property = "figure")),
  params = list(input(id = "slider_health", property = "value"),
                input(id = "slider_free", property = "value"),
                input(id = "slider_econ", property = "value"),
                input(id = "slider_ss", property = "value"),
                input(id = "slider_gen", property = "value"),
                input(id = "slider_corr", property = "value")),
  function(health_value, free_value, econ_value, ss_value, gen_value, corr_value) {
    slider_weights <- c(health_value, free_value, econ_value, ss_value, gen_value, corr_value) # create slider value vector
    
    df_update <- df_table %>% 
      select(Country, Rank)
    df_update[, "Happiness"] <- compute_happiness(slider_weights)
    
    return <- list(render_map(df_update), update_table(df_update), render_bar_plot(df_update))
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