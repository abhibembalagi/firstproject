import sqlite3
import _sqlite3
from datetime import date,timedelta

con_obj=sqlite3.connect('./assignment1.db',check_same_thread=False)
con_obj.row_factory = sqlite3.Row
cursor_obj=con_obj.cursor()

today=date.today()
datee=today.strftime("%Y-%m-%d")
user_data=[]
    #try:
cursor_obj.execute("SELECT author_id FROM github_activities where created_at='"+datee+"' GROUP BY author_id")
rows=cursor_obj.fetchall()
print(rows)
for i in rows:
    print(i[0])
    user_d={}
    #fetch unique user id's for the system date
    cursor_obj.execute("SELECT * FROM github_activities where created_at='"+datee+"' and author_id='"+i['author_id']+"' group by author_id ")
    output_data=cursor_obj.fetchall()
    for x in output_data:
        user_d["DATE"] = x["created_at"]
        user_d["USER_ID"] = x["author_id"]
        #user_commit_counts
        cursor_obj.execute("SELECT COUNT(type) as counts FROM github_activities where created_at='"+datee+"'and author_id='"+i['author_id']+"' and type='COMMIT'")
        commit_data=cursor_obj.fetchall()
        for c in commit_data:
            user_d['COMMIT_COUNTS']=c['counts']
        #user_pull_counts
        cursor_obj.execute("SELECT COUNT(type) as counts FROM github_activities where created_at='"+datee+"'and author_id='"+i['author_id']+"' and type='PULL'")
        pull_data=cursor_obj.fetchall()
        for p in pull_data:
            user_d['PULL_COUNTS']=p['counts']
        user_data.append(user_d)
        print(x["author_id"])