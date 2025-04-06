Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1321767A
	for <util-linux@vger.kernel.org>; Sun,  6 Apr 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743952940; cv=none; b=nOOU7+bsYeDnGVkYI5YPBLfoL83D37rCwgDlB6tRl+9oCwMMoCCfmcLjIf4B1h5GtZbo6Kj6Cm4JA8icNBLUajJTTvXOtsjh+hvIafUuLBaDJg25wFL+U0yK5/dl2rlzqJdRHjddgPW3DOgA0xI4tnRI6HMpHCYHDxT4mSF/03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743952940; c=relaxed/simple;
	bh=Z5fN9hh9653FR6As3TKtWSEQEXS/Y5lOqDruRQk43WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6q9djEggDPOMkQKEgQ+FYOY2oKgXdT5Sdw+NwoOZ7Z/Sx3PNBl02f8HMIUFy9Llh02b3h7mZ4xwHYK55oclN8VYpo0s7wjJD+et6pgirhcrbm9HHIY/ldqkq/SmZaKfXyEEAocc4sgh0/p83myybM4HLX8R5SVdg2cJbndEcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=dJlmagB7; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="dJlmagB7"
X-KPN-MessageId: 0566ae37-12fb-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0566ae37-12fb-11f0-bc28-005056ab378f;
	Sun, 06 Apr 2025 17:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=r1sEzmH1AJ1Y8X5ZuC67+Ddfkonbr9kOsi79P91d300=;
	b=dJlmagB7xjW2K4e86w5rRzINCqx4N/LGIOL7C7d2Mz1zrBemQ8xIbAUve3/3zbzwCv7SLA5mW2g50
	 M4LL5oo/KlA7jeVdZ26iu5f0WxcMcHjYgk/xN6T9CVzY/it98zW2m3GW7lH4fexpVfbOV3/bftyZYu
	 6w6xmAQ7skbVTIAw=
X-KPN-MID: 33|+gG5V1t3480A7+pIIpru8w2gNVVGFTi1nqtZREqUt54SQRqKKbgMweO3al5EqAI
 EX/zbj1wKQUwDxf/Rsj3vnRpMk2VVN0qllCQzzz5qjug=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|T++qdP671876KSsAMqvM9BnEBr9P8CogY3tnmEeKz+mfsEaCFOnCpAgs+FXX/Ny
 hRzcYLlhNZ8956Y5E0pD20A==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id eb842480-12fa-11f0-9b61-005056ab1411;
	Sun, 06 Apr 2025 17:22:15 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: LiviaMedeiros <livia@cirno.name>
Subject: [PATCH 3/4] zramctl: restore normal description indentations in the usage text
Date: Sun,  6 Apr 2025 17:21:46 +0200
Message-ID: <20250406152147.9225-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406152147.9225-1-bensberg@telfort.nl>
References: <20250406152147.9225-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 19c12e63b1 from four months ago changed the indentation of *all*
the option descriptions in the usage text.  That was the wrong thing to
do, as it invalidates all existing translations for no good reason.

When one of the options is (or needs to become) overlong, then the thing
to do is: to put the description of this option on the next line.

So, restore the indentation of the descriptions to what they were
before commit 19c12e63b1, and wrap the description of -p.

Also, make the description of -b fit within 80 columns, and sort the
options better: alphabetically, but single letter before long option.

CC: LiviaMedeiros <livia@cirno.name>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/zramctl.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 36cc55ff9..b9ea5998e 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -745,17 +745,18 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Set up and control zram devices.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --algorithm <alg>              compression algorithm to use\n"), out);
-	fputs(_(" -b, --bytes                        print sizes in bytes rather than in human readable format\n"), out);
-	fputs(_(" -f, --find                         find a free device\n"), out);
-	fputs(_(" -n, --noheadings                   don't print headings\n"), out);
-	fputs(_(" -o, --output <list>                columns to use for status output\n"), out);
-	fputs(_("     --output-all                   output all columns\n"), out);
-	fputs(_(" -p, --algorithm-params <params>    algorithm parameters to use\n"), out);
-	fputs(_("     --raw                          use raw status output format\n"), out);
-	fputs(_(" -r, --reset                        reset all specified devices\n"), out);
-	fputs(_(" -s, --size <size>                  device size\n"), out);
-	fputs(_(" -t, --streams <number>             number of compression streams\n"), out);
+	fputs(_(" -a, --algorithm <alg>     compression algorithm to use\n"), out);
+	fputs(_(" -b, --bytes               print sizes in bytes, not in human-readable form\n"), out);
+	fputs(_(" -f, --find                find a free device\n"), out);
+	fputs(_(" -n, --noheadings          don't print headings\n"), out);
+	fputs(_(" -o, --output <list>       columns to use for status output\n"), out);
+	fputs(_("     --output-all          output all columns\n"), out);
+	fputs(_(" -p, --algorithm-params <parameters>\n"
+		"                           parameters for the compression algorithm\n"), out);
+	fputs(_(" -r, --reset               reset all specified devices\n"), out);
+	fputs(_("     --raw                 use raw status output format\n"), out);
+	fputs(_(" -s, --size <size>         device size\n"), out);
+	fputs(_(" -t, --streams <number>    number of compression streams\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(27));
-- 
2.48.1

