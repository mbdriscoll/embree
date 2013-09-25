# Try to find UPCXX library and include path.
# Once done this will define
#
# UPCXX_FOUND
# UPCXX_INCLUDE_DIR
# UPCXX_LIBRARIES
#

include(FindPackageHandleStandardArgs)

find_path(UPCXX_INCLUDE_DIR
    NAMES
        upcxx.h
    PATHS
        /Users/mbdriscoll/opt/upcxx-0.0.0/include
        ${UPCXX_LOCATION}/include
        $ENV{UPCXX_LOCATION}/include
    DOC
        "The directory where upcxx.h resides"
)

find_path( UPCXX_LIBRARY_PATH
    NAMES
        libupcxx.a
    PATHS
        /Users/mbdriscoll/opt/upcxx-0.0.0/lib
        ${UPCXX_LOCATION}/lib
        $ENV{UPCXX_LOCATION}/lib
    DOC
        "The upcxx core library"
)

set (UPCXX_FOUND "NO")
if(UPCXX_INCLUDE_DIR)
  if(UPCXX_LIBRARY_PATH)
    set (UPCXX_LIBRARIES "-L${UPCXX_LIBRARY_PATH} -lupcxx")
    set (UPCXX_INCLUDE_PATH ${UPCXX_INCLUDE_DIR})
    set (UPCXX_FOUND "YES")
  endif(UPCXX_LIBRARY_PATH)
endif(UPCXX_INCLUDE_DIR)

find_package_handle_standard_args(UPCXX DEFAULT_MSG
    UPCXX_INCLUDE_DIR
    UPCXX_LIBRARIES
)
