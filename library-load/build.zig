const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = .ReleaseFast;

    const exe = b.addExecutable(.{
        .name = "myexe1",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const path = std.build.LazyPath{ .path = "lib" };
    std.debug.print("Adding library search path\n", .{});
    exe.addLibraryPath(path);
    exe.addIncludePath(path);

    exe.linkLibC();

    std.debug.print("Linking against mylib\n", .{});
    exe.linkSystemLibrary("clib");

    // Set rpath
    exe.rpaths.append(path) catch unreachable;

    // Print all rpaths
    for (exe.rpaths.items) |rpath| {
        std.debug.print("rpath: {s}\n", .{rpath.path});
    }

    b.installArtifact(exe);

    // Below if we want to run
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
