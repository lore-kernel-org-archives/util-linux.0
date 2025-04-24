Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598B205E34
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487213; cv=none; b=CcnERwZPS3GCLxhrcHQW3ab7keT0uDcWdQb8bhKJ/h3vO2hbqLMOsZyS2TySHtzdHk87q7uyERR/LsySkFYqVIozvVkyqvPFaNaSoFxsr67ftyXxDS5zQ7uWfZ1pSSK0Pu5ygbVkZf9Rp59YM5NayI+lIgYZQfb6pGqhUKA3FsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487213; c=relaxed/simple;
	bh=G/MAupgB8W4UknLvFXKl79UaXRFu45XjdS2KwFC7jR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIcfJGGc7w2N0Tng/+uY2H4FAqh//rape0ItiirLbGlH+l4iws7HXf4xgHi6bnVyOBWKMtO6O/9SBxqebCkEyfWiZP3VjdGsiq+ByLTvy7B0Aen/xLZiy1CQVX9w2R2uw0/ysUxeY6INPbi1ZuLf536OPOfHZ7GWukMpwJ96anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=A0d5WtbR; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="A0d5WtbR"
X-KPN-MessageId: 5492d64a-20ef-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5492d64a-20ef-11f0-b9a0-005056abbe64;
	Thu, 24 Apr 2025 11:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TnOo4LHvYiB5edq0hqxwZLs3zlE3k1qTyi66/0GKaR0=;
	b=A0d5WtbR25Konh0FShpnMA+6PSH6QY4nGEVWcq0ppoaAN4+SXK5ao8gmfrkorBgwR0x4k9ZvyvHa1
	 u17bGA5VOdQ3MhaQConfOlTZ2SzVjXzJ91vvf9ERNCZkvuROjnCeKeSsvRJlsRsLIEa3vFPDt9f/Sg
	 4JA9PgvUsf9Z5NoA=
X-KPN-MID: 33|xPZgscvR5NauCVH/XIBnWWn5xkFP91OvlBI8IQ2w5wVRzZf206DpLL0oxAj5eMP
 OUB+2ikYEM1DJCbvmBA6kcaAx80HA8v/QOY6SdIRwtHE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|QHXps+cxHswAM9h6sCaTloeh/qlFPYOVRgUn8DlplzbPOxFdDgVwJF8IWeGlhRO
 +VHm1BGtx+pu4nDkJuiE8Gg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2d4623c7-20ef-11f0-95a4-005056abf0db;
	Thu, 24 Apr 2025 11:33:27 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Nathan Sharp <nwsharp@live.com>
Subject: [PATCH 6/7] pipesz: report default size in --help, instead of referring the user
Date: Thu, 24 Apr 2025 11:32:36 +0200
Message-ID: <20250424093237.6432-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424093237.6432-1-bensberg@telfort.nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The man page says where this default size can be found.  In the --help
text it is more useful to directly say what this default size is.

CC: Nathan Sharp <nwsharp@live.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/pipesz.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/misc-utils/pipesz.c b/misc-utils/pipesz.c
index 48f07aed7..c317959e4 100644
--- a/misc-utils/pipesz.c
+++ b/misc-utils/pipesz.c
@@ -71,11 +71,8 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_OPTIONS, stdout);
 	fputsln(_(" -g, --get          examine pipe buffers"), stdout);
-	/* TRANSLATORS: '%s' refers to a system file */
 	fprintf(stdout,
-	     _(" -s, --set <size>   set pipe buffer sizes\n"
-	       "                      size defaults to %s\n"),
-		PIPESZ_DEFAULT_SIZE_FILE);
+		_(" -s, --set <size>   the buffer size to be used (default: %u)\n"), opt_size);
 
 	fputs(USAGE_SEPARATOR, stdout);
 	fputsln(_(" -f, --file <path>  act on a file"), stdout);
@@ -232,6 +229,8 @@ int main(int argc, char **argv)
 	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1) {
 		switch (c) {
 		case 'h':
+			if (ul_path_read_s32(NULL, &opt_size, PIPESZ_DEFAULT_SIZE_FILE))
+				warn(_("cannot parse %s"), PIPESZ_DEFAULT_SIZE_FILE);
 			usage();
 		case 'V':
 			print_version(EXIT_SUCCESS);
-- 
2.48.1

