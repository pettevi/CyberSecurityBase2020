harkkatyö kurssille https://cybersecuritybase.mooc.fi/module-3.1

tested with python 3.8.6 and django 3.1

run this app: py manage.py runserver

numbers.bat is for batch modification of json file
polls_quote.csv contains quotes
same is in json format in polls_quote.json
populate the db.sqlite3 database with DB Browser for SQLite (https://sqlitebrowser.org/)


LINK: https://github.com/pettevi/cybersecuritybase2020.git
Application displays random quotes from Tintin comics. User can (1) generate new quote, (2) vote for the quote, (3) select the character whos quote is shown, and, (4) leave a note for other visitors.
SQlite DB is prepopulated with data. Access it with the UI. App uses python 3.8.6 and django 3.1. 
Hot to run: py manage.py runserver

FLAW 1: OWASP A3 - Sensitive Data Exposure
DESC: Debug interface (http://localhost:8000/tintin/dump) is left in production revealing excessive amounts of data. Interface is used by the author during development to double check DB contents and the changes. This URL is not documented or accessible from the UI by following a link, it has to be known to be reached. 
HOW TO FIX: Debug interface should be removed from production. To remove the interface urls.py code file should be edited and line "path('tintin/dump', views.dump, name='dump')" commented out. This removes the URL completely and patches the vulnerability.

FLAW 2: OWASP A1 - Injection
DESC: "CHOOSE A CHARACTER" dropdown list on the front page (http://localhost:8000/tintin) is not validated on server side. Client side validation is done on the browser by allowing only accepted values. Developer trusts user will not send any other value but one of those available in the UI. Selected value is propagated all the way to SQL clause and used directly in SQL query allowing attacker to feed in any parameter revealing data that should not be available. To test this vulnerability try typing in "Bianca Castafiore" or typing this URL (http://localhost:8000/tintin/?char=Bianca%20Castafiore). Url uses GET to allow link to be copied.
HOW TO FIX: Instead of using cursor.execute() to run raw SQL query same effect can be achieved with Quote.objects.filter(character_name='name'). Query will return empty dictionary if name is not found effectively disabling SQL injection attack. Also returned string from the dropdown list should be escaped and validated on the server side to be sensible and to contain one of the allowed name strings.

FLAW 3: OWASP A5 - Broken Access Control
DESC: On the guestbook page (http://localhost:8000/tintin/note) user can leave messages for others to read. This page does not have session control since Cross Site Request Forgery (csrf) token is commented out in the note.html template. Attacker can feed data outside of user session for example with Postman. Having csrf would make it very difficult for the attacker to automate attacks and not to attack outside of user session at all.
Hot to fix: To turn on Djangos built-in and automatic csrf protection, uncomment <!-- {% csrf_token %} --> line in note.html. Also @csrf_exempt line must be removed or commented out in views.py file. csrf_exempt effectively disables othervise automatic Djangos csrf mechanism.

FLAW 4: OWASP A7 - Cross Site Scripting
DESC: On the guestbook page (http://localhost:8000/tintin/note) user can leave messages for others to read. Both name and message fields accept raw text without any kind of validation on client or server side allowing attacker to feed in XSS attacks. Attacker can store JavaScript in application DB which is ran when another user visits the page. Djangos othervise automatic special character autoescape mechanism is turned off ({% autoescape off %} in note.html) which disables special character escaping allowing javascript to be ran.
HOW TO FIX: Special characters should be escaped on the server side before storing user entries in the DB. Validation should be done again on the client side when the data is returned from the DB just to be sure. Enabling client side validation can be done by removing the {% autoescape off %} and {% endautoescape %} lines in note.html file.

FLAW 5: OWASP A6 - Security Misconfiguration
DESC: Application reveals too much information on 404 error. This error can be got for example with "OWASP A1 - Injection" vulnerability when entering any random string in the character selection dropdown box value field. Whole execution stack is dumped on the UI allowing attacker to gain inside knowledge on the implementation. This is due to misconfiguration on the Django settings file where DEBUG = True settings is left. 
HOW TO FIX: The settings.py file "DEBUG = True" line should be changed to "DEBUG = False". This change will display standard 404: NOT_FOUND page to the user if entering any random URL instead of displaying execution stack.

FLAW 6: OWASP A10 - Insufficient Logging & Monitoring
DESC: Application does not log any application data changes such as writing a guestbook entry or voting for a quote. Application state changing modifications should always be logged in server side for administrator or auditor to verify. Ultimately aplication should support user login process and thus we would always know who committed what changes. Currently logging is done on /dump URL only and it prints out to console.
HOW TO FIX: Logging can be achieved with for example Python’s builtin logging module. Each DB altering change should be logged either in a text based log file or directly in the DB with values "what is changed", "when the change occured" and "who made the change". Monitoring can be achieved by logging to external log server where log file can be stored for a long time and constantly followed. Unexpected log entries should raise an alarm that can be investigated by IT staff.



Copyright 2020 Petteri Hamalainen
All rights reserved
