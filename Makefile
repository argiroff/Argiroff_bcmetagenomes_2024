.SECONDARY:
.SECONDEXPANSION:
print-% :
	@echo '$*=$($*)'

# Rule
# target : prerequisite1 prerequisite2 prerequisite3
# (tab)recipe (and other arguments that are passed to the BASH[or other] script)

#### Interleave fastq ####

# Make file lists
INT_LISTR1=filelists/int_R1_infiles.txt

$(INT_LISTR1) : code/make_intR1_filelist.sh
	code/make_intR1_filelist.sh $@

# Make R2 file list
INT_LISTR2=filelists/int_R2_infiles.txt

$(INT_LISTR2) : code/make_intR2_filelist.sh
	code/make_intR2_filelist.sh $@

# Make interleaved output file list
INT_OUT=filelists/int_outfiles.txt

$(INT_OUT) : code/make_intout_filelist.sh\
		$$(INT_LISTR1)
	code/make_intout_filelist.sh $(INT_LISTR1) $@

# Interleave R1 and R2 into single fastq
INT_FASTQ=data/int/

$(INT_FASTQ) : code/interleave_fastq.sh\
		$$(INT_LISTR1)\
		$$(INT_LISTR2)\
		$$(INT_OUT)
	code/interleave_fastq.sh $(INT_LISTR1) $(INT_LISTR2) $(INT_OUT)

int : $(INT_LISTR1) $(INT_LISTR2) $(INT_OUT) $(INT_FASTQ)
