const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable("my_program", "src/main.zig");
    exe.setBuildMode(mode);
    exe.setTarget(target);

    exe.linkSystemLibrary("my_library");

    exe.install();
}