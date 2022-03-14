# Rosetta Commons Relax Protocol
## Setup
Current setup assumes an up-to-date docker-compose installed, and a prepared pdb file for relaxing.
## Usage
Download this git repository and place the pdb in the same directory. Please change ```<inputfile>``` in docker-compose.yml to your pdb filename.
Start the protocol by:
```bash
docker-compose up -d
```
Resulted files can be found in docker drive.
## Licence and References 
This image uses the following licences:
* [Ubuntu image] https://hub.docker.com/_/ubuntu/
* [Open MPI] https://www-lb.open-mpi.org/community/license.php 
* [Rosetta Commons]https://www.rosettacommons.org/software/license-and-download
