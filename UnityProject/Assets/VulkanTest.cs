using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.UI;

public class VulkanTest : MonoBehaviour
{
    [DllImport("VulkanTools")]
    private static extern uint GetUnityVulkanMaxTextureBinds();

    public Text messageText;
    
    void Start()
    {
        if (SystemInfo.graphicsDeviceType == GraphicsDeviceType.Vulkan)
        {
            uint maxTextureBinds = GetUnityVulkanMaxTextureBinds();
            messageText.text = $"the {maxTextureBinds} supported by the current graphics device";
        }
    }
}
