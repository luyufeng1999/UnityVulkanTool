#include "Unity/IUnityGraphicsVulkan.h"
#include <algorithm>

const  uint32_t kMaxSupportedTextureUnits = 64;
static UnityVulkanInstance s_UnityVulkanInstance;
static IUnityGraphicsVulkan* s_UnityVulkan = nullptr;

extern "C" void UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API
UnityPluginLoad(IUnityInterfaces* interfaces) {
    s_UnityVulkan = interfaces->Get<IUnityGraphicsVulkan>();
    s_UnityVulkanInstance = s_UnityVulkan->Instance();
}

extern "C" uint32_t UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API GetUnityVulkanMaxTextureBinds() {
    VkPhysicalDeviceProperties properties;
    vkGetPhysicalDeviceProperties(s_UnityVulkanInstance.physicalDevice, &properties);
    uint32_t maxTextureBinds = std::min<uint32_t>(properties.limits.maxPerStageDescriptorSampledImages, kMaxSupportedTextureUnits);
    return maxTextureBinds;
}