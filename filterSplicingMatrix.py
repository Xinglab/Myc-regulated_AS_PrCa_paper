import sys,numpy
#input generated PSI matrix (usually with coverage filtered)
#output filtered PSI matrix with PSI filter and NaN filter
#output psi mean and range filter

na_cutoff=float(sys.argv[2])
std_cutoff='Null'
fout=open('std'+str(std_cutoff)+'.na'+str(na_cutoff)+'.'+sys.argv[1].split('/')[-1],'w')
#fout_centered=open('std'+str(std_cutoff)+'.na'+str(na_cutoff)+'.centered.'+sys.argv[1].split('/')[-1],'w')
sample_size=0
c_extreme=0
c_diff=0
c_na=0
n=0
for l in open(sys.argv[1]):
	if n==0:
		n+=1
		sample_size=len(l.split('\t'))
		print na_cutoff*sample_size
		fout.write(l)
		continue
	ls=l.strip().split('\t')
	if ls[10:-1].count('NaN')>na_cutoff*sample_size:
		c_na+=1
		continue

	psi=map(float,ls[8:])
	psi_mean=round(numpy.nanmean(psi),4)
	if abs(max(psi)-min(psi))<0.05:
                c_diff+=1
                continue
	if psi_mean<0.05 or psi_mean>0.95:
		c_extreme+=1
		continue

#	centered_psi=map(lambda x:x-psi_mean,psi)
	# if numpy.nanstd(centered_psi)<std_cutoff:
	# 	continue

#	fout.write('\t'.join(ls[0:8]+map(str,psi))+'\n')
##	fout_centered.write('\t'.join(ls[0:10]+map(str,centered_psi))+'\n')
print c_na, c_diff, c_extreme
