Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD6246785
	for <util-linux@vger.kernel.org>; Fri,  2 May 2025 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188585; cv=none; b=DFdQe52qnyjp+gj/EYgMuWWZXpiuPoA+BpZN4hPI2B0ypbeBsPI7/CGC9WTaBJGgYkY/tdboIelzB3YE04AZ885o0uWCLFyowWdZiGwBFRQdoy6+euvaymnY5HnGjodSLNooy0hnJVQ81A1im7zsUXvhPHHbFU4pMwF9W005iZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188585; c=relaxed/simple;
	bh=AVKylw/EEmQHDn8fT6Rlsy408JClLYeQmyyD3rjd8/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWNzD6+mAbdIcGs8op6SrL3Q1cM3uYOmmtePJTY7bV5smwArd1TwZlIe/7T1/fHkLAi7hpHZnKLXlRNBf0ZHaViVyn/6m+hqdxAhoLdvdhPUGRnty4dnR3bUQQAA6wu2WzPFdONo7OFlk03scK2PLMT7cP+7PFgkklKjhEE7MAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=u4wVbamM; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="u4wVbamM"
X-KPN-MessageId: 505eb1f2-2750-11f0-b9a1-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 505eb1f2-2750-11f0-b9a1-005056abbe64;
	Fri, 02 May 2025 14:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=fBDQ/UgjEW4inwvyuWeOvhk1Cx9fzUbB+8zqi3pDM14=;
	b=u4wVbamMlg/6G3542pMgczRVvguLoCZcQKqqwy3HEznVyHJrXUce0NCQ8/kWglMZ0ZBD/CAgQ2h7f
	 +UuIVa5tFN3Y7/RdaCYmt6/QHS3EAcTNot3IQo1o5j6TRBj8PkBYlR1BOv1PHe7PC3LLzs9ptYscKf
	 PktPFlEUquE5xYJU=
X-KPN-MID: 33|MIeCG2OWuS+m3wbhBxpQVvWe96z98b5E9Cr86JKsV/zATDIB7WZJOdNW1a5Y9dz
 PjHPaN5xL7uqq7KyE/thsrNGAHNaezWs6L6O83yxn8S4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|X/k9nG2ZyYeaUd+7kuMEsDXp773ecPy9BCQWyoAo7KBhjUz5mTc83QJBYG6OJ/x
 K6YCcEM2UTErYJHANn9FVqA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2bd3151c-2750-11f0-855b-005056ab7584;
	Fri, 02 May 2025 14:22:53 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/2] irqtop: use standard 'always/never' arguments instead of 'enable/disable'
Date: Fri,  2 May 2025 14:22:41 +0200
Message-ID: <20250502122242.72961-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most other util-linux tools that accept the option argument "auto"
additionally accept "always" and "never", not "enable" / "disable".

So, make option --cpu-stat accept those standard words (besides the
deviant ones), and adjust the documentation to use the standard words.

Furthermore, make --cpu-stat accept also "on", "off", "yes", "no",
"1", and "0", to allow the user to use shorter words.  The per-CPU
stats can now be suppressed with a succinct: `irqtop -c0`.

CC: Zhenwei Pi <pizhenwei@bytedance.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 bash-completion/irqtop  |  2 +-
 sys-utils/irqtop.1.adoc |  6 ++++--
 sys-utils/irqtop.c      | 11 +++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index 5faf122e5..0dd2f1981 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -9,7 +9,7 @@ _irqtop_module()
 			return 0
 			;;
 		'-c'|'--cpu-stat')
-			COMPREPLY=( $(compgen -W "auto enable disable" -- $cur) )
+			COMPREPLY=( $(compgen -W "auto enable disable always never" -- $cur) )
 			return 0
 			;;
 		'-C'|'--cpu-list')
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index cf258d085..63675f076 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -29,8 +29,10 @@ Specify which output columns to print. Use *--help* to get a list of all support
 Send the produced tables to stdout instead of to a static screen.
 This can be used for sending the output to other programs or to a file.
 
-*-c*, *--cpu-stat* _mode_::
-Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*, *disable*. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enough to show a full line of statistics.
+*-c*, *--cpu-stat* _when_::
+Whether to show the per-CPU statistics. Possible arguments are: *auto*, *never*, *always*.
+The default is *auto*: the per-CPU statistics are shown when the window is wide enough
+for the full list of CPUs.
 
 *-C*, *--cpu-list* _list_::
 Specify cpus in list format to show.
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 3dbd030e0..51e04ee85 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -307,7 +307,7 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_OPTIONS, stdout);
 	fputs(_(" -b, --batch            send tables to stdout, not to a static screen\n"), stdout);
-	fputs(_(" -c, --cpu-stat <mode>  whether to show the per-cpu stats (auto|enable|disable)\n"), stdout);
+	fputs(_(" -c, --cpu-stat <when>  whether to show the per-cpu stats (auto|never|always)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list>  show IRQs only for the specified cpus\n"), stdout);
 	fputs(_(" -d, --delay <secs>     wait this number of seconds between updates\n"), stdout);
 	fputs(_(" -J, --json             use JSON output format (implies --batch)\n"), stdout);
@@ -364,12 +364,11 @@ static void parse_args(	struct irqtop_ctl *ctl,
 		case 'c':
 			if (!strcmp(optarg, "auto"))
 				ctl->cpustat_mode = IRQTOP_CPUSTAT_AUTO;
-			else if (!strcmp(optarg, "enable"))
-				ctl->cpustat_mode = IRQTOP_CPUSTAT_ENABLE;
-			else if (!strcmp(optarg, "disable"))
-				ctl->cpustat_mode = IRQTOP_CPUSTAT_DISABLE;
 			else
-				errx(EXIT_FAILURE, _("unsupported mode '%s'"), optarg);
+				ctl->cpustat_mode = IRQTOP_CPUSTAT_DISABLE - parse_switch(optarg,
+							_("unsupported argument"), "yes", "no",
+							"always", "never", "enable", "disable",
+							"on", "off", "1", "0", NULL);
 			break;
 		case 'C':
 			{
-- 
2.48.1

