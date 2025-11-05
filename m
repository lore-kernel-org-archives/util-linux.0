Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A22621CC71
	for <util-linux@vger.kernel.org>; Wed,  5 Nov 2025 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326968; cv=none; b=BUR63+YvEubgoB2LZegzZSo/IKra4yR1sGmQNs11fyZV8dnUjkO8cdxfepbBrD/A6mq3hMifD6K2fDENZZF+BEU7/MQ9FLy7wWqSTLotdXtStVYF8BRwuHOcPfl4eQK/AfQbS7sYJ4HDfIoHEmFPg7OuvymSduS723YUIRlYC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326968; c=relaxed/simple;
	bh=SHzOrvGvfUg4dE8HGT9GL2cNjL8i6j0h5M3fXcKQSaY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BBvZ38DYm0N0qVd2938G/O3shXgsLR0fGFj7r68rF/ACJz+swNe9bZz0TDhvOdUiyvDOQ+PnXyGgCFfw1y5WxeGp+Qc+9lvZ1WQ/Z06so4tq3pDXiv+AlSRJ92KIqvpd1EDv/3FlNeAp4NlQzOPyUAgmVfUZjXUffz+0enPGG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=EU9zcg+b; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="EU9zcg+b"
X-KPN-MessageId: 8d1a6ffb-ba17-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8d1a6ffb-ba17-11f0-a27d-005056abbe64;
	Wed, 05 Nov 2025 08:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jyhc/uj2bYMfqH72HLrdRg0iqSG3gaW5OBXjCOQP+3E=;
	b=EU9zcg+bDakWwlWYgrGEI5CwJKn7AL9W0tZaDyVhMaAqTvy+q4l6qLX9V/EIEgXBtZZt4/6Ssw6rQ
	 3C9ixMbF9D/HtdrNts9Z3y2qqSsta+yJnD4YKOviNSQc95HInRvOU63ZfdG44/LATXciTtBLuTjutM
	 UxoFSbBEdNwLFwpo=
X-KPN-MID: 33|lo/YfnFUeyOnnM+lqaptyvEtvK3hN2E7LY/ezmNAt59sxiPqcFah2IWOP158NdJ
 Wc+7D/n/U0iZZB1ECF5yUc6ppH0bxqdZI/HtOTYGbcWw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vnMmQag22cATu5O6MPk1FBUSdmQE4y5txxtWprQw8JyrCtqyMcrfV2pSJ0qP4De
 82dKMVsrbo6SRU1cSWrPibA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 45345a4b-ba17-11f0-8005-005056ab7447;
	Wed, 05 Nov 2025 08:15:55 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 2/3] losetup: remove the --verbose flag, as it doesn't actually do anything
Date: Wed,  5 Nov 2025 08:15:43 +0100
Message-ID: <20251105071543.3111-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
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
V2: Remove --verbose also from bash-completion and getopt_long() call.

---
 bash-completion/losetup  | 1 -
 sys-utils/losetup.8.adoc | 3 ---
 sys-utils/losetup.c      | 6 +-----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/bash-completion/losetup b/bash-completion/losetup
index 783d966c7..2eedcd767 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -59,7 +59,6 @@ _losetup_module()
 				--read-only
 				--remove
 				--show
-				--verbose
 				--json
 				--list
 				--noheadings
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
index 2a3257473..fe30d70da 100644
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
@@ -753,7 +751,7 @@ int main(int argc, char **argv)
 	if (loopcxt_init(&lc, 0))
 		err(EXIT_FAILURE, _("failed to initialize loopcxt"));
 
-	while ((c = getopt_long(argc, argv, "ab:cdDfhj:JlLno:O:PrvV",
+	while ((c = getopt_long(argc, argv, "ab:cdDfhj:JlLno:O:PrV",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
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

