.SECONDARY:
.SECONDEXPANSION:
print-% :
	@echo '$*=$($*)'

# Rule
# target : prerequisite1 prerequisite2 prerequisite3
# (tab)recipe (and other arguments that are passed to the BASH[or other] script)

#### Interleave fastq ####

# Interleave R1 and R2 into single fastq file
INT_FASTQ_TEMP1=$(wildcard data/raw/*_R1_001.fastq.gz)
INT_FASTQ_TEMP2=$(subst raw,int,$(INT_FASTQ_TEMP1))
INT_FASTQ=$(subst _R1_,_int_,$(INT_FASTQ_TEMP2))

$(INT_FASTQ) : code/interleave_fastq_local.sh\
		$$(subst data/int/,data/raw/, $$(subst _int_,_R1_,$$@))\
		$$(subst data/int/,data/raw/, $$(subst _int_,_R2_,$$@))
	code/interleave_fastq_local.sh $(subst data/int/,data/raw/, $(subst _int_,_R1_,$@)) $(subst data/int/,data/raw/, $(subst _int_,_R2_,$@)) $@

#### Quality filter and decontamination ####

# Remove adapters
ADPT=$(subst int,adptfilt,$(INT_FASTQ))

$(ADPT) : code/filter_contam_local.sh\
		$$(subst adaptfilt,int,$$@)\
		code/bbmap/resources/adapters.fa
	code/filter_contam_local.sh $(subst adaptfilt,int,$@) code/bbmap/resources/adapters.fa $@

# Remove PhiX
PHIX=$(subst adptfilt,phixfilt,$(ADPT))

$(PHIX) : code/filter_contam_local.sh\
		$$(subst phixfilt,adptfilt,$$@)\
		code/bbmap/resources/phix174_ill.ref.fa.gz
	code/filter_contam_local.sh $(subst phixfilt,adptfilt,$@) code/bbmap/resources/phix174_ill.ref.fa.gz $@

# Filter low quality reads
QUAL=$(subst phixfilt,qualfilt,$(PHIX))

$(QUAL) : code/filter_qual_local.sh\
		$$(PHIX)
	code/filter_qual_local.sh $(PHIX) $@

adpt : $(INT_FASTQ) $(ADPT) $(PHIX) $(QUAL)

#### Assemble contigs ####


