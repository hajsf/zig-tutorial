const std = @import("std");
const c = @cImport({
    @cInclude("string_ptr.h");
});

pub fn main() !void {
    var buf: [*c]u8 = undefined;
    c.joinStrings("Hasan", "Yousef", &buf);
    const len = @as(usize, std.c.strlen(buf));
    const greetings = std.mem.sliceFromRaw(u8, buf[0..len]);
    std.debug.print("Saved string: {s}\n", .{greetings});
}
