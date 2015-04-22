#include "stdafx.h"
#include <iostream>
#include "lua.hpp"
#include <SFML/Graphics.hpp>

using namespace sf;
using namespace std;

CircleShape shape(100.f);

int test(lua_State * L)
{
	Vector2f pos = shape.getPosition();
	shape.setPosition(pos.x + lua_tointeger(L, 1), pos.y);
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
		std::cerr << "unable to run:" << lua_tostring(L, -1);
		lua_pop(L, 1);

	}
	if (!error)
	{
		cout << "Result: " << lua_tonumber(L, -1) << endl;
		lua_pop(L, 1);
	}

	cout << endl;

	RenderWindow window(VideoMode(1200, 800), "SFML works!");
	
	shape.setFillColor(Color::Green);

	while (window.isOpen())
	{
		Event event;
		while (window.pollEvent(event))
		{
			switch (event.type)
			{
			case Event::Closed:
				window.close();
				break;

			case sf::Event::KeyPressed:
				//Send event.key.code to lua for processing
				lua_pushcfunction(L,test);
				lua_setglobal(L, "testFunc");

				lua_getglobal(L, "keyHandler");
				lua_pushinteger(L, event.key.code);
				error = lua_pcall(L, 1, 1, 0);
				if (error)
				{
					std::cerr << "unable to run:" << lua_tostring(L, -1);
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

		window.clear();
		window.draw(shape);
		window.display();
	}

	system("pause");
}