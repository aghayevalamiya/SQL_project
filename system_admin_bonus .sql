select * from games
/* Bonus tapsiriq */

select game_players,listagg(name_1,','),listagg(name_2,','),listagg(name_3,',')
from
(select A.*,row_number() over (partition by game_players order by name_1 desc,name_2 desc,name_3 desc) as row_number
from
(select game_players,
case when score_players>=21 then name_players end   name_1  ,
case when (score_players<21 and score_players>=15) then name_players end   name_2 ,
case when score_players<15 then name_players end  name_3 
from
(select t1.game as game_players,t2.name name_players,sum(t1.score) as score_players
from games t1 inner join players t2 on t1.player=t2.player group by t1.game,t2.name)
) A)
group by game_players
