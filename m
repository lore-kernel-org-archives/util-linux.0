Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:47742 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138AbaCTJnL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 20 Mar 2014 05:43:11 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <jananive@linux.vnet.ibm.com>;
	Thu, 20 Mar 2014 15:13:07 +0530
Subject: [PATCH 28/33] Man pages
To: linux-kernel@vger.kernel.org
From: Janani Venkataraman <jananive@linux.vnet.ibm.com>
Cc: amwang@redhat.com, procps@freelists.org, rdunlap@xenotime.net,
        james.hogan@imgtec.com, aravinda@linux.vnet.ibm.com, hch@lst.de,
        mhiramat@redhat.com, jeremy.fitzhardinge@citrix.com,
        xemul@parallels.com, d.hatayama@jp.fujitsu.com, coreutils@gnu.org,
        kosaki.motohiro@jp.fujitsu.com, adobriyan@gmail.com,
        util-linux@vger.kernel.org, tarundsk@linux.vnet.ibm.com,
        vapier@gentoo.org, roland@hack.frob.com, ananth@linux.vnet.ibm.com,
        gorcunov@openvz.org, avagin@openvz.org, oleg@redhat.com,
        eparis@redhat.com, suzuki@linux.vnet.ibm.com, andi@firstfloor.org,
        tj@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Date: Thu, 20 Mar 2014 15:13:02 +0530
Message-ID: <20140320094302.14878.55418.stgit@localhost.localdomain>
In-Reply-To: <20140320093040.14878.903.stgit@localhost.localdomain>
References: <20140320093040.14878.903.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We have two man pages. One for the command gencore and the second for the
library interface(gencore API) which can be called by the client.

Signed-off-by: Janani Venkataraman <jananive@linux.vnet.ibm.com>
---
 doc/gencore.1 |   31 +++++++++++++++++++++++++++++++
 doc/gencore.3 |   28 ++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 doc/gencore.1
 create mode 100644 doc/gencore.3

diff --git a/doc/gencore.1 b/doc/gencore.1
new file mode 100644
index 0000000..3a7eb8f
--- /dev/null
+++ b/doc/gencore.1
@@ -0,0 +1,31 @@
+.\" Manpage for gencore.
+.\" Contact jananive@linux.vnet.ibm.in to correct errors or typos.
+.TH man 2 "11 Dec 2013" "1.0" "gencore man page"
+.SH NAME
+gencore \- generates coredump
+.SH SYNOPSIS
+gencore pid [output-file-name]
+.SH DESCRIPTION
+gencore takes a dump of the process whose PID is passed
+as a command line argument. If the output file name is
+specified,the core is dumped in that name, if not the
+default filename is core.pid.
+If through options we specify --daemon, in this case the
+gencore command helps in performing a selfdump.Any process
+can connect to this daemon created and request for a dump.
+
+.SH OPTIONS
+--daemon   Creates a daemon to perform selfdumps
+
+--socket   Performs selfdumps with systemd taking care of socket connections.
+	   For this we need to have the correct version of systemd which
+	   has this socket option enabled.
+
+.SH SEE ALSO
+ptrace(2), process_vm_readv(2), gencore(3)
+.SH BUGS
+No known bugs.
+.SH AUTHOR
+Janani Venkataraman <jananive@linux.vnet.ibm.com>
+
+Suzuki Poulose <suzuki@linux.vnet.ibm.com>
diff --git a/doc/gencore.3 b/doc/gencore.3
new file mode 100644
index 0000000..bc77b10
--- /dev/null
+++ b/doc/gencore.3
@@ -0,0 +1,28 @@
+.\" Manpage for libgencore.
+.\" Contact jananive@linux.vnet.ibm.in to correct errors or typos.
+.TH man 3 "11 Dec 2013" "1.0" "libgencore man page"
+.SH NAME
+gencore \- generates coredump
+.SH SYNOPSIS
+int gencore(char *corefile);
+.SH DESCRIPTION
+gencore takes a dump of the process who sends a message
+to the already running gencore daemon asking for a dump.
+The client or the requester specifies the corefile name
+and the dump is generated in the path specified. This name
+can be a relative or an absolute path.
+.SH RETURN VALUE
+gencore returns 0 on success and the appropriate error
+number on a failure.
+.SH ERRORS
+gencore() may fail and returns the errors for the individual operations
+performed by the daemon or server during the coredump generation.
+.SH OPTIONS
+.SH SEE ALSO
+ptrace(2), process_vm_readv(2), socket(2), listen(2), chmod(2),
+getsockopt(2), setuid(2), setgid(2), geteuid(2), daemon(3),
+bind(2), accept(2).
+.SH BUGS
+No known bugs.
+.SH AUTHOR
+Janani Venkataraman <jananive@linux.vnet.ibm.com>

