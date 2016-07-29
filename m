Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/5] lscpu: add parsable testcase with the --physical option
Date: Fri, 29 Jul 2016 14:13:33 +0200
In-Reply-To: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1469794416-97361-3-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 tests/expected/lscpu/lscpu-armv7              |  7 +++
 tests/expected/lscpu/lscpu-ppc-qemu           |  6 +++
 tests/expected/lscpu/lscpu-ppc64-POWER7       | 21 ++++++++
 tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu | 69 +++++++++++++++++++++++++++
 tests/expected/lscpu/lscpu-s390-kvm           |  8 ++++
 tests/expected/lscpu/lscpu-s390-lpar          | 22 +++++++++
 tests/expected/lscpu/lscpu-s390-lpar-drawer   | 13 +++++
 tests/expected/lscpu/lscpu-s390-zvm           |  9 ++++
 tests/expected/lscpu/lscpu-sparc64            | 11 +++++
 tests/expected/lscpu/lscpu-vbox-win           |  7 +++
 tests/expected/lscpu/lscpu-x86_64-64cpu       | 69 +++++++++++++++++++++++++++
 tests/expected/lscpu/lscpu-x86_64-dell_e4310  |  9 ++++
 tests/ts/lscpu/lscpu                          |  5 ++
 13 files changed, 256 insertions(+)

diff --git a/tests/expected/lscpu/lscpu-armv7 b/tests/expected/lscpu/lscpu-armv7
index 84ae4b5dab95..050578df5c0e 100644
--- a/tests/expected/lscpu/lscpu-armv7
+++ b/tests/expected/lscpu/lscpu-armv7
@@ -12,3 +12,10 @@ CPU min MHz:           200.0000
 # CPU,Core,Socket,Node
 0,0,0,
 1,1,0,
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+0,0,0,
+1,1,0,
diff --git a/tests/expected/lscpu/lscpu-ppc-qemu b/tests/expected/lscpu/lscpu-ppc-qemu
index 78b0b295fb98..e6cc68bbd2ae 100644
--- a/tests/expected/lscpu/lscpu-ppc-qemu
+++ b/tests/expected/lscpu/lscpu-ppc-qemu
@@ -14,3 +14,9 @@ L1i cache:             unknown size
 # starting from zero.
 # CPU,Core,Socket,Node,,L1d,L1i
 0,0,0,,,0,0
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i
+0,0,-,,,0,0
diff --git a/tests/expected/lscpu/lscpu-ppc64-POWER7 b/tests/expected/lscpu/lscpu-ppc64-POWER7
index 9a3c0c9649e2..7ae7ea14eb29 100644
--- a/tests/expected/lscpu/lscpu-ppc64-POWER7
+++ b/tests/expected/lscpu/lscpu-ppc64-POWER7
@@ -30,3 +30,24 @@ NUMA node0 CPU(s):     0-15
 13,3,3,0,,3,3
 14,3,3,0,,3,3
 15,3,3,0,,3,3
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i
+0,0,-,0,,0,0
+1,0,-,0,,0,0
+2,0,-,0,,0,0
+3,0,-,0,,0,0
+4,4,-,0,,1,1
+5,4,-,0,,1,1
+6,4,-,0,,1,1
+7,4,-,0,,1,1
+8,8,-,0,,2,2
+9,8,-,0,,2,2
+10,8,-,0,,2,2
+11,8,-,0,,2,2
+12,12,-,0,,3,3
+13,12,-,0,,3,3
+14,12,-,0,,3,3
+15,12,-,0,,3,3
diff --git a/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu b/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
index 0aed12a1df39..1a9b91053d77 100644
--- a/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
+++ b/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
@@ -81,3 +81,72 @@ NUMA node1 CPU(s):
 61,15,15,0,,15,15
 62,15,15,0,,15,15
 63,15,15,0,,15,15
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i
+0,0,-,0,,0,0
+1,0,-,0,,0,0
+2,0,-,0,,0,0
+3,0,-,0,,0,0
+4,4,-,0,,1,1
+5,4,-,0,,1,1
+6,4,-,0,,1,1
+7,4,-,0,,1,1
+8,8,-,0,,2,2
+9,8,-,0,,2,2
+10,8,-,0,,2,2
+11,8,-,0,,2,2
+12,12,-,0,,3,3
+13,12,-,0,,3,3
+14,12,-,0,,3,3
+15,12,-,0,,3,3
+16,16,-,0,,4,4
+17,16,-,0,,4,4
+18,16,-,0,,4,4
+19,16,-,0,,4,4
+20,20,-,0,,5,5
+21,20,-,0,,5,5
+22,20,-,0,,5,5
+23,20,-,0,,5,5
+24,24,-,0,,6,6
+25,24,-,0,,6,6
+26,24,-,0,,6,6
+27,24,-,0,,6,6
+28,28,-,0,,7,7
+29,28,-,0,,7,7
+30,28,-,0,,7,7
+31,28,-,0,,7,7
+32,32,-,0,,8,8
+33,32,-,0,,8,8
+34,32,-,0,,8,8
+35,32,-,0,,8,8
+36,36,-,0,,9,9
+37,36,-,0,,9,9
+38,36,-,0,,9,9
+39,36,-,0,,9,9
+40,40,-,0,,10,10
+41,40,-,0,,10,10
+42,40,-,0,,10,10
+43,40,-,0,,10,10
+44,44,-,0,,11,11
+45,44,-,0,,11,11
+46,44,-,0,,11,11
+47,44,-,0,,11,11
+48,48,-,0,,12,12
+49,48,-,0,,12,12
+50,48,-,0,,12,12
+51,48,-,0,,12,12
+52,52,-,0,,13,13
+53,52,-,0,,13,13
+54,52,-,0,,13,13
+55,52,-,0,,13,13
+56,56,-,0,,14,14
+57,56,-,0,,14,14
+58,56,-,0,,14,14
+59,56,-,0,,14,14
+60,60,-,0,,15,15
+61,60,-,0,,15,15
+62,60,-,0,,15,15
+63,60,-,0,,15,15
diff --git a/tests/expected/lscpu/lscpu-s390-kvm b/tests/expected/lscpu/lscpu-s390-kvm
index 66d1c047c59c..77c06f53e2d7 100644
--- a/tests/expected/lscpu/lscpu-s390-kvm
+++ b/tests/expected/lscpu/lscpu-s390-kvm
@@ -21,3 +21,11 @@ Flags:                 esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs
 0,0,0,
 1,1,1,
 2,2,2,
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+0,0,-,
+1,0,-,
+2,0,-,
diff --git a/tests/expected/lscpu/lscpu-s390-lpar b/tests/expected/lscpu/lscpu-s390-lpar
index 9c8ac2c4f8dd..b9daf07c34e4 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar
+++ b/tests/expected/lscpu/lscpu-s390-lpar
@@ -36,3 +36,25 @@ Flags:                 esan3 zarch stfle msa ldisp eimm dfp etf3eh highgprs
 17,14,5,
 18,15,5,
 19,16,6,
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+1,1,-,
+2,1,-,
+3,2,-,
+4,2,-,
+5,2,-,
+8,1,-,
+9,1,-,
+10,1,-,
+11,2,-,
+12,2,-,
+13,2,-,
+14,2,-,
+15,3,-,
+16,4,-,
+17,4,-,
+18,4,-,
+19,6,-,
diff --git a/tests/expected/lscpu/lscpu-s390-lpar-drawer b/tests/expected/lscpu/lscpu-s390-lpar-drawer
index 2309f1db444b..e5f3af99f883 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar-drawer
+++ b/tests/expected/lscpu/lscpu-s390-lpar-drawer
@@ -37,3 +37,16 @@ Flags:                 esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs
 5,5,1,0,,5,5,5,5
 6,6,1,0,,6,6,6,6
 7,7,1,0,,7,7,7,7
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i,L2d,L2i
+0,0,2,0,,0,0,0,0
+1,1,2,0,,1,1,1,1
+2,2,3,0,,2,2,2,2
+3,3,3,0,,3,3,3,3
+4,4,3,0,,4,4,4,4
+5,5,3,0,,5,5,5,5
+6,6,3,0,,6,6,6,6
+7,7,3,0,,7,7,7,7
diff --git a/tests/expected/lscpu/lscpu-s390-zvm b/tests/expected/lscpu/lscpu-s390-zvm
index 4cd6b8fa0fc1..4c02b037bb95 100644
--- a/tests/expected/lscpu/lscpu-s390-zvm
+++ b/tests/expected/lscpu/lscpu-s390-zvm
@@ -22,3 +22,12 @@ Flags:                 esan3 zarch stfle msa ldisp eimm dfp etf3eh highgprs
 1,1,1,
 2,2,2,
 3,3,3,
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+0,0,-,
+1,0,-,
+2,0,-,
+3,0,-,
diff --git a/tests/expected/lscpu/lscpu-sparc64 b/tests/expected/lscpu/lscpu-sparc64
index aacaf1156f73..fdc5e8b2909d 100644
--- a/tests/expected/lscpu/lscpu-sparc64
+++ b/tests/expected/lscpu/lscpu-sparc64
@@ -17,3 +17,14 @@ Flags:                 sun4u
 11,3,3,
 14,4,4,
 15,5,5,
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+6,0,-,
+7,0,-,
+10,0,-,
+11,0,-,
+14,0,-,
+15,0,-,
diff --git a/tests/expected/lscpu/lscpu-vbox-win b/tests/expected/lscpu/lscpu-vbox-win
index 5204adb9a7e8..595824b9376f 100644
--- a/tests/expected/lscpu/lscpu-vbox-win
+++ b/tests/expected/lscpu/lscpu-vbox-win
@@ -28,3 +28,10 @@ Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
 # CPU,Core,Socket,Node,,L1d,L1d,L2d
 0,0,0,0,,0,0,0
 1,1,0,0,,1,1,0
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1d,L2d
+0,0,0,0,,0,0,0
+1,1,0,0,,1,1,0
diff --git a/tests/expected/lscpu/lscpu-x86_64-64cpu b/tests/expected/lscpu/lscpu-x86_64-64cpu
index 07990eadee5a..cf5c57a63a74 100644
--- a/tests/expected/lscpu/lscpu-x86_64-64cpu
+++ b/tests/expected/lscpu/lscpu-x86_64-64cpu
@@ -92,3 +92,72 @@ Flags:                 fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov
 61,29,1,2,,29,29,29,1
 62,30,2,0,,30,30,30,2
 63,31,3,3,,31,31,31,3
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i,L2,L3
+0,0,0,0,,0,0,0,0
+1,0,2,2,,1,1,1,1
+2,0,1,0,,2,2,2,2
+3,0,3,3,,3,3,3,3
+4,8,0,0,,4,4,4,0
+5,8,2,2,,5,5,5,1
+6,8,1,0,,6,6,6,2
+7,8,3,3,,7,7,7,3
+8,2,0,0,,8,8,8,0
+9,2,2,2,,9,9,9,1
+10,2,1,0,,10,10,10,2
+11,2,3,3,,11,11,11,3
+12,10,0,0,,12,12,12,0
+13,10,2,2,,13,13,13,1
+14,10,1,0,,14,14,14,2
+15,10,3,3,,15,15,15,3
+16,1,0,0,,16,16,16,0
+17,1,2,2,,17,17,17,1
+18,1,1,0,,18,18,18,2
+19,1,3,3,,19,19,19,3
+20,9,0,0,,20,20,20,0
+21,9,2,2,,21,21,21,1
+22,9,1,0,,22,22,22,2
+23,9,3,3,,23,23,23,3
+24,3,0,0,,24,24,24,0
+25,3,2,2,,25,25,25,1
+26,3,1,0,,26,26,26,2
+27,3,3,3,,27,27,27,3
+28,11,0,0,,28,28,28,0
+29,11,2,2,,29,29,29,1
+30,11,1,0,,30,30,30,2
+31,11,3,3,,31,31,31,3
+32,0,0,0,,0,0,0,0
+33,0,2,2,,1,1,1,1
+34,0,1,0,,2,2,2,2
+35,0,3,3,,3,3,3,3
+36,8,0,0,,4,4,4,0
+37,8,2,2,,5,5,5,1
+38,8,1,0,,6,6,6,2
+39,8,3,3,,7,7,7,3
+40,2,0,0,,8,8,8,0
+41,2,2,2,,9,9,9,1
+42,2,1,0,,10,10,10,2
+43,2,3,3,,11,11,11,3
+44,10,0,0,,12,12,12,0
+45,10,2,2,,13,13,13,1
+46,10,1,0,,14,14,14,2
+47,10,3,3,,15,15,15,3
+48,1,0,0,,16,16,16,0
+49,1,2,2,,17,17,17,1
+50,1,1,0,,18,18,18,2
+51,1,3,3,,19,19,19,3
+52,9,0,0,,20,20,20,0
+53,9,2,2,,21,21,21,1
+54,9,1,0,,22,22,22,2
+55,9,3,3,,23,23,23,3
+56,3,0,0,,24,24,24,0
+57,3,2,2,,25,25,25,1
+58,3,1,0,,26,26,26,2
+59,3,3,3,,27,27,27,3
+60,11,0,0,,28,28,28,0
+61,11,2,2,,29,29,29,1
+62,11,1,0,,30,30,30,2
+63,11,3,3,,31,31,31,3
diff --git a/tests/expected/lscpu/lscpu-x86_64-dell_e4310 b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
index 39ec32ca08a1..7e3ea6ed6efb 100644
--- a/tests/expected/lscpu/lscpu-x86_64-dell_e4310
+++ b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
@@ -30,3 +30,12 @@ Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
 1,1,0,0,,1,1,1,0
 2,0,0,0,,0,0,0,0
 3,1,0,0,,1,1,1,0
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i,L2,L3
+0,0,0,0,,0,0,0,0
+1,2,0,0,,1,1,1,0
+2,0,0,0,,0,0,0,0
+3,2,0,0,,1,1,1,0
diff --git a/tests/ts/lscpu/lscpu b/tests/ts/lscpu/lscpu
index 4a98b86042fa..70fbce9f3093 100755
--- a/tests/ts/lscpu/lscpu
+++ b/tests/ts/lscpu/lscpu
@@ -42,6 +42,11 @@ for dump in $(ls $TS_SELF/dumps/*.tar.gz | sort); do
 	"${TS_CMD_LSCPU}" -p -s "${dumpdir}/${name}" \
 		 >>"${TS_OUTPUT}" 2>&1
 
+	echo >>"${TS_OUTPUT}"
+
+	"${TS_CMD_LSCPU}" -p -y -s "${dumpdir}/${name}" \
+		 >>"${TS_OUTPUT}" 2>&1
+
 	# LE/BE depends on binary
 	sed -i -e '/Byte Order:.*/d' $TS_OUTPUT
 
-- 
2.6.6
