" You can also set personal variables with 'g:xptemplate_vars' in your .vimrc.
XPTemplate priority=personal

XPT make " premake4 init script
solution "app"
    configurations { "linux_debug", "linux_release" }
    configuration "linux_debug"
        --links { "" }
        --libdirs { "" }
        --includedirs { "/usr/include/GL" }
        buildoptions { "-std=c++11" }
        defines { "DEBUG" }
        flags { "Symbols" }
    configuration "linux_release"
        --links { "" }
        --includedirs { "" }
        buildoptions { "-std=c++11" }
        defines { "NDEBUG" }
        flags { "Optimize" }
        
    project "app"
        kind "ConsoleApp"
        language "C++"
        location "."
        targetdir "."
        files { "**.cpp", "**.h" }

XPT war " compiler warnings (deleted: -Waggregate-return)
-Wall -Wextra -Weffc++ -Wcast-align -Wcast-qual -Wdisabled-optimization -Wdiv-by-zero -Wendif-labels -Wformat-extra-args -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wimport -Winit-self -Winline -Winvalid-pch -Wlogical-op -Werror=missing-braces -Wmissing-declarations -Wno-missing-format-attribute -Wmissing-include-dirs -Wmultichar -Wpacked -Wpointer-arith -Wreturn-type -Wsequence-point -Wsign-compare -Wstrict-aliasing -Wstrict-aliasing=2 -Wswitch -Werror=undef -Wno-unused -Wvariadic-macros -Wwrite-strings -Werror=declaration-after-statement -Werror=implicit-function-declaration -Werror=nested-externs -Werror=old-style-definition -Werror=strict-prototypes -pedantic-errors
