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
    logger.error("About to throw an intentional error")
    raise ValueError("Intentional error from Python Flask application")

@app.errorhandler(Exception)
def handle_exception(e):
    logger.exception("Unhandled error occurred")
    return f"Error: {str(e)}", 500

if __name__ == "__main__":
    logger.info("Starting Python Flask app on port 8080")
    app.run(host="0.0.0.0", port=8080)
