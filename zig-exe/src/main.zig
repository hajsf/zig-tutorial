const std = @import("std");
//const my_library = @import("libshared");
//const my_library = @import("static");
const lib = @import("./lib/env.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = std.heap.page_allocator;
    _ = allocator;
    defer if (gpa.deinit() != .ok) {
        std.log.err("oh no, we've got a leak", .{});
    } else {
        std.log.debug("memory managed correctly", .{});
    };

    const key = "my-api";
    const value = try lib.getValue(key);
    if (value) |v| {
        std.debug.print("Value of {s}: {s}\n", .{ key, v });
    } else {
        std.debug.print("Key {s} not found\n", .{key});
    }
}
