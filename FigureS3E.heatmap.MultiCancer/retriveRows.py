import sys
events_dict={}
for l in open(sys.argv[1]):
	ls=l.strip().split('\t')
	events_dict[ls[0]]=''

n=0
fout=open(sys.argv[2]+'.sliced.txt','w')
for l in open(sys.argv[2]):
	if n==0:
		n+=1
		fout.write(l)
		continue
	ls=l.strip().split()
	k='_'.join(ls[1:8])
	if k in events_dict:
		events_dict[k]=l

for k in sorted(events_dict.keys()):
	fout.write(events_dict[k])