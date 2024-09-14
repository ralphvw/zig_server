const std = @import("std");
const Socket = @import("config.zig").Socket;
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const socket = try Socket.init();
    try stdout.print("Server address: {}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();
    _ = connection;
}
