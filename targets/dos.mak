CC=gpp
\=\\
\\=$(\)$(\)


BUILDDIR=build
OUTDIR=$(BUILDDIR)$(\)run
OBJDIR=$(BUILDDIR)$(\)dos
SRCDIR=src
OUT=hello

OBJS := $(sort $(patsubst $(SRCDIR)/%,$(OBJDIR)$(\\)%,$(patsubst %.cpp,%.o,$(wildcard $(SRCDIR)/*.cpp))))
OBJS := $(OBJS:/=\\)

$(OUTDIR)$(\)$(OUT).exe: $(OBJS) $(OUTDIR) 
	$(CC) -o $@ $(OBJS)

$(OBJDIR)$(\)%.o: $(SRCDIR)$(\)%.cpp $(OBJDIR)
	$(CC) -c $< -o $@

$(OBJDIR): $(BUILDDIR)
	mkdir $@

$(OUTDIR): $(BUILDDIR)
	mkdir $@

$(BUILDDIR):
	mkdir $@