import logging
from flask import Flask

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

@app.route("/")
def hello():
    logger.info("Received request to root endpoint")
    return "Hello from Python Flask!"

@app.route("/throw-error")
def error():
    logger.warn("About to throw an intentional error")
    # it will be logged by flask using python logging package
    # which is supported by OTel.
    # no need for custom handler
    raise ValueError("Intentional error from Python Flask application")

@app.route("/manual-error")
def manual_error():
    try:
        raise ValueError("Intentional error from Python Flask application")
    except ValueError as e:
        logger.error("Caught an intentional error", exc_info=e)
        return "we handled the error"

if __name__ == "__main__":
    logger.info("Starting Python Flask app on port 8080")
    app.run(host="0.0.0.0", port=8080)
