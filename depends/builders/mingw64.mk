build_mingw64_CC = gcc
build_mingw64_CXX = g++
build_mingw64_AR = ar
build_mingw64_RANLIB = ranlib
build_mingw64_STRIP = strip
build_mingw64_NM = nm
build_mingw64_OTOOL = otool
build_mingw64_INSTALL_NAME_TOOL = install_name_tool
build_mingw64_SHA256SUM = sha256sum
build_mingw64_DOWNLOAD = wget --timeout=$(DOWNLOAD_CONNECT_TIMEOUT) --tries=$(DOWNLOAD_RETRIES) -nv -O

define add_build_tool_func
build_$(build_os)_$1 ?= $$(default_build_$1)
build_$(build_arch)_$(build_os)_$1 ?= $$(build_$(build_os)_$1)
build_$1=$$(build_$(build_arch)_$(build_os)_$1)
endef

$(foreach var,CC CXX AR RANLIB NM STRIP SHA256SUM DOWNLOAD OTOOL INSTALL_NAME_TOOL,$(eval $(call add_build_tool_func,$(var))))
define add_build_flags_func
build_$(build_arch)_$(build_os)_$1 += $(build_$(build_os)_$1)
build_$1=$$(build_$(build_arch)_$(build_os)_$1)
endef
$(foreach flags, CFLAGS CXXFLAGS LDFLAGS, $(eval $(call add_build_flags_func,$(flags))))
