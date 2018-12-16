use track
go 
/*
SELECT 
a.[account_manager_name],
a.[client_name],
a.[total_hours_paid],
a.[total_hours_credited],
a.[total_hours_logged],
a.[total_over_under],
a.[month_start_date],
a.[autobill_date],
a.[hours_purchased],
coalesce(b.[package_name], 'Other') as [package_name],
coalesce(b.[package_color], '#ffffff') as [package_color],
isnull(b.[monthly_hours], 0) as package_hours,
a.[hours_deducted],
a.[current_hours_remaining],
a.[number_of_months],
a.[phones_hist],
a.[dates_hist],
a.[phones_curr],
a.[dates_curr],
a.[Date / Number Preference],
a.[open_convos],
a.setting_date_phone,
a.rrate,
a.[Running Out of ICs],
a.[Active?]
FROM [TRACK].[dbo].[REPORT_time_progress_by_client] a LEFT JOIN [TRACK].[dbo].[packages] b ON
a.[package_hours] = b.[monthly_hours]
WHERE
(a.[account_manager_name] = @USER or @USER = 'ALL') and
(a.[client_active] = convert(int, @CLIENT_ACTIVE) or convert(int, @CLIENT_ACTIVE) = -1)
and coalesce(b.[package_name], 'Other') in (@PACKAGE)
order by a.[client_name]

select top 100 * from [REPORT_time_progress_by_client] where client_name like '%amol%' or client_name like '%charles%myers%'
select * from packages
select top 100 * from clients where name = ''
select top 100 * from clients where client_id = 2614 2968like '%amol%' or name like '%charles%myers%'
*/

select tmp_original.client_name,
    tmp_original.[total_hours_paid], tmp_new.[total_hours_paid] [NEW_total_hours_paid] ,
    tmp_original.[hours_deducted], tmp_new.[hours_deducted] [NEW_hours_deducted] ,
    tmp_original.[total_hours_credited], tmp_new.[total_hours_credited] [NEW_total_hours_credited] ,
    tmp_original.[hours_purchased], tmp_new.[hours_purchased] [NEW_hours_purchased] ,
    tmp_original.current_hours_remaining, tmp_new.current_hours_remaining NEW_current_hours_remaining ,
    tmp_original.[package_hours], tmp_new.[package_hours] [NEW_package_hours] 
from ##tmp_original_REPORT_time_progress_by_client tmp_original 
inner join ##tmp_new_REPORT_time_progress_by_client tmp_new on tmp_original.client_name = tmp_new.client_name
where
    tmp_original.[total_hours_credited]<> tmp_new.[total_hours_credited] or -- [4]
    tmp_original.[hours_purchased]<> tmp_new.[hours_purchased] or -- [1]
    tmp_original.current_hours_remaining<> tmp_new.current_hours_remaining or -- [3]
    tmp_original.[package_hours]<> tmp_new.[package_hours] or-- [5]
    tmp_original.[hours_deducted]<> tmp_new.[hours_deducted] -- [2]
/*
where
    tmp_original.client_active		<> tmp_new.client_active or
    tmp_original.account_manager_name<> tmp_new.account_manager_name or
    --tmp_original.[total_hours_paid]<> tmp_new.[total_hours_paid] or
    --tmp_original.[total_hours_credited]<> tmp_new.[total_hours_credited] or
    tmp_original.[total_hours_logged]<> tmp_new.[total_hours_logged] or
    tmp_original.total_over_under<> tmp_new.total_over_under or
    tmp_original.[month_start_date]<> tmp_new.[month_start_date] or
    tmp_original.[autobill_date]<> tmp_new.[autobill_date] or
    --tmp_original.[hours_purchased]<> tmp_new.[hours_purchased] or
    --tmp_original.[hours_deducted]<> tmp_new.[hours_deducted] or
    --tmp_original.current_hours_remaining<> tmp_new.current_hours_remaining or
    --tmp_original.[package_hours]<> tmp_new.[package_hours] or
    tmp_original.number_of_months<> tmp_new.number_of_months or
    tmp_original.phones_hist<> tmp_new.phones_hist or
    tmp_original.dates_hist<> tmp_new.dates_hist or
    tmp_original.phones_curr<> tmp_new.phones_curr or
    tmp_original.dates_curr<> tmp_new.dates_curr or
    tmp_original.[Date / Number Preference]<> tmp_new.[Date / Number Preference] or
    tmp_original.open_convos<> tmp_new.open_convos or
    tmp_original.setting_date_phone<> tmp_new.setting_date_phone or
    tmp_original.rrate<> tmp_new.rrate or
    tmp_original.[Running Out of ICs]<> tmp_new.[Running Out of ICs] or
    tmp_original.[Active?]<> tmp_new.[Active?]



*/