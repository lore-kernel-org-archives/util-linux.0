Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH 0/4] New tools lsmem and chmem
Date: Wed, 12 Oct 2016 14:00:43 +0200
Message-Id: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

This small patch series adds the tools lsmem and chmem to util-linux.

The lsmem and chmem tools were originally written in perl and are part
of the s390-tools package which can be found here:
https://www.ibm.com/developerworks/linux/linux390/s390-tools.html

These two simple tools can be used to inspect and modify memory
hotplug status of memory blocks (example below).

Given that the tools are architecture independent, there is no reason
to keep them in an s390 specific repository. They seem to be useful
for other architectures as well. And apparently if new features are
added to any of these tools everybody would benefit from it.

This patch series converts the tools to C and adds them to util-linux,
while both, the command line options as well as the output stay
(mostly) compatible. If these tools get merged into util-linux we will
remove their perl veriant from the s390-tools package.

The perl variant within s390-tools was originally written by Gerald
Schaefer. Clemens von Mann started the conversion to C, but left
before his work was finished. So I took his patches and (hopefully)
finished the conversion.

Example output of the lsmem tool:

# lsmem 
RANGE                                 SIZE STATE   REMOVABLE BLOCK
0x0000000000000000-0x000000005fffffff 1,5G online  yes       0-5
0x0000000060000000-0x000000007fffffff 512M online  no        6-7
0x0000000080000000-0x000000013fffffff   3G online  yes       8-19
0x0000000140000000-0x000000014fffffff 256M offline -         20
0x0000000150000000-0x000000017fffffff 768M online  no        21-23

Memory block size   :     256M
Total online memory :     5,8G
Total offline memory:     256M

Set memory range offline using the chmem tool:

# chmem -v -d 0x0000000130000000-0x000000013fffffff
Memory Block 19 (0x0000000130000000-0x000000013fffffff) disabled


Set the same memory range offline by specifying the block number:

# chmem -v -d -b 19
Memory Block 19 (0x0000000130000000-0x000000013fffffff) disabled


Set memory size (1g) online using the chmem tool:

# chmem -v -e 1g
Memory Block 15 (0x00000000f0000000-0x00000000ffffffff) enabled
Memory Block 16 (0x0000000100000000-0x000000010fffffff) enabled
Memory Block 17 (0x0000000110000000-0x000000011fffffff) enabled
Memory Block 18 (0x0000000120000000-0x000000012fffffff) enabled

Please consider merging these two tools.

Thanks,
Heiko

Heiko Carstens (4):
  lib,strutils: add strtoux[16|32|64]_or_err functions
  lsmem: new tool
  chmem: new tool
  lsmem: add testcase

 .gitignore                               |   2 +
 configure.ac                             |  14 +
 include/strutils.h                       |   3 +
 lib/strutils.c                           |  44 ++-
 sys-utils/Makemodule.am                  |  15 +
 sys-utils/chmem.8                        |  95 ++++++
 sys-utils/chmem.c                        | 325 ++++++++++++++++++++
 sys-utils/lsmem.1                        |  95 ++++++
 sys-utils/lsmem.c                        | 494 +++++++++++++++++++++++++++++++
 tests/commands.sh                        |   1 +
 tests/expected/lsmem/lsmem-s390-zvm-6g   |  91 ++++++
 tests/ts/lsmem/dumps/s390-zvm-6g.tar.bz2 | Bin 0 -> 2459 bytes
 tests/ts/lsmem/lsmem                     |  52 ++++
 tests/ts/lsmem/mk-input.sh               |  22 ++
 14 files changed, 1247 insertions(+), 6 deletions(-)
 create mode 100644 sys-utils/chmem.8
 create mode 100644 sys-utils/chmem.c
 create mode 100644 sys-utils/lsmem.1
 create mode 100644 sys-utils/lsmem.c
 create mode 100644 tests/expected/lsmem/lsmem-s390-zvm-6g
 create mode 100644 tests/ts/lsmem/dumps/s390-zvm-6g.tar.bz2
 create mode 100755 tests/ts/lsmem/lsmem
 create mode 100755 tests/ts/lsmem/mk-input.sh

-- 
2.8.4
