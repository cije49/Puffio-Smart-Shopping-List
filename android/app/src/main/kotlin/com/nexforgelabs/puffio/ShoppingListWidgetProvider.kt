package com.nexforgelabs.puffio

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.os.Bundle
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Home-screen widget. All user-visible strings are localized on the
 * Flutter side and pushed via HomeWidget.saveWidgetData; this class
 * only renders them.
 */
class ShoppingListWidgetProvider : HomeWidgetProvider() {

    companion object {
        private const val MAX_SLOTS = 15 // item rows in the layout

        private val ITEM_IDS = intArrayOf(
            R.id.widget_item_0,
            R.id.widget_item_1,
            R.id.widget_item_2,
            R.id.widget_item_3,
            R.id.widget_item_4,
            R.id.widget_item_5,
            R.id.widget_item_6,
            R.id.widget_item_7,
            R.id.widget_item_8,
            R.id.widget_item_9,
            R.id.widget_item_10,
            R.id.widget_item_11,
            R.id.widget_item_12,
            R.id.widget_item_13,
            R.id.widget_item_14,
        )
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            render(context, appWidgetManager, widgetId, widgetData)
        }
    }

    /** Re-render with an appropriate number of rows when the user resizes. */
    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
        render(context, appWidgetManager, appWidgetId, HomeWidgetPlugin.getData(context))
    }

    private fun render(
        context: Context,
        appWidgetManager: AppWidgetManager,
        widgetId: Int,
        widgetData: SharedPreferences
    ) {
        val views = RemoteViews(context.packageName, R.layout.shopping_list_widget)

        // ---- Data pushed from Flutter (already localized) ----
        val title = widgetData.getString("title", "") ?: ""
        val count = (widgetData.all["count"] as? Number)?.toInt() ?: 0
        val countText = widgetData.getString("count_text", "") ?: ""
        val emptyTitle = widgetData.getString("empty_title", "") ?: ""
        val emptySubtitle = widgetData.getString("empty_subtitle", "") ?: ""
        val moreTemplate = widgetData.getString("more_template", "+ %d") ?: "+ %d"

        views.setTextViewText(R.id.widget_title, title)

        // ---- How many rows fit the current widget height? ----
        val options = appWidgetManager.getAppWidgetOptions(widgetId)
        val heightDp = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT, 0)
        val fitting = if (heightDp <= 0) {
            4 // unknown (e.g. first layout): sensible default
        } else {
            // header + padding ≈ 56dp, each row ≈ 27dp
            ((heightDp - 56) / 27).coerceIn(1, MAX_SLOTS)
        }
        // If not everything fits, reserve one row for the "+ X more" line
        // so the list never clips at the bottom.
        val rows = if (count > fitting) maxOf(1, fitting - 1) else fitting

        if (count == 0) {
            // ---- Empty state ----
            views.setViewVisibility(R.id.widget_list, View.GONE)
            views.setViewVisibility(R.id.widget_empty, View.VISIBLE)
            views.setTextViewText(R.id.widget_count, "")
            views.setTextViewText(R.id.widget_empty_title, emptyTitle)
            views.setTextViewText(R.id.widget_empty_subtitle, emptySubtitle)
        } else {
            // ---- Item rows ----
            views.setViewVisibility(R.id.widget_list, View.VISIBLE)
            views.setViewVisibility(R.id.widget_empty, View.GONE)
            views.setTextViewText(R.id.widget_count, countText)

            var shown = 0
            for (i in ITEM_IDS.indices) {
                val text = widgetData.getString("item_$i", "") ?: ""
                if (i < rows && text.isNotEmpty()) {
                    views.setTextViewText(ITEM_IDS[i], text)
                    views.setViewVisibility(ITEM_IDS[i], View.VISIBLE)
                    shown++
                } else {
                    views.setViewVisibility(ITEM_IDS[i], View.GONE)
                }
            }

            val hidden = count - shown
            if (hidden > 0) {
                views.setTextViewText(
                    R.id.widget_more,
                    String.format(moreTemplate, hidden)
                )
                views.setViewVisibility(R.id.widget_more, View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.widget_more, View.GONE)
            }
        }

        // ---- Tap anywhere: open the app directly on the shopping list ----
        val pendingIntent = HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java,
            Uri.parse("puffio://widget/open-list")
        )
        views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

        appWidgetManager.updateAppWidget(widgetId, views)
    }
}
