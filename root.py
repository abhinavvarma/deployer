from flask import Flask
from flask import request
from subprocess import call

from settings import DEPLOYMENT_SCRIPT_PATH, DEPLOYMENT_LOG_PATH

app = Flask(__name__)


@app.route("/deploy/", methods=["POST"])
def deploy():
    errors = ""
    try:
        call([DEPLOYMENT_SCRIPT_PATH])
    except Exception as e:
        errors = "Error Occured: %s\n"%e
    try:
        with open(DEPLOYMENT_LOG_PATH, 'r') as logfile:
            log = logfile.read().replace('\n', '<br>')
    except Exception as fe:
        return "Job started.\n Could not display the log file.\n" + str(fe)
    return str(request.data)+errors + log

if __name__ == "__main__":
    app.run()