#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=0-23:00
#SBATCH --job-name ARC4CFD_BFS
#SBATCH --output=BFSstr%j.txt
#SBATCH --mail-type=FAIL
cd $SLURM_SUBMIT_DIR
module load CCEnv StdEnv/2023 gcc/12.3 gmsh/4.12.2
gmsh Backstep_str_mesh.geo
module load NiaEnv/2019b gcc/8.3.0 intelmpi/2019u5 python/3.6.8
export SU2_RUN="/scratch/j/jphickey/j6joseph/SU2/bin"
export PATH=$PATH:$SU2_RUN
mpirun -n 40 SU2_CFD Backstep_str_config.cfg