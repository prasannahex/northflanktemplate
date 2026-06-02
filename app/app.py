from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return f"Hello from {os.getenv('APP_ENV', 'UNKNOWN')}"

if __name__ == "__main__":
    app.run()
