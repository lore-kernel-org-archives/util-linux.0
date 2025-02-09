Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1296FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089525; cv=none; b=pqkcqxDyUe3UBGJleAsi1PhVicVAQJGv+FIyaOTZBSoeOx30aIyFZEDrcrTyyBN3U80s7IMq4qBiastUMcyboJgmNzC+5jFSaPbEAsJFAbMasG4o2kuoFdOhr93wPtneWqzkjZUSim7HryLbhwgVugOAQXahBjYD7CvS0nPQF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089525; c=relaxed/simple;
	bh=dhJL7v6CutEPUn+eprjT7iJSecR8mzB4p8lnyWJL6I8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAlkfRQ57V5BVGO0fZRh24nuETSMHZaE1pfztu56vq8k+1SNnGyzUse9VsM7/W4hnCzThwYM7Q2hl1WLD+1cKdHIwYydARBIEHVNeoZEaWVDvgkomDm+8P+2wC8wY2jZF8IK2JjvS1tdzsZtdcEcBMTT7iSECPWXEotD2OEe9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=lET5wXg6; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="lET5wXg6"
X-KPN-MessageId: b5209079-e6bf-11ef-87ce-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b5209079-e6bf-11ef-87ce-005056abbe64;
	Sun, 09 Feb 2025 09:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=YSn38ohRg6fQutZuAl/Dmi/SjUgatVNHpW3RjtQBbZ8=;
	b=lET5wXg6AE8+386Nf71L0oC8V0QUI+zZCCxGYt3vAS064MqcfEE7xK0Inw/BXPk2cOJIZo3mCL04w
	 oXHrNV9EvBS/0uuHRx2TdXzK/YE7OqU2qE5oDcTvOYILc23qRG5L3i0JmJBmtwLtK/1NoIab5eT+6v
	 o1MDQYUs26hnt6Pk=
X-KPN-MID: 33|iaBEcbd3lXdw9kLtTQjPrlxo2ejot9DgUrDHJtaHX1rRdPXWrK085U8WI7U746q
 QHng02tyjJYmD0Jq4D37NYhwfxqQmsoxMyB7d894mRc4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HbJ6Z7wkobfT8h7SRHbxduK4Hl7yvoVMPPewysROkAJ9fnaPJVlx2in0jDmkxWb
 RF6yxaTWwHDZ97w/UqDAW9g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 67b6f697-e6bf-11ef-8e50-005056ab7584;
	Sun, 09 Feb 2025 09:25:22 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/14] blkpr: grammarize the description of the tool and its options
Date: Sun,  9 Feb 2025 09:23:25 +0100
Message-ID: <20250209082330.4235-9-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/blkpr.8.adoc |  9 +++++----
 sys-utils/blkpr.c      | 14 +++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/sys-utils/blkpr.8.adoc b/sys-utils/blkpr.8.adoc
index 0f71bd0f0..db2b8a0a9 100644
--- a/sys-utils/blkpr.8.adoc
+++ b/sys-utils/blkpr.8.adoc
@@ -8,7 +8,7 @@
 
 == NAME
 
-blkpr - run persistent reservations command on a device
+blkpr - run a persistent-reservations command on a device
 
 == SYNOPSIS
 
@@ -16,15 +16,16 @@ blkpr - run persistent reservations command on a device
 
 == DESCRIPTION
 
-*blkpr* is used to run persistent reservations command on device that supports Persistent Reservations feature.
+*blkpr* is used to run a persistent-reservations command on a device
+that supports the Persistent Reservations feature.
 
 The _device_ argument is the pathname of the block device.
 
 == OPTIONS
 
 *-c*, *--command* _command_::
-The command of persistent reservations, supported commands are *register*, *reserve*, *release*, *preempt*,
-*preempt-abort*, and *clear*.
+The command for managing persistent reservations. Supported commands are:
+*register*, *reserve*, *release*, *preempt*, *preempt-abort*, and *clear*.
 
 *-k*, *--key* _key_::
 The key the command should operate on.
diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index 7f88eba50..03ca9f7e5 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -213,12 +213,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	      _(" %s [options] <device>\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_("Persistent reservations on a device.\n"), out);
+	fputs(_("Manage persistent reservations on a device.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -c, --command <cmd>      command of persistent reservations\n"), out);
-	fputs(_(" -k, --key <num>          key to operate\n"), out);
-	fputs(_(" -K, --oldkey <num>       old key to operate\n"), out);
+	fputs(_(" -c, --command <cmd>      command for persistent reservations\n"), out);
+	fputs(_(" -k, --key <num>          key to operate on\n"), out);
+	fputs(_(" -K, --oldkey <num>       old key to operate on\n"), out);
 	fputs(_(" -f, --flag <flag>        command flag\n"), out);
 	fputs(_(" -t, --type <type>        command type\n"), out);
 
@@ -227,13 +227,13 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_ARGUMENTS, out);
 
-	fputs(_(" <cmd> is an command, available command:\n"), out);
+	fputs(_(" <cmd> is a command; available commands are:\n"), out);
 	print_pr_command(out);
 
-	fputs(_(" <flag> is a command flag, available flags:\n"), out);
+	fputs(_(" <flag> is a command flag; available flags are:\n"), out);
 	print_pr_flag(out);
 
-	fputs(_(" <type> is a command type, available types:\n"), out);
+	fputs(_(" <type> is a command type; available types are:\n"), out);
 	print_pr_type(out);
 
 	fprintf(out, USAGE_MAN_TAIL("blkpr(8)"));
-- 
2.48.1

