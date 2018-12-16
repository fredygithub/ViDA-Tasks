use track

go

/*
Question: should we name it Matchmaker or AM?
*/
declare @tmpPhotoRanking table(StampDate datetime, ClientName nvarchar(100),  Analyst nvarchar(100), AM nvarchar(100))
Insert into @tmpPhotoRanking

Select '02/21/2018','Carol Stewart','kristin@virtualdatingassistants.com','Alberto' Union 
Select '02/04/2018','Ellie Wyeth ','kristin@virtualdatingassistants.com','Alberto' Union 
Select '01/22/2018','Nikki Trager','kristin@virtualdatingassistants.com','Alberto Orozco' Union 
Select '02/16/2018','Anthony Bunker','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/09/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Allison' Union 
Select '01/21/2018','Anthony Purcell ','kristin@virtualdatingassistants.com','Allison' Union 
Select '03/14/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Allison' Union 
Select '03/14/2018','Brian Acacio','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Allison' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Allison' Union 
Select '03/03/2018','Fred Heeren','kristin@virtualdatingassistants.com','Allison' Union 
Select '01/27/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/02/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Allison' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/03/2018','Mike Davis','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/07/2018','Mike Gleason','kristin@virtualdatingassistants.com','Allison' Union 
Select '01/31/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Allison' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Allison' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/23/2018','Rajan Singh','kristin@virtualdatingassistants.com','Allison' Union 
Select '03/03/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/02/2018','Shon Messer','kristin@virtualdatingassistants.com','Allison' Union 
Select '01/15/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Allison' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Allison ' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/08/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/23/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/12/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/14/2018','Brian Stephens','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/04/2018','Fred Heeren ','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/19/2018','Giorgio Cagliero ','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/09/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/23/2018','Justin Winchester ','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/24/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/27/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/07/2018','Mike Gleason','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/26/2018','Mouni Reddy ','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/05/2018','Nick Sharma ','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/30/2018','Nikhil Raghavan ','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/05/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Ally' Union 
Select '01/14/2018','Tanmay Rajpathank ','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/16/2018','Tom Melcher ','kristin@virtualdatingassistants.com','Ally' Union 
Select '03/23/2018','Yogi Kantharia ','kristin@virtualdatingassistants.com','Ally' Union 
Select '02/06/2018','Andy Bose','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Amy' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Amy' Union 
Select '01/12/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Amy' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/02/2018','Michael Shiff','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/06/2018','Mike Gleason','kristin@virtualdatingassistants.com','Amy' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Amy' Union 
Select '01/30/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Amy' Union 
Select '01/25/2018','Paul Hermann','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/27/2018','Peter Strohm','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/23/2018','Rajan Singh','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/03/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Amy' Union 
Select '02/17/2018','Steve Halliday','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/24/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Amy' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Ana Perez' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Ana Perez' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Ana Perez' Union 
Select '03/22/2018','Peter Biedak ','kristin@virtualdatingassistants.com','Ana Perez' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Ana Perez' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/09/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/21/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/19/2018','Dan Graham','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/04/2018','Fred Heeren','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/08/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/23/2018','Justin Winchester','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/23/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/26/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/13/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/01/2018','Michael Talbot','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/06/2018','Mike Gleason','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/30/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/05/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/24/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/03/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/04/2018','Fred Heeren','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/07/2018','Kyle Johnson ','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/06/2018','Matt Terlp','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/05/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/22/2018','Peter Biedak','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/24/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Andrea Hounsell ' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Andrea Hounsell ' Union 
Select '03/17/2018','John Connors ','kristin@virtualdatingassistants.com','Andrea Hounsell ' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Andrea Hounsell ' Union 
Select '03/03/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Andrea Hounsell ' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Andrea Hounsell ' Union 
Select '02/05/2018','Alison McNeil','kristin@virtualdatingassistants.com','Andrew' Union 
Select '02/20/2018','Carol Stewart','kristin@virtualdatingassistants.com','Andrew' Union 
Select '02/04/2018','Ellie Wyeth','kristin@virtualdatingassistants.com','Andrew' Union 
Select '01/23/2018','NIkki Trager','kristin@virtualdatingassistants.com','Andrew' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/09/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/22/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/14/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/14/2018','Brian Stephens','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/25/2018','Chris Duncan ','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/25/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/04/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/12/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/04/2018','Fred Heeren','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/17/2018','James Shook','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/18/2018','John Connors','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/24/2018','Justin Winchester','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/24/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/27/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/02/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/03/2018','Michael Schiff','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/03/2018','Mike Davis','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/07/2018','Mike Gleason','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/23/2018','Rajan Singh','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/04/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/18/2018','Steve Holliday','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/15/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/17/2018','Tom Melcher','kristin@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/24/2018','Mike Hawk','kristin@virtualdatingassistants.com','Arielle Lindsey  ' Union 
Select '02/02/2018','Shon Messer','kristin@virtualdatingassistants.com','Arielle Lindsey  ' Union 
Select '02/05/2018','Alison McNeil','kristin@virtualdatingassistants.com','Ben Gebler' Union 
Select '02/20/2018','Carol Stewart','kristin@virtualdatingassistants.com','Ben Gebler' Union 
Select '02/05/2018','Ellie Wyeth','kristin@virtualdatingassistants.com','Ben Gebler' Union 
Select '01/22/2018','Nikki Trager','kristin@virtualdatingassistants.com','Ben Gebler' Union 
Select '02/05/2018','Alison McNeil','kristin@virtualdatingassistants.com','BenJ' Union 
Select '02/20/2018','Carol Stewart','kristin@virtualdatingassistants.com','BenJ' Union 
Select '02/04/2018','Ellie Wyeth','kristin@virtualdatingassistants.com','BenJ' Union 
Select '01/23/2018','Nikki Trager','kristin@virtualdatingassistants.com','BenJ' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/08/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/06/2018','Bonnie','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/12/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/23/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/26/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/26/2018','Michael Lee','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/30/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/24/2018','Paul Hermann','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '03/04/2018','Robert Ronchi','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Bonnie' Union 
Select '01/21/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Bonnie L' Union 
Select '01/23/2018','Justin Winchester','kristin@virtualdatingassistants.com','Bonnie L' Union 
Select '01/22/2018','Mike Hawk','kristin@virtualdatingassistants.com','Bonnie L' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Bonnie Lamer' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Bonnie Lamer' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Bonnie Lamer' Union 
Select '01/08/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Bonnie Lamer' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Bonnie Lamer' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Bonnie Lamer' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/09/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/23/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/11/2018','Dan Twaddell ','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/09/2018','Glenn Degelleke ','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/23/2018','Justin Winchester','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/23/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/26/2018','Kurt Heiser ','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/07/2018','Mike Gleason ','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/22/2018','Mike Hawk','kristin@virtualdatingassistants.com','brianne Castro' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/26/2018','Peter Strohm ','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/23/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/26/2018','Chris Duncan','kristin@virtualdatingassistants.com','Chloe' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Chloe' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/12/2018','John Rodgers','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/23/2018','Justin Winchester','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/23/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Chloe' Union 
Select '02/02/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/26/2018','Michael Lee','kristin@virtualdatingassistants.com','Chloe' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Chloe' Union 
Select '02/03/2018','Mike Davis','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Chloe' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/11/2018','Vaibhav Mallya','kristin@virtualdatingassistants.com','Chloe' Union 
Select '01/09/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Chloe Rose' Union 
Select '02/04/2018','alison mcneil','kristin@virtualdatingassistants.com','Connor' Union 
Select '02/19/2018','Carol Stewart','kristin@virtualdatingassistants.com','connor' Union 
Select '02/06/2018','Andy Bose','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/22/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Ellie' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/14/2018','Brian Stephens','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/04/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/12/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Ellie' Union 
Select '03/04/2018','Fred Heeran','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/10/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/07/2018','Gus Jursch','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/07/2018','Kevin Jenks','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/24/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Ellie' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/02/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Ellie' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Ellie' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/03/2018','Micheal Schiff','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/06/2018','Mike Gleason','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/06/2018','Nick Sharma','kristin@virtualdatingassistants.com','Ellie' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/27/2018','Peter Strohm','kristin@virtualdatingassistants.com','Ellie' Union 
Select '03/04/2018','Robert Ronchi','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/18/2018','Steve Holliday','kristin@virtualdatingassistants.com','Ellie' Union 
Select '01/15/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Ellie' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/09/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/22/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/14/2018','Dave Stech','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/03/2018','Fred Heeren','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/09/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/23/2018','Justin Winchester','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/23/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/26/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/13/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/02/2018','Michael Shiff','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/01/2018','Michael Talbot','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/06/2018','Mike Gleason','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/30/2018','Nasim Tukhi ','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/05/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/24/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/21/2018','Peter Biedak ','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/03/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Jacki' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Jacki' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/23/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Jacki' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Jamila' Union 
Select '03/27/2018','Brian Prout','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '02/15/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '01/10/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '01/27/2018','Kurt Heiser ','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '02/14/2018','Kurt Mueller k','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '01/25/2018','Michael Lee ','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '03/27/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '01/30/2018','Nasim Tukhi ','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '02/23/2018','Rajan Singh','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '02/17/2018','Steve Holliday ','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '03/23/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Jamila ' Union 
Select '02/20/2018','Carol Stewart','kristin@virtualdatingassistants.com','Jarred ' Union 
Select '03/13/2018','Brett Maugeri ','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/03/2018','Fred Heeren','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/07/2018','Kyle Johnson ','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/03/2018','Robert Rinchi ','kristin@virtualdatingassistants.com','Jasmine Vo' Union 
Select '01/23/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '03/14/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/15/2018','DAVE Stech','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/23/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/26/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/13/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/02/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '03/02/2018','Michaek Talbot','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/25/2018','Michael Lee ','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/02/2018','Mike davis','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/07/2018','Mike Gleason','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/27/2018','Peter Strohm','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '01/15/2018','Tanmay Rajpathak','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '03/24/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Jen Smith' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '01/09/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/24/2018','Konrad Kalkurst','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '03/13/2018','Marko Strinic','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/05/2018','Alison McNeil','kristin@virtualdatingassistants.com','Josh G' Union 
Select '02/20/2018','Carol Stewart','kristin@virtualdatingassistants.com','Josh G' Union 
Select '01/23/2018','Nikki Trager ','kristin@virtualdatingassistants.com','Josh G' Union 
Select '02/15/2018','KRISTIN HARRIS TEST','kristin@virtualdatingassistants.com','KRISTIN HARRIS' Union 
Select '02/08/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/26/2018','Biran Prout','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/12/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/03/2018','Fred Heeren','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/01/2018','Michael Talbot','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/23/2018','Rajan Singh','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/03/2018','Robert Ronchi','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Lorena' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Lorena' Union 
Select '02/08/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/19/2018','Dan Graham','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/03/2018','Fred Heeren','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/07/2018','Matt Terlop','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/01/2018','Michael Talbot','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/05/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/03/2018','Robert Ronchi','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/24/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/04/2018','Alison McNeil','kristin@virtualdatingassistants.com','Mark Reagan' Union 
Select '02/19/2018','Carol Stewart','kristin@virtualdatingassistants.com','Mark Reagan' Union 
Select '02/04/2018','Ellie Wyeth','kristin@virtualdatingassistants.com','Mark Reagan' Union 
Select '01/23/2018','Nikki Trager','kristin@virtualdatingassistants.com','Mark Reagan' Union 
Select '02/04/2018','Alison McNeil','kristin@virtualdatingassistants.com','Mike J' Union 
Select '02/20/2018','Carol Stewart','kristin@virtualdatingassistants.com','Mike J' Union 
Select '02/04/2018','Ellie Wyeth','kristin@virtualdatingassistants.com','Mike J' Union 
Select '01/22/2018','Nikki Trager','kristin@virtualdatingassistants.com','Mike J' Union 
Select '02/02/2018','Ken Howery','kristin@virtualdatingassistants.com','N/A' Union 
Select '03/12/2018','Brett Maugari','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/27/2018','Mouni Reddi','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/23/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/04/2018','Fred Heeren','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/04/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Olivia' Union 
Select '03/24/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Olivia' Union 
Select '02/06/2018','Andy Bose','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/22/2018','Anthony Purcell ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/24/2018','Conrad Kalkhurst ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/20/2018','Dan Graham ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/15/2018','Dave Stech ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/04/2018','Fred Heeren ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/09/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/18/2018','John Connors','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/22/2018','Justin Vlaovic ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/24/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/26/2018','Kurt Heiser ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/02/2018','Michael Talbot ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/07/2018','Mike Gleason ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/24/2018','Mike Hawk','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/31/2018','Nikhil Raghavan ','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/04/2018','Robert Ronchi','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Onawa' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Onawa' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Onawa' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Onawa ' Union 
Select '01/24/2018','Justin Winchester','kristin@virtualdatingassistants.com','Onawa ' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Onawa ' Union 
Select '03/07/2018','Paul Hotaling ','kristin@virtualdatingassistants.com','Onawa ' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/04/2018','Fred Heeren','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/18/2018','John Connors','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/07/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '02/06/2018','Andrew Bose','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/22/2018','Anthony Purcell ','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/14/2018','Brian Stephens','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/09/2018','Glenn Degelleke ','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/24/2018','Justin Winchester','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '02/07/2018','Mike Gleason','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/31/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '02/23/2018','Rajan Singh','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Rebecca' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '01/25/2018','Chris Duncan ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '02/24/2018','Conrad Kalkhurst ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '01/15/2018','Dave Stech ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '01/27/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '02/01/2018','Lawrence Radu ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/05/2018','Matthew Kruse ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '02/02/2018','Michael Schiff','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/02/2018','Michael Talbot ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '02/06/2018','Nick Sharma','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '01/25/2018','Paul Herrmann ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/07/2018','Paul Hotaling','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/03/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/24/2018','Yogi Kantharia ','kristin@virtualdatingassistants.com','Rebecca ' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Rebecca Brown' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Rebecca Brown' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Rebecca Brown' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/09/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/21/2018','Anthony Purcell','kristin@virtualdatingassistants.com','ROSALIA' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/06/2018','Brett Oliver','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/27/2018','Brian Prout','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/03/2018','Fred Heeren','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/24/2018','Guy White','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/18/2018','John Connors','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/23/2018','Justin Winchester','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/24/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/13/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/07/2018','Matt Terlop','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/25/2018','Michael Lee','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/02/2018','Michael Schiff ','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/07/2018','Mike Gleason','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/27/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/03/2018','Robert Ronchi','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '03/24/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Rosalia' Union 
Select '02/04/2018','Alison McNeil','kristin@virtualdatingassistants.com','Ryan Willis' Union 
Select '02/04/2018','Ellie Wyeth','kristin@virtualdatingassistants.com','Ryan Willis' Union 
Select '01/23/2018','Nikki Trager','kristin@virtualdatingassistants.com','Ryan Willis' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Samantha' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Samantha' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Samantha' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Samantha' Union 
Select '01/30/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Samantha' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Samantha' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/04/2018','Fred Heeren ','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/17/2018','John Connors','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/07/2018','Kyle Johnson ','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/05/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/21/2018','Peter Biedak','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/03/2018','Robert Ronchi','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '03/23/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Sara Graham' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/09/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/22/2018','Anthony Purcell','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/13/2018','Brett Maugeri','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/14/2018','Brian Stephens','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/03/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/20/2018','Dan Graham','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/11/2018','Dan Twaddell','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/03/2018','David Shapiro','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/14/2018','Dmitry Berdnikov','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/16/2018','James Shook','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/18/2018','John Connors','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/11/2018','John Rodgers','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/24/2018','Justin Winchester','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/24/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/27/2018','Kurt Heiser','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/14/2018','Kurt Mueller','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/08/2018','Kyle Johnson','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/01/2018','Lawrence Radu','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/06/2018','Matt Terlop','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/14/2018','Merrit Quirk','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/02/2018','Michael Shiff','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/02/2018','Mike Davis','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/07/2018','Mike Gleason','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/23/2018','Mike Hawk','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/26/2018','Mouni Reddy','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/31/2018','Nikhil Raghavan','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/06/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/25/2018','Paul Herrmann','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/27/2018','Peter Strohm','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/03/2018','Robert Rinchi','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Sheri' Union 
Select '02/17/2018','Steve Holliday ','kristin@virtualdatingassistants.com','Sheri' Union 
Select '01/15/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/16/2018','Tom Melcher','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/23/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','Sheri' Union 
Select '03/26/2018','Brian Prout','kristin@virtualdatingassistants.com','Stac' Union 
Select '01/13/2018','Brian Stephens','kristin@virtualdatingassistants.com','Stac' Union 
Select '02/04/2018','Dan Dumitru','kristin@virtualdatingassistants.com','Stac' Union 
Select '01/12/2018','Dan Twaddell ','kristin@virtualdatingassistants.com','Stac' Union 
Select '02/04/2018','David Shapiro','kristin@virtualdatingassistants.com','Stac' Union 
Select '01/26/2018','Kurt Heiser ','kristin@virtualdatingassistants.com','Stac' Union 
Select '03/02/2018','Michael Talbot','kristin@virtualdatingassistants.com','Stac' Union 
Select '02/02/2018','Mike Davis ','kristin@virtualdatingassistants.com','stac' Union 
Select '02/06/2018','Mike Gleason','kristin@virtualdatingassistants.com','Stac' Union 
Select '03/26/2018','Mouni Reddy ','kristin@virtualdatingassistants.com','Stac' Union 
Select '01/31/2018','Nikhil Raghavan ','kristin@virtualdatingassistants.com','Stac' Union 
Select '02/22/2018','Rajan Singh','kristin@virtualdatingassistants.com','Stac' Union 
Select '03/03/2018','Robert Rinchi ','kristin@virtualdatingassistants.com','stac' Union 
Select '01/14/2018','Tanmay Rajpathank','kristin@virtualdatingassistants.com','Stac' Union 
Select '02/01/2018','Terrence Wong','kristin@virtualdatingassistants.com','Stac' Union 
Select '02/05/2018','Andrew Bose','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/08/2018','Anthony Ibrahim','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/06/2018','Brett Oliver','kristin@virtualdatingassistants.com','Stacy' Union 
Select '03/25/2018','Brian Acacio ','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/25/2018','Chris Duncan','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/24/2018','Conrad Kalkhurst','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/15/2018','Dave Stech','kristin@virtualdatingassistants.com','Stacy' Union 
Select '03/03/2018','Fred Heeren','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/19/2018','Giorgio Cagliero','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/09/2018','Glenn Degelleke','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/15/2018','Joseph Zulueta','kristin@virtualdatingassistants.com','Stacy' Union 
Select '03/22/2018','Justin Vlaovic','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/23/2018','Justin Winchester ','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/01/2018','Lawrence Radu ','kristin@virtualdatingassistants.com','Stacy' Union 
Select '03/06/2018','Matt Terlop ','kristin@virtualdatingassistants.com','Stacy' Union 
Select '03/05/2018','Matthew Kruse','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/25/2018','Michael Lee ','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/02/2018','Michael Schiff ','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/22/2018','Mike Hawk','kristin@virtualdatingassistants.com','Stacy' Union 
Select '01/30/2018','Nasim Tukhi','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/05/2018','Nick Sharma','kristin@virtualdatingassistants.com','Stacy' Union 
Select '03/05/2018','Patrick Larkin','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/26/2018','Peter Strohm','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/24/2018','Ross Molden','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/01/2018','Shon Messer','kristin@virtualdatingassistants.com','Stacy' Union 
Select '02/17/2018','Steve Holliday','kristin@virtualdatingassistants.com','Stacy' Union 
Select '03/23/2018','Yogi Kantharia','kristin@virtualdatingassistants.com','stacy' Union 
Select '01/23/2018','Konrad Jamrozik','kristin@virtualdatingassistants.com','Stacy ' Union 
Select '01/20/2018','Allison','meagan@virtualdatingassistants.com','Allison' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Ally' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Ally' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Ally' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Ally' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Ally' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Ally' Union 
Select '02/02/2018','Ken Howery','meagan@virtualdatingassistants.com','Ally' Union 
Select '01/20/2018','Yifeng Xu ','meagan@virtualdatingassistants.com','Ally' Union 
Select '02/15/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Amy' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Amy' Union 
Select '03/06/2018','JD Steanson','meagan@virtualdatingassistants.com','Amy' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Amy' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Ana Perez' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Ana Perez' Union 
Select '02/15/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Andie Hunter' Union 
Select '01/19/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Andie Hunter' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/26/2018','Brian Acacio','meagan@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '03/15/2018','Kev Devore','meagan@virtualdatingassistants.com','Andrea Hounsell' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '01/20/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Arielle Lindsey ' Union 
Select '02/15/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Bonnie' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Bonnie' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Bonnie' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Bonnie' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Bonnie' Union 
Select '01/19/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Bonnie Lamer' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/26/2018','Brian Acacio','meagan@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/06/2018','JD Steanson','meagan@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Brianne Castro' Union 
Select '03/15/2018','Ken Devore ','meagan@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/20/2018','Yifeng Xu ','meagan@virtualdatingassistants.com','Brianne Castro' Union 
Select '01/21/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Chloe' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Ellie' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Ellie' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Ellie' Union 
Select '01/20/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Ellie' Union 
Select '02/16/2018','Anthony Bunker ','meagan@virtualdatingassistants.com','Jacki' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Jacki' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Jacki' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Jacki' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Jacki' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Jacki' Union 
Select '01/19/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Jacki' Union 
Select '03/16/2018','Ken Devore ','meagan@virtualdatingassistants.com','Jamila ' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/06/2018','JD Steanson ','meagan@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Jasmine Vo' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Jen Smith' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Jen Smith' Union 
Select '03/06/2018','JD Steanson','meagan@virtualdatingassistants.com','Jen Smith' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Jen Smith' Union 
Select '02/02/2018','Ken Howery','meagan@virtualdatingassistants.com','Jen Smith' Union 
Select '01/20/2018','YiFeng Xu','meagan@virtualdatingassistants.com','Jen Smith' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Jennifer Smith' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Jennifer Smith' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Lorena' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Lorena' Union 
Select '03/24/2018','Brian Acacio','meagan@virtualdatingassistants.com','Lorena' Union 
Select '03/06/2018','JD Steanson','meagan@virtualdatingassistants.com','Lorena' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Lorena' Union 
Select '02/15/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Lynsi Williams' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Lynsi Williams' Union 
Select '02/02/2018','Ken Howery','meagan@virtualdatingassistants.com','Michelle Johnson' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/06/2018','JD Steanson','meagan@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Nova Johnstone' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Olivia' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Olivia' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Olivia' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Olivia' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Olivia' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Onawa' Union 
Select '03/06/2018','JD Steanson','meagan@virtualdatingassistants.com','Onawa' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Onawa' Union 
Select '01/20/2018','Yifeng Xu ','meagan@virtualdatingassistants.com','Onawa' Union 
Select '03/15/2018','Ken Devore ','meagan@virtualdatingassistants.com','Onawa ' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Rachel Gallagher' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Rebecca' Union 
Select '03/06/2018','JD Steanson ','meagan@virtualdatingassistants.com','Rebecca' Union 
Select '01/19/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Rebecca' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Rebecca ' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Rebecca ' Union 
Select '03/16/2018','Brian Acacio','meagan@virtualdatingassistants.com','Rebecca Brown' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Rebecca Brown' Union 
Select '03/13/2018','Brian Acacio','meagan@virtualdatingassistants.com','Rosalia' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Rosalia' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Rosalia' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Rosalia' Union 
Select '02/02/2018','Ken Howery','meagan@virtualdatingassistants.com','Rosalia' Union 
Select '01/20/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Rosalia' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Sara Graham' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Sara Graham' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Sara Graham' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Sara Graham' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Sara Graham' Union 
Select '02/16/2018','Anthony Bunker','meagan@virtualdatingassistants.com','Sheri' Union 
Select '03/14/2018','Brian Acacio','meagan@virtualdatingassistants.com','Sheri' Union 
Select '03/25/2018','Brian Acacio','meagan@virtualdatingassistants.com','Sheri' Union 
Select '03/06/2018','JD Steanson','meagan@virtualdatingassistants.com','Sheri' Union 
Select '03/15/2018','Ken Devore','meagan@virtualdatingassistants.com','Sheri' Union 
Select '03/16/2018','Ken Devore','meagan@virtualdatingassistants.com','Sheri' Union 
Select '01/20/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Sheri' Union 
Select '01/19/2018','Yifeng Xu','meagan@virtualdatingassistants.com','Stac' Union 
Select '02/16/2018','Anthony Bunker ','meagan@virtualdatingassistants.com','Stacy' Union 
Select '03/05/2018','JD Steanson','meagan@virtualdatingassistants.com','Stacy' Union 
Select '02/02/2018','Ken Howery','meagan@virtualdatingassistants.com','Stacy' Union 
Select '02/24/2018','Angela Antony','michelle@clickmagnetdating.com','24' Union 
Select '01/31/2018','Debra Charles','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/22/2018','Divya Mehra','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/08/2018','Divya Mehra ','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/18/2018','Katie Shepherd','michelle@clickmagnetdating.com','Alberto' Union 
Select '03/07/2018','Kelly McGlothlin ','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/14/2018','Lara Koslow ','michelle@clickmagnetdating.com','Alberto' Union 
Select '03/08/2018','Leslie Brown','michelle@clickmagnetdating.com','Alberto' Union 
Select '03/09/2018','Leslie Brown','michelle@clickmagnetdating.com','ALberto' Union 
Select '02/25/2018','Letitia Pinson','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/02/2018','Lorna Breen','michelle@clickmagnetdating.com','Alberto' Union 
Select '03/10/2018','Meagan','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/11/2018','Rachel Heller','michelle@clickmagnetdating.com','Alberto' Union 
Select '03/10/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/07/2018','Shirly Mani ','michelle@clickmagnetdating.com','Alberto' Union 
Select '02/24/2018','Wendy Svarre ','michelle@clickmagnetdating.com','Alberto' Union 
Select '01/16/2018','Ada Cooper','michelle@clickmagnetdating.com','Alberto Orozco' Union 
Select '01/28/2018','Emily Gray','michelle@clickmagnetdating.com','Alberto Orozco' Union 
Select '01/20/2018','Julie Ward ','michelle@clickmagnetdating.com','Alberto Orozco' Union 
Select '01/18/2018','Kathy Laux','michelle@clickmagnetdating.com','Alberto Orozco' Union 
Select '01/13/2018','Reba Rosenthal','michelle@clickmagnetdating.com','Alberto Orozco' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Allison' Union 
Select '02/14/2018','Alex McCauley ','michelle@clickmagnetdating.com','Allison' Union 
Select '02/08/2018','Anthony Navarini ','michelle@clickmagnetdating.com','Allison' Union 
Select '02/07/2018','Brett Oliver','michelle@clickmagnetdating.com','Allison' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Allison' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Allison' Union 
Select '01/28/2018','Chris Barbieri','michelle@clickmagnetdating.com','Allison' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Allison' Union 
Select '01/20/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Allison' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Allison' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Allison' Union 
Select '03/12/2018','Gerard Juarez','michelle@clickmagnetdating.com','Allison' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Allison' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Allison' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Allison' Union 
Select '01/20/2018','James Duncan','michelle@clickmagnetdating.com','Allison' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Allison' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Allison' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Allison' Union 
Select '01/07/2018','Kevin Jenks','michelle@clickmagnetdating.com','Allison' Union 
Select '01/27/2018','Mani Aleyas','michelle@clickmagnetdating.com','Allison' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Allison' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Allison' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Allison' Union 
Select '03/01/2018','Mike Bliskell ','michelle@clickmagnetdating.com','Allison' Union 
Select '01/15/2018','Paul Shattuck','michelle@clickmagnetdating.com','Allison' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Allison' Union 
Select '01/20/2018','Ryan Kostolni ','michelle@clickmagnetdating.com','Allison' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Allison' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Allison' Union 
Select '02/02/2018','Terrence Wong','michelle@clickmagnetdating.com','Allison' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Allison' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Allison' Union 
Select '01/13/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Allison' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Allison' Union 
Select '03/14/2018','Merritt Quick','michelle@clickmagnetdating.com','Allison ' Union 
Select '02/16/2018','Michael Feinstein','michelle@clickmagnetdating.com','Allison ' Union 
Select '02/24/2018','Ross Molden ','michelle@clickmagnetdating.com','Allison ' Union 
Select '02/14/2018','Alex McCauley ','michelle@clickmagnetdating.com','Ally' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Ally' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Ally' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Ally' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Ally' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Ally' Union 
Select '01/28/2018','Chris Barbieri','michelle@clickmagnetdating.com','Ally' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Ally' Union 
Select '01/20/2018','Dan Kushkuley ','michelle@clickmagnetdating.com','Ally' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Ally' Union 
Select '03/10/2018','David Paul ','michelle@clickmagnetdating.com','Ally' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Ally' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Ally' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Ally' Union 
Select '02/07/2018','Greg Karr ','michelle@clickmagnetdating.com','Ally' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Ally' Union 
Select '01/20/2018','James Duncan','michelle@clickmagnetdating.com','Ally' Union 
Select '03/17/2018','Jared Raia ','michelle@clickmagnetdating.com','Ally' Union 
Select '03/14/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Ally' Union 
Select '01/06/2018','Jordan Milan ','michelle@clickmagnetdating.com','Ally' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Ally' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Ally' Union 
Select '02/22/2018','Kevin Curtin ','michelle@clickmagnetdating.com','Ally' Union 
Select '01/07/2018','Kevin Jenks','michelle@clickmagnetdating.com','Ally' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Ally' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Ally' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Ally' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Ally' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Ally' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Ally' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Ally' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Ally' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Ally' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Ally' Union 
Select '03/02/2018','Michael Stevens ','michelle@clickmagnetdating.com','Ally' Union 
Select '03/01/2018','Michael Talbot ','michelle@clickmagnetdating.com','Ally' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Ally' Union 
Select '03/17/2018','Nick Dodson ','michelle@clickmagnetdating.com','Ally' Union 
Select '01/14/2018','Paul Shattuck','michelle@clickmagnetdating.com','Ally' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Ally' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Ally' Union 
Select '03/22/2018','Reed Scott ','michelle@clickmagnetdating.com','Ally' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Ally' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Ally' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Ally' Union 
Select '01/21/2018','Tallal Mirza ','michelle@clickmagnetdating.com','Ally' Union 
Select '02/17/2018','Teague Lasser ','michelle@clickmagnetdating.com','Ally' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Ally' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Ally' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Ally' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Ally' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Ally' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Ally' Union 
Select '03/08/2018','Yusen Li ','michelle@clickmagnetdating.com','Ally' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Amy' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Amy' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Amy' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Amy' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Amy' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Amy' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Amy' Union 
Select '03/11/2018','Gerard Juarez','michelle@clickmagnetdating.com','Amy' Union 
Select '01/08/2018','Gus Jursch','michelle@clickmagnetdating.com','Amy' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Amy' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Amy' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Amy' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Amy' Union 
Select '02/23/2018','Kevin Curtin','michelle@clickmagnetdating.com','Amy' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Amy' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Amy' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Amy' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Amy' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Amy' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Amy' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Amy' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Amy' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Amy' Union 
Select '03/17/2018','Nick Dodson','michelle@clickmagnetdating.com','Amy' Union 
Select '03/09/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Amy' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Amy' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Amy' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Amy' Union 
Select '01/22/2018','Tallal Mirza','michelle@clickmagnetdating.com','Amy' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Amy' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Amy' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Amy' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Amy' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Amy' Union 
Select '02/17/2018','Vance Campbell','michelle@clickmagnetdating.com','Amy' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Amy' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Amy Mooney' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/12/2018','Gerard Juarez','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/14/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/17/2018','Ryan Hendix','michelle@clickmagnetdating.com','Ana Perez' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/27/2018','Chris Barbieri','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/19/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/11/2018','Gerard Juarez','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/06/2018','Gus Jursch','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/20/2018','James Duncan','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/21/2018','Kevin Curtin','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/06/2018','Kevin Jenks','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/17/2018','Nick Dodson','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/14/2018','Paul Shattuck','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/23/2018','Ross Molden','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Andie Hunter' Union 
Select '03/18/2018','Brad Hunt ','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/03/2018','Dennis Li','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Andrea Hounsell' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/15/2018','Jeff Kulinsky ','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/09/2018','Kip Birgen ','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/13/2018','Marko Strinic ','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/22/2018','Reed Scott ','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Andrea Hounsell ' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Andrea Hounsell1' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Andrea Hounsell1' Union 
Select '01/17/2018','Ada Cooper','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/24/2018','Angela Antony','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/31/2018','Debra Charles','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/23/2018','Divya Mehra','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/07/2018','Divya Mehra','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/27/2018','Emily Gray','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/20/2018','Julie Ward','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/17/2018','Kathy Laux','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/18/2018','Katie Shephard','michelle@clickmagnetdating.com','Andrew' Union 
Select '03/06/2018','Kelly McGlothlin','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/14/2018','Lara Koslow','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/06/2018','Laurie Leidig','michelle@clickmagnetdating.com','Andrew' Union 
Select '03/07/2018','Leslie Brown','michelle@clickmagnetdating.com','Andrew' Union 
Select '03/09/2018','Leslie Brown','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/25/2018','Letitia Pinson','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/01/2018','Lorna Breen','michelle@clickmagnetdating.com','Andrew' Union 
Select '03/10/2018','Meagan Kaufman','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/11/2018','Rachel Heller','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/13/2018','Reba Rosenthal','michelle@clickmagnetdating.com','Andrew' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/07/2018','Shirly Mani','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Andrew' Union 
Select '02/24/2018','Wendy Svarre','michelle@clickmagnetdating.com','Andrew' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Arielle Lindsey' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/14/2018','Ben Horowitz','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/07/2018','Brett Oliver','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/05/2018','Brett Oliver ','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/28/2018','Chris Barbieri','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/20/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/12/2018','Gerard Juarez','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/08/2018','Gus Jursch','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/21/2018','James Duncan','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/18/2018','Jared Raia','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/07/2018','Jordan Milan','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/22/2018','Kevin Curtin','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/07/2018','Kevin Jenks','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/27/2018','Mani Aleyas','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/14/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/15/2018','Paul Shattuck','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '03/18/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/18/2018','Tony Wagner','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '01/13/2018','Tyler Hartmann ','michelle@clickmagnetdating.com','Arielle Lindsey ' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Arielle Lindsey  ' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Arielle Lindsey  ' Union 
Select '01/12/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Arielle Lindsey  ' Union 
Select '01/16/2018','Ada Cooper','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '01/31/2018','Debra Charles','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '02/08/2018','Divya Mehra','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '01/29/2018','Emily Gray','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '02/18/2018','Katie Shepherd','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '02/15/2018','Lara Koslow','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '01/06/2018','Laurie Leidig','michelle@clickmagnetdating.com','Ben gebler' Union 
Select '02/25/2018','Letitia Pinson','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '02/01/2018','Lorna Breen','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '02/12/2018','Rachel Heller','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '02/08/2018','Shirly Mani','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Ben Gebler' Union 
Select '02/24/2018','Angela Antony','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/22/2018','Divya Mehra','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/08/2018','Divya Mehra','michelle@clickmagnetdating.com','BenJ' Union 
Select '01/20/2018','Julie Ward','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/17/2018','Katie Shepherd','michelle@clickmagnetdating.com','BenJ' Union 
Select '03/07/2018','Kelly McGlothlin ','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/14/2018','Lara Koslow','michelle@clickmagnetdating.com','BenJ' Union 
Select '01/06/2018','Laurie Leidig','michelle@clickmagnetdating.com','BenJ' Union 
Select '03/07/2018','Leslie Brown','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/25/2018','Letitia Pinson','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/02/2018','Lorna Breen','michelle@clickmagnetdating.com','BenJ' Union 
Select '03/09/2018','Meagan','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/12/2018','Rachel Heller','michelle@clickmagnetdating.com','BenJ' Union 
Select '01/13/2018','Reba Rosenthal','michelle@clickmagnetdating.com','BenJ' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/07/2018','Shirly Mani','michelle@clickmagnetdating.com','BenJ' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','BenJ' Union 
Select '02/24/2018','Wendy Svarre','michelle@clickmagnetdating.com','BenJ' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Bonnie' Union 
Select '01/27/2018','Chris Barbieri','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/08/2018','Gary Greco','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/11/2018','Gerard Juarez','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/22/2018','Kevin Curtin','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Bonnie' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/14/2018','Merritt Quirk','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/16/2018','Teague Lasser','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/06/2018','Teddy Woodward','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Bonnie' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Bonnie' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Bonnie' Union 
Select '01/20/2018','James Duncan','michelle@clickmagnetdating.com','Bonnie L' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Bonnie L' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Bonnie L' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/19/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/07/2018','Kevin Jenks','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/19/2018','Michael Housman','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/14/2018','Paul Shattuck','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/19/2018','Thomas Weber','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Bonnie Lamer' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Brianne' Union 
Select '01/22/2018','Tallal Mirza','michelle@clickmagnetdating.com','Brianne' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Brianne' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/05/2018','Brett Oliver ','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/28/2018','Chris Barbieri','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/20/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/02/2018','Dennis Li ','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/09/2018','Gary Greco ','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/12/2018','Gerard Juarez','michelle@clickmagnetdating.com','brianne Castro' Union 
Select '02/07/2018','Greg Karr ','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/08/2018','Gus Jursch','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/22/2018','Kevin Curtin','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/06/2018','Teddy Woodward','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Brianne Castro' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Brianne Castro ' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/21/2018','James Duncan','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/15/2018','Paul Shattuck','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Chloe' Union 
Select '01/07/2018','Kevin Jenks','michelle@clickmagnetdating.com','Chloe R' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Chloe Rose' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Chloe Rose' Union 
Select '01/17/2018','Ada Cooper','michelle@clickmagnetdating.com','Connor' Union 
Select '02/24/2018','Angela Antony','michelle@clickmagnetdating.com','Connor' Union 
Select '02/01/2018','Debra Charles','michelle@clickmagnetdating.com','connor' Union 
Select '02/21/2018','Divya Mehra','michelle@clickmagnetdating.com','connor' Union 
Select '02/07/2018','Divya Mehra','michelle@clickmagnetdating.com','Connor' Union 
Select '01/28/2018','Emily Gray','michelle@clickmagnetdating.com','connor' Union 
Select '01/20/2018','Julie Ward','michelle@clickmagnetdating.com','connor' Union 
Select '01/18/2018','Kathy Laux','michelle@clickmagnetdating.com','connor' Union 
Select '02/17/2018','katie shepherd','michelle@clickmagnetdating.com','connor' Union 
Select '03/07/2018','Kelly McGlothlin','michelle@clickmagnetdating.com','Connor' Union 
Select '02/14/2018','Lara Koslow','michelle@clickmagnetdating.com','connor' Union 
Select '01/06/2018','Laurie Leidig','michelle@clickmagnetdating.com','Connor' Union 
Select '03/07/2018','Leslie brown','michelle@clickmagnetdating.com','connor' Union 
Select '03/09/2018','Leslie Brown','michelle@clickmagnetdating.com','connor' Union 
Select '02/26/2018','Letitia Pinson','michelle@clickmagnetdating.com','Connor' Union 
Select '02/02/2018','Lorna Breen','michelle@clickmagnetdating.com','connor' Union 
Select '03/10/2018','meagan','michelle@clickmagnetdating.com','connor' Union 
Select '01/12/2018','Reba Rosenthal','michelle@clickmagnetdating.com','connor' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Connor' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Connor' Union 
Select '02/24/2018','Wendy Svarre','michelle@clickmagnetdating.com','Connor' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Ellie' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Ellie' Union 
Select '01/28/2018','Chris Barbieri','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/07/2018','Luis Flores','michelle@clickmagnetdating.com','Ellie' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Ellie' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/07/2018','Teddy Woodward','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Ellie' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Ellie' Union 
Select '02/18/2018','Tony Wagner','michelle@clickmagnetdating.com','Ellie' Union 
Select '01/12/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Ellie' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/08/2018','Anthony Navarini ','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','JAcki' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/06/2018','Brett Oliver ','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/01/2018','Chandra Shakermi','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/27/2018','Chris Barbieri','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/19/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/10/2018','David Paul','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/01/2018','Dennis Li','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/11/2018','Gerard Juarez','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/07/2018','Greg Karr ','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/23/2018','Guy White','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/20/2018','James Duncan','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/14/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/22/2018','Kevin Curtin','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/14/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/06/2018','Luis Flores ','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/02/2018','Michael Stevens','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/23/2018','Mike Johnson','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/14/2018','Paul Shattuck','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/21/2018','Reed Scott','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','JAcki' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/16/2018','Teague Lasser','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Jacki' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Jacki' Union 
Select '03/08/2018','Yusen Li ','michelle@clickmagnetdating.com','Jacki' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Jacki ' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Jacki Higgins' Union 
Select '01/06/2018','Kevin Jenks','michelle@clickmagnetdating.com','Jacki Higgins' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','jamila' Union 
Select '02/15/2018','Alex McCauley','michelle@clickmagnetdating.com','Jamila ' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Jamila ' Union 
Select '02/15/2018','David Johnson','michelle@clickmagnetdating.com','Jamila ' Union 
Select '01/20/2018','James Duncan ','michelle@clickmagnetdating.com','Jamila ' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Jamila ' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Jamila ' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','jamila ' Union 
Select '03/22/2018','Reed Scott ','michelle@clickmagnetdating.com','Jamila ' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Jamila ' Union 
Select '01/20/2018','Ryan Kostolni ','michelle@clickmagnetdating.com','Jamila ' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Jamila ' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Jamila ' Union 
Select '02/01/2018','Debra Charles','michelle@clickmagnetdating.com','Jarred' Union 
Select '02/08/2018','Divya Mehra','michelle@clickmagnetdating.com','Jarred' Union 
Select '03/08/2018','Leslie Brown','michelle@clickmagnetdating.com','Jarred' Union 
Select '02/02/2018','Lorna Breen','michelle@clickmagnetdating.com','Jarred' Union 
Select '03/09/2018','Meagan','michelle@clickmagnetdating.com','Jarred' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Jarred' Union 
Select '02/07/2018','Shirly Mani','michelle@clickmagnetdating.com','Jarred' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Jarred' Union 
Select '02/15/2018','Laura Koslow','michelle@clickmagnetdating.com','Jarred Schulte' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/03/2018','Dennis Li ','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/15/2018','Jeff Kulinsky ','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/15/2018','Kevin Holzmeyer ','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/03/2018','Michael Stevens ','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Jasmine Vo' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/27/2018','Chris Barbieri','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/20/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/06/2018','Gus Jursch','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/21/2018','James Duncan','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/06/2018','Kevin Jenks','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/15/2018','Paul Shattuck','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Jen Smith' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '02/08/2018','Chris Jacksin','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/11/2018','Gerard Juarez','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '02/22/2018','Kevin Curtin','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '01/13/2018','Mark Rubenstein','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '01/21/2018','Talia Mirza','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Jennifer Smith' Union 
Select '01/16/2018','Ada Cooper','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/24/2018','Angela Antony','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/07/2018','Divya Mehra','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/18/2018','Katie Shepherd','michelle@clickmagnetdating.com','Josh G' Union 
Select '03/07/2018','Kelly McGlothlin','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/14/2018','Lara Koslow','michelle@clickmagnetdating.com','Josh G' Union 
Select '01/06/2018','Laurie Leidig','michelle@clickmagnetdating.com','Josh G' Union 
Select '03/08/2018','Leslie Brown','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/25/2018','Letitia Pinson','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/01/2018','Lorna Breen','michelle@clickmagnetdating.com','Josh G' Union 
Select '03/09/2018','None','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/11/2018','Rachel Heller','michelle@clickmagnetdating.com','Josh G' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/07/2018','Shirly Mani','michelle@clickmagnetdating.com','Josh G' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Josh G' Union 
Select '02/24/2018','Wendy Svarre','michelle@clickmagnetdating.com','Josh G' Union 
Select '01/31/2018','Debra Charles','michelle@clickmagnetdating.com','Josh Grapes' Union 
Select '02/22/2018','Divya Mehra','michelle@clickmagnetdating.com','Josh Grapes' Union 
Select '01/27/2018','Emily Gray','michelle@clickmagnetdating.com','Josh Grapes' Union 
Select '01/18/2018','Kathy Laux','michelle@clickmagnetdating.com','Josh Grapes' Union 
Select '01/13/2018','Reba Rosenthal','michelle@clickmagnetdating.com','Josh Grapes' Union 
Select '01/20/2018','Julie Ward','michelle@clickmagnetdating.com','JoshG' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/17/2018','Brad Hunt','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/10/2018','David Paul','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/01/2018','Dennis Li','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/11/2018','Gerard Juarez','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/14/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/11/2018','Ken Ng','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/21/2018','Kevin Curtin','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/17/2018','Nick Dodson','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/23/2018','Ross Molden','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/18/2018','Tony Wagner','michelle@clickmagnetdating.com','Lorena' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Lorena' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/11/2018','Gerard Juarez','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/23/2018','Guy White','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/11/2018','Ken Ng','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/21/2018','Kevin Curtin','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/08/2018','Lynsi Williams','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/23/2018','Mike Johnson','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/17/2018','Nick Dodson','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/16/2018','Teague Lasser','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/07/2018','Theodore Woodward','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Lynsi Williams' Union 
Select '03/07/2018','Leslie Brown','michelle@clickmagnetdating.com','Mark R' Union 
Select '03/09/2018','Leslie Brown','michelle@clickmagnetdating.com','Mark R' Union 
Select '02/24/2018','Letitia Pinson','michelle@clickmagnetdating.com','Mark R' Union 
Select '03/10/2018','Meagan','michelle@clickmagnetdating.com','Mark R' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Mark R' Union 
Select '01/16/2018','Ada Cooper','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/24/2018','Angela Antony','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/01/2018','Debra Charles','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/22/2018','Divya Mehra','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/07/2018','Divya Mehra','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '01/27/2018','Emily Gray','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '01/20/2018','Julie Ward','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '01/18/2018','Kathy Laux','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/18/2018','Katie Shepherd','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '03/06/2018','Kelly McGlothlin','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/15/2018','Lara Koslow','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/14/2018','Lara Koslow','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '01/07/2018','Laurie Leidig','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/01/2018','Lorna Breen','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/11/2018','Rachel Heller','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/07/2018','Shirly Mani','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '02/24/2018','Wendy Svarre','michelle@clickmagnetdating.com','Mark Reagan' Union 
Select '03/09/2018','Leslie Brown','michelle@clickmagnetdating.com','Matthew B' Union 
Select '03/09/2018','Rachel Weinstock','michelle@clickmagnetdating.com','Matthew B' Union 
Select '03/07/2018','Leslie Brown','michelle@clickmagnetdating.com','Matthew B.' Union 
Select '03/09/2018','Meagan Project','michelle@clickmagnetdating.com','Matthew B.' Union 
Select '03/07/2018','Kelly McGlothlin','michelle@clickmagnetdating.com','Matthew Beale' Union 
Select '01/06/2018','Laurie Leidig','michelle@clickmagnetdating.com','Mike' Union 
Select '01/16/2018','Ada Cooper','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/24/2018','Angela Antony','michelle@clickmagnetdating.com','Mike J' Union 
Select '01/31/2018','Debra Charles','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/22/2018','Divya Mehra','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/07/2018','Divya Mehra','michelle@clickmagnetdating.com','Mike J' Union 
Select '01/28/2018','Emily Gray','michelle@clickmagnetdating.com','Mike J' Union 
Select '01/17/2018','Kathy Laux','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/17/2018','Katie Shepherd','michelle@clickmagnetdating.com','Mike J' Union 
Select '03/06/2018','Kelly McGlothlin','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/14/2018','Lara Koslow','michelle@clickmagnetdating.com','Mike J' Union 
Select '03/07/2018','Leslie Brown','michelle@clickmagnetdating.com','Mike J' Union 
Select '03/09/2018','Leslie Brown','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/24/2018','Letitia Pinson','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/01/2018','Lorna Breen','michelle@clickmagnetdating.com','Mike J' Union 
Select '03/09/2018','Megan Project','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/11/2018','Rachel Heller','michelle@clickmagnetdating.com','Mike J' Union 
Select '01/13/2018','Reba Rosenthal','michelle@clickmagnetdating.com','Mike J' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/07/2018','Shirly Mani','michelle@clickmagnetdating.com','Mike J' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Mike J' Union 
Select '02/24/2018','Wendy Svarre','michelle@clickmagnetdating.com','Mike J' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Mike Johnson' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/10/2018','David Paul','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/13/2018','Mark Strinic','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/06/2018','Teddy Woodward','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Nova Johnstone' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/03/2018','Dennis Li','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/07/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Olivia' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Olivia' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/27/2018','Chris Barbieri','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/20/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/12/2018','Gerard Juarez','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/07/2018','Greg Karr ','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/18/2018','Jared Raia','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/11/2018','Ken Ng','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/15/2018','Kevin Holzmeyer ','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/06/2018','Kevin Jenks','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/01/2018','Matt Metosky ','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/14/2018','Paul Shattuck','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/18/2018','Peter Lopipero','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/20/2018','Ryan Kostolni ','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/22/2018','Tallal Mirza','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/06/2018','Theodore (Teddy) Woodward ','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/17/2018','Tony Wagner ','michelle@clickmagnetdating.com','Onawa' Union 
Select '01/13/2018','Tyler Hartmann ','michelle@clickmagnetdating.com','Onawa' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/06/2018','Will Flowerday ','michelle@clickmagnetdating.com','Onawa' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Onawa ' Union 
Select '02/08/2018','Anthony Navarini ','michelle@clickmagnetdating.com','Onawa ' Union 
Select '02/08/2018','Chris Jackson ','michelle@clickmagnetdating.com','Onawa ' Union 
Select '01/08/2018','Gus Jursch','michelle@clickmagnetdating.com','Onawa ' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Onawa ' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Onawa ' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Onawa ' Union 
Select '03/18/2018','Ryan Hendrix ','michelle@clickmagnetdating.com','Onawa ' Union 
Select '03/08/2018','Yusen Li ','michelle@clickmagnetdating.com','Onawa ' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/19/2018','Brad Hunt','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/01/2018','Chandra Shaker (Maddula)','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/10/2018','David Paul','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/04/2018','James Spencer','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/19/2018','Nick Dodson','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/07/2018','Teddy Woodward','michelle@clickmagnetdating.com','Rachel Gallagher' Union 
Select '03/08/2018','Adam Wenig ','michelle@clickmagnetdating.com','Rebecca' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/29/2018','Chris Barbieri','michelle@clickmagnetdating.com','Rebecca' Union 
Select '02/15/2018','David Johnson','michelle@clickmagnetdating.com','Rebecca' Union 
Select '03/11/2018','Gerard Juarez ','michelle@clickmagnetdating.com','Rebecca' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/06/2018','Gus Jursch','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/15/2018','Joseph Zulueta ','michelle@clickmagnetdating.com','Rebecca' Union 
Select '02/21/2018','Kevin Curtin ','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/06/2018','Kevin Jenks','michelle@clickmagnetdating.com','Rebecca' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/27/2018','Mani Aleyas','michelle@clickmagnetdating.com','Rebecca' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Rebecca' Union 
Select '03/14/2018','Merrit Quirk ','michelle@clickmagnetdating.com','Rebecca' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/19/2018','Michael Housman','michelle@clickmagnetdating.com','Rebecca' Union 
Select '03/03/2018','Michael Stevens ','michelle@clickmagnetdating.com','Rebecca' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/20/2018','Ryan Kostolni ','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/22/2018','Tallal Mirza','michelle@clickmagnetdating.com','Rebecca' Union 
Select '02/02/2018','Terrence Wong','michelle@clickmagnetdating.com','Rebecca' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Rebecca' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Rebecca' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '01/19/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/03/2018','James Spence ','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/22/2018','Reed Scott ','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '02/24/2018','Ross Molden','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '02/16/2018','Teague Lasser','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Rebecca ' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Rebecca Brown' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Rebecca Brown' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Rebecca Brown' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Rebecca Brown' Union 
Select '02/14/2018','Alex McCauley ','michelle@clickmagnetdating.com','Rosalia' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/01/2018','Chandra Shaker ','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/28/2018','Chris Barbieri','michelle@clickmagnetdating.com','Rosalia' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Rosalia' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Rosalia' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/12/2018','Gerard Juarez','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/21/2018','James Duncan ','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/18/2018','Jared Raia','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/15/2018','Jeff Kulinsky ','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/07/2018','Jordan Milan','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/22/2018','Justin Vlaovic','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/07/2018','Kevin Jenks','michelle@clickmagnetdating.com','Rosalia' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/26/2018','Mani Aleyas','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/14/2018','Paul Shattuck','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/17/2018','Peter Lopipero','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/18/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Rosalia' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/07/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Rosalia' Union 
Select '01/11/2018','Vaibhav Mallya','michelle@clickmagnetdating.com','Rosalia' Union 
Select '03/08/2018','Yusen Li ','michelle@clickmagnetdating.com','Rosalia' Union 
Select '02/22/2018','Divya Mehra','michelle@clickmagnetdating.com','Ryan' Union 
Select '02/08/2018','Divya Mehra','michelle@clickmagnetdating.com','Ryan' Union 
Select '02/18/2018','Katie Shepherd ','michelle@clickmagnetdating.com','Ryan' Union 
Select '03/07/2018','Kelly McGlothlin','michelle@clickmagnetdating.com','Ryan' Union 
Select '03/09/2018','Kristin Bell?','michelle@clickmagnetdating.com','Ryan' Union 
Select '02/14/2018','Lara Koslow','michelle@clickmagnetdating.com','Ryan' Union 
Select '03/08/2018','Leslie Brown','michelle@clickmagnetdating.com','Ryan' Union 
Select '02/25/2018','Letitia Pinson','michelle@clickmagnetdating.com','Ryan' Union 
Select '03/09/2018','Rochelle Weinstock','michelle@clickmagnetdating.com','Ryan' Union 
Select '02/08/2018','Shirly Mani','michelle@clickmagnetdating.com','Ryan' Union 
Select '02/23/2018','Wendy Svarre','michelle@clickmagnetdating.com','Ryan' Union 
Select '01/17/2018','Ada Cooper','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '01/31/2018','Debra Charles','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '01/28/2018','Emily Gray','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '01/20/2018','Julie Ward','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '01/18/2018','Kathy Laux','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '01/06/2018','Laurie Leidig','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '02/03/2018','Lorna Breen','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '02/11/2018','Rachel Heller ','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '01/13/2018','Reba Rosenthal','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '01/03/2018','Tanzila Watts','michelle@clickmagnetdating.com','Ryan Willis' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Samantha' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/20/2018','Dan Graham','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/11/2018','David Paul','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/17/2018','Jared Raia','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/15/2018','Jeff Kulinsky ','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/14/2018','Marko Strinic','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/14/2018','Merrit Quirk','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/17/2018','Ryan Hendrix','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '03/08/2018','Yusen Li ','michelle@clickmagnetdating.com','Sara Graham' Union 
Select '02/14/2018','Alex McCauley','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/08/2018','Anthony Navarini','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/14/2018','Ben Horowitz','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/18/2018','Brad Hunt','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/06/2018','Brett Oliver','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/01/2018','Chandra Shaker','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/28/2018','Chris Barbieri','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/20/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/14/2018','David Johnson','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/02/2018','Dennis Li','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/09/2018','Gary Greco','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/07/2018','Greg Karr ','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/07/2018','Gus Jursch','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/24/2018','Guy White','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/21/2018','James Duncan','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/15/2018','Jeff Kulinsky','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/15/2018','Joseph Zulueta','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/22/2018','Kevin Curtin','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/15/2018','Kevin Holzmeyer','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/06/2018','Kevin Jenks','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/09/2018','Kip Birgen','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/27/2018','Mani Aleyas','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/14/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/13/2018','Marko Strinic','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/20/2018','Michael Housman','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/03/2018','Michael Stevens','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/01/2018','Mike Bliskell ','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/18/2018','Nick Dodson','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/15/2018','Paul Shattuck','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/08/2018','Paul Yazbeck','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/18/2018','Peter Lopipero','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/20/2018','Ryan Kostolni','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/21/2018','Tallal Mirza','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/01/2018','Terrence Wong','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/06/2018','Theodore (Teddy) Woodward','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/14/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Sheri' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Sheri' Union 
Select '03/08/2018','Yusen Li ','michelle@clickmagnetdating.com','Sheri' Union 
Select '01/05/2018','Brett Oliver','michelle@clickmagnetdating.com','Stac' Union 
Select '01/07/2018','Gus Jursch ','michelle@clickmagnetdating.com','stac' Union 
Select '03/23/2018','Guy White','michelle@clickmagnetdating.com','Stac' Union 
Select '03/03/2018','James Spence','michelle@clickmagnetdating.com','stac' Union 
Select '03/06/2018','Luis Flores','michelle@clickmagnetdating.com','Stac' Union 
Select '01/13/2018','Mark Rubinshtein','michelle@clickmagnetdating.com','Stac' Union 
Select '03/08/2018','Paul Yazbeck ','michelle@clickmagnetdating.com','Stac' Union 
Select '03/08/2018','Adam Wenig','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/08/2018','Anthony Navarini ','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/21/2018','Anthony Purcell','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/13/2018','Ben Horowitz','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/27/2018','Chris Barbieri','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/08/2018','Chris Jackson','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/19/2018','Dan Kushkuley','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/02/2018','Dennis Li ','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/24/2018','Gabriel Engle','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/08/2018','Gary Greco ','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/07/2018','Greg Karr','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/20/2018','James Duncan ','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/06/2018','Jordan Milan','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/10/2018','Ken Ng','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/22/2018','Kevin Curtin','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/06/2018','Kevin Jenks','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/08/2018','Lasse Olesen','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/26/2018','Mani Aleyas ','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/01/2018','Matt Metosky','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/15/2018','Michael Feinstein','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/19/2018','Michael Housman','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/02/2018','Michael Stevens ','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/01/2018','Mike Bliskell','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/24/2018','Mike Johnson','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/14/2018','Paul Shattuck','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/22/2018','Reed Scott','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/20/2018','Ryan Kostolni ','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/21/2018','Tallal Mirza ','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/17/2018','Teague Lasser','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/06/2018','Theodore (Teddy) Woodward ','michelle@clickmagnetdating.com','stacy' Union 
Select '01/20/2018','Thomas Weber','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/17/2018','Tony Wagner','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/13/2018','Tyler Hartmann','michelle@clickmagnetdating.com','Stacy' Union 
Select '01/12/2018','Vaibhav Mallya ','michelle@clickmagnetdating.com','Stacy' Union 
Select '02/17/2018','Vince Campbell','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/06/2018','Will Flowerday','michelle@clickmagnetdating.com','Stacy' Union 
Select '03/08/2018','Yusen Li','michelle@clickmagnetdating.com','Stacy'  

select count(distinct clientname)
    from @tmpPhotoRanking

--select distinct am
--    from @tmpPhotoRanking
--select *
--    from @tmpPhotoRanking where AM like 'Andie Hunter'

select am, count(*)
    from @tmpPhotoRanking

    --where AM like 'Andie Hunter'
    group by am
    having count(*) >20;

select t1.*, u.[User], u.name as [Database Name], u.Email, [Role] 
from (
    select am, count(*) cnt
	   from @tmpPhotoRanking
	   group by am
	   having count(*) >20
	   ) t1
    left join users u on left(t1.am,len(t1.am)) like left(u.name,len(t1.am))
    left join roles on roles.role_id = u.role_id


DECLARE @tContenders TABLE (name nvarchar(50))
Insert into @tContenders
--SELECT 'Ally' UNION
SELECT 'Brianne' UNION 
SELECT 'Ellie' UNION 
SELECT 'Jaclyn' UNION 
--SELECT 'Jamila' UNION 
SELECT 'Rebecca T' UNION 
--SELECT 'Rosalia' UNION 
--SELECT 'Stacy' UNION 
SELECT 'Amy' UNION 
SELECT 'Sheri' UNION 
SELECT 'Jen S' UNION 
SELECT 'Lorena' UNION 
SELECT 'Lynsi' UNION 
SELECT 'Nova' UNION 
SELECT 'Sara ' UNION 
SELECT 'Olivia' UNION 
SELECT 'Jasmine' UNION 
SELECT 'Andrea' UNION 
SELECT 'Arielle' UNION 
SELECT 'Bonnie' UNION 
SELECT 'Rachel G' UNION 
SELECT 'reBecca' UNION 
SELECT 'Jessica' UNION 
SELECT 'Allison' UNION 
SELECT 'Onawa ' UNION 
SELECT 'Ana'  

--SELECT * FROM @tContenders

select c.name as [Provided Contenders List], u.[User], u.name as [Database Name], u.Email, [Role] 
    from @tContenders c	   
	   left join users u on left(c.name,len(c.name)) like left(u.name,len(c.name))
	   left join roles on roles.role_id = u.role_id
	   where u.active = 1
	   
    --where [name] like 'Rebecca%'
    --substring([name] like 'Jack%'-- 'stac%'

select *
    from  users u
	   left join roles on roles.role_id = u.role_id	   
    where [name] like '%hig%'
	   and active = 1
    substring([name] like 'Jack%'-- 'stac%'

create table Test(nid int identity, testname varchar(100))
