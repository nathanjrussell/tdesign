from math import comb
t=3
v=17
k=7
l=7

num_blocks = l*comb(v,t)/comb(k,t)
colsum = num_blocks*k/v
parameter_list = []
#parameter_list.append("-c v={0!s}".format(v))
#parameter_list.append("-c k={0!s}".format(k))
#parameter_list.append("-c t={0!s}".format(t))
parameter_list.append("#const v = {0!s}.".format(v))
parameter_list.append("#const k = {0!s}.".format(k))
parameter_list.append("#const t = {0!s}.".format(t))
for i in range(0,t+1):
    max = t-i
    for j in range(0,max+1):
        val = l*comb(v-i-j,k-i)//comb(v-t,k-t)
        #st = "-c l{0!s}{1!s}={2!s}".format(i,j,val)
        st = "#const l{0!s}{1!s} = {2!s}.".format(i,j,val)
        parameter_list.append(st)

# st = " ".join(parameter_list)
# print(st)
# print(num_blocks, colsum)
for p in parameter_list:
    print(p)
