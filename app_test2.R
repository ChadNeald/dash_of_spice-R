app$layout(
  htmlDiv(
    list(
      htmlDiv(
        # left corner
        dbcCol(
            list(
              htmlH1("Dash Of Spice", style=list(color = 'white')),
              htmlBr()
            ),
            className = 'row',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%')
        ),
        # description
        htmlDiv(
            list(htmlP(paste("Description: Write something here about how the app works. Blah blah baloney baloney cheese and macaroni. :-)"))
            ),
            className = 'row',
            style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%')
        ),
        # sliders
        htmlDiv(
            list(
                dbcCol(
                    slider_list()
                )
            ),
            className = 'row'
        ), 
        style = list('backgroundColor' = '#ffd803b9', 'padding' = 20, 'width' = '23%', 'height' = '100%', overflow = 'auto'),

        # center Div:
        htmlDiv(
            list(
                htmlDiv(
                    # Logo
                    dbcCard(dbcCardImg(src="assets/logo.png"), style =list('width' = '10%')),
                    # Title
                    htmlH1("The Happiness Navigator"),style=list("align" = "center"),
                    dbcCard(dbcCardImg(src="assets/smiley.gif"), style =list('width' = '10%'))
                )
            ),
            className = 'three columns',
            style = list(overflow = 'auto', padding = 0, height = '110vh', backgroundColor = '#ffd803b9')
        )
      )
    )
  )
)