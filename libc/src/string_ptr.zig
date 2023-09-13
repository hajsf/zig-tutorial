const std = @import("std");

pub fn joinStrings(firstname: []const u8, lastname: []const u8, buf: *[]u8) !void {
    var stream = std.io.fixedBufferStream(buf.*);
    var writer = stream.writer();

    try writer.print("Hello, {s} {s}!", .{ firstname, lastname });

    buf.* = stream.getWritten();
}
