Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338442E3390
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414324; cv=none; b=oqITmDMDpOfiM5cgKi5MfGxcZk3Pp6wvCOXO/ntjBLsM+pITkr8c1Mguywmf2y6QS80uHug0GtsNEn8WNzpdZiztdkUx95ZO87gbH6HaAKJT6d99ebysXGQ/0Am2+GjDjnLyDnWKuE0el+RxruQGGW6Tk0iMt0jLlqFK1p0Dz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414324; c=relaxed/simple;
	bh=3nTl6QDpTs9JwVyR5MQgnGEKoRm5yaBmGZobtNiO+gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJW5t4HQ/jZdYMovmR3+yhqhBkzdzs8dDqNa42pbkatut1Cw9r6V0VSqt2oF1OHL76oqa3E5qvNdOKX+BsLa8cdfbOsaPYbU6X71JObrrh9KLxgx8wxhM4TVMMo/WRA45NlwwmSB5ZYNIO5KBR2RxmI1PJVyG3lpTnqhxKxu/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=DGYW1XZl; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="DGYW1XZl"
X-KPN-MessageId: ed6f89fc-0e14-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ed6f89fc-0e14-11f0-bc28-005056ab378f;
	Mon, 31 Mar 2025 11:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=xNMdoobXZaAqTrrO90TR59fYy1qOMJWAaAtB6u8poJA=;
	b=DGYW1XZlh5Gw0FKT9O3ASXgDfFDNQwIxWs8Xc5Vkxv6usAGVp9nKFJVQ7MDb1OEEAiA44KHULcb9H
	 eZ+H0jesy098S9w4S1GXEGu7fFTGmN3bInqA8mfjuc2UHzcblDCNOTqA15JtirD6zaiIWaDiZJnLoY
	 GXEi5LTWWYlGrbDU=
X-KPN-MID: 33|NoUjwKgdonDl/i9t0UVhalt0TRyYUS52IPx2SaLDrqzo0FhAr828ez7or1bnVGE
 SlXiAmzlWY5H2hrtdRRC5Ise4cTLkkKl+SXwyj80zWV4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7YwUHwAKjTzb2TW2oPX84pd5gmyKY128ntRitRNtUbLHL8WydRavW5o+DIgICsa
 J68/r58jMNdldR5Tt2ZX79A==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id dc32df78-0e14-11f0-8516-005056ab7584;
	Mon, 31 Mar 2025 11:45:20 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Joe Jin <joe.jin@oracle.com>,
	Zhenwei Pi <pizhenwei@bytedance.com>
Subject: [PATCH 05/10] irqtop: improve several more option descriptions, and align them all
Date: Mon, 31 Mar 2025 11:44:38 +0200
Message-ID: <20250331094443.9619-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep at least two spaces between option+argument and its description,
while making sure not to go above 80 columns per line.

Also, improve the docstring (there is no need to mention that irqtop
is a utility) and remove the ugly Q from the list of interactive keys.

CC: Joe Jin <joe.jin@oracle.com>
CC: Zhenwei Pi <pizhenwei@bytedance.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/irqtop.1.adoc |  4 ++--
 sys-utils/irqtop.c      | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 04158a0ef..cf258d085 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -8,7 +8,7 @@
 
 == NAME
 
-irqtop - utility to display kernel interrupt information
+irqtop - display kernel interrupt information
 
 == SYNOPSIS
 
@@ -16,7 +16,7 @@ irqtop - utility to display kernel interrupt information
 
 == DESCRIPTION
 
-Display kernel interrupt counter information in *top*(1) style view.
+Display interrupt-counter information from the kernel in the style of *top*(1).
 
 The default output is subject to change. So whenever possible, you should avoid using default outputs in your scripts. Always explicitly define expected columns by using *--output*.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index e0abddd82..3dbd030e0 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -303,28 +303,28 @@ static void __attribute__((__noreturn__)) usage(void)
 	printf(_(" %s [options]\n"), program_invocation_short_name);
 	fputs(USAGE_SEPARATOR, stdout);
 
-	puts(_("Interactive utility to display kernel interrupt information."));
+	puts(_("Display kernel interrupt information."));
 
 	fputs(USAGE_OPTIONS, stdout);
-	fputs(_(" -b, --batch           send tables to stdout, not to a static screen\n"), stdout);
-	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
-	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
-	fputs(_(" -d, --delay <secs>    wait this number of seconds between updates\n"), stdout);
-	fputs(_(" -J, --json            use JSON output format (implies --batch)\n"), stdout);
-	fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
-	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
-	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
-	fputs(_(" -S, --softirq        show softirqs instead of interrupts\n"), stdout);
-	fputs(_(" -t, --threshold <N>  only IRQs with counters above <N>\n"), stdout);
+	fputs(_(" -b, --batch            send tables to stdout, not to a static screen\n"), stdout);
+	fputs(_(" -c, --cpu-stat <mode>  whether to show the per-cpu stats (auto|enable|disable)\n"), stdout);
+	fputs(_(" -C, --cpu-list <list>  show IRQs only for the specified cpus\n"), stdout);
+	fputs(_(" -d, --delay <secs>     wait this number of seconds between updates\n"), stdout);
+	fputs(_(" -J, --json             use JSON output format (implies --batch)\n"), stdout);
+	fputs(_(" -n, --iter <number>    the maximum number of iterations\n"), stdout);
+	fputs(_(" -o, --output <list>    which columns to show, and in which order\n"), stdout);
+	fputs(_(" -s, --sort <column>    sort the table on this column\n"), stdout);
+	fputs(_(" -S, --softirq          show softirqs instead of interrupts\n"), stdout);
+	fputs(_(" -t, --threshold <num>  show only IRQs with counters above this number\n"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
-	fprintf(stdout, USAGE_HELP_OPTIONS(22));
+	fprintf(stdout, USAGE_HELP_OPTIONS(24));
 
 	fputs(_("\nThe following interactive key commands are valid:\n"), stdout);
 	fputs(_("  i      sort by IRQ\n"), stdout);
 	fputs(_("  t      sort by TOTAL\n"), stdout);
 	fputs(_("  d      sort by DELTA\n"), stdout);
 	fputs(_("  n      sort by NAME\n"), stdout);
-	fputs(_("  q Q    quit program\n"), stdout);
+	fputs(_("  q      quit program\n"), stdout);
 
 	fputs(USAGE_COLUMNS, stdout);
 	irq_print_columns(stdout, 0);
-- 
2.48.1

