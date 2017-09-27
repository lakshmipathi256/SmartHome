
package com.cdi.smarthome.model;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Locale.Category;

/**
 * {@link Util} is for some utility methods.
 * 

 * @since 1.0
 * @version 1.0.0.1
 */
public final class Util {

    /**
     * Utility method to get a simple human readable date and time using the default locale set for the JVM on the
     * server is used.
     * 
     * @return - Simple date and time
     */
    public static String getSimpleDate() {
        return getSimpleDate(null);
    }

    /**
     * Utility method to get a simple human readable date and time
     * 
     * @param locale
     *            - If null then the default locale set for the JVM on the server is used.
     * @return - Simple date and time
     */
    public static String getSimpleDate(Locale locale) {
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.MEDIUM,
                ((locale == null) ? Locale.getDefault(Category.DISPLAY) : locale));
        String formattedDate = dateFormat.format(date);
        return formattedDate;
    }
}
