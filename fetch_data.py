import numbers
from select import select
import pandas as pd
import sqlite3
import requests,json
from datetime import date, datetime,timedelta

#Date for daily data
today=date.today()
datee=today.strftime("%Y-%m-%d")

#headers to authorize data pull
headers = {
    'Authorization': 'token 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'
}
#DB connection and table creation if not exits
connection_obj = sqlite3.connect('./assignment1.db')
connection_obj.row_factory = sqlite3.Row
cursor_obj=connection_obj.cursor()
try:
    cursor_obj.execute("CREATE TABLE IF NOT EXISTS github_activities(ID INTEGER PRIMARY KEY, REPO_NAME VARCHAR(100),TYPE CHAR(20),ACTIVITY_ID VARCHAR(200) NOT NULL UNIQUE,AUTHOR_ID VARCHAR(100),CREATED_AT VARCHAR(100))")
except:
    pass
#Read repo details from input file
input_data=pd.read_csv("./input_repos.csv")

#fetch commit and pull details of all repos from the input list and store it table
insert_query='INSERT INTO github_activities(REPO_NAME,TYPE,ACTIVITY_ID,AUTHOR_ID,CREATED_AT) VALUES(?,?,?,?,?)'
for ip_data in input_data.repo_name:
    #to fetch commits of a repositry 
    url = 'https://api.github.com/repos/'+ip_data+'/commits'
    response = requests.get(url,headers=headers)
    d=response.json()
    print(d)
    for x in d:
        #FETCH DATA INTO VARIABLES
        created_at=x["commit"]["author"]["date"]
        datee=created_at.split('T')[0]
        type="COMMIT"
        activity_id=x["sha"]
        author_id=x["author"]["id"]
        try:
            cursor_obj.execute("INSERT INTO github_activities(REPO_NAME,TYPE,ACTIVITY_ID,AUTHOR_ID,CREATED_AT) VALUES(?,?,?,?,?)",(ip_data,type,activity_id,author_id,datee))
        except:
            pass

    #to fetch pull data of repository
    url1 = 'https://api.github.com/repos/'+ip_data+'/pulls'
    resp = requests.get(url1,headers=headers)
    d1=resp.json()
    for n in d1:
        created_at=n["created_at"]
        date=created_at.split('T')[0]
        type="PULL"
        activity_id=n["number"]
        author_id=n["user"]["id"]
        try: 
            cursor_obj.execute(insert_query,(ip_data,type,activity_id,author_id,date))
        except:
            pass
cursor_obj.execute("select * from github_activities")
rows=cursor_obj.fetchall()
for row in rows:
    print(row['author_id'])