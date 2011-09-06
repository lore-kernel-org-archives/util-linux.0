Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010200.960945606@de.ibm.com>
Date: Tue, 06 Sep 2011 02:53:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 10/11] [PATCH] lscpu: add s390 test case
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 tests/expected/lscpu/lscpu-s390-lpar  |   35 +++++++++++++++++++++++++++++++++
 tests/expected/lscpu/lscpu-s390-zvm   |   21 +++++++++++++++++++
 tests/ts/lscpu/bla.tar.gz             |  Bin 0 -> 2573 bytes
 tests/ts/lscpu/dumps/s390-lpar.tar.gz |  Bin 0 -> 6611 bytes
 tests/ts/lscpu/dumps/s390-zvm.tar.gz  |  Bin 0 -> 2582 bytes
 tests/ts/lscpu/mk-input.sh            |    4 +++
 6 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 tests/expected/lscpu/lscpu-s390-lpar
 create mode 100644 tests/expected/lscpu/lscpu-s390-zvm
 create mode 100644 tests/ts/lscpu/bla.tar.gz
 create mode 100644 tests/ts/lscpu/dumps/s390-lpar.tar.gz
 create mode 100644 tests/ts/lscpu/dumps/s390-zvm.tar.gz

diff --git a/tests/expected/lscpu/lscpu-s390-lpar b/tests/expected/lscpu/lscpu-s390-lpar
new file mode 100644
index 0000000..600fd3f
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-s390-lpar
@@ -0,0 +1,35 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                20
+On-line CPU(s) list:   1-5,8-19
+Off-line CPU(s) list:  0,6,7
+Thread(s) per core:    1
+Core(s) per socket:    4
+Socket(s) per book:    6
+Book(s):               4
+Vendor ID:             IBM/S390
+BogoMIPS:              14367.00
+Hypervisor vendor:     IBM
+Virtualization type:   full
+Dispatching mode:      vertical
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+1,0,0,
+2,1,0,
+3,2,1,
+4,3,1,
+5,4,1,
+8,5,2,
+9,6,2,
+10,7,2,
+11,8,3,
+12,9,3,
+13,10,3,
+14,11,3,
+15,12,4,
+16,13,5,
+17,14,5,
+18,15,5,
+19,16,6,
diff --git a/tests/expected/lscpu/lscpu-s390-zvm b/tests/expected/lscpu/lscpu-s390-zvm
new file mode 100644
index 0000000..9ce22d4
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-s390-zvm
@@ -0,0 +1,21 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                4
+On-line CPU(s) list:   0-3
+Thread(s) per core:    1
+Core(s) per socket:    1
+Socket(s) per book:    1
+Book(s):               4
+Vendor ID:             IBM/S390
+BogoMIPS:              14367.00
+Hypervisor vendor:     IBM
+Virtualization type:   full
+Dispatching mode:      horizontal
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+0,0,0,
+1,1,1,
+2,2,2,
+3,3,3,
diff --git a/tests/ts/lscpu/bla.tar.gz b/tests/ts/lscpu/bla.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..9432cbd5e4cb843477b7e97c173ffbc28a8c24b0
GIT binary patch
literal 2573
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
YdqM(ctoHev{vcn|aE>&j7BElkPcZb)mH+?%

literal 0
HcmV?d00001

diff --git a/tests/ts/lscpu/dumps/s390-lpar.tar.gz b/tests/ts/lscpu/dumps/s390-lpar.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..59aea6ac19669d5030c973745c41de0ef9ff9991
GIT binary patch
literal 6611
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
Uf@KokD)D<(eAh~6%}||x0sX6;1ONa4

literal 0
HcmV?d00001

diff --git a/tests/ts/lscpu/dumps/s390-zvm.tar.gz b/tests/ts/lscpu/dumps/s390-zvm.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..b13594d2b096ba82f7afac37f59ee6b8bf04b16e
GIT binary patch
literal 2582
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

literal 0
HcmV?d00001

diff --git a/tests/ts/lscpu/mk-input.sh b/tests/ts/lscpu/mk-input.sh
index ddf70ec..299ac08 100644
--- a/tests/ts/lscpu/mk-input.sh
+++ b/tests/ts/lscpu/mk-input.sh
@@ -30,6 +30,10 @@ if [ -d "/proc/xen" ]; then
 	fi
 fi
 
+if [ -e "/proc/sysinfo" ]; then
+	$CP /proc/sysinfo $TS_DUMP
+fi
+
 $CP /sys/devices/system/cpu/* $TS_DUMP
 $CP /sys/devices/system/node/*/cpumap $TS_DUMP
 
-- 
1.7.5.4
