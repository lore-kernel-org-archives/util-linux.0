Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAB802
	for <util-linux@vger.kernel.org>; Mon, 24 Feb 2025 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402583; cv=none; b=t2lPcLa+WZv6tNBawgca3IfP3N5TU+sU6Y7WI38erRg7qz7Kp6m8ZN3EBdDL4R7a1v49pVfdvOd8+wTdC4xk+1+EHG8laNbg95DVatmUps00TY81YIYiUonHgy1X49zCt8j4IRNawCSg7zLdSvnRoWOTKk+CL/kp+Jwu+IYQBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402583; c=relaxed/simple;
	bh=ESl9e4vBg9aqE7mjl/sEqT8mteetfveIra9fO+4XJFM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+6MhEF8C6h0DWKzpdmtAJR/fLO9YgWGD28jLgUdMcVe8MxEhOqazFx6RGClj+LM33GGE+QkfFPFdqK7A+V3G+TW7/CYDxaGpr0fmg7n4lAWynLeogeubmemOfjaOvhrRR7edPDJl8JLQYPCU8v2lbMO9M76WlTV5dPRXFxSvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=dUz3fcS8; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="dUz3fcS8"
X-KPN-MessageId: 9ee7f559-f2b0-11ef-b99e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9ee7f559-f2b0-11ef-b99e-005056abbe64;
	Mon, 24 Feb 2025 14:09:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=MCYTFSLm/8xZBQqlutGTffNwTVCRUQ+kio/McWxM7W0=;
	b=dUz3fcS8ZzgXHO2hgcOF+z+63JlyXRTvgREehhW8B1P8vFisPt78LjdAwanC58H8REKxuwy1UKZ/U
	 kZ6Yv3oYzEI368juWMw9C6MnH9eJap/FmQKjz6WmTooEhi6V8oEIMV2OjNFgwFPIZ5HXeIaLqVO0+v
	 qSEhsOzGn5SahJBw=
X-KPN-MID: 33|cmuW06uAu3DZo1bLSJajrPTfekDXMUNXlagoVr2eEOW9dkckdokWg5erBExngnp
 ESL90y+IgS2vWcNTMZ/1WVg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Ebei6NsIgcGDQi6XofPaBOgq9W57GJZqWV6tp0LBYURH6OxCgwR1O41jtEfHZdW
 Miy9113dorGmwFrJH4Wt5Aw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 9a273aaf-f2b0-11ef-9583-005056abf0db;
	Mon, 24 Feb 2025 14:09:38 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] scriptlive: reduce two usage synopses to one simple one
Date: Mon, 24 Feb 2025 14:08:39 +0100
Message-ID: <20250224130840.25770-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224130840.25770-1-bensberg@telfort.nl>
References: <20250224130840.25770-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No synopsis can show all possible permutattions of arguments and
options, so do not even try and just give the most basic form,
without unneeded -t, -I, or -B.

Also, use angle brackets to show that <timingfile> and <typescript>
are placeholders.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/scriptlive.1.adoc | 2 +-
 term-utils/scriptlive.c      | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/term-utils/scriptlive.1.adoc b/term-utils/scriptlive.1.adoc
index 1efb429bb..58aeb4ce1 100644
--- a/term-utils/scriptlive.1.adoc
+++ b/term-utils/scriptlive.1.adoc
@@ -13,7 +13,7 @@ scriptlive - re-run session typescripts, using timing information
 
 == SYNOPSIS
 
-*scriptlive* [options] [*-t*] _timingfile_ [*-I*|*-B*] _typescript_
+*scriptlive* [options] _timingfile_ _typescript_
 
 == DESCRIPTION
 
diff --git a/term-utils/scriptlive.c b/term-utils/scriptlive.c
index 1b0bf96cb..e4a3434ed 100644
--- a/term-utils/scriptlive.c
+++ b/term-utils/scriptlive.c
@@ -54,10 +54,7 @@ usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [options]\n"),
-	      program_invocation_short_name);
-	fprintf(out,
-	      _(" %s [-t] timingfile [-I|-B] typescript\n"),
+	      _(" %s [options] <timingfile> <typescript>\n"),
 	      program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -74,6 +71,8 @@ usage(void)
 	fputs(_(" -d, --divisor <num>     speed up or slow down execution with time divisor\n"), out);
 	fputs(_(" -E, --echo <when>       echo input in session (auto, always or never)\n"), out);
 	fputs(_(" -m, --maxdelay <num>    wait at most this many seconds between updates\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(25));
 
 	fprintf(out, USAGE_MAN_TAIL("scriptlive(1)"));
-- 
2.48.1

