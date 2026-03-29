package com.hms.config;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.hms.db.DBConnection;

@WebListener
public class DatabaseBootstrapListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		if (!Boolean.parseBoolean(System.getenv("BOOTSTRAP_DB"))) {
			return;
		}

		try (Connection conn = DBConnection.getConn(); Statement stmt = conn.createStatement()) {
			String script = readScript("/db/bootstrap.sql");
			for (String sql : script.split(";")) {
				String trimmed = sql.trim();
				if (!trimmed.isEmpty()) {
					stmt.execute(trimmed);
				}
			}
		} catch (Exception e) {
			throw new IllegalStateException("Failed to bootstrap database", e);
		}
	}

	private String readScript(String resourcePath) throws Exception {
		InputStream inputStream = getClass().getResourceAsStream(resourcePath);
		if (inputStream == null) {
			throw new IllegalStateException("Resource not found: " + resourcePath);
		}

		StringBuilder builder = new StringBuilder();
		try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
			String line;
			while ((line = reader.readLine()) != null) {
				String trimmed = line.trim();
				if (!trimmed.startsWith("--")) {
					builder.append(line).append('\n');
				}
			}
		}
		return builder.toString();
	}
}
