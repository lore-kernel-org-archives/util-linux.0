Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D730B525
	for <util-linux@vger.kernel.org>; Wed, 29 Oct 2025 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735862; cv=none; b=fXMCcGDFbi6DOJ07tDLqX98T62rtGkdLAsQJcsNzwOOnK/iUHrEeki3ELR2/xEXD2A396vtHC1eDxAejM2sk9mAqsqM9bgWD5q0KW0V4SGM2bEeRZm2K+QreUDTvHRW3LMY5EtUEckbdBLwkhvqqmq4cM+29qUWa/iLBpS8SHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735862; c=relaxed/simple;
	bh=ghOJCLGbdkiyWgthYHCYoOO0d0LmO7CJD1Z5wN3HeYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/yZ9GKXZEYohfNu22G3BQGQb3mePha1Ymz4p6X0hPsbQrBD25Vcs2qpxLI6/lLxN4u2lcpiNq7dCsZMO9TgUhCLLffNAh5ftJ4Fqe3W5FHnOpOTGY5tonVKYXfwue4LYoYvcjiqAaV475F61V1/SOqyHpbkF7bpBcQLqHoJ3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=p7Lukrg5; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="p7Lukrg5"
X-KPN-MessageId: 4adb8636-b4b7-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4adb8636-b4b7-11f0-a27d-005056abbe64;
	Wed, 29 Oct 2025 12:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ikcVLt3dTQwyOkgm3HMgOZZI+Zjta/2eiHflbEY4eMs=;
	b=p7Lukrg57G4nK82xFrK+DrsMyj4ALOkOBR+JlOBvBqhKJBnhECyeTho6KEgW3idCvbyorGMGE+24x
	 4fFn7rmVBvK5Sl8opG86MyFYFkifyZiTEYHfzB5nNvgmrXmh8//d0Fnapip9rqMVcjvcfYcAdXfOME
	 oPH8vpk7RBEUmmsI=
X-KPN-MID: 33|6HZ74Aq1Tx/ugMXTkTaO2NTAaJ9g7oUwq2CC/xuV1KQ8KXMd89LJH7pH+XkjlXP
 ptFVmlsRl+TSb3eHVC9dGnXCcVTRpA5xeVAOHMIAvFzA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RT2QESrH/SEVZZfGqprtP5kC3yLWmS1g6is3DvdBw8nSrwXMSb4ryykzvoSeG4N
 MNfU8I6I2aU7rU+lvOPnsxw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 02069c2d-b4b7-11f0-b8c6-005056ab7584;
	Wed, 29 Oct 2025 12:04:15 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] losetup: remove the --verbose flag, as it doesn't actually do anything
Date: Wed, 29 Oct 2025 12:03:57 +0100
Message-ID: <20251029110358.18170-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029110358.18170-1-bensberg@telfort.nl>
References: <20251029110358.18170-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fourteen years ago, commit c7e0925def rewrote the `losetup` tool,
removing all references to the 'verbose' variable.  Three years
later, commit 60cb2c3720 removed the line 'verbose = 1' because
the compiler complained that the variable was set but never used.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/losetup.8.adoc | 3 ---
 sys-utils/losetup.c      | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
index f51710af8..131ebfa56 100644
--- a/sys-utils/losetup.8.adoc
+++ b/sys-utils/losetup.8.adoc
@@ -106,9 +106,6 @@ Set up a read-only loop device.
 *--direct-io*[**=on**|*off*]::
 Enable or disable direct I/O for the backing file. The default is *off*. Specifying either *--direct-io* or *--direct-io=on* will enable it. But, *--direct-io=off* can be provided to explicitly turn it off.
 
-*-v*, *--verbose*::
-Verbose mode.
-
 *-l*, *--list*::
 If a loop device or the *-a* option is specified, print the default columns for either the specified loop device or all loop devices; the default is to print info about all devices. See also *--output*, *--noheadings*, *--raw*, and *--json*.
 
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 2a3257473..7da0ebbd0 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -501,7 +501,6 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --direct-io[=<on|off>]    open backing file with O_DIRECT\n"), out);
 	fputs(_("     --loop-ref <string>       loop device reference\n"), out);
 	fputs(_("     --show                    print device name after setup (with -f)\n"), out);
-	fputs(_(" -v, --verbose                 verbose mode\n"), out);
 
 	/* output options */
 	fputs(USAGE_SEPARATOR, out);
@@ -730,7 +729,6 @@ int main(int argc, char **argv)
 		{ "raw",          no_argument,       NULL, OPT_RAW       },
 		{ "loop-ref",     required_argument, NULL, OPT_REF,      },
 		{ "show",         no_argument,       NULL, OPT_SHOW      },
-		{ "verbose",      no_argument,       NULL, 'v'           },
 		{ "version",      no_argument,       NULL, 'V'           },
 		{ "remove",       no_argument,       NULL, OPT_REMOVE    },
 		{ NULL, 0, NULL, 0 }
@@ -829,8 +827,6 @@ int main(int argc, char **argv)
 			if (use_dio)
 				lo_flags |= LO_FLAGS_DIRECT_IO;
 			break;
-		case 'v':
-			break;
 		case OPT_SIZELIMIT:			/* --sizelimit */
 			sizelimit = strtosize_or_err(optarg, _("failed to parse size"));
 			flags |= LOOPDEV_FL_SIZELIMIT;
-- 
2.51.2

