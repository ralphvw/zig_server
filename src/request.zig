const std = @import("std");
const Connection = std.net.Server.Connection;

pub const Method = enum {
    GET,
    POST,
    PUT,
    DELETE,
};

pub fn read_request(conn: Connection, buffer: []u8) !void {
    const reader = conn.stream.reader();
    _ = try reader.read(buffer);
}
