const std = @import("std");
//extern fn getValue(key: []const u8) ?[]const u8;
//const lib = @import("./lib/libshared.so");
//const my_library = @import("static");
//const lib = @import("./lib/env.zig");

extern fn add(a: i32, b: i32) i32;

pub fn main() !void {
    const result = add(2, 3);
    std.debug.print("2 + 3 = {}\n", .{result});

    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    // _ = allocator;
    // defer if (gpa.deinit() != .ok) {
    //     std.log.err("oh no, we've got a leak", .{});
    // } else {
    //     std.log.debug("memory managed correctly", .{});
    // };

    // const key = "my-api";
    // const value = try lib.getValue(key);
    // if (value) |v| {
    //     std.debug.print("Value of {s}: {s}\n", .{ key, v });
    // } else {
    //     std.debug.print("Key {s} not found\n", .{key});
    // }
}
