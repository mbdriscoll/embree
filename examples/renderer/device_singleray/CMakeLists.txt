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

CONFIGURE_CPU ()
FIND_PACKAGE(UPCXX REQUIRED)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

SET (SOURCES 
    api/singleray_device.cpp
    lights/hdrilight.cpp   
    shapes/trianglemesh_normals.cpp   
    shapes/trianglemesh_full.cpp       
    samplers/sampler.cpp
    samplers/distribution1d.cpp
    samplers/distribution2d.cpp
    integrators/pathtraceintegrator.cpp
    filters/filter.cpp
    renderers/debugrenderer.cpp
    renderers/integratorrenderer.cpp
    renderers/progress.cpp
    )

IF (__XEON_PHI__)
  ADD_EXECUTABLE(device_singleray${EXT} ${SOURCES})
  TARGET_LINK_LIBRARIES(device_singleray${EXT} sys${EXT} embree${EXT} coi_server${EXT})
ELSE ()
  add_definitions( -DGASNET_SEQ )
  include_directories(${UPCXX_INCLUDE_DIR})
  include_directories(${GASNET_INCLUDE_DIR})
  include_directories(${GASNET_CONDUIT_INCLUDE_DIR})
  ADD_LIBRARY(device_singleray${EXT} SHARED ${SOURCES})
  TARGET_LINK_LIBRARIES(device_singleray${EXT} sys${EXT} embree${EXT} image${EXT}
    -L${UPCXX_LIBRARY_PATH} upcxx
    -L${GASNET_LIBRARY_PATH} gasnet-mpi-seq ammpi
    ${MPI_C_LIBRARIES}
  )

ENDIF ()
