Build args
----------
| Variable      | Utility                                         |
|---------------|-------------------------------------------------|
| STEAM_LOGIN   | Steam login to retrive the server files         |
| STEAM_PASS    | Steam password                                  |
| STEAM_GUARD   | Steam guard code (if your account requires it)  |

Environment variables
---------------------
*NOTE*:  These will all work with the default config file; if you mount in
your own Default.ini, you'll need to include %VARIABLE_NAME% syntax in the
file if you want them to work.  See Default.ini for reference.

| Variable              | Utility                                                                   |
|-----------------------|---------------------------------------------------------------------------|
| KF_SERVER_NAME        | Server name (in the server list)                                          |
| KF_SERVER_SHORT_NAME  | Server "short" name                                                       |
| KF_SERVER_PASSWORD    | Password for players to enter the server                                  |
| KF_ADMIN_NAME         | Admin's name (for webadmin)                                               |
| KF_ADMIN_EMAIL        | Admin's email address (for reference)                                     |
| KF_ADMIN_PASSWORD     | Admin password (in-game and webadmin)                                     |
| KF_GAME_LENGTH        | Game length (0 = short, 1 = medium, 2 = long, 3 = custom) (default: 2)    |
| KF_GAME_DIFFICULTY    | Game difficulty (floating-point number) (default: 7.000000)               |
| KF_PORT_GAME          | UDP game port (default: 7707)                                             |
| KF_PORT_GAMESPY_QUERY | UDP master server query port (default: 7717)                              |
| KF_PORT_WEBADMIN      | TCP webadmin port (default: 8075)                                         |

Build instructions
------------------
```bash
docker build -t killingfloor --build-arg STEAM_LOGIN=login --build-arg STEAM_PASS=pass .
```

If that fails with the following message:
```
This computer has not been authenticated for your account using Steam Guard.
Please check your email for the message from Steam, and enter the Steam Guard
 code from that message.
You can also enter this code at any time using 'set_steam_guard_code'
 at the console.
Steam Guard code:FAILED with result code 63
```
Simply re-run the `docker build` command with the STEAM_GUARD argument set to
the code you received:
```bash
docker build -t killingfloor --build-arg STEAM_LOGIN=login --build-arg STEAM_PASS=pass --build-arg STEAM_GUARD=code .
```

Run instructions
----------------
```bash
docker run -d --name kf -p 8075:8075 -p 7707:7707/udp -p 7708:7708/udp -p 20560:20560/udp -p 28852:28852 -e KF_ADMIN_NAME=name -e KF_ADMIN_PASSWORD=password -e KF_GAME_LENGTH=2 -e KF_SERVER_NAME='My KF Server' killingfloor
```

