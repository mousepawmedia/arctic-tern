# Top Level Makefile (MousePaw Media Build System)
# Version: 2.1.0
# Tailored For: Arctic Tern
#
# Author(s): Jason C. McDonald

# LICENSE (BSD-3-Clause)
# Copyright (c) 2018 MousePaw Media.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGE.
#
# CONTRIBUTING
# See https://www.mousepawmedia.com/developers for information
# on how to contribute to our projects.

MK_DIR = @cmake -E make_directory
CH_DIR = @cmake -E chdir
CP = @cmake -E copy
CP_DIR = @cmake -E copy_directory
RM = @cmake -E remove
RM_DIR = @cmake -E remove_directory
ECHO = @cmake -E echo
LN = @cmake -E create_symlink

none: help

help:
	$(ECHO) "=== Arctic Tern 2.0 ==="
	$(ECHO) "Select a build target:"
	$(ECHO) "  make ready           Build Arctic Tern and bundles it for distribution."
	$(ECHO) "  make clean           Clean up Arctic Tern and Tester."
	$(ECHO) "  make cleandebug      Clean up Arctic Tern and Tester Debug."
	$(ECHO) "  make cleanrelease    Clean up Arctic Tern and Tester Release."
	$(ECHO) "  make docs            Generate HTML docs."
	$(ECHO) "  make docs_pdf        Generate PDF docs."
	$(ECHO) "  make arctic-tern       Build Arctic Tern as release."
	$(ECHO) "  make arctic-tern       Build Arctic Tern as debug."
	$(ECHO) "  make tester          Build Arctic Tern Tester (+Arctic Tern) as release."
	$(ECHO) "  make tester_debug    Build Arctic Tern Tester (+Arctic Tern) as debug."
	$(ECHO) "  make all             Build everything."
	$(ECHO) "  make allfresh        Clean and rebuild everything."
	$(ECHO)
	$(ECHO) "Clang Sanitizers (requires Debug build and Clang.)"
	$(ECHO) "  SAN=address     Use AddressSanitizer"
	$(ECHO) "  SAN=leak        Use LeakSanitizer w/o AddressSanitizer (Linux only)"
	$(ECHO) "  SAN=memory      Use MemorySanitizer"
	$(ECHO) "  SAN=thread      Use ThreadSanitizer"
	$(ECHO) "  SAN=undefined   Use UndefiniedBehaviorSanitizer"
	$(ECHO)
	$(ECHO) "Optional Architecture"
	$(ECHO) "  ARCH=32         Make x86 build (-m32)"
	$(ECHO) "  ARCH=64         Make x64 build (-m64)"
	$(ECHO)
	$(ECHO) "Use Configuration File"
	$(ECHO) "  CONFIG=foo      Uses the configuration file 'foo.config'"
	$(ECHO) "                  in the root of this repository."
	$(ECHO) "  When unspecified, default.config will be used."
	$(ECHO)
	$(ECHO) "For other build options, see the 'make' command in 'docs/', 'arctic-tern-source/', and 'arctic-tern-tester/'."
.PHONY: help

clean:
	$(MAKE) clean -C arctic-tern-tester
	$(RM_DIR) arctic-tern
	$(RM) tester_debug
	$(RM) tester
.PHONY: clean

cleanall: clean
	$(MAKE) clean -C docs
.PHONY: cleanall

cleandebug:
	$(MAKE) cleandebug -C arctic-tern-tester
	$(RM) tester_debug
.PHONY: cleandebug

cleanrelease:
	$(MAKE) cleanrelease -C arctic-tern-tester
	$(RM) tester
.PHONY: cleanrelease

docs:
	$(RM_DIR) docs/build/html
	$(MAKE) html -C docs
	$(ECHO) "-------------"
	$(ECHO) "<<<<<<< FINISHED >>>>>>>"
	$(ECHO) "View docs at 'docs/build/html/index.html'."
	$(ECHO) "-------------"
.PHONY: docs

docs_pdf:
	$(MAKE) latexpdf -C docs
	$(ECHO) "-------------"
	$(ECHO) "<<<<<<< FINISHED >>>>>>>"
	$(ECHO) "View docs at 'docs/build/latex/Arctic Tern.pdf'."
	$(ECHO) "-------------"
.PHONY: docs_pdf

arctic-tern:
	$(ECHO) "-------------"
	$(ECHO) "<<<<<<< FINISHED >>>>>>>"
	$(ECHO) "Arctic Tern is in 'arctic-tern-source/include'."
	$(ECHO) "-------------"
.PHONY: arctic-tern

arctic-tern:
	$(ECHO) "-------------"
	$(ECHO) "<<<<<<< FINISHED >>>>>>>"
	$(ECHO)  on "Arctic Tern is in 'arctic-tern-source/include'."
	$(ECHO) "-------------"
.PHONY: arctic-tern_debug

ready: arctic-tern
	$(RM_DIR) arctic-tern
	$(ECHO) "Creating file structure..."
	$(MK_DIR) arctic-tern
	$(ECHO) "Copying Arctic Tern..."
	$(CP_DIR) arctic-tern-source/include/ arctic-tern/include/
	$(ECHO) "Copying README and LICENSE..."
	$(CP) README.md arctic-tern/README.md
	$(CP) LICENSE.md arctic-tern/LICENSE.md
	$(ECHO) "-------------"
	$(ECHO) "<<<<<<< FINISHED >>>>>>>"
	$(ECHO) "The library is in 'arctic-tern'."
	$(ECHO) "-------------"
.PHONY: ready

tester: arctic-tern
	$(MAKE) release -C arctic-tern-tester
	$(RM) tester
	$(LN) arctic-tern-tester/bin/Release/arctic-tern-tester tester
	$(ECHO) "-------------"
	$(ECHO) "<<<<<<< FINISHED >>>>>>>"
	$(ECHO) "Arctic Tern Tester is in 'arctic-tern-tester/bin/Release'."
	$(ECHO) "The link './tester' has been created for convenience."
	$(ECHO) "-------------"
.PHONY: tester

tester_debug: arctic-tern_debug
	$(MAKE) debug -C arctic-tern-tester
	$(RM) tester_debug
	$(LN) arctic-tern-tester/bin/Debug/arctic-tern-tester tester_debug
	$(ECHO) "-------------"
	$(ECHO) "<<<<<<< FINISHED >>>>>>>"
	$(ECHO) "Arctic Tern Tester is in 'arctic-tern-tester/bin/Debug'."
	$(ECHO) "The link './tester_debug' has been created for convenience."
	$(ECHO) "-------------"
.PHONY: tester_debug

all: docs tester
.PHONY: all

allfresh: cleanall all
.PHONY: allfresh
