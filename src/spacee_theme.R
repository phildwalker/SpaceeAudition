comp_theme <- function () { 
  font <- "Montserrat"
  #base_size=12, base_family="Avenir"
  theme_bw() %+replace% 
    theme(
      panel.background  = element_blank(),
      plot.background = element_rect(fill="gray96", colour=NA), 
      legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA),
      
      #text elements
      plot.title = element_text(             #title
        family = font,            #set font family
        size = 20,                #set font size
        face = 'bold',            #bold typeface
        hjust = 0,                #left align
        vjust = 2),               #raise slightly
      
      plot.subtitle = element_text(          #subtitle
        family = font,            #font family
        size = 16,   #font size
        hjust = 0),               
      
      plot.caption = element_text(           #caption
        family = font,            #font family
        size = 14,                 #font size
        hjust = 1),               #right align
      
      axis.title = element_text(             #axis titles
        family = font,            #font family
        size = 14),               #font size
      
      axis.text = element_text(              #axis text
        family = font,            #axis family
        size = 14),                #font size
      
      axis.text.x = element_text(            #margin for axis text
        margin=margin(5, b = 10)),
      
      strip.text = element_text(family = font, size = 14)
    )
}
