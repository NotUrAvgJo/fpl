# Example codes for Day 2:
# 1) reading tibble from googlesheet
# 2) working with tables: filtering and deriving new columns
# 3) changing table shapes 
# 4) writing tibble back to googlesheet
# 5) introduction to plotting with ggplot

# An example of using libraries 
require(googlesheets4)
require(tidyverse)


# An example of reading a googlesheet.  The googlesheet_id is the name in the URL.  
# The 'sheet' is the name of the sheet.
# You need to login to your google account to access

googlesheet_id='1xZ1rNPKFYKic3PwHXrsTXHM5D9jFmQ6dxvZYLDUiviw'; # fpl_20202021
dt_fixture_raw<-read_sheet(googlesheet_id,sheet="fixture_raw")

dt_fixture_2021<-
  dt_fixture_raw%>%
  fill(Team)%>%
  filter(Opponent!="None")%>%
  mutate(opp_short=str_sub(Opponent,end=3),location=str_sub(Opponent,start=-2,end=-2))%>%
  select(team_short=Team,week=GW,opp_short,location)

# An example how to write back to to the googlesheet, into a sheet name "fixture_2021". 
# If the sheet does not exist in the googlesheet, then it will create the sheet.
# write_sheet(dt_fixture_2021,googlesheet_id_20202021,sheet="fixture_2021")

# An example of changing the shape of a tibble. 
# pivot_wider, pivot_longer are the two functions
# In this example, pivot_wider will change the shape of a tibble so that the column names are wide (by week)
# The column names not specified will be used as an ID - in this case, team_short and location
# The ID must be unique

dt_fixture_2021%>%
  pivot_wider(names_from = week,names_prefix="W",values_from=opp_short)

# An example of how to filter and to plot using tile
dt_fixture_2021%>%
  filter(team_short=="TOT" & week<=12)%>%  # filter only for a specific condition
  ggplot(aes(y=factor(week),x=team_short))+geom_tile(aes(fill=location))+geom_text(aes(label=opp_short))+
  labs(y="Week",x="Team",fill="Location")+
  theme(legend.position = "top")


