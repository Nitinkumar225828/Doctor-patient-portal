package com.hms.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

	public static Connection getConn() {

		try {

			String driver = getEnv("DB_DRIVER", "com.mysql.cj.jdbc.Driver");
			String url = getUrl(driver);
			String user = getUser(driver);
			String password = getPassword(driver);

			Class.forName(driver);
			return DriverManager.getConnection(url, user, password);

		} catch (Exception e) {
			throw new IllegalStateException("Unable to create database connection", e);
		}
	}

	private static String getUrl(String driver) {
		String url = System.getenv("DB_URL");
		if (url != null && !url.trim().isEmpty()) {
			return url;
		}

		if (driver.toLowerCase().contains("h2")) {
			return "jdbc:h2:mem:hospital;MODE=MySQL;DATABASE_TO_LOWER=TRUE;DB_CLOSE_DELAY=-1";
		}

		String host = getEnv("DB_HOST", "127.0.0.1");
		String port = getEnv("DB_PORT", "3307");
		String database = getEnv("DB_NAME", "hospital");
		return "jdbc:mysql://" + host + ":" + port + "/" + database;
	}

	private static String getUser(String driver) {
		if (driver.toLowerCase().contains("h2")) {
			return getEnv("DB_USER", "sa");
		}
		return getEnv("DB_USER", "root");
	}

	private static String getPassword(String driver) {
		if (driver.toLowerCase().contains("h2")) {
			return getEnv("DB_PASSWORD", "");
		}
		return getEnv("DB_PASSWORD", "wasim");
	}

	private static String getEnv(String key, String defaultValue) {
		String value = System.getenv(key);
		if (value == null || value.trim().isEmpty()) {
			return defaultValue;
		}
		return value;
	}
}
