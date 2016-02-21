import json

import datetime

from flask import Flask
from flask import request
from settings import DEPLOYMENT_WATCHED_LOG_PATH, REF_TO_WATCH, DEPLOYMENT_LOG_PATH

app = Flask(__name__)


@app.route("/deploy/log", methods=["GET"])
def get_log():
    try:
        content = "<h2>DEPLOYMENT LOG</h2><hr>"
        with open(DEPLOYMENT_LOG_PATH, 'r') as logfile:
            content += "\n".join(logfile.readlines())
    except Exception as fe:
        return "" + str(fe)
    return content.replace("\n", "<br>")


@app.route("/deploy/", methods=["POST"])
def deploy():
    push_data = json.loads(request.data)
    if push_data.get('ref') != REF_TO_WATCH:
        return "Sorry! I am not watching this ref"
    try:
        content = "(%s): Deployment is scheduled"%(datetime.datetime.utcnow())
        with open(DEPLOYMENT_WATCHED_LOG_PATH, 'w') as logfile:
            logfile.write(content)
    except Exception as fe:
        return "" + str(fe)
    return content


if __name__ == "__main__":
    app.run()
