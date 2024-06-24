#!/bin/bash
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=20g
#SBATCH -p qTRD
#SBATCH -t 2-00:00
#SBATCH -J fastsurfer
#SBATCH -e jobs/error%A_%a.err
#SBATCH -o jobs/out%A_%a.out
#SBATCH -A psy53c17
#SBATCH --mail-type=ALL
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --oversubscribe

module load singularity
singularity exec --no-home \
                 -B /data/users2/washbee/fastsurfer-data:/data \
                 -B /data/users2/washbee/fastsurfer-output:/output \
                 -B $FREESURFER_HOME:/fs \
                 -B /data/users2/washbee/FastSurfer_benchmark/:/fastsurfer \
                 /data/users2/washbee/containers/fastsurfer-latest.sif \
                 /fastsurfer/run_fastsurfer.sh \
                 --fs_license /fs/.license \
                 --t1 /data/test/201818/mri/orig.mgz \
                 --sid 201818 \
                 --sd /output/test \
                 --parallel \
                 --3T
