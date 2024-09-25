const std = @import("std");
const Socket = @import("config.zig").Socket;
const stdout = std.io.getStdOut().writer();
const Request = @import("request.zig");
const Method = Request.Method;
const Response = @import("response.zig");

pub fn main() !void {
    const socket = try Socket.init();
    try stdout.print("Server address: {}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();
    var buffer: [1024]u8 = undefined;

    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }

    try Request.read_request(connection, buffer[0..buffer.len]);

    const request = try Request.parse_request(buffer[0..buffer.len]);
    try stdout.print("{any}\n", .{request});
    if (request.method == Method.GET) {
        if (std.mem.eql(u8, request.uri, "/")) {
            try Response.send_200(connection);
        } else {
            try Response.send_404(connection);
        }
    }
}
