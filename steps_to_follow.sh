# Generate Mesh
module load CCEnv StdEnv/2023 gcc/12.3 gmsh/4.12.2
gmsh Backstep_str_mesh.geo -0    # Avoid -0 to open in GUI and then close GUI to continue.
#confirm if Backstep_str_mesh.su2 exists

#Test job in StdEnv
module load CCEnv StdEnv/2023 gcc/9.3.0 openmpi/4.0.3 su2/7.5.1
salloc --nodes 1 -n 20 --time=00:30:00
#wait for nodes to be allocated
mpirun -n 20 SU2_CFD Backstep_str_config.cfg

#Test job in NiaEnv  (requires download of pre-compiled SU2 v8)
module load NiaEnv/2019b gcc/8.3.0 intelmpi/2019u5 python/3.6.8
export SU2_RUN="/scratch/j/jphickey/j6joseph/SU2/bin"   # path to the pre-compiled bin folder
export PATH=$PATH:$SU2_RUN
salloc --nodes 1 -n 20 --time=00:30:00
#wait for nodes to be allocated
mpirun -n 20 SU2_CFD Backstep_str_config.cfg

#Main Job in StdEnv
sbatch su2job_StdEnv.sh

#Main Job in NiaEnv (requires download of pre-compiled SU2 v8; change path in line 10 of su2job_NiaEnv.sh)
sbatch su2job_NiaEnv.sh