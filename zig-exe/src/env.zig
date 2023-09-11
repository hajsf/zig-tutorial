const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    // _ = allocator;
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
        var key_value = std.mem.split(u8, line, "=");
        const key = key_value.next() orelse "";
        const value = key_value.next() orelse "";
        if (std.mem.eql(u8, key, "my-api")) {
            std.debug.print("Value of my-api: {s}\n", .{value});
            break;
        }
    }
}
