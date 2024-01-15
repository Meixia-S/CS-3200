# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'finalProject2023'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'LoneStarTravel'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the LoneStar Travels' app!</h1>"

    # Import the various Beluprint Objects
    from src.Activity_Destination.Activity_Destination import Activity_Destination
    from src.Airline.Airline import Airline
    from src.Cultural_Site_Tour.Cultural_Site_Tour import Cultural_Site_Tour
    from src.Customer_Flight.Customer_Flight import Customer_Flight
    from src.Destination.Destination import Destination
    from src.Discount.Discount import Discount
    from src.Flight.Flight import Flight
    from src.Insurance.Insurance import Insurance
    from src.Previous_Trip.Previous_Trip import Previous_Trip
    from src.Representative.Representative import Representative
    from src.Research_Archive.Research_Archive import Research_Archive
    from src.Secondary_Traveler.Secondary_Traveler import Secondary_Traveler
    from src.Visit_Memo.Visit_Memo import Visit_Memo

    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.register_blueprint(Activity_Destination, url_prefix='/ad')
    app.register_blueprint(Airline,              url_prefix='/a')
    app.register_blueprint(Cultural_Site_Tour,   url_prefix='/cst')
    app.register_blueprint(Customer_Flight,      url_prefix='/cf')
    app.register_blueprint(Destination,          url_prefix='/des')
    app.register_blueprint(Discount,             url_prefix='/d')
    app.register_blueprint(Flight,               url_prefix="/f")
    app.register_blueprint(Insurance,            url_prefix='/i')
    app.register_blueprint(Previous_Trip,        url_prefix='/pt')
    app.register_blueprint(Representative,       url_prefix='/r')
    app.register_blueprint(Research_Archive,     url_prefix='/ra')
    app.register_blueprint(Secondary_Traveler,   url_prefix='/st')
    app.register_blueprint(Visit_Memo,           url_prefix='/vm')

    # Don't forget to return the app object
    return app

