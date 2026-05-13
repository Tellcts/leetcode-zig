const std = @import("std");

pub fn build(builder: *std.Build) void {
    // 设置编译配置参数
    const target = builder.standardTargetOptions(.{});
    const optimize = builder.standardOptimizeOption(.{});

    // 添加对外模块，使得用户可以直接通过`@import("leetcode")`直接导入
    const mod = builder.addModule("leetcode", .{
        .root_source_file = builder.path("src/lib.zig"),
        .target = target,
    });

    // 创建静态库 or 动态库
    const static_lib = builder.addLibrary(.{
        .name = "my_lib",
        .linkage = .static,
        .root_module = builder.createModule(.{
            .root_source_file = builder.path("src/lib.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const dynamic_lib = builder.addLibrary(.{
        .name = "my_lib",
        .linkage = .dynamic,
        .root_module = builder.createModule(.{
            .root_source_file = builder.path("src/lib.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    builder.installArtifact(static_lib);
    builder.installArtifact(dynamic_lib);

    // 创建可执行文件编译目标，必须添加一个匿名根模块
    const exe = builder.addExecutable(.{
        // 二进制名称
        .name = "main",
        .root_module = builder.createModule(.{
            .root_source_file = builder.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            // 静态声明二进制的模块依赖，使得`src/main.zig`中可以`@import("foo")`
            .imports = &.{
                .{ .name = "leetcode", .module = mod },
            },
        }),
    });
    // steps: install -> run_cmd -> run_step
    // 将二进制构建产物复制到由 zig build --prefix 指定的目录中
    builder.installArtifact(exe);
    // 声明一个 run step，通过 zig build run 调用
    const run_step = builder.step("run", "Run the app");
    // 创建一个运行 exe 构建产物的步骤
    const run_cmd = builder.addRunArtifact(exe);
    // 使得 run step 依赖于 run_cmd，即先要完成 run_cmd 才能执行 run_step
    run_step.dependOn(&run_cmd.step);
    // 使得 run_cmd 依赖于 安装步骤，
    run_cmd.step.dependOn(builder.getInstallStep());
    // 使得可以在 zig build run 后面传递参数格式为 `zig build run -- arg1 arg2 ...`
    if (builder.args) |args| {
        run_cmd.addArgs(args);
    }

    // 添加测试文件编译目标，需要指定根模块作为入口
    // 类似于 builder.addExecutable()
    const mod_tests = builder.addTest(.{
        .root_module = mod,
    });
    // 声明一个 test step，通过 zig build test 调用
    const test_step = builder.step("test", "Run all tests");
    // 创建一个运行 mod_tests 测试产物的步骤
    const run_mod_tests = builder.addRunArtifact(mod_tests);
    // 使得 test step 依赖于 run_mod_tests 步骤
    test_step.dependOn(&run_mod_tests.step);
}
