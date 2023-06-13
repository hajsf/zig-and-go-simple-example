// Run as zig build
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const libShared = b.addSharedLibrary(.{
        .name = "mylibshared",
        .root_source_file = .{ .path = "mylibshared.zig" },
        .target = target,
        .optimize = .ReleaseFast,
    });
    b.installArtifact(libShared);

    const libStatic = b.addStaticLibrary(.{
        .name = "mylibstatic",
        .root_source_file = .{ .path = "mylibstatic.zig" },
        .target = target,
        .optimize = .ReleaseFast,
    });
    b.installArtifact(libStatic);
}
