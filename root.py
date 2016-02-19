from flask import Flask
from subprocess import call

from settings import DEPLOYMENT_SCRIPT_PATH

app = Flask(__name__)


@app.route("/deploy/")
def deploy():
    try:
        call([DEPLOYMENT_SCRIPT_PATH])
    except Exception as e:
        return str(e)
    return "Job started"

if __name__ == "__main__":
    app.run()