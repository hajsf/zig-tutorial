const std = @import("std");

pub fn joinStrings(allocator: std.mem.Allocator, firstname: []const u8, lastname: []const u8) ![]u8 {
    var buf = try allocator.alloc(u8, "Hello,".len + firstname.len + lastname.len + 3);
    var stream = std.io.fixedBufferStream(buf);
    var writer = stream.writer();

    try writer.print("Hello, {s} {s}!", .{ firstname, lastname });

    return stream.getWritten();
}
