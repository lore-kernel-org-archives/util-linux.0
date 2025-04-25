Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520FD23BCE3
	for <util-linux@vger.kernel.org>; Fri, 25 Apr 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577273; cv=none; b=tcO8RSYlz8luWjj/XLs4Q1g8xyXKGQBPDlCKDZRrROjSbi1E9wAmmGc626PjXUvEtMeQj9ZRyXbt1yCxOimF7B3t8fnweqhxIC7gWEkeWV6X3/fVsFAzYcRxSHps5FkVONwYi85pxpPNRhkgzg4bnI239HbnTRiYgsDePi8MTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577273; c=relaxed/simple;
	bh=sxpuM0GLt8yv0gcVwMhhzFkbll3UsarNqR5gxWDAtXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9Ai2RS46FeIB6Rlx8VXUygMWy1Tbu/p/v51ceAqDzDhF1sTnogi5gdbpt6KmyZySUlRxnPVHR2aJm3R7LRLoGw548GaEff2Lwd+YIk0daCQOwfpCqUq8sgO7SZfrBgPWdqU+yn0gTDwu8tcmQ+OG6rLCHO7WnfeZjkRFHrZLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=MVA7Wvrt; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="MVA7Wvrt"
X-KPN-MessageId: f50fea68-21c0-11f0-bc2a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f50fea68-21c0-11f0-bc2a-005056ab378f;
	Fri, 25 Apr 2025 12:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Ow45osh1e/fV6l+X0rWGdW1cM4sQ0CXk4PmovWACu3M=;
	b=MVA7WvrtxGDVHLrctldb9Hffk7lkLwJEPWZPwAyJCnjwq3k7zGyxrQRRUAVsjamUyJrLOLqwtuKMx
	 6QRRCfZZoAeYtTGISaWSNq0GGmyaDdGBc/EElfu9eqK457MFUqB3vt8AGsO5/A3xQhnw9t6RXxkFlF
	 6cIKQv1CJyJ5vxC0=
X-KPN-MID: 33|v7sqjYI5GU9z1Z3lghj0lhHNtarMD8c2vlEB/dhDmQQ1m5mul002QhDH4lHXwZA
 gusYqz9YMy84i1lxpb1Szh2G74zC+PrqKaALHC4GFhsg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9bmQWmOgtCkVSKsOs1difcCKlSBKFvMhZ92ozeqF8Yi74F4dl/2GXDVGecv1FBc
 ZADGBcZC1bTdh8An14YzdAQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id daef23d5-21c0-11f0-9b83-005056ab1411;
	Fri, 25 Apr 2025 12:34:24 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Nathan Sharp <nwsharp@live.com>
Subject: [PATCH 6/7 V2] pipesz: report default size in --help, instead of referring the user
Date: Fri, 25 Apr 2025 12:34:21 +0200
Message-ID: <20250425103421.11938-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
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
 misc-utils/pipesz.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/pipesz.c b/misc-utils/pipesz.c
index 48f07aed7..6eb5cc001 100644
--- a/misc-utils/pipesz.c
+++ b/misc-utils/pipesz.c
@@ -61,6 +61,9 @@ static char opt_verbose = 0;	/* --verbose */
 
 static void __attribute__((__noreturn__)) usage(void)
 {
+	if (ul_path_read_s32(NULL, &opt_size, PIPESZ_DEFAULT_SIZE_FILE))
+		warn(_("cannot parse %s"), PIPESZ_DEFAULT_SIZE_FILE);
+
 	fputs(USAGE_HEADER, stdout);
 	fprintf(stdout, _(" %s [options] [--set <size>] [--] [command]\n"), program_invocation_short_name);
 	fprintf(stdout, _(" %s [options] --get\n"), program_invocation_short_name);
@@ -71,11 +74,8 @@ static void __attribute__((__noreturn__)) usage(void)
 
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
-- 
2.48.1

