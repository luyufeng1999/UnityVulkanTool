# UnityVulkanTool

基于[UnityNativeRenderingPlugin](https://github.com/Unity-Technologies/NativeRenderingPlugin) 实现的 Vulkan API 物理设备信息获取工具

## 目前实现的功能

获取物理设备支持的最大纹理绑定数量

```c#
[DllImport("VulkanTools")]
private static extern uint GetUnityVulkanMaxTextureBinds();
```

