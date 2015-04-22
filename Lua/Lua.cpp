#include "stdafx.h"
#include <iostream>
#include "lua.hpp"

using namespace std;

int _tmain(int argc, _TCHAR* argv[])
{
	cout << endl;
	lua_State* L = luaL_newstate();
	luaL_openlibs(L);
	//int error = luaL_loadstring(L, "print('Hello World!')") || lua_pcall(L, 0, 0, 0);

	int error = luaL_loadfile(L, "script.lua") || lua_pcall(L, 0, 0, 0);

	lua_getglobal(L, "sqr");
	lua_pushinteger(L, 10);

	error = lua_pcall(L, 1, 1, 0);

	if (!error)
	{
		cout << "Result: " << lua_tonumber(L, -1) << endl;
		lua_pop(L, 1);
	}

	cout << endl;

	system("pause");
}

