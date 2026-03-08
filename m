Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C450276
	for <util-linux@vger.kernel.org>; Sun,  8 Mar 2026 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772968824; cv=none; b=K6gK07HPqIuQHnri979KkIE/35I8LEHeKqTYrMyuA9XSeCFT5lA95rZP+psrzWc4JvklTeYkflWMhq3JTyDHbRwP1Ef0XqQ7/4RTIEWespq6OcHd/GlpxqbXP0kAaaKFOYjS9kJVLj8kVHo07x9eWWQD2T/ZWc59t7uZVjDly4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772968824; c=relaxed/simple;
	bh=PUIusoE+6eqDa7UBywsLV7uifV0rgcWepg4miUK2rO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O88gFU3C63fcn20D5L+gcVfmEOlXx7myQISobtq3Ss7bvlx3smVy10zzWQDJ0jjRagJMhQYrV9kGkFvN9w1FWAQccL3trQuYl/XcHOsy6p4JfuNca4vA5EhbX/KH07vUv6dm5iC8hldC66KL24Z/A2SKEmAKE3pAycTCW66j8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=qHDSsMC6; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="qHDSsMC6"
X-KPN-MessageId: c864706f-1ae0-11f1-969b-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c864706f-1ae0-11f1-969b-005056abbe64;
	Sun, 08 Mar 2026 12:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=9mPh4ivHzkRO0FJ6S3cPx16zRNahidZjWXJH+9BLi0I=;
	b=qHDSsMC6hPTdM5aUEp8ePIynKJ5r6XBJfUucUG9qYSjDqYxJJu4f8DHn60bFj/D3cwm210Vt8k7zJ
	 GVZro7HAyE7POoWuqKO0xVgOzvz4C38lJ6T3cFEteXcJu5E5T/LVk+1TZ5BylzcexEP/hGgQd0NSTJ
	 9R/wGCnuN6WFQeMI=
X-KPN-MID: 33|R4tP8jV6pFqKTHj5jbN4IzE+Cn9a5xOM4A30IECwGucvpracJVG/LmxAuOJghyo
 jiqP+Gsl3rkzOup71SaK+vXco1LEQ/BqQ0Oj1JEGsf6I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aUD0wnwyLT1u3OVsiW6puoT6N0rYRtsPgbI7x1XNcO6915k+3Uw1DEM6tYWcisf
 2+y2w6uDB6y9/L5UBwfswyQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c84494d4-1ae0-11f1-b8e3-005056ab7584;
	Sun, 08 Mar 2026 12:20:16 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] nsenter: (usage) improve the alignment of the option descriptions
Date: Sun,  8 Mar 2026 12:20:03 +0100
Message-ID: <20260308112004.9206-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308112004.9206-1-bensberg@telfort.nl>
References: <20260308112004.9206-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perfect alignment is not possible, otherwise too little space remains
for the descriptions.

Also, slightly reword one description to fit within 80 columns again,
and align also a description that was missed by commit 986188d1da two
monts ago.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/nsenter.c | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 98da75511..e10ba9cf9 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -95,34 +95,34 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Run a program with namespaces of other processes.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --all                    enter all namespaces\n"), out);
-	fputs(_(" -t, --target <PID>           target process to get namespaces from\n"), out);
-	fputs(_(" -m, --mount[=<file>|=:<nsid>]  enter mount namespace\n"), out);
-	fputs(_(" -u, --uts[=<file>|=:<nsid>]  enter UTS namespace (hostname etc)\n"), out);
-	fputs(_(" -i, --ipc[=<file>|=:<nsid>]  enter System V IPC namespace\n"), out);
-	fputs(_(" -n, --net[=<file>|=:<nsid>]  enter network namespace\n"), out);
-	fputs(_(" -N, --net-socket <fd>        enter socket's network namespace (use with --target)\n"), out);
-	fputs(_(" -p, --pid[=<file>|=:<nsid>]  enter pid namespace\n"), out);
+	fputs(_(" -a, --all                     enter all namespaces\n"), out);
+	fputs(_(" -t, --target <PID>            target process to get namespaces from\n"), out);
+	fputs(_(" -m, --mount[=<file>|=:<nsid>] enter mount namespace\n"), out);
+	fputs(_(" -u, --uts[=<file>|=:<nsid>]   enter UTS namespace (hostname etc)\n"), out);
+	fputs(_(" -i, --ipc[=<file>|=:<nsid>]   enter System V IPC namespace\n"), out);
+	fputs(_(" -n, --net[=<file>|=:<nsid>]   enter network namespace\n"), out);
+	fputs(_(" -N, --net-socket <fd>         enter socket's network namespace (needs --target)\n"), out);
+	fputs(_(" -p, --pid[=<file>|=:<nsid>]   enter pid namespace\n"), out);
 	fputs(_(" -C, --cgroup[=<file>|=:<nsid>]  enter cgroup namespace\n"), out);
-	fputs(_(" -U, --user[=<file>|=:<nsid>] enter user namespace\n"), out);
-	fputs(_("     --user-parent            enter parent user namespace\n"), out);
-	fputs(_(" -T, --time[=<file>|=:<nsid>] enter time namespace\n"), out);
-	fputs(_(" -S, --setuid[=<uid>]         set uid in entered namespace\n"), out);
-	fputs(_(" -G, --setgid[=<gid>]         set gid in entered namespace\n"), out);
-	fputs(_("     --preserve-credentials   do not touch uids or gids\n"), out);
-	fputs(_("     --keep-caps              retain capabilities granted in user namespaces\n"), out);
-	fputs(_(" -r, --root[=<dir>]           set the root directory\n"), out);
-	fputs(_(" -w, --wd[=<dir>]             set the working directory\n"), out);
-	fputs(_(" -W, --wdns <dir>             set the working directory in namespace\n"), out);
-	fputs(_(" -e, --env                    inherit environment variables from target process\n"), out);
-	fputs(_(" -F, --no-fork                do not fork before exec'ing <program>\n"), out);
-	fputs(_(" -c, --join-cgroup            join the cgroup of the target process\n"), out);
+	fputs(_(" -U, --user[=<file>|=:<nsid>]  enter user namespace\n"), out);
+	fputs(_("     --user-parent             enter parent user namespace\n"), out);
+	fputs(_(" -T, --time[=<file>|=:<nsid>]  enter time namespace\n"), out);
+	fputs(_(" -S, --setuid[=<uid>]          set uid in entered namespace\n"), out);
+	fputs(_(" -G, --setgid[=<gid>]          set gid in entered namespace\n"), out);
+	fputs(_("     --preserve-credentials    do not touch uids or gids\n"), out);
+	fputs(_("     --keep-caps               retain capabilities granted in user namespaces\n"), out);
+	fputs(_(" -r, --root[=<dir>]            set the root directory\n"), out);
+	fputs(_(" -w, --wd[=<dir>]              set the working directory\n"), out);
+	fputs(_(" -W, --wdns <dir>              set the working directory in namespace\n"), out);
+	fputs(_(" -e, --env                     inherit environment variables from target process\n"), out);
+	fputs(_(" -F, --no-fork                 do not fork before exec'ing <program>\n"), out);
+	fputs(_(" -c, --join-cgroup             join the cgroup of the target process\n"), out);
 #ifdef HAVE_LIBSELINUX
-	fputs(_(" -Z, --follow-context   set SELinux context according to --target PID\n"), out);
+	fputs(_(" -Z, --follow-context          set SELinux context according to --target PID\n"), out);
 #endif
 
 	fputs(USAGE_SEPARATOR, out);
-	fprintf(out, USAGE_HELP_OPTIONS(30));
+	fprintf(out, USAGE_HELP_OPTIONS(31));
 	fprintf(out, USAGE_MAN_TAIL("nsenter(1)"));
 
 	exit(EXIT_SUCCESS);
-- 
2.53.0

