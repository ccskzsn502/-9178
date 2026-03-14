MODULE_NAME := rwMem
RESMAN_CORE_OBJS := sys.o bp.o
RESMAN_GLUE_OBJS :=

ifneq ($(KERNELRELEASE),)
    $(MODULE_NAME)-objs := $(RESMAN_GLUE_OBJS) $(RESMAN_CORE_OBJS)
    # 修复致命错误：必须是 obj-m 才能生成 .ko 动态模块
    obj-m := $(MODULE_NAME).o
else
ifeq ($(KDIR),)
    $(error KDIR is not defined. Please set the KDIR variable.)
endif

PWD := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) M=$(PWD) ARCH=arm64 LLVM=1 CROSS_COMPILE=aarch64-linux-gnu- modules

clean:
	rm -f *.ko *.o *.mod.o *.mod *.mod.c *.symvers modules.order .*.cmd
endif
