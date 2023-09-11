const std = @import("std");
const my_library = @import("my_library");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const key = "my-api";
    const value = try my_library.getValue(allocator, key);
    if (value) |v| {
        std.debug.print("Value of {}: {}\n", .{ key, v });
    } else {
        std.debug.print("Key {} not found\n", .{ key });
    }
}