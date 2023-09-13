const std = @import("std");

const format = "Hello, {s} {s}!";

export fn joinStringsSize(firstname: [*:0]const u8, lastname: [*:0]const u8) u64 {
    return std.fmt.count(format, .{ firstname, lastname });
}

// Returns the number of bytes written, or 0 if there was not enough space.
export fn joinStrings(buf_ptr: [*]u8, buf_len: usize, firstname: [*:0]const u8, lastname: [*:0]const u8) u64 {
    var buf = buf_ptr[0..buf_len];
    const written = std.fmt.bufPrint(buf, format, .{ firstname, lastname }) catch return 0;
    return written.len;
}
