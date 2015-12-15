# Retrieve & Rank Custom Scorers
## Description
This project enables the usage of custom features within the Retrieve & Rank service on Bluemix. This project was built in the
Python programming language and uses the Flask micro-framework. To use this application, there is a Python script called server.py,
which exposes two endpoints to be consumed by the application that uses it.
## Application Architecture 
The Flask server that is created within the script server.py is intended to run as a "sidecar" within the rest of the application;
that is, the parent application will make REST API calls to this "sidecar" service rather than making direct calls to the
deployed Retrieve & Rank service. The principal difference is that the Flask server will handle the integration/injection of
custom features that have been registered.
## Steps to get set up
There are 4 steps to set up the server to integrate custom features:
    1) Identify the custom scorers for your application. A custom scorer is a Python class that extracts a score that is to be used by the ranker
    2) Create a configuration file (see configs/features.json as an example) to configure your application to consume these scorers
    3) Start the Flask server by running the command 'python server.py ... ' with the proper parameters 
    4) Make calls to the endpoint that is configured when starting the server.py. The results should be roughly the same as making calls to /fcselect on the service directly