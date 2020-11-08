harkkatyö kurssille https://cybersecuritybase.mooc.fi/module-3.1

tested with python 3.8.6 and django 3.1

run this app: py manage.py runserver

numbers.bat is for batch modification of json file
polls_quote.csv contains quotes
same is in json format in polls_quote.json
populate the db.sqlite3 database with DB Browser for SQLite (https://sqlitebrowser.org/)



OWASP A3 - Sensitive Data Exposure
Debug interface is left in production revealing 

OWASP A1 - Injection. 
Value field is not validated on server side. Value is used directly in SQL clause allowing 
attacker to feed in any value revealing data that should be available. Try typing in "Bianca Castafiore"

OWASP A5 - Broken Access Control
Since csrf_token is commented out session control is not in use
Data can be fed in with Postman for example

OWASP A7 - Cross Site Scripting
autoescape off disables special character escape allowing javascript to be ran

OWASP A10 - Insufficient Logging & Monitoring



Copyright 2020 Petteri Hamalainen
All rights reserved
