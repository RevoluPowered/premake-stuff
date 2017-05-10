-- Premake build script for Lua 
-- Tested with lua-5.3.4
-- Created for use with premake5.
-- Authored by Gordon Alexander MacPherson

workspace "Lua"
	configurations { "Debug", "Release" }

project "lua53"
	kind "SharedLib"
	language "C"
	
	files { "**.h", "**.c" }
	
	-- remove other project files for other things
	removefiles {
		"src/luac.c",
		"src/lua.c",
		"src/luac.h",
		"src/lua.h"
	}
	-- required to properly build this as dll. _STUPID
	defines { "LUA_BUILD_AS_DLL" }
	
	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		
project "lua"
	kind "ConsoleApp"
	language "C"
	
	files { "**.h" }
	
	-- remove other project files for other things
	files {
		"src/lua.c",
		"src/lua.h"
	}
	
	links( "lua53" )
	
	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"

project "luac"
	kind "ConsoleApp"
	language "C"
	
	files { "**.h", "**.c" }
	
	-- remove other project files for other things
	removefiles {
		"src/lua.c",
		"src/lua.h"
	}
	
	links( "lua53" )
	
	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"