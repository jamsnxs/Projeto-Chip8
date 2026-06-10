const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "chip8",
        .root_module = exe_mod,
    });

    exe.addIncludePath(b.path("vendor/raylib/src"));
    exe.addIncludePath(b.path("vendor/raylib/src/external/glfw/include"));
    exe.addIncludePath(b.path("vendor/raylib/src/external/glfw/src"));

    exe.addCSourceFiles(.{
        .files = &.{
            "src/main.c",

            "vendor/raylib/src/rcore.c",
            "vendor/raylib/src/rshapes.c",
            "vendor/raylib/src/rtextures.c",
            "vendor/raylib/src/rtext.c",

            "vendor/raylib/src/external/glfw/src/context.c",
            "vendor/raylib/src/external/glfw/src/init.c",
            "vendor/raylib/src/external/glfw/src/input.c",
            "vendor/raylib/src/external/glfw/src/monitor.c",
            "vendor/raylib/src/external/glfw/src/platform.c",
            "vendor/raylib/src/external/glfw/src/vulkan.c",
            "vendor/raylib/src/external/glfw/src/window.c",

            "vendor/raylib/src/external/glfw/src/x11_init.c",
            "vendor/raylib/src/external/glfw/src/x11_monitor.c",
            "vendor/raylib/src/external/glfw/src/x11_window.c",
            "vendor/raylib/src/external/glfw/src/xkb_unicode.c",

            "vendor/raylib/src/external/glfw/src/linux_joystick.c",

            "vendor/raylib/src/external/glfw/src/posix_module.c",
            "vendor/raylib/src/external/glfw/src/posix_poll.c",
            "vendor/raylib/src/external/glfw/src/posix_thread.c",
            "vendor/raylib/src/external/glfw/src/posix_time.c",

            "vendor/raylib/src/external/glfw/src/glx_context.c",
            "vendor/raylib/src/external/glfw/src/egl_context.c",
            "vendor/raylib/src/external/glfw/src/osmesa_context.c",
        },
        .flags = &.{
            "-std=c99",
            "-D_POSIX_C_SOURCE=200809L",
            "-D_GNU_SOURCE",
            "-DPLATFORM_DESKTOP",
            "-DGRAPHICS_API_OPENGL_33",
            "-D_GLFW_X11",
        },
    });

    exe.linkLibC();

    exe.linkSystemLibrary("GL");
    exe.linkSystemLibrary("m");
    exe.linkSystemLibrary("pthread");
    exe.linkSystemLibrary("dl");
    exe.linkSystemLibrary("rt");

    exe.linkSystemLibrary("X11");
    exe.linkSystemLibrary("Xi");
    exe.linkSystemLibrary("Xrandr");
    exe.linkSystemLibrary("Xinerama");
    exe.linkSystemLibrary("Xcursor");

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run CHIP-8 emulator");
    run_step.dependOn(&run_cmd.step);
}
