#include "stdafx.h"
#include <iostream>
#include "lua.hpp"
#include <SFML/Graphics.hpp>

using namespace sf;
using namespace std;

enum TileTypes
{
	PLAYER  = 0,
	WALL    = 1,
	PATH    = 2,
	START   = 3,
	END     = 4,
};

CircleShape player = CircleShape(10.f);
RenderWindow window(VideoMode(1200, 800), "SFML works!");

int move(lua_State * L)
{
	Vector2f pos = player.getPosition();
	player.setPosition(pos.x + lua_tointeger(L, 1), pos.y + lua_tointeger(L, 2));
	lua_pop(L, 2);
	return 0;
}

Color GetColor(int type)
{
	if (type == PLAYER)
		return Color(0, 102, 204, 255);
	else if (type == WALL)
		return Color(0, 51, 15, 255);
	else if (type == PATH)
		return Color(71, 45, 0, 255);
	else if (type == START)
		return Color(204, 0, 0, 255);
	else if (type == END)
		return Color(0, 204, 0, 255);
	else
		return Color(0, 0, 0, 0);
}

int DrawSquare(lua_State * L)
{
	float posX = lua_tonumber(L, 1);
	float posY = lua_tonumber(L, 2);
	float dimensions = lua_tonumber(L, 3);
	int type = lua_tointeger(L, 4);
	lua_pop(L, 4);

	RectangleShape shape = RectangleShape(Vector2f(dimensions, dimensions));
	shape.setPosition(Vector2f(posX, posY));
	shape.setFillColor(GetColor(type));

	window.draw(shape);
	return 0;
}

int DrawPlayer(lua_State * L)
{
	window.draw(player);
	return 0;
}

int ClearWindow(lua_State * L)
{
	window.clear();
	return 0;
}

int DisplayWindow(lua_State * L)
{
	window.display();
	return 0;
}

int _tmain(int argc, _TCHAR* argv[])
{
	cout << endl;
	lua_State* L = luaL_newstate();
	luaL_openlibs(L);
	//int error = luaL_loadstring(L, "print('Hello World!')") || lua_pcall(L, 0, 0, 0);

	int error = luaL_loadfile(L, "script.lua") || lua_pcall(L, 0, 0, 0);
	if (error)
	{
		std::cerr << "unable to run:" << lua_tostring(L, -1) << endl;
		lua_pop(L, 1);

	}

	cout << endl;
	player.setFillColor(GetColor(PLAYER));

	lua_pushcfunction(L, move);
	lua_setglobal(L, "moveC");

	lua_pushcfunction(L, ClearWindow);
	lua_setglobal(L, "clearWindowC");

	lua_pushcfunction(L, DrawSquare);
	lua_setglobal(L, "drawSquareC");

	lua_pushcfunction(L, DrawPlayer);
	lua_setglobal(L, "drawPlayerC");

	lua_pushcfunction(L, DisplayWindow);
	lua_setglobal(L, "displayWindowC");

	while (window.isOpen())
	{
		Vector2f pos = player.getPosition ( );
		lua_getglobal ( L, "update" );
		lua_pushnumber ( L, pos.x);
		lua_pushnumber ( L, pos.y );
		lua_pushnumber ( L, player.getRadius ( ) );
		error = lua_pcall ( L, 3, 0, 0 );
		if ( error ) {
			std::cerr << "unable to run:" << lua_tostring ( L, -1 ) << endl;
		}

		Event event;
		while (window.pollEvent(event))
		{
			bool keyDown = true;
			switch (event.type)
			{
			case Event::Closed:
				window.close();
				break;
			case sf::Event::KeyReleased:
				keyDown = false;
			case sf::Event::KeyPressed:
				//Send event.key.code to lua for processing
				lua_getglobal(L, "keyHandler");
				lua_pushinteger(L, event.key.code);
				lua_pushboolean ( L, keyDown );
				error = lua_pcall(L, 2, 1, 0);
				if (error)
				{
					std::cerr << "unable to run:" << lua_tostring(L, -1) << endl;
					lua_pop(L, 1);
				}
				if (!error)
				{
					cout << lua_tonumber(L, -1) << endl;
					lua_pop(L, 1);
				}					
				break;

			default:
				break;
			}
		}

		lua_getglobal(L, "render");
		error = lua_pcall(L, 0, 0, 0);
		if (error)
		{
			std::cerr << "unable to run:" << lua_tostring(L, -1) << endl;
			lua_pop(L, 1);
		}

		//window.clear();
		//window.draw(shape);
		//window.display();
	}

	system("pause");
}