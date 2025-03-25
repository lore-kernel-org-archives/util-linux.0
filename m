Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02B19C558
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899458; cv=none; b=jvKi1Zg/BplWpLgmAVX1HYaFAWqYQMbAo5FtV5xPxCl81YFV+6xUUsztdVsIL8jDxGHQz0mR2gxxMrDlugaZiJAx6tGwbhPwrwidwpMer4nVSTcO3Dn6CuN57yyeV3O1HRkGgYOieybKjkRnpxF9GkcAlxaPeDomm4FxmLIocjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899458; c=relaxed/simple;
	bh=EhHHzakfpk6JvdJXqFDDchcdcXnALrFk7yDvcMu1x0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0c9xWmpTHTcvvjEvL7STltKcB2o6kmjUyIvVCD61PH3xb2Zdc8wc5NjNwbkBoa8pUUBZEIjpkF+i8Tkh6qSd+3rpQ5dOASHqp/H3zRc0eUx/3jh7pYMf0ZAyzdghbJAtuBw0M3I3EFGKuEvJeampMNGNPNEoYGvSPRhxC8ebB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=LBaysM9w; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="LBaysM9w"
X-KPN-MessageId: 27a45bff-0966-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 27a45bff-0966-11f0-86cb-005056aba152;
	Tue, 25 Mar 2025 11:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=GSDsUdGXu7hn0A09kFC/33/Pt6UtDytgzrEDtnpne8E=;
	b=LBaysM9w+jxR5tsGAVv87sclqSBnIF8v52jljd9EIIllREBL4JN9+XMyqULy3KCrTPawrgesmViMf
	 dKA040hJxegVHHFskBdVEq8pUeAkBCyASvpxUmX9PA08YSP9/ByinzrmWvfoRe2oRa6JPxjEzWr80s
	 5LCTDnNh0RFcZr+s=
X-KPN-MID: 33|4Gw7agF7iFeacGKRIYx2v9TtMQXkrygcQKG//BCzmz5WcEuQ1hWFZWOYzdQhITV
 sFOwH4+v165AU6h2Pf2SQonFJ9AgGz/d02OnfPgnZ++g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|M5hkUVEEeeOAePLGHKTs3Bmu3KjUj9hLfr6h/KdttGNsNbl59nFuPLDG5FYbZ5Q
 zlVeHPZyY6J3JSGadyO+EyA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 184eb601-0966-11f0-9b42-005056ab1411;
	Tue, 25 Mar 2025 11:44:14 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/11] mkfs.cramfs: reduce the synopsis to the standard, succinct form
Date: Tue, 25 Mar 2025 11:43:02 +0100
Message-ID: <20250325104305.23980-8-bensberg@telfort.nl>
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

The old synopsis was 1) incomplete (mentioning -h and -v, but not
-V and -E and -z, for example), and 2) overlong, being wider than
80 columns.  So, change the synposis to what most other utilities
nowadays use: "<name> [options] <arguments>..." -- this makes it
much clearer what the two required arguments are.

Also, reshuffle the descriptions of the two arguments, to not hide
them among the options.

And remove the description of option -s, as listing an option that
does nothing is not helpful.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/mkfs.cramfs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 51fa2122a..74f51a280 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -128,10 +128,15 @@ struct entry {
 static void __attribute__((__noreturn__)) usage(void)
 {
 	fputs(USAGE_HEADER, stdout);
-	fprintf(stdout, _(" %s [-h] [-v] [-b blksize] [-e edition] [-N endian] [-i file] [-n name] dirname outfile\n"),
-		program_invocation_short_name);
+	fprintf(stdout, _(" %s [options] dirname outfile\n"), program_invocation_short_name);
+
 	fputs(USAGE_SEPARATOR, stdout);
-	fputsln(_("Make compressed ROM file system."), stdout);
+	fputsln(_("Make a compressed ROM file system."), stdout);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_(  " dirname        root of the filesystem to be compressed"), stdout);
+	fputsln(_(  " outfile        output file"), stdout);
+
 	fputs(USAGE_OPTIONS, stdout);
 	fputsln(_(  " -v             be verbose"), stdout);
 	fputsln(_(  " -E             make all warnings errors (non-zero exit status)"), stdout);
@@ -141,14 +146,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputsln(_(  " -i file        insert a file image into the filesystem"), stdout);
 	fputsln(_(  " -n name        set name of cramfs filesystem"), stdout);
 	fprintf(stdout, _(" -p             pad by %d bytes for boot code\n"), PAD_SIZE);
-	fputsln(_(  " -s             sort directory entries (old option, ignored)"), stdout);
 	fputsln(_(  " -z             make explicit holes"), stdout);
 	fputsln(_(  " -l[=<mode>]    use exclusive device lock (yes, no or nonblock)"), stdout);
-	fputs(USAGE_SEPARATOR, stdout);
-	fputsln(_(  " dirname        root of the filesystem to be compressed"), stdout);
-	fputsln(_(  " outfile        output file"), stdout);
+
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(16));
+
 	fprintf(stdout, USAGE_MAN_TAIL("mkfs.cramfs(8)"));
 	exit(MKFS_EX_OK);
 }
-- 
2.48.1

