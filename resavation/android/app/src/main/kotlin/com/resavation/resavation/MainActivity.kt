package com.resavation.resavation

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall;
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import com.algolia.search.client.ClientSearch
import com.algolia.search.helper.toIndexName
import com.algolia.search.model.APIKey
import com.algolia.search.model.ApplicationID
import com.algolia.search.model.IndexName
import com.algolia.search.model.response.ResponseSearch
import com.algolia.search.model.search.Query
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json


class MainActivity : FlutterActivity() {

    val algoliaAPIAdapter = AlgoliaAPIFlutterAdapter(
        ApplicationID("FQSSI69V1P"),
        APIKey("d94b6fa40a45e57bb1aad57409d0c2fa")
    )

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.algolia/api"
        ).setMethodCallHandler { call, result ->
            algoliaAPIAdapter.perform(call, result)
        }
    }
}


class AlgoliaAPIFlutterAdapter(applicationID: ApplicationID, apiKey: APIKey) {

    val client = ClientSearch(applicationID, apiKey)

    fun perform(call: MethodCall, result: MethodChannel.Result): Unit = runBlocking {
//        Log.d("AlgoliaAPIAdapter", "method: ${call.method}")
//        Log.d("AlgoliaAPIAdapter", "args: ${call.arguments}")
        val args = call.arguments as? List<String>
        if (args == null) {
            result.error("AlgoliaNativeError", "Missing arguments", null)
            return@runBlocking
        }

        when (call.method) {
            "search" -> search(
                indexName = args[0].toIndexName(),
                query = Query(args[1]),
                result = result
            )
            else -> result.notImplemented()
        }
    }

    suspend fun search(indexName: IndexName, query: Query, result: MethodChannel.Result) {
        val index = client.initIndex(indexName)
        try {
            val search = index.search(query = query)
            result.success(Json.encodeToString(ResponseSearch.serializer(), search))
        } catch (e: Exception) {
            result.error("AlgoliaNativeError", e.localizedMessage, e.cause)
        }
    }
}


