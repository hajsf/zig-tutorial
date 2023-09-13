const std = @import("std");
const c = @cImport({
    @cInclude("string_utils.h");
});

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
    const greetings = c.joinStrings(@as(?*anyopaque, @ptrCast(@constCast(&allocator))), "Hasan", "Yousef");
    defer allocator.free(@as([*:0]u8, @ptrCast(greetings)));

    std.debug.print("Saved string: {s}\n", .{@as([*:0]u8, @ptrCast(greetings))});
}
