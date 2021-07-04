require(googlesheets4)
require(tidyverse)

googlesheet_id='1jSyyujNat95vTgp5QV5ImruETdkHDARdk5kUvzWsHrY'; # fpl_20202021
dt_xga<-read_sheet(googlesheet_id,sheet="xga" ,skip = 1)

dt_xga_2022<-
  dt_xga%>%
  transmute(Player,Pos,
            Minutes=as.numeric(Min),
            xG=as.numeric((xG...28)),
            xA=as.numeric((xA...29)))
  
dt_xga_2022%>%arrange(-xG)
dt_xga_2022%>%arrange(-xA)
dt_xga_2022%>%mutate(xGxA=4*xG+3*xA)%>%arrange(-xGxA)
dt_xga_2022%>%mutate(ptpergoal=case_when(Pos=="GK"~6,
                                         Pos=="DF"~6,
                                         Pos=="MF"~5,
                                         Pos=="FW"~4,
                                         TRUE~4),
                     xGxA=ptpergoal*xG+3*xA)%>%
  arrange(-xGxA)%>%
  filter(Minutes>1200&Pos=="DF")%>%View()
  