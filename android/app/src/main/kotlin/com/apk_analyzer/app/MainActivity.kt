package com.apk_analyzer.app

import android.content.pm.PackageManager
import android.os.Bundle
import android.content.pm.PackageInfo
import android.graphics.drawable.Drawable
import android.util.Base64
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {

    private val CHANNEL = "apk_analyzer"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "getPermissions") {
                    val apkPath = call.argument<String>("apkPath")

                    if (apkPath != null) {
                        val permissions = getPermissionsFromApk(apkPath)
                        result.success(permissions)
                    } else {
                        result.error("INVALID_PATH", "APK path is null", null)
                    }

                } else if (call.method == "getAppName") {
                    val apkPath = call.argument<String>("apkPath")

                    if (apkPath != null) {
                        try {
                            val appName = getAppNameFromApk(apkPath)
                            result.success(appName)
                        } catch (e: Exception) {
                            result.error("ERROR", "Failed to get app name: ${e.message}", null)
                        }
                    } else {
                        result.error("INVALID_PATH", "APK path is null", null)
                    }

                } else if (call.method == "getPackageName") {
                    val apkPath = call.argument<String>("apkPath")

                    if (apkPath != null) {
                        try {
                            val packageName = getPackageNameFromApk(apkPath)
                            result.success(packageName)
                        } catch (e: Exception) {
                            result.error("ERROR", "Failed to get package name: ${e.message}", null)
                        }
                    } else {
                        result.error("INVALID_PATH", "APK path is null", null)
                    }

                } else if (call.method == "getAppLogo") {
                    val apkPath = call.argument<String>("apkPath")

                    if (apkPath != null) {
                        try {
                            val logoBase64 = getAppLogoFromApk(apkPath)
                            result.success(logoBase64)
                        } catch (e: Exception) {
                            result.error("ERROR", "Failed to get app logo: ${e.message}", null)
                        }
                    } else {
                        result.error("INVALID_PATH", "APK path is null", null)
                    }

                } else {
                    result.notImplemented()
                }
            }
    }

    private fun getPermissionsFromApk(apkPath: String): List<String> {
        val pm: PackageManager = packageManager

        val packageInfo: PackageInfo? =
            pm.getPackageArchiveInfo(apkPath, PackageManager.GET_PERMISSIONS)

        val permissionsList = mutableListOf<String>()

        packageInfo?.requestedPermissions?.forEach {
            permissionsList.add(it)
        }

        return permissionsList
    }

    private fun getAppNameFromApk(apkPath: String): String {
        val pm: PackageManager = packageManager
        
        val packageInfo: PackageInfo? = pm.getPackageArchiveInfo(
            apkPath,
            PackageManager.GET_META_DATA
        )
        
        val appInfo = packageInfo?.applicationInfo
        appInfo?.sourceDir = apkPath
        appInfo?.publicSourceDir = apkPath
        
        val appName = if (appInfo != null) {
            pm.getApplicationLabel(appInfo).toString()
        } else {
            "Unknown App"
        }
        
        return appName
    }

    private fun getPackageNameFromApk(apkPath: String): String {
        val pm: PackageManager = packageManager
        
        val packageInfo: PackageInfo? = pm.getPackageArchiveInfo(
            apkPath,
            PackageManager.GET_META_DATA
        )
        
        return packageInfo?.packageName ?: "Unknown Package"
    }

    private fun getAppLogoFromApk(apkPath: String): String {
        val pm: PackageManager = packageManager
        
        val packageInfo: PackageInfo? = pm.getPackageArchiveInfo(
            apkPath,
            PackageManager.GET_META_DATA
        )
        
        val appInfo = packageInfo?.applicationInfo
        appInfo?.sourceDir = apkPath
        appInfo?.publicSourceDir = apkPath
        
        return if (appInfo != null) {
            try {
                val icon: Drawable? = pm.getApplicationIcon(appInfo)
                if (icon != null) {
                    drawableToBase64(icon)
                } else {
                    ""
                }
            } catch (e: Exception) {
                ""
            }
        } else {
            ""
        }
    }

    private fun drawableToBase64(drawable: Drawable): String {
        val bitmap = android.graphics.Bitmap.createBitmap(
            drawable.intrinsicWidth,
            drawable.intrinsicHeight,
            android.graphics.Bitmap.Config.ARGB_8888
        )
        val canvas = android.graphics.Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        
        val outputStream = ByteArrayOutputStream()
        bitmap.compress(android.graphics.Bitmap.CompressFormat.PNG, 100, outputStream)
        val imageBytes = outputStream.toByteArray()
        
        return Base64.encodeToString(imageBytes, Base64.NO_WRAP)
    }
}