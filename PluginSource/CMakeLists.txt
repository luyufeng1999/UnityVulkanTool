cmake_minimum_required(VERSION 3.10)
project (UnityVulkanTools)

# 设置C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 生成位置独立代码（动态库必需）
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# 添加源码
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/Unity)
add_library(VulkanTools SHARED main.cpp)

#  添加Vulkan依赖
find_package(Vulkan REQUIRED)

include_directories(${Vulkan_INCLUDE_DIRS})
target_link_libraries(VulkanTools ${Vulkan_LIBRARIES})