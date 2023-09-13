const std = @import("std");
const c = @cImport({
    @cInclude("clib.h");
});

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .verbose_log = true }){};

    defer {
        if (gpa.deinit() == .ok) {
            std.debug.print("Memory has been managed correctly.\n", .{});
        } else {
            std.debug.print("Memory has not been managed correctly.\n", .{});
            // CAN I ADD SOMETHING HERE TO SHOW ME MORE DEATILS ABOUT THE LEAKS IN MY CODE?
        }
    }
    const allocator = gpa.allocator();
    const firstname = "Hasan";
    const lastname = "Yousef";
    var buf = try allocator.alloc(u8, c.joinStringsSize(firstname, lastname));
    defer allocator.free(buf);
    const len = c.joinStrings(buf.ptr, buf.len, firstname, lastname);
    const greetings = buf[0..len]; // not really necessary here, because we allocated the correct size from `joinStringsSize`
    std.debug.print("Saved string: {s}\n", .{greetings});
}

// zig build-lib -dynamic clib.zig
// zig run -I . cmain.zig
