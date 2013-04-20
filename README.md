Mission Puck
===============
Project planning at [Pivotal Tracker](https://www.pivotaltracker.com/s/projects/809065)

Introduction
---------------
The Mission Puck project is designed to provide information sharing support for search and rescue missions. The application is intended to run on inexpensive hardware (such as a $35 [Raspberry Pi](http://www.raspberrypi.org/)) and provide basic search management functions including:

- Volunteer sign-in/out
- Team builder / team lists
- Shared mission log
- Shared mission briefing document

Installation
----------------

#### Generic Linux/OS X

    git clone https://github.com/mcosand/Mission-Puck.git puck
    cd puck
    bundle install
    rake db:migrate
    ./run-faye.sh &
    rails server

Configuration
-----------------

Related Projects
----------------
* **[https://github.com/mcosand/Mission-Puck-Apps](https://github.com/mcosand/Mission-Puck-Apps "Mission Puck Apps")**
     - Windows application to send data to printer on regular schedule. (disaster recovery)

