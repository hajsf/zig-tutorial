const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = .ReleaseFast;

    const exe = b.addExecutable(.{
        .name = "myexe",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    const path = std.build.LazyPath{ .path = "../zig-lib/zig-out/lib/" };
    std.debug.print("Adding library search path\n", .{});
    exe.addLibraryPath(path); //"zig-lib/zig-out/lib/" });

    std.debug.print("Linking against mylib\n", .{});
    exe.linkSystemLibrary("shared");
    //  exe.linkSystemLibrary("static");

    b.installArtifact(exe);

    //the linkLibrary method is used to link against a library that you have built as part of your project
    // const lib = b.addSharedLibrary(.{
    //    .name = "mylib",
    //    .root_source_file = .{ .path = "mylib.zig" },
    //    .target = target,
    //    .optimize = optimize,
    //});
    //b.installArtifact(lib);
    //exe.linkLibrary("mylib");

    // Below if we want to run
    //    const run_cmd = b.addRunArtifact(exe);
    //    run_cmd.step.dependOn(b.getInstallStep());

    //    if (b.args) |args| {
    //        run_cmd.addArgs(args);
    //    }

    //    const run_step = b.step("run", "Run the app");
    //    run_step.dependOn(&run_cmd.step);
}
