Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3B18B46E
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414317; cv=none; b=HpXPBsVDhVK/8LNY35TL3j/dcaVgT9u2yWPTdYkaHxSjyes8xeZ9nkGQ5y9mQXpyj9mjIWzdKasNFXUKQOokVtUkAKyudVRbcXPJdeR7qYgQFmUNZSw1Xue8E0ZUJSDo4I3ibOrX/MyR2uVJFxHsnD2+GXKStWKLXthsaUZM5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414317; c=relaxed/simple;
	bh=oX1ZNUKfCk9x6JZAWKoO9Bs1iUIorupxALTRcwY4F3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUQ00wjHGLDOequZE8SKd1prkEmfx2otEAVX3EJMeAYECZ/s6sorKEYEnepzPiVPbN2Sdjl0ceQjSgdtKz3M4CbUdF7EvXYcWKxzwn+kj2CD4Vcdt+y9q+v1TqcUkhXtZ76Ud6ej0yYzJokQ6F4jXAzAhyb1TnsjzE7ZKZTqAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=jh6OJaTH; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="jh6OJaTH"
X-KPN-MessageId: e93280da-0e14-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e93280da-0e14-11f0-86cb-005056aba152;
	Mon, 31 Mar 2025 11:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=kTKIiePZeO0/L/5aSpaE4uYOzU2SBx14N6bZZqtIhpo=;
	b=jh6OJaTHvYN9rh4qyPDCdojADEOgg60B30K58DW/jc4xXJm5qfxezUfYqNwz62WPPh5YAYl1GHoay
	 iDh210joPOOdQRU3Y28FwbJv0XZfpw4jf8imDatm5u6Oq8Cnb/F9w7h9hHlOO7Pjpdk5p88d5vEZzV
	 rarxVVgE3oOYXrXQ=
X-KPN-MID: 33|T3NYeEwBafUjQYCRMGeye4ZJwVwMFwRwrmcUUkPUJYd5KhkygfvhEA54h7JDXh0
 uLXyigWZ3O4A3CXT1kU8rgkVD08JY7VKC3/pIzVt41ok=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nhEX5FtGBopfvngPswXFoR94NKqkkVwaPJJfus+wsz49ZB9HaImFRF/tY8p4sBl
 1lwIzfct/gsbwTMWBZgfPmg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d7f68869-0e14-11f0-8516-005056ab7584;
	Mon, 31 Mar 2025 11:45:13 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Joe Jin <joe.jin@oracle.com>
Subject: [PATCH 04/10] irqtop: improve the description of --batch, and align it with others
Date: Mon, 31 Mar 2025 11:44:37 +0200
Message-ID: <20250331094443.9619-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also improve the description of --delay and tweak the one of --json,
and align both descriptions with the preceding ones.

CC: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/irqtop.1.adoc | 7 ++++---
 sys-utils/irqtop.c      | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 880ee1906..04158a0ef 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -26,7 +26,8 @@ The default output is subject to change. So whenever possible, you should avoid
 Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
 
 *-b*, *--batch*::
-Starts irqtop in batch mode, which could be useful for sending output to other programs or to a file.
+Send the produced tables to stdout instead of to a static screen.
+This can be used for sending the output to other programs or to a file.
 
 *-c*, *--cpu-stat* _mode_::
 Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*, *disable*. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enough to show a full line of statistics.
@@ -35,10 +36,10 @@ Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*
 Specify cpus in list format to show.
 
 *-d*, *--delay* _seconds_::
-Update interrupt output every _seconds_ intervals.
+Update the tables every this number of seconds.
 
 *-J*, *--json*::
-Use JSON output format. irqtop will run in batch mode.
+Use JSON output format. Implies *--batch*.
 
 *-n*, *--iter* _number_::
 Specifies the maximum iterations before quitting.
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 751e9e19b..e0abddd82 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -306,11 +306,11 @@ static void __attribute__((__noreturn__)) usage(void)
 	puts(_("Interactive utility to display kernel interrupt information."));
 
 	fputs(USAGE_OPTIONS, stdout);
-	fputs(_(" -b, --batch batch mode\n"), stdout);
+	fputs(_(" -b, --batch           send tables to stdout, not to a static screen\n"), stdout);
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
-	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
-	fputs(_(" -J, --json  use JSON output format (will run in batch mode)\n"), stdout);
+	fputs(_(" -d, --delay <secs>    wait this number of seconds between updates\n"), stdout);
+	fputs(_(" -J, --json            use JSON output format (implies --batch)\n"), stdout);
 	fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
-- 
2.48.1

