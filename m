Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EA3E5ED0
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072623; cv=none; b=SexDl7Gyzg1VoIFgQpj21YNixTpKp6U5faCCWRW2fMZp32xVaclK3Rj6WmsW15MBI3xh0byRg+LIiDrgHv4dVIlSKsYp6QtSN9pkW1QuKUDlUHynhj9nRimDS/1rBmj4rXwTg014sqTwN8dnYQDC+tr8sMpNsbIplSu+L4MflKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072623; c=relaxed/simple;
	bh=q+DHkmzk72PMQ522rT0tMFg9RirQ+x8soDwTfYI9ZwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBJ1fSkgInKAvMwNFYfiYRinRcUvLJxTzr2JAvyiUtoXdIA3pEvqktnABXkyJSPSXC8w/qZFDWSZ1uaPcU7ATqW1o4LXwRkRbN0lLHwG8Yb/gP6iG/qVbCy4wUoWRvfQvprm0YRrHmNJuPbzGhOYD5/85sASlqlNlrlP9ho33CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=H+zXUhFr; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="H+zXUhFr"
X-KPN-MessageId: 50411a37-1bd2-11f1-b183-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 50411a37-1bd2-11f1-b183-005056abad63;
	Mon, 09 Mar 2026 17:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=7NrmTc92+saJ/1EN4PhpOpY/vL9LWH7Zfkisagm/jjQ=;
	b=H+zXUhFrKTyJHy7DUMHcfvxGgt/8wAzIo8zBqpbgXSX6q6SOgmKqx7ZPkqS/t+0Ufa0NcKorQnvdW
	 MCgeiTeQnfLRoChZ1WLFG29mR/ATi7IV/0vsT/CbvLPa5zZXTfLbo1+aqTyJCnReW0PEvZ8U/OVxX2
	 DhHiZH1twiFUJWS4=
X-KPN-MID: 33|YaXnW8krLz2hfyZ2q5rUHwRFH24hNTBJbYBOxMun2gaIFQq3pczcHDTWYAkRHN/
 tU4kEKdPa3gDs6/Sr/2hXig==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|WWRVbktaxzaQzYc/AO2CmjnD8NlTp2ga8gnnuIZya7Y2AXtYwKRmJcYAky1nYc9
 9ltqysvwTbykKkmtoVNrlkw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5021709a-1bd2-11f1-a6cb-005056abf0db;
	Mon, 09 Mar 2026 17:09:12 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 1/2] copyfilerange: (usage) correct the markup and improve the wording
Date: Mon,  9 Mar 2026 17:09:02 +0100
Message-ID: <20260309160903.15490-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The <source>, <destination>, and <range> arguments are required,
so do not mark them as optional (with the square brackets).
Also, trim the redundant lines about the source and destination
files, improve the explanation for the <range> argument, and
keep the text within 80 columns.

Furthermore, list the short options first (as is custom), and
match the indentaion of the -h and -V options to the others.

CC: Dick Marinus <dick@mrns.nl>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/copyfilerange.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/misc-utils/copyfilerange.c b/misc-utils/copyfilerange.c
index 20f0373bd..a72c81cd1 100644
--- a/misc-utils/copyfilerange.c
+++ b/misc-utils/copyfilerange.c
@@ -55,25 +55,23 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-		_(" %1$s [options] [<source>] [<destination>] [<range>...]\n"),
+		_(" %1$s [options] <source> <destination> <range>...\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputsln(_("Copy file ranges from source to destination file."), out);
+	fputsln(_("Copy the specified range(s) from source to destination file."), out);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputsln(_(" source                      source filename"), out);
-	fputsln(_(" destination                 destination filename"), out);
-	fputsln(_(" range                       source_offset:dest_offset:length, all values are in bytes"), out);
-	fputsln(_("                             if length is set to 0 as much as available will be copied"), out);
-	fputsln(_("                             when the offset is omitted the last file position is used"), out);
+	fputsln(_("Each <range> is of the form <source_offset>:<destination_offset>:<length>,\n"
+	          "with all values in bytes. If <length> is 0, as much data as available will\n"
+	          "be copied. When an offset is omitted, the last file position is used."), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputsln(_(" --ranges, -r filename       read range(s) separated by newlines from filename"), out);
-	fputsln(_(" --verbose, -v               verbose mode"), out);
+	fputsln(_(" -r, --ranges <file>     read range(s) separated by newlines from this file"), out);
+	fputsln(_(" -v, --verbose           verbose mode"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-	fprintf(out, USAGE_HELP_OPTIONS(16));
+	fprintf(out, USAGE_HELP_OPTIONS(25));
 
 	fprintf(out, USAGE_MAN_TAIL("copyfilerange(1)"));
 	exit(EXIT_SUCCESS);
-- 
2.53.0

