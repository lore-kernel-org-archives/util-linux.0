Return-Path: util-linux-owner@vger.kernel.org
Received: from blu0-omc2-s20.blu0.hotmail.com ([65.55.111.95]:43389 "EHLO
	blu0-omc2-s20.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755344Ab3BJQbT (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 10 Feb 2013 11:31:19 -0500
Message-ID: <BLU0-SMTP36414270EB979DF67318E53D50B0@phx.gbl>
Date: Mon, 11 Feb 2013 02:25:03 +1000
From: Luis Aranguren <pizzaman@hotmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Hypervisor & Virtualization lscpu test fail
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi, I'm trying to package util-linux for exherbo, a source based distro.

util-linux's lscpu tests fail when compiled on a VM running under a VMware Vsphere esxi hypervisor. 

#cat ./C/64/tests/diff/lscpu/lscpu-x86_64-64cpu
--- /var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/util-linux-2.22.2/tests/expected/lscpu/lscpu-x86_64-64cpu    2012-10-15 10:09:42.000000000 +0000
+++ /var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/C/64/tests/output/lscpu/lscpu-x86_64-64cpu   2013-02-09 03:35:37.000000000 +0000
@@ -12,6 +12,8 @@
 CPU MHz:               1064.000
 BogoMIPS:              3989.44
 Virtualization:        VT-x
+Hypervisor vendor:     VMware
+Virtualization type:   full
 L1d cache:             32K
 L1i cache:             32K
 L2 cache:              256K


# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                2
On-line CPU(s) list:   0,1
Thread(s) per core:    1
Core(s) per socket:    2
Socket(s):             1
NUMA node(s):          1
Vendor ID:             AuthenticAMD
CPU family:            16
Model:                 6
Stepping:              3
CPU MHz:               1497.506
BogoMIPS:              2995.01
Hypervisor vendor:     VMware
Virtualization type:   full
L1d cache:             64K
L1i cache:             64K
L2 cache:              1024K
NUMA node0 CPU(s):     0,1

How can I solve this?
Luis Aranguren

