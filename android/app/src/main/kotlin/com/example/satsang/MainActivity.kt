package com.example.satsang
import android.content.Intent
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import java.io.File
import androidx.core.content.FileProvider
import androidx.core.view.WindowCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(window, false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
        }


        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "resumePath").setMethodCallHandler {
                call, result ->
            if(call.method == "resumePathMethod") {
                var path = (call.arguments as HashMap<*, *>)["path"]
                val file: File = File(path.toString())
                val target = Intent(Intent.ACTION_VIEW)
                target.flags = Intent.FLAG_ACTIVITY_NO_HISTORY
                try {
                    val uri = FileProvider.getUriForFile(
                        this@MainActivity,
                        "com.example.satsang.fileProvider",
                        file
                    )
                    target.setDataAndType(uri, "application/pdf")
                    target.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                    startActivity(Intent.createChooser(target, "Open file"))
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
            else {
                result.notImplemented()
            }
        }

    }
}
