const std = @import("std");
const string_utils = @import("string_ptr.zig");

pub fn main() !void {
    const Gpa = std.heap.GeneralPurposeAllocator(.{ .enable_memory_limit = true, .verbose_log = true, .retain_metadata = true });
    var gpa = Gpa{};
    defer {
        if (gpa.deinit() == .ok) {
            std.debug.print("Memory has been managed correctly.\n", .{});
        } else {
            std.debug.print("Memory has not been managed correctly.\n", .{});
            // Unfortunately, Zig does not provide built-in tools for leak detection.
            // You would need to use external tools like Valgrind for that.
        }
    }

    const allocator = gpa.allocator();
    var buf = try allocator.alloc(u8, 100);
    defer allocator.free(buf); // freeing the buffer instead of the `greetings` to ensure all the allocated size `100` had been cleared

    var greetings: []u8 = buf;
    try string_utils.joinStrings("Hasan", "Yousef", &greetings);

    std.debug.print("Saved string: {s}\n", .{greetings});
}
