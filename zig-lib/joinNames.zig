const std = @import("std");

export fn joinNames(firstName: [*c]const u8, lastName: [*c]const u8) [*c]u8 {
    var allocator = std.heap.page_allocator;
    var buffer = try std.Buffer.initSize(allocator, 0);
    defer buffer.deinit();

    try buffer.append(firstName);
    try buffer.append(", ");
    try buffer.append(lastName);

    return buffer.toOwnedSlice().ptr;
}
