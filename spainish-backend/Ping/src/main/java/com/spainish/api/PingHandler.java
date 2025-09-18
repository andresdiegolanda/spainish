package com.spainish.api;

import java.time.Instant;
import java.util.Map;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

public class PingHandler implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {
	@Override
	public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent req, Context ctx) {
		String body = """
				{
				  "status":"ok",
				  "service":"spainish-backend",
				  "timestamp":"%s"
				}
				""".formatted(Instant.now().toString());

		return new APIGatewayProxyResponseEvent().withStatusCode(200)
				.withHeaders(Map.of("Content-Type", "application/json", "Access-Control-Allow-Origin", "*"))
				.withBody(body);
	}
}
