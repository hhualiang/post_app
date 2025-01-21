package com.example.post_app

import android.os.Bundle
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import java.io.IOException

class MainActivity : FlutterActivity() {
    private lateinit var channel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize MethodChannel
        channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "com.example.post_app/channel")
        channel.setMethodCallHandler { call, result ->
            if (call.method == "fetchComments") {
                val postId = call.argument<Int>("postId") ?: 0
                fetchComments(postId, result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun fetchComments(postId: Int, result: MethodChannel.Result) {
        val client = OkHttpClient()

        val url = "https://jsonplaceholder.typicode.com/comments?postId=$postId"

        val request = Request.Builder()
            .url(url)
            .build()

        client.newCall(request).enqueue(object : okhttp3.Callback {
            override fun onFailure(call: okhttp3.Call, e: IOException) {
                runOnUiThread {
                    result.error("ERROR", "Failed to fetch comments", e.message)
                }
            }

            override fun onResponse(call: okhttp3.Call, response: Response) {
                if (response.isSuccessful) {
                    val responseBody = response.body?.string() ?: ""
                    runOnUiThread {
                        result.success(responseBody)
                    }
                } else {
                    runOnUiThread {
                        result.error("ERROR", "Error fetching comments: ${response.code}", null)
                    }
                }
            }
        })
    }
}
