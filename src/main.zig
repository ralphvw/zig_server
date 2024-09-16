const std = @import("std");
const Socket = @import("config.zig").Socket;
const stdout = std.io.getStdOut().writer();
const request = @import("request.zig");

pub fn main() !void {
    const socket = try Socket.init();
    try stdout.print("Server address: {}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();
    var buffer: [1024]u8 = undefined;

    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }

    try request.read_request(connection, buffer[0..buffer.len]);
    try stdout.print("{s}\n", .{buffer});
}
