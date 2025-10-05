Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033514A4F9
	for <util-linux@vger.kernel.org>; Sun,  5 Oct 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759670529; cv=none; b=CKeFTkyNteFhwgBcan9nLIrS6SKeowM/VFv+S2/aCq1yzcEFrdSi2XQ1uoIc+G9fCFqsFNfrgl1K63dT3pNY8TigUiBUJqrDoQLFqnUb94ggxcqCjOhSK1eOuDH/j//2gtw+LdLe0W60yLifo8o0w2vLpP1MrCZcTboTNJ+S+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759670529; c=relaxed/simple;
	bh=SQBz00eac0VBBEdJd+mJ8L7QOBUXzLoyVk0neeHz/6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epWQ3kEeBADNE8kmGsMtNDOHj8RFdIS8mjKGhVJEJ18h9eiJ7YyM/FNmOgYjQSEwCou8+UvUiqS0VRQERRjW71V2ltXcCmZ9p77TirIBpX7ddgw4hobnLoBUwqqeqmeSDnsPw2Fx4xu3uotufeqxdTRTy1AKYx9aNVOXMDdzZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=YUuwSoiK; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="YUuwSoiK"
X-KPN-MessageId: 3c679ec8-a1ee-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3c679ec8-a1ee-11f0-a27d-005056abbe64;
	Sun, 05 Oct 2025 15:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=EaIEXDzrEuJCtFU+ZpsMgktaTOQ2g1I4BvA8h6gQ6sY=;
	b=YUuwSoiKeka53Xqn72Q2HaRdQf8KsHj99yXY8l4O2OS3CgBmhgTsFA3KMNCsvYm68Y6Yo+cyvwt/C
	 52+A6LbDD2b7eRbYYNysyr8vGNvrGlLLMjZzP6OFPOPtF4yi7y7h7HJ35eV3AvCg1Y00FV5lwDBwWp
	 1H/zdhaLl/d3Ez4w=
X-KPN-MID: 33|EgT7ZyueZWFnTFzm2AY3C60S2XQWLEkUaPaSyb9yoim+4zI7hYk33mJEULyiq6+
 lIeZEWEt48kYCyN5TPZQ5y2JfCpK8oqKIKB5O6TH8KJg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ZF1yQtZFq6/q3MYnFybp+77hQ4v58NnjvThucEGXHvg6cvKX4QzvKloLvVp5SA0
 jkfaX/fdvDDpBHwABOgoznA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1f92769f-a1ee-11f0-a6c9-005056abf0db;
	Sun, 05 Oct 2025 15:20:55 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Subject: [PATCH 1/2] swapon: (usage) make the help text fit within 80 columns again
Date: Sun,  5 Oct 2025 15:20:47 +0200
Message-ID: <20251005132048.78447-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit 72829b08fe added four extra spaces to each description
in the usage text, causing some lines to be wider than 80 characters.
Undo that addition, to make the help text fit again in 80 columns.

Also, put the equals sign for the new --annotation option inside the
square brackets instead of mistakenly before them.

CC: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/swapon.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 1cf8fda2c..896728880 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -830,21 +830,21 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Enable devices and files for paging and swapping.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --all                	enable all swaps from /etc/fstab\n"), out);
-	fputs(_(" -d, --discard[=<policy>] 	enable swap discards, if supported by device\n"), out);
-	fputs(_(" -e, --ifexists           	silently skip devices that do not exist\n"), out);
-	fputs(_(" -f, --fixpgsz            	reinitialize the swap space if necessary\n"), out);
-	fputs(_(" -o, --options <list>     	comma-separated list of swap options\n"), out);
-	fputs(_(" -p, --priority <prio>    	specify the priority of the swap device\n"), out);
-	fputs(_(" -s, --summary            	display summary about used swap devices (DEPRECATED)\n"), out);
-	fputs(_(" -T, --fstab <path>       	alternative file to /etc/fstab\n"), out);
-	fputs(_("     --show[=<columns>]   	display summary in definable table\n"), out);
-	fputs(_("     --output-all         	output all available columns\n"), out);
-	fputs(_("     --annotation=[<when>]     annotate columns with a tooltip (always|never|auto)\n"), out);
-	fputs(_("     --noheadings         	don't print table heading (with --show)\n"), out);
-	fputs(_("     --raw                	use the raw output format (with --show)\n"), out);
-	fputs(_("     --bytes              	display swap size in bytes in --show output\n"), out);
-	fputs(_(" -v, --verbose            	verbose mode\n"), out);
+	fputs(_(" -a, --all                enable all swaps from /etc/fstab\n"), out);
+	fputs(_(" -d, --discard[=<policy>] enable swap discards, if supported by device\n"), out);
+	fputs(_(" -e, --ifexists           silently skip devices that do not exist\n"), out);
+	fputs(_(" -f, --fixpgsz            reinitialize the swap space if necessary\n"), out);
+	fputs(_(" -o, --options <list>     comma-separated list of swap options\n"), out);
+	fputs(_(" -p, --priority <prio>    specify the priority of the swap device\n"), out);
+	fputs(_(" -s, --summary            display summary about used swap devices (DEPRECATED)\n"), out);
+	fputs(_(" -T, --fstab <path>       alternative file to /etc/fstab\n"), out);
+	fputs(_("     --show[=<columns>]   display summary in definable table\n"), out);
+	fputs(_("     --output-all         output all available columns\n"), out);
+	fputs(_("     --annotation[=<when>]  annotate columns with a tooltip (always|never|auto)\n"), out);
+	fputs(_("     --noheadings         don't print table heading (with --show)\n"), out);
+	fputs(_("     --raw                use the raw output format (with --show)\n"), out);
+	fputs(_("     --bytes              display swap size in bytes in --show output\n"), out);
+	fputs(_(" -v, --verbose            verbose mode\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(26));
-- 
2.51.0

