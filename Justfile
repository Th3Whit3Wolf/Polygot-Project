default_size		:= "words"
default_exercise	:= "-h"

# Compile all compiled languages
build:
	#!/bin/sh
	pushd C > /dev/null
	echo "Compiling C"
	fd -e c -x gcc -O3 {/} -o {/.} > /dev/null
	echo "C Compiled"
	popd > /dev/null
	pushd Cpp > /dev/null
	echo "Compiling C++"
	fd -e cpp -x g++ -O3 {/} -o {/.} > /dev/null
	echo "C++ Compiled"
	popd > /dev/null
	pushd D > /dev/null
	echo "Compiling D"
	fd -e d -x dmd -release -O -w -of={/.} {/} > /dev/null
	fd -e o -x rm > /dev/null
	echo "D Compiled"
	popd > /dev/null
	pushd Go > /dev/null
	echo "Compiling Go"
	fd -e go -x go build > /dev/null
	echo "Go Compiled"
	popd > /dev/null
	pushd Nim > /dev/null
	echo "Compiling Nim"
	fd -e nim -x nim -d:release --opt:speed c --verbosity:0 --hints:off  > /dev/null
	echo "Nim Compiled"
	popd > /dev/null
	pushd Rust > /dev/null
	echo "Compiling Rust"
	fd -e rs -x rustc -C opt-level=3 -C lto=fat > /dev/null
	echo "Rust Compiled"
	popd > /dev/null
	pushd Swift > /dev/null
	echo "Compiling Swift"
	fd -e swift -x swiftc -O -g > /dev/null
	echo "Swift Compiled"
	popd > /dev/null

# Show size of all executables
size arg=default_size:
	#!/bin/bash
	if [ {{arg}} = bin ]; then
		fd -t x -x du -h | sort -h
	elif [ {{arg}} = lines ]; then
		tokei -s=lines
	elif [ {{arg}} = words ]; then
		echo "Language: C"
		fd -e c -x wc | sed 's/C\///g' | sed 's/.c//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: C++"
		fd -e cpp -x wc | sed 's/Cpp\///g' | sed 's/.cpp//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: D"
		fd -e d -x wc | sed 's/D\///g' | sed 's/.d//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: Dart"
		fd -e dart -x wc | sed 's/Dart\///g' | sed 's/.dart//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: Go"
		fd -e go -x wc | sed 's/Go\///g' | sed 's/.go//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: Nim"
		fd -e nim -x wc | sed 's/Nim\///g' | sed 's/.nim//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: Python"
		fd -e py -x wc | sed 's/Python\///g' | sed 's/.py//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: Ruby"
		fd -e rb -x wc | sed 's/Ruby\///g' | sed 's/.rb//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: Rust"
		fd -e rs -x wc | sed 's/Rust\///g' | sed 's/.rs//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
		echo "Language: Swift"
		fd -e swift -x wc | sed 's/Swift\///g' | sed 's/.swift//g' | awk '{print "\t"$4 ": \t" $1 " lines, " $2 " words, & " $3 " bytes"}'
		echo
	else
		echo "USAGE:"
		echo "    just size [FLAGS]"
		echo ""
		echo "FLAGS:"
		echo "    just size bin      List all binaries, sorted by size"
		echo "    just size lines    Show detailed stats of source by language"
		echo "    just size words    Show detailed stats of source by file"
	fi

# Show details of exercise
ex exercise=default_exercise:
	#!/bin/bash

	if test -f "C/ex{{exercise}}"; then
		C_BIN=$(du -h C/ex{{exercise}} | awk '{print $1}')
	fi
	if test -f "Cpp/ex{{exercise}}"; then
		CPP_BIN=$(du -h Cpp/ex{{exercise}} | awk '{print $1}')
	fi
	if test -f "D/ex{{exercise}}"; then
		D_BIN=$(du -h D/ex{{exercise}} | awk '{print $1}')
	fi
	if test -f "Go/ex{{exercise}}"; then
		GO_BIN=$(du -h Go/ex{{exercise}} | awk '{print $1}')
	fi
	if test -f "Nim/ex{{exercise}}"; then
		NIM_BIN=$(du -h C/ex{{exercise}} | awk '{print $1}')
	fi
	if test -f "Rust/ex{{exercise}}"; then
		RUST_BIN=$(du -h Rust/ex{{exercise}} | awk '{print $1}')
	fi
	if test -f "Swift/ex{{exercise}}"; then
		SWIFT_BIN=$(du -h Swift/ex{{exercise}} | awk '{print $1}')
	fi

	case {{exercise}} in
		''|*[!0-9]*)
			echo "USAGE:"
			echo "    just ex [<exercise>]"
			echo ""
			echo "ARGS:"
			echo "    <exercise>    exercise as number (example 11)"
			;;
		*)
			echo "Exercise {{exercise}}"
			echo
			echo "┌─────────────────────────────────────────────────────────────┐"
			cat C/ex{{exercise}}.c | wc | awk '{print "│   C:         " $1 " lines, " $2 " words, & " $3 " bytes" }' 
			echo "│   ├───────────────────────────────────────────"
			echo "│   └─ Binary Size: $C_BIN"
			echo "│"
			cat Cpp/ex{{exercise}}.cpp | wc | awk     '{print "│   Cpp:       " $1 " lines, " $2 " words, & " $3 " bytes"}' 
			echo "│   ├───────────────────────────────────────────"
			echo "│   └─ Binary Size: $CPP_BIN"
			echo "│"
			cat D/ex{{exercise}}.d | wc | awk         '{print "│   D:         " $1 " lines, " $2 " words, & " $3 " bytes"}'
			echo "│   ├───────────────────────────────────────────"
			echo "│   └─ Binary Size: $D_BIN" 
			echo "│"
			cat Dart/ex{{exercise}}.dart | wc | awk   '{print "│   Dart:      " $1 " lines, " $2 " words, & " $3 " bytes"}' 
			cat Go/ex{{exercise}}.go | wc | awk       '{print "│   Go:        " $1 " lines, " $2 " words, & " $3 " bytes"}'
			echo "│   ├───────────────────────────────────────────"
			echo "│   └─ Binary Size: $GO_BIN"  
			echo "│"
			cat Nim/ex{{exercise}}.nim | wc | awk     '{print "│   Nim:       " $1 " lines, " $2 " words, & " $3 " bytes"}'
			echo "│   ├───────────────────────────────────────────" 
			echo "│   └─ Binary Size: $NIM_BIN" 
			echo "│"
			cat Python/ex{{exercise}}.py | wc | awk   '{print "│   Python:    " $1 " lines, " $2 " words, & " $3 " bytes"}' 
			echo "│"
			cat Ruby/ex{{exercise}}.rb | wc | awk     '{print "│   Ruby:      " $1 " lines, " $2 " words, & " $3 " bytes"}' 
			echo "│"
			cat Rust/ex{{exercise}}.rs | wc | awk     '{print "│   Rust:      " $1 " lines, " $2 " words, & " $3 " bytes"}' 
			echo "│   ├───────────────────────────────────────────"
			echo "│   └─ Binary Size: $RUST_BIN" 
			echo "│"
			cat Swift/ex{{exercise}}.swift | wc | awk '{print "│   Swift:     " $1 " lines, " $2 " words, & " $3 " bytes"}' 
			echo "│   ├───────────────────────────────────────────"
			echo "│   └─ Binary Size: $SWIFT_BIN" 
			echo "└─────────────────────────────────────────────────────────────┘"
		;;
	esac
