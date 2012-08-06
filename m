Return-Path: util-linux-owner@vger.kernel.org
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:41379 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab2HFFLC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 01:11:02 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <faizanh@linux.vnet.ibm.com>;
	Mon, 6 Aug 2012 15:10:28 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q765Av0314352444
	for <util-linux@vger.kernel.org>; Mon, 6 Aug 2012 15:10:57 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q765AvEV025187
	for <util-linux@vger.kernel.org>; Mon, 6 Aug 2012 15:10:57 +1000
From: Faizan husain <faizanh@linux.vnet.ibm.com>
To: util-linux@vger.kernel.org
Cc: faizan husain <faizanh@linux.vnet.ibm.com>
Subject: [PATCH] lscpu : -b and -c option does not give expected output.
Date: Sun,  5 Aug 2012 22:10:52 -0700
Message-Id: <1344229852-4737-1-git-send-email-faizanh@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: faizan husain <faizanh@linux.vnet.ibm.com>

Options for lscpu command are giving incorrect output.
As per the man page or help, '-b' option should limit the output to online CPUs
and '-c' option should limit the output to offline CPUs.
But we could see the output is same for '-a','-b' and '-c' options.

Signed-off-by: faizan husain <faizanh@linux.vnet.ibm.com>
---
 sys-utils/lscpu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b93998a..7c28a56 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1101,12 +1101,12 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 #endif
 	print_n(_("CPU(s):"), desc->ncpus);
 
-	if (desc->online)
+	if (desc->online && mod->online)
 		print_cpuset(mod->hex ? _("On-line CPU(s) mask:") :
 					_("On-line CPU(s) list:"),
 				desc->online, mod->hex);
 
-	if (desc->online && CPU_COUNT_S(setsize, desc->online) != desc->ncpus) {
+	if (desc->online && mod->offline && CPU_COUNT_S(setsize, desc->online) != desc->ncpus) {
 		cpu_set_t *set;
 
 		/* Linux kernel provides cpuset of off-line CPUs that contains
-- 
1.7.4.1

