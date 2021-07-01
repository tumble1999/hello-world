#---------------------------------------------------------------------------------
# Makefile for NightFox's Lib Projects (NitroFS)
#---------------------------------------------------------------------------------



#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif


#---------------------------------------------------------------------------------
# This part substitutes this include:
# include $(DEVKITARM)/ds_rules
# This allows you to set ROM info and icon easy
# Please update this block from DS_RULES file at every DEVKITARM update
#---------------------------------------------------------------------------------
include $(DEVKITARM)/base_rules

LIBNDS	:=	$(DEVKITPRO)/libnds

GAME_TITLE	    :=	Text 1
GAME_SUBTITLE1	:=	Text 2
GAME_SUBTITLE2	:=	Text 3
GAME_ICON		:=	$(CURDIR)/../icon.bmp

_ADDFILES	:=	-d $(NITRO_FILES)


#---------------------------------------------------------------------------------
%.nds: %.arm9
	@echo "Make $@"
	ndstool -c $@ -9 $< -b $(GAME_ICON) "$(GAME_TITLE);$(GAME_SUBTITLE1);$(GAME_SUBTITLE2)" $(_ADDFILES)
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.nds: %.elf
	@echo "Make $@"
	ndstool -c $@ -9 $< -b $(GAME_ICON) "$(GAME_TITLE);$(GAME_SUBTITLE1);$(GAME_SUBTITLE2)" $(_ADDFILES)
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.arm9: %.elf
	@echo "Make $@"
	$(OBJCOPY) -O binary $< $@
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.arm7: %.elf
	@echo "Make $@"
	$(OBJCOPY) -O binary $< $@
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.elf:
	@echo "Make $@"
	@echo linking $(notdir $@)
	$(LD)  $(LDFLAGS) $(OFILES) $(LIBPATHS) $(LIBS) -o $@


#---------------------------------------------------------------------------------
# TARGET is the name of the output
# BUILD is the directory where object files & intermediate files will be placed
# SOURCES is a list of directories containing source code
# INCLUDES is a list of directories containing extra header files
# DATA is a list of directories containing binary files embedded using bin2o
# NITRODATA is the directory where files for NitroFS will be placed
#---------------------------------------------------------------------------------
TARGET		:=	$(shell basename $(CURDIR))
SELF		:=	targets/nds.mak
BUILD		:=	build
OUTDIR		:=	run
OBJDIR		:=	nds
SOURCES		:=	src
INCLUDES	:=	include
ASSETS		:=	assets
DATA		:=	data
NITRODATA	:=	nitrofiles
AUDIO		:=	$(ASSETS)/audio

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------
ARCH	:=	-mthumb -mthumb-interwork

CFLAGS	:=	-g -Wall -O2\
 		-march=armv5te -mtune=arm946e-s -fomit-frame-pointer\
		-ffast-math \
		$(ARCH)

CFLAGS	+=	$(INCLUDE) -DARM9
CXXFLAGS	:= $(CFLAGS) -fno-rtti -fno-exceptions

ASFLAGS	:=	-g $(ARCH)
LDFLAGS	=	-specs=ds_arm9.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)

#---------------------------------------------------------------------------------
# any extra libraries we wish to link with the project
#---------------------------------------------------------------------------------
LIBS	:= -lmm9 -lnflib -lfilesystem -lfat -lnds9


#---------------------------------------------------------------------------------
# list of directories containing libraries, this must be the top level containing
# include and lib
#---------------------------------------------------------------------------------
LIBDIRS	:=	$(LIBNDS) $(CURDIR)/dep/nds


#---------------------------------------------------------------------------------
# no real need to edit anything past this point unless you need to add additional
# rules for different file extensions
#---------------------------------------------------------------------------------
CD=$(notdir $(CURDIR))
ifeq ($(CD),$(BUILD))
.PHONY:$(OUTDIR) $(OBJDIR)
$(OUTDIR):$(OBJDIR)
	@echo "Make $@"
	[ -d $@ ] || mkdir -p $@
	make -C $(OUTDIR) -f $(CURDIR)/../$(SELF)

$(OBJDIR):
	@echo "Make $@"
	[ -d $@ ] || mkdir -p $@
	make -C $(OBJDIR) -f $(CURDIR)/../$(SELF)

else ifeq ($(CD),$(OBJDIR))
#---------------------------------------------------------------------------------
# main targets
#---------------------------------------------------------------------------------
$(OUTPUT).nds	: 	$(OUTPUT).elf
	@echo "Make(main targets) $@"
$(OUTPUT).elf	:	$(OFILES)
	@echo "Make(main targets) $@"

#---------------------------------------------------------------------------------
%.bin.o	:	%.bin
#---------------------------------------------------------------------------------
	@echo "Make $@"
	@echo $(notdir $<)
	$(bin2o)
#-------------------------------------------------------------
# rule for converting the output into an object file
#-------------------------------------------------------------
%.bin.o:	%.bin
#-------------------------------------------------------------
	@echo "Make $@"
	$(bin2o)

#-------------------------------------------------------------
# rule for generating soundbank file from audio files
#-------------------------------------------------------------
soundbank.bin:	$(AUDIOFILES)
#-------------------------------------------------------------
	@echo "Make $@"
	mmutil $^ -osoundbank.bin -hsoundbank.h -d
else ifeq ($(CD),$(OUTDIR))
ok:
	@echo "nah"
else
#---------------------------------------------------------------------------------

export OUTPUT	:=	$(CURDIR)/$(BUILD)/$(OUTDIR)/$(TARGET)

export VPATH	:=	$(foreach dir,$(SOURCES),$(CURDIR)/$(dir)) \
					$(foreach dir,$(DATA),$(CURDIR)/$(dir))

export DEPSDIR	:=	$(CURDIR)/$(BUILD)/$(OBJDIR)

export NITRO_FILES	:=	$(CURDIR)/$(BUILD)/$(NITRODATA)

CFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES	:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
SFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))
BINFILES	:=	$(foreach dir,$(DATA),$(notdir $(wildcard $(dir)/*.*)))

export AUDIOFILES := $(foreach dir,$(notdir $(wildcard $(AUDIO)/*.*)),$(CURDIR)/$(AUDIO)/$(dir))

#---------------------------------------------------------------------------------
# use CXX for linking C++ projects, CC for standard C
#---------------------------------------------------------------------------------
ifeq ($(strip $(CPPFILES)),)
#---------------------------------------------------------------------------------
	export LD	:=	$(CC)
#---------------------------------------------------------------------------------
else
#---------------------------------------------------------------------------------
	export LD	:=	$(CXX)
#---------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------

export OFILES	:=	$(addsuffix .o,$(BINFILES)) \
					$(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)

export INCLUDE	:=	$(foreach dir,$(INCLUDES),-iquote $(CURDIR)/$(dir)) \
					$(foreach dir,$(LIBDIRS),-I$(dir)/include) \
					-I$(CURDIR)/$(BUILD)

export LIBPATHS	:=	$(foreach dir,$(LIBDIRS),-L$(dir)/lib)

icons := $(wildcard $(ASSETS)/*.bmp)

ifneq (,$(findstring $(TARGET).bmp,$(icons)))
	export GAME_ICON := $(CURDIR)/$(ASSETS)/$(TARGET).bmp
else
	ifneq (,$(findstring icon.bmp,$(icons)))
		export GAME_ICON := $(CURDIR)/$(ASSETS)/icon.bmp
	endif
endif

.PHONY: $(BUILD) clean

#---------------------------------------------------------------------------------
$(BUILD):
	@echo "Make $@"
	[ -d $@ ] || mkdir -p $@
	[ -d $@/nitrofiles ] || mkdir -p $@/nitrofiles
	make -C $(BUILD) -f $(CURDIR)/$(SELF)

#---------------------------------------------------------------------------------
clean:
	@echo "Make $@"
	@echo clean ...
	rm -fr $(BUILD) $(TARGET).elf $(TARGET).nds $(TARGET).arm9

#---------------------------------------------------------------------------------
endif