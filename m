Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49319C558
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899466; cv=none; b=BX4r3SChnY4Dj4ZGQIAvnxJ+U93rTTVLdIJeV/8D6FGUT5sofRzm4OECHL5kJ+Efi9Yi1EkFkmFdFfuZYdBv2LwgS6QaugdKICGGv3V8rdo/Kb4cl0FqkmYh4bpoUFKMlhpaD3rSiG66qxhNmFGCB+IjE/x4ZweAQkmY20yfNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899466; c=relaxed/simple;
	bh=H2LQo5X6Tw6O0cawEgG1PCC0tq60yBzyvhmMMLtMwB8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QngNOLq7nAbWKF6TnxbGoau0Ih4uUAJt8bvo1T6kCllrJ8NYcfgw2lQ8WFwTRw6PqQFJqkW0rRxdFHII4qxYStZim2A4D5pSk+BvV93uDg7VgwjBYuuZVQ7bvFvk/WPEMcvNEWyDRZOj1DFRKhNw3HDDrq3dGmL7x4SxIaFbDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=G/UZb0Dq; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="G/UZb0Dq"
X-KPN-MessageId: 38763e6a-0966-11f0-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 38763e6a-0966-11f0-b99f-005056abbe64;
	Tue, 25 Mar 2025 11:45:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=30wdDkPL5aojAT+CetbMl/LlJaZUeslkTCto7al9Pow=;
	b=G/UZb0DqweAKdcQermNhtZzw/q0GqJ7/X0xwYqOff8m57GL+GmMJke0jzBs2g0IzKcy35jZT54BMb
	 ibjhPAHf3thXqAdNPbGn/SFy2PIXFEbMeaHkmMvmqA+zi4WDxjNZYjK8L6hu2bNfeJY41HLWReb3tk
	 YGJvXg7ZmKBhCJf0=
X-KPN-MID: 33|xT7HEahvNYIiL1/o6Bd9Oz+7Yn83Uy75LstI77B0w8ngEOeiYApU/kVBG/nUlnG
 fIJ+vQAObjabhIGXwVJsGbkmqKB7G2LB7+HHLdikSxuA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Bw/nN8wy+eq39zExivGZxaolETGvkPBMal9SWDwKf6fPVXhRdiCWdtbn26wm7JB
 1PMeGXkAzZ37QocSnSjTScw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1d74c6cf-0966-11f0-9593-005056abf0db;
	Tue, 25 Mar 2025 11:44:23 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/11] mkfs.cramfs: vertically align the option descriptions of the usage text
Date: Tue, 25 Mar 2025 11:43:03 +0100
Message-ID: <20250325104305.23980-9-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325104305.23980-1-bensberg@telfort.nl>
References: <20250325104305.23980-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And trim unneeded whitespace.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/mkfs.cramfs.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 74f51a280..c8130055d 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -134,20 +134,22 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputsln(_("Make a compressed ROM file system."), stdout);
 
 	fputs(USAGE_SEPARATOR, stdout);
-	fputsln(_(  " dirname        root of the filesystem to be compressed"), stdout);
-	fputsln(_(  " outfile        output file"), stdout);
+	fputsln(_(" dirname        root of the filesystem to be compressed"), stdout);
+	fputsln(_(" outfile        output file"), stdout);
 
 	fputs(USAGE_OPTIONS, stdout);
-	fputsln(_(  " -v             be verbose"), stdout);
-	fputsln(_(  " -E             make all warnings errors (non-zero exit status)"), stdout);
-	fputsln(_(  " -b blksize     use this blocksize, must equal page size"), stdout);
-	fputsln(_(  " -e edition     set edition number (part of fsid)"), stdout);
-	fprintf(stdout, _(" -N endian      set cramfs endianness (%s|%s|%s), default %s\n"), "big", "little", "host", "host");
-	fputsln(_(  " -i file        insert a file image into the filesystem"), stdout);
-	fputsln(_(  " -n name        set name of cramfs filesystem"), stdout);
-	fprintf(stdout, _(" -p             pad by %d bytes for boot code\n"), PAD_SIZE);
-	fputsln(_(  " -z             make explicit holes"), stdout);
-	fputsln(_(  " -l[=<mode>]    use exclusive device lock (yes, no or nonblock)"), stdout);
+	fputsln(_(" -v             be verbose"), stdout);
+	fputsln(_(" -E             make all warnings errors (non-zero exit status)"), stdout);
+	fputsln(_(" -b blksize     use this blocksize, must equal page size"), stdout);
+	fputsln(_(" -e edition     set edition number (part of fsid)"), stdout);
+	fprintf(stdout,
+	        _(" -N endian      set cramfs endianness (%s|%s|%s), default %s\n"), "big", "little", "host", "host");
+	fputsln(_(" -i file        insert a file image into the filesystem"), stdout);
+	fputsln(_(" -n name        set name of cramfs filesystem"), stdout);
+	fprintf(stdout,
+	        _(" -p             pad by %d bytes for boot code\n"), PAD_SIZE);
+	fputsln(_(" -z             make explicit holes"), stdout);
+	fputsln(_(" -l[=<mode>]    use exclusive device lock (yes, no or nonblock)"), stdout);
 
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(16));
-- 
2.48.1

