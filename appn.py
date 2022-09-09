from readline import append_history_file
from flask import Flask,render_template,request,jsonify,make_response
import sqlite3 as sql
from datetime import date,timedelta

app=Flask(__name__)
#connection object and cursor object creation
con_obj=sql.connect('./assignment1.db',check_same_thread=False)
con_obj.row_factory = sql.Row
cursor_obj=con_obj.cursor()

today=date.today() - timedelta(days=1)
datee=today.strftime("%Y-%m-%d")

def get_details():
    user_data=[]
    #try:
    cursor_obj.execute("SELECT author_id FROM github_activities where created_at='"+datee+"' GROUP BY author_id")
    rows=cursor_obj.fetchall()
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
    #except:
        #pass
    return (user_data)
def get_repo_details():
    repo_data=[]
    cursor_obj.execute("SELECT REPO_NAME FROM GITHUB_ACTIVITIES WHERE created_at='"+datee+"' group by REPO_NAME")
    out=cursor_obj.fetchall()
    for r in out:
        repo={}
        cursor_obj.execute("SELECT * FROM GITHUB_ACTIVITIES WHERE created_at='"+datee+"' and repo_name='"+r['repo_name']+"' group by repo_name")
        repo_d=cursor_obj.fetchall()
        for k in repo_d:
            repo['DATE']=k['created_at']
            repo['REPO_NAME']=k['repo_name']
            #repo_commit_counts
            cursor_obj.execute("SELECT COUNT(type) as counts FROM github_activities where created_at='"+datee+"'and repo_name='"+r['repo_name']+"' and type='COMMIT'")
            repo_commit_data=cursor_obj.fetchall()
            for l in repo_commit_data:
                repo['COMMIT_COUNTS']=l['counts']
            #repo_pull_counts
            cursor_obj.execute("SELECT COUNT(TYPE) as counts FROM GITHUB_ACTIVITIES WHERE CREATED_AT='"+datee+"' and REPO_NAME='"+r['repo_name']+"' and TYPE='PULL'")
            #print("SELECT COUNT(TYPE) as counts FROM GITHUB_ACTIVITIES WHERE CREATED_AT='"+datee+"' and REPO_NAME='"+r['repo_name']+"' and TYPE='PULL'")
            repo_pull_data=cursor_obj.fetchall()
            for r_data in repo_pull_data:
                repo['PULL_COUNTS']=r_data['counts']
            repo_data.append(repo)
    return(repo_data)


@app.route('/github/user/stats')
def user_stats():
    user_data=get_details()
    return jsonify(user_data)

@app.route('/github/repo/stats')
def repo_stats():
    return(jsonify(get_repo_details()))

if __name__=='__main__':
    app.config['JSON_SORT_KEYS'] = False
    app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True
    app.run(debug=True)
