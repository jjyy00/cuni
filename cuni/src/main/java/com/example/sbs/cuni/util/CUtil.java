package com.example.sbs.cuni.util;

import java.math.BigInteger;

public class CUtil {

	public static long getAsLong(Object object) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).longValue();
		} else if (object instanceof Long) {
			return (long) object;
		} else if (object instanceof Integer) {
			return (long) object;
		} else if (object instanceof String) {
			return Long.parseLong((String) object);
		}

		return -1;
	}

	public static int getAsInt(Object object) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		} else if (object instanceof Long) {
			return (int) object;
		} else if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return -1;
	}

} 