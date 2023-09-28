select * from Spotify_Youtube;

-- list of unique Artist list 

select distinct Artist  from Spotify_Youtube;

-- counting total number of Unique Artist 
select count(distinct Artist) as Artist  from Spotify_Youtube;

-- Couting the number of tracks for each album 

select Album_type ,( count(Track) ) as 'Total Tracks' from Spotify_Youtube
group by Album_type


--  Total  Album
select sum(totaltracks) as totaltracks
from (select Album_type , count(*) as totaltracks
from Spotify_Youtube
group by Album_type
) as subquery;



--  Album Contribution

select Album_type, 
count(*)  as 'Total Tracks'
,
concat(cast(((count(*)*1.0 / 
(
select sum(totaltracks) as totaltracks
from (select count(*) as totaltracks
from Spotify_Youtube
) as subquery
) *1.0)*100)as decimal(10,2))
, 
'%')
as Precentage
from Spotify_Youtube
group by Album_type



---  top 10 Artist  basis on Views On Youtube

select top 10 Artist , sum(Views) as 'Total number of views' from Spotify_Youtube
group by Artist
order by sum(Views) desc

---  top 10 Artist  basis on Stream On Spotify

select top 10 Artist , sum(Duration_minute) as 'Total number of views' from Spotify_Youtube
group by Artist
order by sum(Duration_minute) desc

---  top 10 commented songs   On Youtube

select top 10 Track , Artist, Views , Album,Uri , Channel, Comments as 'Total number of Comments' from Spotify_Youtube
order by Comments desc



---  top 10 Liked songs   On Youtube

select top 10 Track , Artist,  Album,Uri , Channel, Likes as 'Total number of Likes' from Spotify_Youtube
order by Likes desc

-- Top 10 channel Basis on views

select top 10  Channel,sum(Views) as 'Total number of views' from Spotify_Youtube
group by Channel
order by sum(Views) desc

-- top 10 highest duration songs

select  top 10   Track ,concat(cast(Duration_minute as decimal (10,2)) ,'Minute')as Total_Minute from Spotify_Youtube
group by Track,Duration_minute
order by Duration_minute desc

-- Total Licenced songs

select count(Licensed) as 'Total Licensed Songs'  from Spotify_Youtube
where Licensed=1

-- Total UnLicenced songs

select count(Licensed) as 'Total UnLicensed Songs'  from Spotify_Youtube
where Licensed=0

-- Average time duration for Tracks 

select 
concat(cast((sum(Duration_minute) / 
count(*)) as decimal(10,2)) ,' Minute')
as 'Average Time Duration'
from Spotify_Youtube