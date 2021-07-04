googlesheet_id='1jSyyujNat95vTgp5QV5ImruETdkHDARdk5kUvzWsHrY'; # fpl_20202021
dt_fixture_raw<-read_sheet(googlesheet_id,sheet="fixture_raw")
dt_fixture_2021<-
  dt_fixture_raw%>%
  fill(Team)%>%
  filter(Opponent!="None")%>%
  select(Team,week=GW,Opponent,FDR)
dt_fixture_2021%>%
  filter(Team=="TOT")%>%
  ggplot(aes(x=week,y=FDR))+geom_tile(alpha=0.5)+
  geom_text(size=4,angle=45,aes(label=Opponent))+
  scale_x_continuous(breaks=seq(1,38,2))+
  labs(x="Week",y="FDR")+
  theme(legend.position = "top")

