# 工具链配置
CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc -x assembler-with-cpp
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# 目标名称和目录
TARGET = stm32_template
BUILD_DIR = build

# 编译选项
CFLAGS = -mcpu=cortex-m3 -mthumb -Os -g
CFLAGS += -DUSE_STDPERIPH_DRIVER -DSTM32F10X_MD
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += -D__STREXB_NOT_SUPPORTED -D__STREXH_NOT_SUPPORTED
CFLAGS += -ICMSIS/CM3/CoreSupport 
CFLAGS += -ICMSIS/CM3/DeviceSupport/ST/STM32F10x
CFLAGS += -ILibraries/STM32F10x_StdPeriph_Driver/inc 
CFLAGS += -IUser


# 链接脚本
LDSCRIPT = linker.ld

# 源文件
SRCS = \
	User/main.c \
	CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c \
	Libraries/STM32F10x_StdPeriph_Driver/src/stm32f10x_gpio.c \
	Libraries/STM32F10x_StdPeriph_Driver/src/stm32f10x_rcc.c \
	CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/startup_stm32f10x_md.s

# 目标文件
OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(filter %.c, $(SRCS)))
OBJS += $(patsubst %.s, $(BUILD_DIR)/%.o, $(filter %.s, $(SRCS)))

# 默认目标
all: $(BUILD_DIR)/$(TARGET).elf

# 规则：编译 C 文件
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) $< -o $@

# 规则：编译汇编文件
$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	$(AS) -c $(CFLAGS) $< -o $@

# 链接生成 ELF 文件
$(BUILD_DIR)/$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) -T$(LDSCRIPT) $^ -o $@ -Wl,--gc-sections
	$(OBJCOPY) -O binary $@ $(BUILD_DIR)/$(TARGET).bin
	$(SIZE) $@

# 清理
clean:
	rm -rf $(BUILD_DIR)

# 烧录（需安装 stlink）
flash: $(BUILD_DIR)/$(TARGET).bin
	st-flash write $< 0x08000000

.PHONY: all clean flash
