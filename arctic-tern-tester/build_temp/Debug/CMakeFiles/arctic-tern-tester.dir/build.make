# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/build_temp/Debug

# Include any dependencies generated for this target.
include CMakeFiles/arctic-tern-tester.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/arctic-tern-tester.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/arctic-tern-tester.dir/flags.make

CMakeFiles/arctic-tern-tester.dir/main.cpp.o: CMakeFiles/arctic-tern-tester.dir/flags.make
CMakeFiles/arctic-tern-tester.dir/main.cpp.o: ../../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/build_temp/Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/arctic-tern-tester.dir/main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/arctic-tern-tester.dir/main.cpp.o -c /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/main.cpp

CMakeFiles/arctic-tern-tester.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/arctic-tern-tester.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/main.cpp > CMakeFiles/arctic-tern-tester.dir/main.cpp.i

CMakeFiles/arctic-tern-tester.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/arctic-tern-tester.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/main.cpp -o CMakeFiles/arctic-tern-tester.dir/main.cpp.s

# Object files for target arctic-tern-tester
arctic__tern__tester_OBJECTS = \
"CMakeFiles/arctic-tern-tester.dir/main.cpp.o"

# External object files for target arctic-tern-tester
arctic__tern__tester_EXTERNAL_OBJECTS =

../../bin/Debug/arctic-tern-tester: CMakeFiles/arctic-tern-tester.dir/main.cpp.o
../../bin/Debug/arctic-tern-tester: CMakeFiles/arctic-tern-tester.dir/build.make
../../bin/Debug/arctic-tern-tester: ../../../../goldilocks/goldilocks/lib/libgoldilocks.a
../../bin/Debug/arctic-tern-tester: ../../../../iosqueak/iosqueak/lib/libiosqueak.a
../../bin/Debug/arctic-tern-tester: CMakeFiles/arctic-tern-tester.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/build_temp/Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/Debug/arctic-tern-tester"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/arctic-tern-tester.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/arctic-tern-tester.dir/build: ../../bin/Debug/arctic-tern-tester

.PHONY : CMakeFiles/arctic-tern-tester.dir/build

CMakeFiles/arctic-tern-tester.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/arctic-tern-tester.dir/cmake_clean.cmake
.PHONY : CMakeFiles/arctic-tern-tester.dir/clean

CMakeFiles/arctic-tern-tester.dir/depend:
	cd /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/build_temp/Debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/build_temp/Debug /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/build_temp/Debug /home/jason/Code/Repositories/arctic-tern/arctic-tern-tester/build_temp/Debug/CMakeFiles/arctic-tern-tester.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/arctic-tern-tester.dir/depend

