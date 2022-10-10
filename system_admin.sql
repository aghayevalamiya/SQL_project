/* Birinci tapsiriq */

select game_players,
listagg((case when score_players>=21 then name_players end ),',') as name_1,
listagg((case when (score_players<21 and score_players>=15) then name_players end ),',') as name_2,
listagg((case when score_players<15 then name_players end ),',') as name_3
from
(select t1.game as game_players,t2.name name_players,sum(t1.score) as score_players
from games t1 inner join players t2 on t1.player=t2.player group by t1.game,t2.name)
group by game_players

/* Ikinci tapsiriq */

select player,
listagg((case when score_player>=21 then game  end ),',') birinci_yer,
listagg((case when score_player<21 and score_player>=15 then game  end ),',') ikinci_yer,
listagg((case when score_player < 15 then game  end ),',') ucuncu_yer
from 
(select player,game,sum(score) as score_player from games group by game,player)
group by player

/* Ucuncu tapsiriq */

select game_players,
sum(case when score_players>=21 then  age_players end ) as name_1,
sum(case when score_players<21 and score_players>=15 then  age_players end ) as name_2,
sum(case when score_players<15 then  age_players end) as name_3,
greatest(nvl(sum(case when score_players>=21 then  age_players end ),0) ,
nvl(sum(case when score_players<21 and score_players>=15 then  age_players end ),0),
nvl(sum(case when score_players<15 then  age_players end) ,0)) as greatest_
from
(select t1.game as game_players,t2.name name_players,sum(t1.score) as score_players,t2.age as age_players
from games t1 inner join players t2 on t1.player=t2.player group by t1.game,t2.name,t2.age)
group by game_players






/* Dorduncu tapsiriq */




