const std = @import("std");

pub fn getValue(allocator: *std.mem.Allocator, key: []const u8) !?[]const u8 {
    _ = allocator;
    const file = try std.fs.cwd().openFile(".env", .{});
    defer file.close();

    var buf: [1024]u8 = undefined;
    var stream = file.reader();

    while (try stream.readUntilDelimiterOrEof(&buf, 10)) |line| {
        var key_value = std.mem.split(line, "=");
        const env_key = key_value.next() orelse "";
        const value = key_value.next() orelse "";
        if (std.mem.eql(u8, env_key, key)) {
            return value;
        }
    }
    return null;
}