USE vida;
GO

DECLARE
  @MinMsgCount INT     =25,
  @DateFrom    DATETIME='2018-05-20 11:36:37.000';

DECLARE @tmpTemplates TABLE
(id           INT IDENTITY,
 template_msg VARCHAR(50)
);
INSERT INTO @tmpTemplates (template_msg)
       SELECT '1st Template Used'
       UNION
       SELECT '2nd Template Used';



DECLARE
  @tmp_PM_Y TABLE
(
  Client          VARCHAR(50),
  PM_Y_LeadsAndOpp_Count INT,
  OPP_Y           INT);

INSERT INTO @tmp_PM_Y
       SELECT Client,
              COUNT( * )    PM_Y_LeadsAndOpp_Count,
              SUM( is_opp ) OPP_Y
       FROM
       (
         SELECT company client,
                0
         AS             is_opp
         FROM leads
	    left join @tmpTemplates tmpTemplates on leads.[Predictive Messaging Template Used] = tmpTemplates.template_msg
         WHERE [created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
               AND tmpTemplates.template_msg IN
         ('1st Template Used', '2nd Template Used')
         UNION ALL
         SELECT [clients name] client,
                1
         AS                    is_opp
         FROM opportunities op
         INNER JOIN
         accounts
         ON accounts.[clients id]=op.[clients id]
	    left join @tmpTemplates tmpTemplates on op.[Predictive Messaging Template Used] = tmpTemplates.template_msg
         WHERE op.[created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
               AND tmpTemplates.template_msg IN
         ('1st Template Used', '2nd Template Used')
       ) t
       GROUP BY client
       HAVING COUNT( * )>@MinMsgCount;

   --      SELECT leads.[Predictive Messaging Template Used]
   --      FROM leads
	  --  left join @tmpTemplates tmpTemplates on leads.[Predictive Messaging Template Used] = tmpTemplates.template_msg
   --      WHERE [created time]>@DateFrom
   --            AND site IN
   --      ('Match',
   --       'POF')
   --           AND tmpTemplates.template_msg IS NULL--NOT IN ('1st Template Used', '2nd Template Used')
   --      UNION ALL
   --      SELECT OP.[Predictive Messaging Template Used]
   --      FROM opportunities op
   --      INNER JOIN
   --      accounts
   --      ON accounts.[clients id]=op.[clients id]
	  --  left join @tmpTemplates tmpTemplates on op.[Predictive Messaging Template Used] = tmpTemplates.template_msg
   --      WHERE op.[created time]>@DateFrom
   --            AND site IN
   --      ('Match',
   --       'POF')
   --            AND tmpTemplates.template_msg IS NULL--NOT IN ('1st Template Used', '2nd Template Used')
			--) T GROUP BY [Predictive Messaging Template Used]

DECLARE
  @tmp_PM_N TABLE
(
  Client          VARCHAR(50),
  PM_N_LeadsAndOpp_Count INT,
  OPP_Y           INT);

INSERT INTO @tmp_PM_N
       SELECT Client,
              COUNT( * )    PM_N_LeadsAndOpp_Count,
              SUM( is_opp ) OPP_Y
       FROM
       (
         SELECT company client,
                0
         AS             is_opp
         FROM leads
	    left join @tmpTemplates tmpTemplates on leads.[Predictive Messaging Template Used] = tmpTemplates.template_msg
         WHERE [created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
              AND tmpTemplates.template_msg IS NULL--NOT IN ('1st Template Used', '2nd Template Used')
         UNION ALL
         SELECT [clients name] client,
                1
         AS                    is_opp
         FROM opportunities op
         INNER JOIN
         accounts
         ON accounts.[clients id]=op.[clients id]
	    left join @tmpTemplates tmpTemplates on op.[Predictive Messaging Template Used] = tmpTemplates.template_msg
         WHERE op.[created time]>@DateFrom
               AND site IN
         ('Match',
          'POF')
               AND tmpTemplates.template_msg IS NULL--NOT IN ('1st Template Used', '2nd Template Used')
       ) t
       GROUP BY client
       HAVING COUNT( * )>@MinMsgCount;

SELECT tmp_PM_Y.client,
       tmp_PM_N.PM_N_LeadsAndOpp_Count,
       tmp_PM_N.OPP_Y,
       CAST( (CAST( tmp_PM_N.OPP_Y AS NUMERIC )*100)/tmp_PM_N.PM_N_LeadsAndOpp_Count AS NUMERIC(10, 2) ) Conversion_PM_N,
       tmp_PM_Y.PM_Y_LeadsAndOpp_Count,
       tmp_PM_Y.OPP_Y,
       CAST( (CAST( tmp_PM_Y.OPP_Y AS NUMERIC )*100)/tmp_PM_Y.PM_Y_LeadsAndOpp_Count AS NUMERIC(10, 2) ) Conversion_PM_Y
FROM @tmp_PM_Y tmp_PM_Y
INNER JOIN
@tmp_PM_N tmp_PM_N
ON tmp_PM_N.client=tmp_PM_Y.client
ORDER BY tmp_PM_Y.client;
