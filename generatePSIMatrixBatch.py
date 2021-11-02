import sys,numpy, argparse
#read in rMATS-turbo count matrix
#read in sample list
#read in events list from rMATS-turbo
#do PSI calculation
#missing PSI is put as NaN for R and python pandas recognition
#do coverage filtering -by dataset/group

def loadArgs():
	parser = argparse.ArgumentParser(description='Merge and generate PSI matrix from rMATS-turbo JC file (Oct 2017)')
	parser.add_argument('fin_matrices', help='a list of rMATS-turbo output JC matrices.')
	parser.add_argument('fin_events', help='a list of rMATS-turbo output fromGTF files.')
	parser.add_argument('fin_samples', help='a list of rMATS-turbo input sample files.')
	parser.add_argument('-c', '--cov-cutoff', default=10, help='average coverage filter for the MERGED MATRIX. Defualt is 10. Specify 0 will not skip that step so it is slow now.(FUTURE TASK)')
	parser.add_argument('-o', '--out-name', help='The output file name append.')
	parser.add_argument('-s', '--sample-name-field', help='Decide to parse sample name from which field in sample file path. 1 for from file name,2 for from 1 level up folder name. ')
	parser.add_argument('-e', '--merge-events-only', default=False, action="store_true" ,help='Do not perform actual matrix merge, only perform calculation on total merged events.')

	args = parser.parse_args()
	return args


args=loadArgs()
cov_cutoff=int(args.cov_cutoff)
out_name=args.out_name
if out_name ==None or args.sample_name_field ==None:
	exit('[Error] Please set output file name and sample name field. See -h for example.')
if args.sample_name_field!='1' and args.sample_name_field!='2':
	exit('[Error] Please set (a valid) sample_name_field!')
sample_name_field=int(args.sample_name_field)
if sample_name_field==1:
	print 'warning: sample name parsed from bam file.  (alternatively can be parsed from up level folder)'
if sample_name_field==2:
	print 'warning: sample name parsed from folder name above the bam file.  (alternatively can be parsed from bam file)'

fin_list=[]
sample_fin_list=[]
events_fin_list=[]
sample_size={}
sample_header=[]
file_batch_list=[]

#PARSING INPUT FILE LISTS
fin_list=[l.strip() for l in open(args.fin_matrices)]

events_fin_list=[l.strip() for l in open(args.fin_events)]


for l in open(args.fin_samples):
	ls=l.strip()
	sample_fin_list.append(ls)
	for r in open(ls):
		rs=map(lambda x:x.split('/')[-sample_name_field].split('.bam')[0],r.strip().strip(',').split(','))
		#rs=map(lambda x:x.split('/')[-2],r.strip().strip(',').split(','))
		if sample_name_field==2:
			sn_list=r.strip().strip(',').split(',')
			for e,sn in enumerate(rs):
				if len(sn)==0:
					rs[e]=sn_list[e].split('/')[-1].split('.')[0]
		sample_header+=rs
		sample_size[ls]=len(r.split(','))
#MAKING MERGED EVENTS LIST
total_event_dict={}
for events_fin in events_fin_list:
	for index,event_l in enumerate(open(events_fin)):
			if index==0:
				continue
			event_ls=event_l.strip().split('\t')
			events_cord=event_ls[1].strip('"')+'\t'+event_ls[2].strip('"')+'\t'+'\t'.join(event_ls[3:7]+event_ls[8:10])
			if events_cord in total_event_dict:
				continue
			total_event_dict[events_cord]=''

print len(total_event_dict)

total_event_list=sorted(total_event_dict.keys())

fout=open('prefilter_events.cov'+str(cov_cutoff)+'.splcing.merged_matrix.'+out_name+'.txt','w')
for e in total_event_list:
	fout.write(e.strip()+'\n')

if args.merge_events_only:
	exit('Done.')

print 'done loading file dir', len(total_event_dict)

#START MERGING MATRICES IN BATCH MODE FOLLOWING EVENTS LIST GENERATED.
batch=20000
for b in range(0,len(total_event_list),batch):
	Intercep_Matrix={}
	print 'batch ',b 
	batch_event_list= total_event_list[b:min(b+batch,len(total_event_list))]
	batch_event_dict= dict.fromkeys(batch_event_list, 0)
	for n,fin in enumerate(fin_list):
		eventID={}
		for index,event_l in enumerate(open(events_fin_list[n])):
			if index==0:
				continue
			event_ls=event_l.strip().split('\t')
			event_cord=event_ls[1].strip('"')+'\t'+event_ls[2].strip('"')+'\t'+'\t'.join(event_ls[3:7]+event_ls[8:10])
			if event_cord in batch_event_dict:
				eventID[event_ls[0]]=event_cord
		print fin, len(eventID)
		for index,r in enumerate(open(fin)):
			if index==0:
				continue
			rs=r.strip().split('\t')
			if rs[0] not in eventID:
				continue
			Incl=map(float,rs[1].split(','))
			Skip=map(float,rs[2].split(','))
			Cov=[num+Skip[o] for o,num in enumerate(Incl)]
			psi_values=[]
			for i,I in enumerate(Incl):
				if int(I)+int(Skip[i])==0:
					psi_values.append('NaN')
				else:
					psi_values.append(str(round(I/int(rs[5])/(I/int(rs[5])+Skip[i]/int(rs[6])),4)))

			if eventID[rs[0]] not in Intercep_Matrix:
				Intercep_Matrix[eventID[rs[0]]]={}
			if sample_fin_list[n] not in Intercep_Matrix[eventID[rs[0]]]:
				Intercep_Matrix[eventID[rs[0]]][sample_fin_list[n]]=(psi_values,Cov)
			if len(psi_values)!=sample_size[sample_fin_list[n]]:
				exit('Abort: Sample number does not match observations in JC file.')
	print len(Intercep_Matrix)

	file_batch_list.append('cov'+str(cov_cutoff)+'.splcing.merged_matrix.'+out_name+'.txt.batch_'+str(b)+'.txt')
	fout=open('cov'+str(cov_cutoff)+'.splcing.merged_matrix.'+out_name+'.txt.batch_'+str(b)+'.txt','w')
	fout.write('AC\tGeneName\tchr\tstrand\texonStart\texonEnd\tupstreamEE\tdownstreamES\t'+'\t'.join(sample_header)+'\n')
	for k in sorted(Intercep_Matrix.keys()):
		psi_value_all=[]
		cov_all=[]
		for sample in sample_fin_list:
			if sample in Intercep_Matrix[k]:
				psi_value_all+=Intercep_Matrix[k][sample][0]
				cov_all+=Intercep_Matrix[k][sample][1]
			else:
				psi_value_all+=['NaN']*sample_size[sample]

		mean=numpy.mean(cov_all)
		if mean>=cov_cutoff:
			fout.write(k+'\t'+'\t'.join(psi_value_all)+'\n')
	fout.close()
fout_merge=open('cov'+str(cov_cutoff)+'.splcing.merged_matrix.'+out_name+'.txt','w')
header=0
for file_batch in file_batch_list:
	for j,l in enumerate(open(file_batch)):
		if j==0:
			if header==0:
				header+=1
				fout_merge.write(l)
			continue
		fout_merge.write(l)
fout_merge.close()
		
