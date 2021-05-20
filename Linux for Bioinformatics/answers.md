## Answers to questions from "Linux for Bioinformatics"

**Q1. What is your home directory?**

A1. My home directory is `/home/ubuntu`.

**Q2. What is the output of this command?**

A2. The output of `ls` is `hello_world.txt`.

**Q3. What is the output of each `ls` command?**

A3. The output of `ls` in `my_folder` is nothing (empty directory), and in `my_folder2` is `hello_world.txt`.

**Q4. What is the output of each?**

A4. The output of `ls` in my_folder` and `my_folder2` is nothing (empty directory), and in `my_folder3` is `hello_world.txt`.

**Q5. Why didn't that work?**

A5. 'Permission denied (publickey)'. The user `sudouser` requires a new key-pair to be generated. Therefore `ssh` using path/to/private_key will not work. 

**Q6. What was the solution?**

A6. My solution: 

1. Create new `.ssh` directory in `sudouser` home directory and create file there named `authorized_keys`.

2. As `sudouser`, chmod permissions of `.ssh` to 700 and `authorized_keys` to 600.

3. On local machine, generate a key pair with `ssh-keygen -t rsa` and copy the public key located in `id_rsa.pub`.

4. On the AWS instance, paste the public key into `/home/sudouser/.ssh/authorized_keys`.

5. `sudouser` can now log in to the AWS instance from local machine using `ssh sudouser@ip.xx.xxx.xxx.xxx`

**Q7. What does the `sudo docker run` part of the command do? and what does the `salmon swim` part of the command do?**

A7.

1. `sudo docker run` creates a container from the specified image, in this case `combinelab/salmon`.

2. 'salmon swim' is the command to be executed when the container is started using the run command. According to the docs, this performs a super-secret operation - printing a cool-looking graphic to the 
command line.

Side note: on my system, instead of "Version Info: This is the most recent version of salmon", I have "Version Server Response: Not Found".

**Q8. What is the output of this command?**

A8. "serveruser is not in the sudoers file.  This incident will be reported."

**Q9. what does `-c bioconda` do?**

A9. The `-c` option stands for channel. This tells conda to download packages from a particular location - a URL to a directory containing conda packages. In this case, `bioconda` is a channel specialising in 
bioinformatics software.

**Q10. What does the `-o athal.ga.gz` part of the command do?**

A10. `-o` stands for `--output`, i.e. the file the data should be written to, in this case the file is `athal.ga.gz`.

**Q11. What is a `.gz` file?**

A11. `.gz` is a type of compressed archive file. It stands for GNU zip, which is the compression algorithm used. This is a standard way of reducing file sizes for transfer. 

**Q12. What does the `zcat` command do?**

A12. `zcat` prints the contents of a compressed file without actually uncompressing it.

**Q13. What does the `head` command do?**

A13. `head`, by default, prints the first ten lines of the selected file(s) to the command line. In the case of `.gz` files, this command is clearly inferior to `zcat`, since the output is incomprehensible.

**Q14. what does the number `100` signify in the command?**

A14. The `-n` tag determines the number of lines of the file that `head` should print (starting from the first line). So in this case `100` specifies that the first 100 lines should be printed.

**Q15. What is `|` doing?**

A15. `|`, the pipe, is a feature that takes the output of the first command, and uses it in the following command, so having obtained the uncompressed output of the `athal.fa.gz` file using `zcat`, the first 
hundred lines of it are printed with `head -n 100`. The two commands are thereby used in combination to obtain a comprehensible and succint(ish) output.

**Q16. What format are the downloaded sequencing reads in?**

A16. `.sra` format.

**Q17. What is the total size of the disk?**

A17. Total disk size is 7.7G.

**Q18. How much space is remaining on the disk?**

A18. Remaining disk space is 1.5G

**Q19. What went wrong?**

A19. There is no longer enough space on the disk to convert the reads to .fastq format. The error "err: storage exhausted while writing file within file system module - system bad file descriptor error fd='5'" 
is produced. Also, with `ll -lh` the size of `SRR074122.fastq` is shown as 1.5G, i.e. the remaining disk space as determined in the last question.

**Q20: What was your solution?**

A20. Append `--gzip` to the `fastq-dump SRR074122` command. This will compress the output using gzip and therefore save disk space.
