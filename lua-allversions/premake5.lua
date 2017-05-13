-- Premake build script for Lua
-- Tested with lua-5.3.4
-- Created for use with premake5.
-- Authored by Gordon Alexander MacPherson
-- git ignore the build/ directory
workspace "Lua"
	location "build"
	configurations { "Debug", "Release" }

-- lua shared library
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

	configuration "linux"
		-- GCC requires you to manually link math.h
		links { "m" }

	configuration "windows"
		-- microsoft compiler requires additional flags
		-- to produce DLL from this project.
		defines( "LUA_BUILD_AS_DLL" )

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"

-- lua interpreter
project "lua"
	kind "ConsoleApp"
	language "C"

	files { "**.h" }

	-- remove other project files for other things
	files {
		"src/lua.c",
		"src/lua.h"
	}

	configuration "linux"
		-- GCC requires you to manually link math.h
		links { "m" }

	links( "lua53" )

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"


-- lua bytecode compiler
project "luac"
	kind "ConsoleApp"
	language "C"

	files { "**.h", "**.c" }

	-- remove other project files for other things
	removefiles {
		"src/lua.c",
		"src/lua.h"
	}

	configuration "linux"
		-- GCC requires you to manually link math.h
		links { "m" }

	links( "lua53" )

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
