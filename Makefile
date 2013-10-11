CC	= g++
RM	= rm -fr
MKDIR	= mkdir -p

SRC	= sort_set.cpp
HDR	= 

DEPDIR	= .dep
OBJDIR	= .obj

OBJ	= $(SRC:%.cpp=$(OBJDIR)/%.o)

OUT	= main

CFLAGS	+= -std=c++11
CFLAGS	+= -g -Wall

V	?= 0

ifeq ($(V),1)
	quiet=
else
	quiet=quiet_
endif

ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
	quiet=silent_
endif

all:	$(OBJDIR) $(DEPDIR) $(OBJ) $(OUT) tags

# ----------------------------------------------------------------------------

# If quiet is set, only print short version of command
cmd	= @$(if $($(quiet)cmd_$(1)),\
		echo '$($(quiet)cmd_$(1))' &&) $(cmd_$(1))

# ----------------------------------------------------------------------------

quiet_cmd_TAGS	= CTAGS	$@
      cmd_TAGS	= ctags $(SRC)

tags:	$(SRC) $(HDR)
	$(call cmd,TAGS)

# ----------------------------------------------------------------------------

quiet_cmd_CC	= CC	$<
      cmd_CC	= $(CC) $(CFLAGS) -c $< -o $@ && (												\
		  $(CC) -MM $(CFLAGS) -c $< | sed 's/.*:/'$(OBJDIR)'\/\0/' > $(DEPDIR)/$*.d;							\
		  cp -f $(DEPDIR)/$*.d $(DEPDIR)/$*.d.tmp;											\
		  sed -e 's/.*://' -e 's/\\$$//' < $(DEPDIR)/$*.d.tmp | fmt -1 | sed -e 's/^ *//' -e 's/$$/:/' >> $(DEPDIR)/$*.d;		\
		  rm -f $(DEPDIR)/$*.d.tmp)

$(OBJDIR)/%.o: %.cpp
	$(call cmd,CC)

# ----------------------------------------------------------------------------

quiet_cmd_LD	= LD	$@
      cmd_LD	= $(CC) -o $@ $(OBJ) $(LDFLAGS)

main:	$(OBJ)
	$(call cmd,LD)

# ----------------------------------------------------------------------------

quiet_cmd_MKDIR	= MKDIR	$@
      cmd_MKDIR	= $(MKDIR) $@

$(DEPDIR) $(OBJDIR):
	$(call cmd,MKDIR)

# ----------------------------------------------------------------------------

clean:	force
	$(RM) $(OUT) $(OBJ)

distclean: clean
	$(RM) $(DEPDIR) $(OBJDIR) tags

force:

-include $(SRC:%.cpp=$(DEPDIR)/%.d)

