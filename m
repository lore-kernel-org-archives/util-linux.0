Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8937 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751581AbcG2MNq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jul 2016 08:13:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6TC8sVj118989
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:46 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24fcvxqe4d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:45 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 29 Jul 2016 13:13:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CE14317D8056
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 13:15:13 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6TCDdpf58785844
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 12:13:39 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6TBDfPp015617
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 05:13:41 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/5] lscpu: new --physical option and small improvements
Date: Fri, 29 Jul 2016 14:13:31 +0200
Message-Id: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

another couple of lscpu patches from me. The first patch adds a option
"--physical" which makes lscpu read the core ids, socket ids,
etc. from the corresponding sysfs files, instead of calculating them
on its own.

At least an s390 this is useful to tell on which physical CPUs a
logical partition is running. A subsequent patch adds a new "lscpu -p
-y" testcase so we have at least some test coverage for the parsable
output for this new option.

Please note that the short option of "--physical" is "-y". If you are
not happy with that one feel free to change it; I couldn't decide
which character would make most sense and there isn't any existing
tool with a similar option. So...

Then there are two minor improvement patches.

The last patch adds proper detection of "Thread(s) per core" on
s390. It reads a new field "max thread id" from /proc/cpuinfo which
was just merged into the upstream kernel sources. With this new field
the "Thread(s) per core" line in the summary output now always
reflects the number of hardware threads available, independent of the
number of online CPUs.

Please consider merging these changes.

Thanks,
Heiko

Heiko Carstens (5):
  lscpu: add --physical option
  lscpu: add parsable testcase with the --physical option
  lscpu: only try to read sysfs attributes of present CPUs
  lspcu: minor manpage improvement
  lscpu: print correct number of threads per core if possible

 sys-utils/lscpu.1                             |  16 +++-
 sys-utils/lscpu.c                             | 128 +++++++++++++++++++++-----
 tests/expected/lscpu/lscpu-armv7              |   7 ++
 tests/expected/lscpu/lscpu-ppc-qemu           |   6 ++
 tests/expected/lscpu/lscpu-ppc64-POWER7       |  21 +++++
 tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu |  69 ++++++++++++++
 tests/expected/lscpu/lscpu-s390-kvm           |   8 ++
 tests/expected/lscpu/lscpu-s390-lpar          |  22 +++++
 tests/expected/lscpu/lscpu-s390-lpar-drawer   |  13 +++
 tests/expected/lscpu/lscpu-s390-zvm           |   9 ++
 tests/expected/lscpu/lscpu-sparc64            |  11 +++
 tests/expected/lscpu/lscpu-vbox-win           |   7 ++
 tests/expected/lscpu/lscpu-x86_64-64cpu       |  69 ++++++++++++++
 tests/expected/lscpu/lscpu-x86_64-dell_e4310  |   9 ++
 tests/ts/lscpu/lscpu                          |   5 +
 15 files changed, 375 insertions(+), 25 deletions(-)

-- 
2.6.6

