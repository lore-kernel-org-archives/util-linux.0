Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110815152453.052584040@de.ibm.com>
Date: Mon, 15 Aug 2011 17:24:53 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH/RFC 0/2] new chcpu tool
List-ID: <util-linux.vger.kernel.org>

This patch set introduces a new chcpu tool to util-linux. chcpu lets a user
configure CPUs. In this first version all that is possible is to enable or
disable CPUs (set them online of offline).
This is quite useful if you work a lot with virtual servers, since
enabling and disabling cpus manually via sysfs becomes tiring.

This first version is kept very simple so that I can easily change things
based on feedback/criticism before I add more functionality.
More features that I would like to add are

- rescan cpus: trigger the kernel to trigger a rescan of cpus. Necessary
  because not all hypervisors on s390 generate a guest event if a new
  cpu becomes visible to a guest.

- configure/deconfigure cpus: if cpus are offline the resources taken by
  the hypervisor can be freed if the cpus are deconfigured. Makes sense
  if a cpus are given dedicated to a logical partition. Deconfigured cpus
  can be given to other logical partitions.

- set dispatch mode: if the underlying hypervisor is PR/SM (LPAR hypervisor)
  it is possible to configure it's scheduling algorithm for the virtual cpus
  of the own logical partition.

Other architectures might add own features...

Any feedback and/or criticism would be welcome.

A usage example with a logical partition with 20 virtual cpus:

[root@r35lp37]# chcpu --help

Usage:
 chcpu [options] [cpu-list]

Options:
  -h, --help         print this help
  -e, --enable       enable cpus
  -d, --disable      disable cpus
  -v, --verbose      explain what is being done
  -V, --version      output version information and exit

[root@r35lp37]# cat /proc/cpuinfo
vendor_id       : IBM/S390
# processors    : 4
bogomips per cpu: 14367.00
features        : esan3 zarch stfle msa ldisp eimm dfp etf3eh highgprs 
processor 1: version = 00,  identification = 279F25,  machine = 2817
processor 10: version = 00,  identification = 279F25,  machine = 2817
processor 11: version = 00,  identification = 279F25,  machine = 2817
processor 12: version = 00,  identification = 279F25,  machine = 2817

[root@r35lp37]# ./chcpu -v -e 0-20
CPU 0 enabled
CPU 1 already enabled
CPU 2 enabled
CPU 3 enabled
CPU 4 enabled
CPU 5 enabled
CPU 6 enabled
CPU 7 enabled
CPU 8 enabled
CPU 9 enabled
CPU 10 already enabled
CPU 11 already enabled
CPU 12 already enabled
CPU 13 enabled
CPU 14 enabled
CPU 15 enabled
CPU 16 enabled
CPU 17 enabled
CPU 18 enabled
CPU 19 enabled
CPU 20 does not exist

[root@r35lp37]# cat /proc/cpuinfo 
vendor_id       : IBM/S390
# processors    : 20
bogomips per cpu: 14367.00
features        : esan3 zarch stfle msa ldisp eimm dfp etf3eh highgprs 
processor 0: version = 00,  identification = 279F25,  machine = 2817
processor 1: version = 00,  identification = 279F25,  machine = 2817
processor 2: version = 00,  identification = 279F25,  machine = 2817
processor 3: version = 00,  identification = 279F25,  machine = 2817
processor 4: version = 00,  identification = 279F25,  machine = 2817
processor 5: version = 00,  identification = 279F25,  machine = 2817
processor 6: version = 00,  identification = 279F25,  machine = 2817
processor 7: version = 00,  identification = 279F25,  machine = 2817
processor 8: version = 00,  identification = 279F25,  machine = 2817
processor 9: version = 00,  identification = 279F25,  machine = 2817
processor 10: version = 00,  identification = 279F25,  machine = 2817
processor 11: version = 00,  identification = 279F25,  machine = 2817
processor 12: version = 00,  identification = 279F25,  machine = 2817
processor 13: version = 00,  identification = 279F25,  machine = 2817
processor 14: version = 00,  identification = 279F25,  machine = 2817
processor 15: version = 00,  identification = 279F25,  machine = 2817
processor 16: version = 00,  identification = 279F25,  machine = 2817
processor 17: version = 00,  identification = 279F25,  machine = 2817
processor 18: version = 00,  identification = 279F25,  machine = 2817
processor 19: version = 00,  identification = 279F25,  machine = 2817

Thanks,
Heiko
