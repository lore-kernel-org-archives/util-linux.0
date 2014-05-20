Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62919 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbaETPm5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 11:42:57 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH 2/5] tests: add vbox lscpu dump
Date: Tue, 20 May 2014 15:42:28 +0000
Message-Id: <1400600551-7227-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Taken from openSUSE-13.1 guest in VirtualBox-4.3.10 (host=Win7):
   Hypervisor vendor:     Oracle
   Virtualization type:   full

Dump was provides by Bernhard Voelker.

CC: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/lscpu/lscpu-vbox-win  |  29 +++++++++++++++++++++++++++++
 tests/ts/lscpu/dumps/vbox-win.tar.gz | Bin 0 -> 15769 bytes
 2 files changed, 29 insertions(+)
 create mode 100644 tests/expected/lscpu/lscpu-vbox-win
 create mode 100644 tests/ts/lscpu/dumps/vbox-win.tar.gz

diff --git a/tests/expected/lscpu/lscpu-vbox-win b/tests/expected/lscpu/lscpu-vbox-win
new file mode 100644
index 0000000..569f078
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-vbox-win
@@ -0,0 +1,29 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                2
+On-line CPU(s) list:   0,1
+Thread(s) per core:    1
+Core(s) per socket:    2
+Socket(s):             1
+NUMA node(s):          1
+Vendor ID:             GenuineIntel
+CPU family:            6
+Model:                 58
+Model name:            Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
+Stepping:              9
+CPU MHz:               1600.000
+CPU max MHz:           3800.0000
+CPU min MHz:           1600.0000
+BogoMIPS:              3355.62
+Hypervisor vendor:     Oracle
+Virtualization type:   full
+L1d cache:             32K
+L1d cache:             32K
+L2d cache:             6144K
+NUMA node0 CPU(s):     0,1
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1d,L2d
+0,0,0,0,,0,0,0
+1,1,0,0,,1,1,0
diff --git a/tests/ts/lscpu/dumps/vbox-win.tar.gz b/tests/ts/lscpu/dumps/vbox-win.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e8204fe110175681d61973f8dcc8b7841acb622e
GIT binary patch
literal 15769
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
K4MKlJh5jEkk0$E?

literal 0
HcmV?d00001

-- 
1.8.4.5

