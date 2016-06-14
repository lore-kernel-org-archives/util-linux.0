Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] lscpu: add s390 drawer testcase
Date: Tue, 14 Jun 2016 12:38:08 +0200
Message-Id: <1465900688-49217-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Add a new s390 testcase so we get some coverage for the new drawer cpu
topology level.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 tests/expected/lscpu/lscpu-s390-lpar-drawer  |  35 +++++++++++++++++++++++++++
 tests/ts/lscpu/dumps/s390-lpar-drawer.tar.gz | Bin 0 -> 18125 bytes
 2 files changed, 35 insertions(+)
 create mode 100644 tests/expected/lscpu/lscpu-s390-lpar-drawer
 create mode 100644 tests/ts/lscpu/dumps/s390-lpar-drawer.tar.gz

diff --git a/tests/expected/lscpu/lscpu-s390-lpar-drawer b/tests/expected/lscpu/lscpu-s390-lpar-drawer
new file mode 100644
index 000000000000..1624e73dd3e0
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-s390-lpar-drawer
@@ -0,0 +1,35 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                8
+On-line CPU(s) list:   0-7
+Thread(s) per core:    1
+Core(s) per socket:    8
+Socket(s) per book:    3
+Book(s) per drawer:    2
+Drawers(s):            4
+NUMA node(s):          1
+Vendor ID:             IBM/S390
+Model name:            0
+BogoMIPS:              20325.00
+Hypervisor:            PR/SM
+Hypervisor vendor:     IBM
+Virtualization type:   full
+Dispatching mode:      horizontal
+L1d cache:             128K
+L1i cache:             96K
+L2d cache:             2048K
+L2i cache:             2048K
+NUMA node0 CPU(s):     0-140
+Flags:                 esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx sie
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i,L2d,L2i
+0,0,0,0,,0,0,0,0
+1,1,0,0,,1,1,1,1
+2,2,0,0,,2,2,2,2
+3,3,1,0,,3,3,3,3
+4,4,1,0,,4,4,4,4
+5,5,1,0,,5,5,5,5
+6,6,1,0,,6,6,6,6
+7,7,1,0,,7,7,7,7
diff --git a/tests/ts/lscpu/dumps/s390-lpar-drawer.tar.gz b/tests/ts/lscpu/dumps/s390-lpar-drawer.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..3386ded68169a66aba5f54885ad84606728250c7
GIT binary patch
literal 18125
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
Q6PPQs<>hkP{LK0P0NF|U%K!iX

literal 0
HcmV?d00001

-- 
2.6.6
