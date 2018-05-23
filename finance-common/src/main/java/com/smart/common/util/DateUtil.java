package com.smart.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil {

    /**
     * 基础ISO 8601日期格式yyyyMMdd，即2002年12月25日20021225
     */
    public static final String ISO_DATE_FORMAT = "yyyyMMdd";

    /**
     * 扩展ISO 8601日期格式yyyy-MM-dd即2002年12月25日2002-12-25
     */
    public static final String ISO_EXPANDED_DATE_FORMAT = "yyyy-MM-dd";

    /**
     * yyyy-MM-dd hh:mm:ss
     */
    public static String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss";
    public static String DATE_PATTERN = "yyyyMMddHHmmss";
   
    /**
     * 则个
     */
    private static boolean LENIENT_DATE = false;


    private static Random random = new Random();
    private static final int ID_BYTES = 10;

    public synchronized static String generateId() {
        StringBuffer result = new StringBuffer();
        result = result.append(System.currentTimeMillis());
        for (int i = 0; i < ID_BYTES; i++) {
            result = result.append(random.nextInt(10));
        }
        return result.toString();
    }

    protected static final float normalizedJulian(float JD) {

        float f = Math.round(JD + 0.5f) - 0.5f;

        return f;
    }

    /**
     * 返回朱利安日期。 Julian日期将被转换为中午GMT，
     * 以便它与最接近的半整数相匹配
     * （即，1.4的朱利安日期换成1.5，0.9换成0.5）。
     *
     * @param JD the Julian date(朱利安日期表示从当年的元旦到现在过了多少天)
     * @return 公历的日期
     */
    public static final Date toDate(float JD) {

        /* 要将Julian日数转换为公历日期，假定格林威治时间为0小时（如此
     它以0.5结尾）。 做下面的计算，再次删除所有的小数部分
     乘法和分裂。 注意：这种方法不会准确的给出日期
     Gregorian Proleptic Calendar，即通过延长公历获得的日历
      日历倒退到1582年以前。使用格里历闰年规则。
          特别是，如果Y <400，则该方法失败。 */
        float Z = (normalizedJulian(JD)) + 0.5f;
        float W = (int) ((Z - 1867216.25f) / 36524.25f);
        float X = (int) (W / 4f);
        float A = Z + 1 + W - X;
        float B = A + 1524;
        float C = (int) ((B - 122.1) / 365.25);
        float D = (int) (365.25f * C);
        float E = (int) ((B - D) / 30.6001);
        float F = (int) (30.6001f * E);
        int day = (int) (B - D - F);
        int month = (int) (E - 1);

        if (month > 12) {
            month = month - 12;
        }

        int year = (int) (C - 4715); //(if Month is January or February) or C-4716 (otherwise)

        if (month > 2) {
            year--;
        }

        Calendar c = Calendar.getInstance();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month - 1); // damn 0 offsets
        c.set(Calendar.DATE, day);

        return c.getTime();
    }

    /**
     * 返回两个日期之间的天数。 正值表明
     * 第二个日期在第一个之后，负值表示，
     * 相反。 依靠特定的时间是有问题的。
     *
     * @param early the "first date"
     * @param late the "second date"
     * @return the days between the two dates
     */
    public static final int daysBetween(Date early, Date late) {

        Calendar c1 = Calendar.getInstance();
        Calendar c2 = Calendar.getInstance();
        c1.setTime(early);
        c2.setTime(late);

        return daysBetween(c1, c2);
    }

    /**
     * 返回两个日期之间的天数。 正值表明
     * 第二个日期在第一个日期之后，负值表示，
     * 相反。
     *
     * @param early
     * @param late
     * @return the days between two dates.
     */
    public static final int daysBetween(Calendar early, Calendar late) {

        return (int) (toJulian(late) - toJulian(early));
    }

    /**
     *公历转换成朱利安日期
     * @param c a calendar instance
     * @return the julian day number
     */
    public static final float toJulian(Calendar c) {

        int Y = c.get(Calendar.YEAR);
        int M = c.get(Calendar.MONTH);
        int D = c.get(Calendar.DATE);
        int A = Y / 100;
        int B = A / 4;
        int C = 2 - A + B;
        float E = (int) (365.25f * (Y + 4716));
        float F = (int) (30.6001f * (M + 1));
        float JD = C + D + E + F - 1524.5f;

        return JD;
    }

    /**
     * 公历转换成朱利安日期
     * @param date
     * @return the julian day number
     */
    public static final float toJulian(Date date) {

        Calendar c = Calendar.getInstance();
        c.setTime(date);

        return toJulian(c);
    }

    /**
     * @param isoString  
     * @param fmt 
     * @param field   Calendar.YEAR/Calendar.MONTH/Calendar.DATE
     * @param amount 
     * @return
     * @throws ParseException
     */
    public static final String dateIncrease(String isoString, String fmt,
                                            int field, int amount) {

        try {
            Calendar cal = GregorianCalendar.getInstance(TimeZone.getTimeZone(
                    "GMT"));
            cal.setTime(stringToDate(isoString, fmt, true));
            cal.add(field, amount);

            return dateToString(cal.getTime(), fmt);

        } catch (Exception ex) {
            return null;
        }
    }

    /**
     * 时间字段滚动功能。
     * 在给定时间字段上滚动（上/下）单个时间单位。
     *
     * @param isoString
     * @param field the time field.
     * @param up Indicates if rolling up or rolling down the field value.
     * @exception ParseException if an unknown field value is given.
     */
    public static final String roll(String isoString, String fmt, int field,
                                    boolean up) throws ParseException {

        Calendar cal = GregorianCalendar.getInstance(TimeZone.getTimeZone(
                "GMT"));
        cal.setTime(stringToDate(isoString, fmt));
        cal.roll(field, up);

        return dateToString(cal.getTime(), fmt);
    }

    /**
     * Time Field Rolling function.
     * Rolls (up/down) a single unit of time on the given time field.
     *
     * @param isoString
     * @param field the time field.
     * @param up Indicates if rolling up or rolling down the field value.
     * @exception ParseException if an unknown field value is given.
     */
    public static final String roll(String isoString, int field, boolean up) throws
            ParseException {

        return roll(isoString, DATETIME_PATTERN, field, up);
    }

    /**
     *  java.util.Date
     * @param dateText  
     * @param format  
     * @param lenient  
     * @return
     */
    public static Date stringToDate(String dateText, String format,
                                    boolean lenient) {

        if (dateText == null) {

            return null;
        }

        DateFormat df = null;

        try {

            if (format == null) {
                df = new SimpleDateFormat();
            } else {
                df = new SimpleDateFormat(format);
            }

            // setLenient avoids allowing dates like 9/32/2001
            // which would otherwise parse to 10/2/2001
            df.setLenient(false);

            return df.parse(dateText);
        } catch (ParseException e) {

            return null;
        }
    }

    /**
     * @return Timestamp
     */
    public static java.sql.Timestamp getCurrentTimestamp() {
        return new java.sql.Timestamp(new Date().getTime());
    }

    /** java.util.Date
     * @param format
     * @return
     */
    public static Date stringToDate(String dateString, String format) {

        return stringToDate(dateString, format, LENIENT_DATE);
    }

    /**
     * java.util.Date
     */
    public static Date stringToDate(String dateString) {
        return stringToDate(dateString, ISO_EXPANDED_DATE_FORMAT, LENIENT_DATE);
    }

    /**  
     * @return 
     * @param pattern 
     * @param date  
     */
    public static String dateToString(Date date, String pattern) {

        if (date == null) {

            return null;
        }

        try {

            SimpleDateFormat sfDate = new SimpleDateFormat(pattern);
            sfDate.setLenient(false);

            return sfDate.format(date);
        } catch (Exception e) {

            return null;
        }
    }

    /**
     * yyyy-MM-dd
     * @param date
     * @return
     */
    public static String dateToString(Date date) {
        return dateToString(date, ISO_EXPANDED_DATE_FORMAT);
    }

    /**  
     * @return  
     */
    public static Date getCurrentDateTime() {
        Calendar calNow = Calendar.getInstance();
        Date dtNow = calNow.getTime();

        return dtNow;
    }

    /**
     *  
     * @param pattern  
     * @return
     */
    public static String getCurrentDateString(String pattern) {
        return dateToString(getCurrentDateTime(), pattern);
    }

    /**
     *   yyyy-MM-dd
     * @return
     */
    public static String getCurrentDateString() {
        return dateToString(getCurrentDateTime(), ISO_EXPANDED_DATE_FORMAT);
    }

    /**
     * 返回固定格式的当前时间
     *   yyyy-MM-dd hh:mm:ss
     * @return
     */
    public static String dateToStringWithTime( ) {

        return dateToString(new Date(), DATETIME_PATTERN);
    }

    
    /**
     *   yyyy-MM-dd hh:mm:ss
     * @param date
     * @return
     */
    public static String dateToStringWithTime(Date date) {

        return dateToString(date, DATETIME_PATTERN);
    }

    /**
     *  
     * @param date
     * @param days
     * @return java.util.Date
     */
    public static Date dateIncreaseByDay(Date date, int days) {

        Calendar cal = GregorianCalendar.getInstance(TimeZone.getTimeZone(
                "GMT"));
        cal.setTime(date);
        cal.add(Calendar.DATE, days);

        return cal.getTime();
    }

    /**
     *  
     * @param date
     * @return java.util.Date
     */
    public static Date dateIncreaseByMonth(Date date, int mnt) {

        Calendar cal = GregorianCalendar.getInstance(TimeZone.getTimeZone(
                "GMT"));
        cal.setTime(date);
        cal.add(Calendar.MONTH, mnt);

        return cal.getTime();
    }

    /**
     *  
     * @param date
     * @param mnt
     * @return java.util.Date
     */
    public static Date dateIncreaseByYear(Date date, int mnt) {

        Calendar cal = GregorianCalendar.getInstance(TimeZone.getTimeZone(
                "GMT"));
        cal.setTime(date);
        cal.add(Calendar.YEAR, mnt);

        return cal.getTime();
    }

    /**
     *  
     * @param date   yyyy-MM-dd
     * @param days
     * @return  yyyy-MM-dd
     */
    public static String dateIncreaseByDay(String date, int days) {
        return dateIncreaseByDay(date, ISO_DATE_FORMAT, days);
    }

    /**
     * @param date  
     * @param fmt  
     * @param days
     * @return
     */
    public static String dateIncreaseByDay(String date, String fmt, int days) {
        return dateIncrease(date, fmt, Calendar.DATE, days);
    }

    /**
     *  
     * @param src  
     * @param srcfmt  
     * @param desfmt 
     * @return
     */
    public static String stringToString(String src, String srcfmt,
                                        String desfmt) {
        return dateToString(stringToDate(src, srcfmt), desfmt);
    }

    /**
     *  
     * @param date  
     * @return string
     */
    public static String getYear(Date date) {
        SimpleDateFormat formater = new SimpleDateFormat(
                "yyyy");
        String cur_year = formater.format(date);
        return cur_year;
    }

    /**
     *  
     * @param date  
     * @return string
     */
    public static String getMonth(Date date) {
        SimpleDateFormat formater = new SimpleDateFormat(
                "MM");
        String cur_month = formater.format(date);
        return cur_month;
    }

    /**
     * @param date  
     * @return string
     */
    public static String getDay(Date date) {
        SimpleDateFormat formater = new SimpleDateFormat(
                "dd");
        String cur_day = formater.format(date);
        return cur_day;
    }
    
    /**
     * @param date  
     * @return string
     */
    public static String getHour(Date date) {
        SimpleDateFormat formater = new SimpleDateFormat(
                "HH");
        String cur_day = formater.format(date);
        return cur_day;
    }    

    public static int getMinsFromDate(Date dt) {
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(dt);
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int min = cal.get(Calendar.MINUTE);
        return ((hour * 60) + min);
    }

    /**
     * 将字符串转换为日期对象的函数。 如果输入无效，则表示当前或次日日期
     * 退回（由Ali Naqvi于2006-5-16添加）。
     * @param str String input in YYYY-MM-DD HH:MM[:SS] format.
     * @param isExpiry boolean if set and input string is invalid then next day date is returned
     * @return Date
     */
    public static Date convertToDate(String str, boolean isExpiry) {
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date dt = null;
        try {
            dt = fmt.parse(str);
        } catch (ParseException ex) {
            Calendar cal = Calendar.getInstance();
            if (isExpiry) {
                cal.add(Calendar.DAY_OF_MONTH, 1);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
            } else {
                cal.set(Calendar.HOUR_OF_DAY, 0);
                cal.set(Calendar.MINUTE, 0);
            }
            dt = cal.getTime();
        }
        return dt;
    }

    public static Date convertToDate(String str) {
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        Date dt = null;
        try {
            dt = fmt.parse(str);
        } catch (ParseException ex) {
            dt = new Date();
        }
        return dt;
    }

    public static String dateFromat(Date date, int minute) {
        String dateFormat = null;
        int year = Integer.parseInt(getYear(date));
        int month = Integer.parseInt(getMonth(date));
        int day = Integer.parseInt(getDay(date));
        int hour = minute / 60;
        int min = minute % 60;
        dateFormat = String.valueOf(year)
                     +
                     (month > 9 ? String.valueOf(month) :
                      "0" + String.valueOf(month))
                     +
                     (day > 9 ? String.valueOf(day) : "0" + String.valueOf(day))
                     + " "
                     +
                     (hour > 9 ? String.valueOf(hour) : "0" + String.valueOf(hour))
                     +
                     (min > 9 ? String.valueOf(min) : "0" + String.valueOf(min))
                     + "00";
        return dateFormat;
    }
    public static String sDateFormat() {
    	return new SimpleDateFormat(DATE_PATTERN).format(Calendar.getInstance().getTime());	
    }
    public static void main(String[] args)
	{
    	String timeDir=DateUtil.dateToString(new Date(),DateUtil.ISO_EXPANDED_DATE_FORMAT);
		System.out.println(timeDir);
	}
    
}
