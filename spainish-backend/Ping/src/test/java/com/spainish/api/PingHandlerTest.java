package com.spainish.api;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Tests for {@link PingHandler}.
 */
public class PingHandlerTest {

    @Test
    public void returnsOkWithExpectedJsonAndHeaders() {
        // Arrange
        PingHandler handler = new PingHandler();
        APIGatewayProxyRequestEvent request = new APIGatewayProxyRequestEvent();

        // Act
        APIGatewayProxyResponseEvent response = handler.handleRequest(request, null);

        // Assert status
        assertNotNull("Response must not be null", response);
        assertEquals("Status code should be 200", 200, response.getStatusCode().intValue());

        // Assert headers
        assertNotNull("Headers must not be null", response.getHeaders());
        assertEquals("application/json", response.getHeaders().get("Content-Type"));
        assertEquals("*", response.getHeaders().get("Access-Control-Allow-Origin"));

        // Assert body
        String body = response.getBody();
        assertNotNull("Body must not be null", body);
        assertTrue("Body should contain status field", body.contains("\"status\":\"ok\""));
        assertTrue("Body should contain service field", body.contains("\"service\":\"spainish-backend\""));
        assertTrue("Body should contain timestamp field", body.contains("\"timestamp\":"));
    }
}
