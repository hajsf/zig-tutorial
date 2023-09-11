// Run as zig build
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const libShared = b.addSharedLibrary(.{
        .name = "shared",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = .ReleaseFast,
    });
    b.installArtifact(libShared);

    const libStatic = b.addStaticLibrary(.{
        .name = "static",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = .ReleaseFast,
    });
    b.installArtifact(libStatic);
}
