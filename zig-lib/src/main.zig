const std = @import("std");

/// The getValue function is returning the value of the provided key.
/// The `.env` file should be located at the root folder.
export fn getValue(key: []const u8) !?[]const u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};

    defer if (gpa.deinit() != .ok) {
        std.log.err("oh no, we've got a leak", .{});
    } else {
        std.log.debug("memory managed correctly", .{});
    };
    const file = try std.fs.cwd().openFile(".env", .{});
    defer file.close();

    var buf: [1024]u8 = undefined;
    var stream = file.reader();

    while (try stream.readUntilDelimiterOrEof(&buf, 10)) |line| {
        var key_value = std.mem.split(line, "=");
        const env_key = key_value.next() orelse "";
        const value = key_value.next() orelse "";
        if (std.mem.eql(u8, env_key, key)) {
            std.debug.print("Value of of {s} is: {s}\n", .{ key, value });
            return value;
        }
    }
    return null;
}
