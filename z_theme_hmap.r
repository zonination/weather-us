z_theme_hmap <- function() {
  theme_bw(base_size=9) +
    #Background and Grid formatting
    theme(panel.background=element_rect(fill="#F0F0F0", color="#F0F0F0")) +
    theme(plot.background=element_rect(fill="#F0F0F0", color="#F0F0F0")) +
    theme(panel.border=element_rect(color="#F0F0F0")) +
    theme(panel.grid.major=element_blank()) +
    theme(panel.grid.minor=element_blank()) +
    #Legend formatting
    theme(legend.background = element_rect(fill="#F0F0F0")) +
    theme(legend.text = element_text(size=14,color="#525252")) +
    theme(legend.title= element_text(size=12,color="#525252"))+
    #Facet Strip Formatting
    theme(strip.text.x = element_text(size = 12, colour = "#525252")) +
    theme(strip.text.y = element_text(size = 12, colour = "#525252")) +
    #Axis & Title Formatting
    theme(plot.title=element_text(color="#525252", size=20, vjust=1.25)) +
    theme(axis.ticks=element_blank()) +
    theme(axis.text.x=element_text(size=14,color="#737373",angle=90)) +
    theme(axis.text.y=element_text(size=14,color="#737373")) +
    theme(axis.title.x=element_text(size=16,color="#737373", vjust=0)) +
    theme(axis.title.y=element_text(size=16,color="#737373", vjust=.5))
}