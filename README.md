# Rosetta Commons Relax Protocol
## Setup
Current setup assumes an up-to-date docker-compose installed, and a prepared pdb file for relaxing.
## Usage
Place the pdb in the same directory with the following docker-compose.yml file. Please change ```<inputfile>``` to your pdb filename.
```
version: "3.9"
services:
  relax:
    image: thachung/rosetta-relax
    command: bash relaxscript.sh
    volumes:
      - drive:/home/runtime
    secrets:
      - source: inputfile
        target: /home/runtime/inputfile.pdb

secrets:
  inputfile:
    file: ./<inputfile>.pdb

volumes:
  drive:
```
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
