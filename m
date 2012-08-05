Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:49555 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab2HEKiI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 Aug 2012 06:38:08 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <faizanh@linux.vnet.ibm.com>;
	Sun, 5 Aug 2012 16:08:06 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q75AbnKn27525126
	for <util-linux@vger.kernel.org>; Sun, 5 Aug 2012 16:07:49 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q75G7OpT008202
	for <util-linux@vger.kernel.org>; Sun, 5 Aug 2012 21:37:24 +0530
From: Faizan husain <faizanh@linux.vnet.ibm.com>
To: util-linux@vger.kernel.org
Cc: faizan husain <faizanh@linux.vnet.ibm.com>
Subject: [PATCH] lscpu : -b and -c option does not give expected output.
Date: Sun,  5 Aug 2012 03:37:08 -0700
Message-Id: <1344163028-30238-1-git-send-email-faizanh@linux.vnet.ibm.com>
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
index b93998a..648f51e 100644
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
+	if (desc->online && mod->online && CPU_COUNT_S(setsize, desc->online) != desc->ncpus) {
 		cpu_set_t *set;
 
 		/* Linux kernel provides cpuset of off-line CPUs that contains
-- 
1.7.4.1

