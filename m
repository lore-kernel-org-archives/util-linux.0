Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate3.uk.ibm.com ([194.196.100.163]:43902 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab1JJJHu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 05:07:50 -0400
Received: from d06nrmr1507.portsmouth.uk.ibm.com (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9A97n8a003424
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 09:07:49 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9A97CsC2342914
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:07:48 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9AG0QAb027414
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:00:27 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/6] lscpu: fix typo in help text
Date: Mon, 10 Oct 2011 10:59:40 +0200
Message-Id: <1318237184-6616-3-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add missing 'n' in help text for extended output line.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 66fa971..7c8cb13 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1197,7 +1197,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -a, --all               print online and offline CPUs (default for -e)\n"
 		" -b, --online            print online CPUs only (default for -p)\n"
 		" -c, --offline           print offline CPUs only\n"
-		" -e, --extended[=<list>] print out a extended readable format\n"
+		" -e, --extended[=<list>] print out an extended readable format\n"
 		" -h, --help              print this help\n"
 		" -p, --parse[=<list>]    print out a parsable format\n"
 		" -s, --sysroot <dir>     use directory DIR as system root\n"
-- 
1.7.6.3

