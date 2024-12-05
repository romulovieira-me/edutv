<?xml version="1.0" encoding="utf-8"?>
<!-- Copyright (C) 2013-2018 PUC-Rio/Laboratorio TeleMidia

This file is part of NCLua.

NCLua is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

NCLua is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for more details.

You should have received a copy of the GNU General Public License
along with NCLua.  If not, see <https://www.gnu.org/licenses/>.  -->

<ncl id="example-http">
  <head>

    <regionBase>
      <region id="luaRegion" width="100%" height="100%"/>
      <region id="videoRegion" width="10%" height="10%"/>
      <region id="xRegion" width="10%" height="10%" left="20%"/>
    </regionBase>

    <descriptorBase>
    
      <descriptor id="luaDesc" region="luaRegion" />

	  <descriptor id="descVideo" region="videoRegion" focusIndex="1" moveRight="2"/>

	  <descriptor id="descX" region="xRegion" focusIndex="2" moveLeft="1"/>

    </descriptorBase>

    <connectorBase>
		<causalConnector id="onSelectionSet">
        <connectorParam name="var" />
        <simpleCondition role="onSelection" />
	    <simpleAction role="set" value="$var" max="unbounded" qualifier="seq" />
      </causalConnector>
	  <causalConnector id="onBeginStart">
        <simpleCondition role="onBegin" />
        <simpleAction role="start" max="unbounded" />
      </causalConnector>
    </connectorBase>
  </head>

  <body>

    <port id="init" component="lua"/>

    <media type="application/x-ginga-settings" id="programSettings">
      <property name="currentKeyMaster" value="1"/>
    </media>

    <media id="video" descriptor="descVideo" src="media/video1.mp4">
      <property name="soundLevel" value="0"/>
    </media>
    

    <media id="x" descriptor="descX" src="media/x.png">
    </media>
    
    <media id="lua" descriptor="luaDesc" src="media/http-client.lua">
			<property name="createRoom"/>
      <property name="startQuestion"/>
		</media>

    <media id="http" descriptor="luaDesc" src="media/http.lua"/>
	
		
	<link xconnector="onSelectionSet">
      <bind role="onSelection" component="video" />
      <bind role="set" component="lua" interface="createRoom">
        <bindParam name="var" value="1" />
      </bind>
    </link>

    <link xconnector="onSelectionSet">
      <bind role="onSelection" component="x" />
      <bind role="set" component="lua" interface="startQuestion">
        <bindParam name="var" value="1" />
      </bind>
    </link>
    
    <link xconnector="onBeginStart">
      <bind role="onBegin" component="lua" />
      <bind role="start" component="video"/>
      <bind role="start" component="x"/>
    </link>

  </body>
</ncl>
