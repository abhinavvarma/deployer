import json
from subprocess import call

from flask import Flask
from flask import request
from settings import DEPLOYMENT_SCRIPT_PATH, DEPLOYMENT_LOG_PATH, REF_TO_WATCH

app = Flask(__name__)


@app.route("/deploy/", methods=["POST"])
def deploy():
    push_data = json.loads(request.data)
    if push_data.get('ref') != REF_TO_WATCH:
        return "Sorry! I am not watching this ref"
    errors = ""
    try:
        call([DEPLOYMENT_SCRIPT_PATH])
    except Exception as e:
        errors = "Error Occurred: %s\n" % e
    try:
        with open(DEPLOYMENT_LOG_PATH, 'r') as logfile:
            log = logfile.read().replace('\n', '<br>')
    except Exception as fe:
        return "Job started.\n Could not display the log file.\n" + str(fe)
    return errors + log



if __name__ == "__main__":
    app.run()
