#!/bin/bash
difference=-1
i=0
oldscore=-1
nstruc=19
while (( $(bc <<<"$difference<0") ))
do
    echo "------------- RUN number ${i} ----------------"
    mkdir run$i
    cp inputfile.pdb ./run$i/run$i.pdb
    cd run$i
    inputpdb=run$i.pdb
    mpiexec --use-hwthread-cpus /home/rosetta_src_2021.16.61629_bundle/main/source/build/src/release/linux/5.10/64/x86/gcc/9/cxx11thread-mpi-serialization/relax.cxx11threadmpiserialization.linuxgccrelease -s ${inputpdb} -nstruct ${nstruc} -relax:constrain_relax_to_start_coords -relax:coord_constrain_sidechains -relax:ramp_constraints false -ex1 -ex2 -use_input_sc -no_optH false>output.txt
    sort -r score.sc>sortedscore.sc
    line=$(sed '3q;d' sortedscore.sc)
    score=$(echo $line | cut -d " " -f 2)
    file=$(echo $line | cut -d " " -f 23)
    difference=$(bc <<<"$score - $oldscore")
    echo "current score:${score}  old score:${oldscore} difference:${difference}"
    oldscore=$score
    cp ${file}.pdb ../${file}.pdb
    cd ..
    inputfile=${file}.pdb
    ((i++))
done
echo "------------- RELAX completed ----------------"
