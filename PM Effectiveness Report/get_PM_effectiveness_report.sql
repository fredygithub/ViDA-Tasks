USE vida;
GO
--ALTER PROCEDURE get_PM_effectiveness_report
--AS

DECLARE @MinMsgCount INT     =25;
DECLARE @DateFrom    DATETIME=(GetDate() - 90);

DECLARE @tmpTemplates TABLE
(id           INT IDENTITY,
 template_msg VARCHAR(50),
 is_pm bit
);
INSERT INTO @tmpTemplates (template_msg, is_pm)
       SELECT '1st Template Used', 1
       UNION
       SELECT '2nd Template Used', 1
       UNION
       SELECT 'Neither Used', 0;



DECLARE
  @tmp_PM_Y TABLE
(
  Client          VARCHAR(50),
  PM_Yes_LeadsAndOpp INT,
  PM_Yes_OPP           INT,
  PM_Yes_NumberOrDate INT);

INSERT INTO @tmp_PM_Y
       SELECT Client,
              COUNT( * )    PM_Yes_LeadsAndOpp,
              SUM( is_opp ) PM_Yes_OPP,
		    SUM( is_NumberOrDate ) PM_Opp_NumberOrDate
       FROM
       (
         SELECT company client,
                0
         AS             is_opp,
			 0	    is_NumberOrDate
         FROM ViDA.dbo.leads
	    left join @tmpTemplates tmpTemplates on leads.[Predictive Messaging Template Used] = tmpTemplates.template_msg
         WHERE [created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
               AND tmpTemplates.is_pm = 1
         UNION ALL
         SELECT [clients name] client,
                1
         AS                    is_opp,
		  case when ([stage] like '%number%' or [stage] like '%date%') then 1 else 0 end is_NumberOrDate
         FROM ViDA.dbo.opportunities op
         INNER JOIN
         ViDA.dbo.accounts
         ON accounts.[clients id]=op.[clients id]
	    left join @tmpTemplates tmpTemplates on op.[Predictive Messaging Template Used] = tmpTemplates.template_msg
         WHERE op.[created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
               AND tmpTemplates.is_pm = 1
       ) t
       GROUP BY client
       HAVING COUNT( * )>@MinMsgCount;


DECLARE
  @tmp_PM_N TABLE
(
  Client          VARCHAR(50),
  PM_No_LeadsAndOpp INT,
  PM_No_OPP           INT,
  PM_No_NumberOrDate INT);

INSERT INTO @tmp_PM_N
       SELECT Client,
              COUNT( * )    PM_No_LeadsAndOpp,
              SUM( is_opp ) PM_No_OPP,
		    SUM( is_NumberOrDate ) PM_Opp_NumberOrDate
       FROM
       (
         SELECT company client,
                0
         AS             is_opp,
			 0	    is_NumberOrDate
         FROM ViDA.dbo.leads
	    left join @tmpTemplates tmpTemplates on isnull(leads.[Predictive Messaging Template Used],'Neither Used') = tmpTemplates.template_msg
         WHERE [created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
		    AND tmpTemplates.is_pm = 0
         UNION ALL
         SELECT [clients name] client,
                1
         AS                    is_opp,
		  case when ([stage] like '%number%' or [stage] like '%date%') then 1 else 0 end is_NumberOrDate
         FROM ViDA.dbo.opportunities op
         INNER JOIN
         ViDA.dbo.accounts
         ON accounts.[clients id]=op.[clients id]
	    left join @tmpTemplates tmpTemplates on isnull(op.[Predictive Messaging Template Used],'Neither Used') = tmpTemplates.template_msg
         WHERE op.[created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
               AND tmpTemplates.is_pm = 0
       ) t
       GROUP BY client
       HAVING COUNT( * )>@MinMsgCount;

SELECT tmp_PM_Y.client,
       tmp_PM_N.PM_No_LeadsAndOpp,
       tmp_PM_N.PM_No_OPP,
       CAST( (CAST( tmp_PM_N.PM_No_OPP AS NUMERIC ))/tmp_PM_N.PM_No_LeadsAndOpp AS NUMERIC(10, 2) ) Conversion_PM_No,
	  PM_No_NumberOrDate,
       tmp_PM_Y.PM_Yes_LeadsAndOpp,
       tmp_PM_Y.PM_Yes_OPP,
       CAST( (CAST( tmp_PM_Y.PM_Yes_OPP AS NUMERIC ))/tmp_PM_Y.PM_Yes_LeadsAndOpp AS NUMERIC(10, 2) ) Conversion_PM_Yes
	  ,PM_Yes_NumberOrDate
	  ,CAST( (CAST( tmp_PM_Y.PM_Yes_OPP AS NUMERIC ))/tmp_PM_Y.PM_Yes_LeadsAndOpp AS NUMERIC(10, 2) ) - CAST( (CAST( tmp_PM_N.PM_No_OPP AS NUMERIC ))/tmp_PM_N.PM_No_LeadsAndOpp AS NUMERIC(10, 2) ) Response_Variation
	  ,CAST( (CAST( tmp_PM_Y.PM_Yes_OPP AS NUMERIC )+CAST( tmp_PM_N.PM_No_OPP AS NUMERIC ))/(tmp_PM_Y.PM_Yes_LeadsAndOpp+tmp_PM_N.PM_No_LeadsAndOpp) AS NUMERIC(10, 2) ) - CAST( (CAST( tmp_PM_N.PM_No_OPP AS NUMERIC ))/tmp_PM_N.PM_No_LeadsAndOpp AS NUMERIC(10, 2) ) Other_Variation
FROM @tmp_PM_Y tmp_PM_Y
INNER JOIN
@tmp_PM_N tmp_PM_N
ON tmp_PM_N.client=tmp_PM_Y.client
ORDER BY tmp_PM_Y.client;
