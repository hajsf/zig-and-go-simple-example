const std = @import("std");
const allocator = std.heap.page_allocator;

pub fn main() !void {
    const server_options: std.net.StreamServer.Options = .{};
    var server = std.net.StreamServer.init(server_options);
    defer server.deinit();
    const addr = try std.net.Address.parseIp("0.0.0.0", 8080);

    // Start listening on the given address
    try server.listen(addr);

    // Handling connections
    while (true) {
        // Accept incoming connections
        const conn = if (server.accept()) |conn| conn else |_| continue;
        // Close the connection when exiting the scope
        defer conn.stream.close();

        // Create a reader for the connection stream
        const reader = conn.stream.reader();
        // Initialize a buffer to store incoming data
        var buffer: [1024]u8 = undefined;
        var buffer_len: usize = 0;

        // Read incoming data from the connection stream
        while (true) {
            if (reader.readByte()) |byte| {
                // Append incoming bytes to the buffer
                buffer[buffer_len] = byte;
                buffer_len += 1;
                // Check if the buffer contains a double CRLF sequence indicating the end of an HTTP request header
                if (buffer_len > 3) if (std.mem.eql(u8, buffer[buffer_len - 4 .. buffer_len], "\r\n\r\n")) break;
            } else |_| {
                break;
            }
        }

        // Parse the incoming request to extract the method and route
        const request_end = std.mem.indexOf(u8, buffer[0..buffer_len], "\r\n") orelse buffer_len;
        const request_line = buffer[0..request_end];
        const method_end = std.mem.indexOf(u8, request_line, " ") orelse request_line.len;
        const method = request_line[0..method_end];
        const route_start = method_end + 1;
        const route_end = std.mem.indexOf(u8, request_line[route_start..], " ") orelse (request_line.len - route_start);
        const route = request_line[route_start .. route_start + route_end];

        // Handle different routes and methods
        if (std.mem.eql(u8, method, "GET")) {
            if (std.mem.eql(u8, route, "/")) {
                // Serve the index.html file from the www folder
                try conn.stream.writeAll("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
                const file = try std.fs.cwd().openFile("www/index.html", .{});
                defer file.close();
                var file_reader = file.reader();
                while (true) {
                    const bytes_read = try file_reader.read(buffer[0..]);
                    if (bytes_read == 0) break;
                    try conn.stream.writeAll(buffer[0..bytes_read]);
                }
            } else if (std.mem.eql(u8, route, "/login")) {
                // Serve the login.html file from the www folder
                try conn.stream.writeAll("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
                const file = try std.fs.cwd().openFile("www/login.html", .{});
                defer file.close();
                var file_reader = file.reader();
                while (true) {
                    const bytes_read = try file_reader.read(buffer[0..]);
                    if (bytes_read == 0) break;
                    try conn.stream.writeAll(buffer[0..bytes_read]);
                }
            } else {
                // Serve a 404 Not Found response for unknown routes
                try conn.stream.writeAll("HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\n\r\n<h1>404 Not Found</h1>");
            }
        } else if (std.mem.eql(u8, method, "POST")) {
            // Serve a JSON error message for POST requests
            try conn.stream.writeAll("HTTP/1.1 400 Bad Request\r\nContent-Type: application/json\r\n\r\n{\"error\": \"POST requests are not supported\"}");
        } else {
            // Serve a 405 Method Not Allowed response for unknown methods
            try conn.stream.writeAll("HTTP/1.1 405 Method Not Allowed\r\nContent-Type: text/html\r\n\r\n<h1>405 Method Not Allowed</h1>");
        }
    }
}
