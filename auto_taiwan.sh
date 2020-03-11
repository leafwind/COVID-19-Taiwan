# usage:
# you have to clone 2 repositories, for example:
# https://github.com/CSSEGISandData/COVID-19 -> COVID-19/
# https://github.com/leafwind/COVID-19-Taiwan -> COVID-19-Taiwan/
# then use job scheduler or crontab to run this script pediodically:
# `cd COVID-19-Taiwan/; ./auto_taiwan.sh`

# remove old data
rm -rf ./archived_data/
rm -rf ./csse_covid_19_data/
rm -rf ./who_covid_19_situation_reports/

# cp new version data from CSSE data
cp -R ./../COVID-19/archived_data .
cp -R ./../COVID-19/csse_covid_19_data .
cp -R ./../COVID-19/who_covid_19_situation_reports .

# replace Taiwan's country
sed -i 's/Taiwan,Taipei and environs/Taiwan,Taiwan/g' ./archived_data/archived_daily_case_updates/*
sed -i 's/Taiwan,Taipei and environs/Taiwan,Taiwan/g' ./archived_data/archived_time_series/*
sed -i 's/Taiwan,Taipei and environs/Taiwan,Taiwan/g' ./csse_covid_19_data/csse_covid_19_daily_reports/*
sed -i 's/Taiwan,Taipei and environs/Taiwan,Taiwan/g' ./csse_covid_19_data/csse_covid_19_time_series/*
sed -i 's/Taiwan,China/Taiwan,Taiwan/g' ./who_covid_19_situation_reports/who_covid_19_sit_rep_time_series/who_covid_19_sit_rep_time_series.csv

# commit and push
git commit -am 'auto update'
git push origin master
