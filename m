Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate7.uk.ibm.com ([194.196.100.167]:45710 "EHLO
	mtagate7.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab1JJJAb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 05:00:31 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9A90Uld001498
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 09:00:30 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9A90UvH1646622
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:00:30 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9A90PH0006255
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 03:00:26 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/6] chcpu und lscpu updates
Date: Mon, 10 Oct 2011 10:59:38 +0200
Message-Id: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

just some more small updates for chcpu and lscpu. The main part are
the man pages updates. Hopefully for the better :)

Thanks,
Heiko

Heiko Carstens (6):
  lscpu: switch Yes/No output to lower case
  lscpu: fix typo in help text
  lscpu: change column names back to mixed case
  lscpu: add s390 kvm test case
  chcpu: man page update
  lscpu: man page update

 sys-utils/Makefile.am                |    2 +-
 sys-utils/chcpu.1                    |   94 -----------------------
 sys-utils/chcpu.8                    |   85 +++++++++++++++++++++
 sys-utils/lscpu.1                    |  136 ++++++++++++++++++++++++----------
 sys-utils/lscpu.c                    |   37 ++++-----
 tests/expected/lscpu/lscpu-s390-kvm  |   21 +++++
 tests/ts/lscpu/dumps/s390-kvm.tar.gz |  Bin 0 -> 2275 bytes
 7 files changed, 221 insertions(+), 154 deletions(-)
 delete mode 100644 sys-utils/chcpu.1
 create mode 100644 sys-utils/chcpu.8
 create mode 100644 tests/expected/lscpu/lscpu-s390-kvm
 create mode 100644 tests/ts/lscpu/dumps/s390-kvm.tar.gz

-- 
1.7.6.3

