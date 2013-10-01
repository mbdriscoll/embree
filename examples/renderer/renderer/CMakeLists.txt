## ======================================================================== ##
## Copyright 2009-2013 Intel Corporation                                    ##
##                                                                          ##
## Licensed under the Apache License, Version 2.0 (the "License");          ##
## you may not use this file except in compliance with the License.         ##
## You may obtain a copy of the License at                                  ##
##                                                                          ##
##     http://www.apache.org/licenses/LICENSE-2.0                           ##
##                                                                          ##
## Unless required by applicable law or agreed to in writing, software      ##
## distributed under the License is distributed on an "AS IS" BASIS,        ##
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. ##
## See the License for the specific language governing permissions and      ##
## limitations under the License.                                           ##
## ======================================================================== ##

FIND_PACKAGE(UPCXX REQUIRED)

INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${UPCXX_INCLUDE_DIR}
  ${GASNET_INCLUDE_DIR}
  ${GASNET_CONDUIT_INCLUDE_DIR}
)

ADD_EXECUTABLE(renderer
  renderer.cpp
  #glutdisplay.cpp
  regression.cpp
)

IF (APPLE)
  # use normal linking command
  TARGET_LINK_LIBRARIES(renderer sys lexers loaders image device
    device_singleray
    -L${UPCXX_LIBRARY_PATH} upcxx
    -L${GASNET_LIBRARY_PATH} gasnet-mpi-seq ammpi
    ${MPI_C_LIBRARIES}
  )
ELSE ()
  SET(CMAKE_CXX_LINK_EXECUTABLE "CC -fPIC <LINK_FLAGS> -o <TARGET> ${CMAKE_GNULD_IMAGE_VERSION} <OBJECTS> <LINK_LIBRARIES>")
  TARGET_LINK_LIBRARIES(renderer sys lexers loaders image device
    pthread dl hugetlbfs
    device_singleray
    -L${UPCXX_LIBRARY_PATH} upcxx
    -L${GASNET_LIBRARY_PATH} gasnet-mpi-seq ammpi
    ${MPI_C_LIBRARIES}
  )
ENDIF ()
