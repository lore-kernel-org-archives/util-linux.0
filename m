Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864C802
	for <util-linux@vger.kernel.org>; Mon, 24 Feb 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402558; cv=none; b=baPjKSknbhPNpVgzAu3/g0yqXVu2t58rVGTPj2PB7yTszpyKw7HDubUb4CpgiKw+6wjcA84Ty/G4m0KvJMzuyt4VKrgCFoTPYmtg+JGOPEJRZyfK+sgMrk1IGZzsPb5ntef3Qgslm7lOWP5KAYONZCsmQuaav3Y/5yCKFjPS22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402558; c=relaxed/simple;
	bh=Afh9ZxbsjI/JJXzNbbP1YUw6Eb4boi3BUxCXpWlX7Ms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDwS1TBx+lr9QsYrSe9VgpE3FAxLQuMCIPsPUyhCY4OyqNY/EX1tKzg7sZq4pR8evojIcU+gw6sExmz+SJndSG1695DzL/NZJwXgWkZ292d2byWfkFuDyRZbc8kX7l2Wps0RTMoP++17P4zcRcbGBkNnz2U+OqY0Z1jgKPx7GhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=PVU90qCz; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="PVU90qCz"
X-KPN-MessageId: 9004d504-f2b0-11ef-b99e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9004d504-f2b0-11ef-b99e-005056abbe64;
	Mon, 24 Feb 2025 14:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=uD4DcFWpXEtpMZWNqYUFGXFMdJhU+Ji3BupbWG/E90E=;
	b=PVU90qCziL079lnaPT2VLUyJxMtIKiD/+B2NNix7b4nToTjoHw8Z26ZU3NYTpaUNhhWYi7ZrVuJ/s
	 IyhclkiG+RR+iXf2uGlP0vlg0YDVG/wMCkfhp8b7vzZAkvoR0LL82vit/3+/a4za6YL/ZJ7NG9WvPO
	 YWR9sHN4HjjB39rk=
X-KPN-MID: 33|celd092NuOJUqjV168qrqJgw5vSPl+DLBeTRvNZrduaNaxJm43EVmVYRpfe8Wdv
 v+J3xY8WCIXKEideCsrnVFX1eTljbXV1y4/XNnl9HAvI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2uhXJ2I+JTyJp/GU6nhmKcqq9X3F9hWoUwjb62211gEeuDD7fnwUQe3Q8F8a8ja
 YB4mgypjxj9MdaM6rMbYdoQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8b42d7a3-f2b0-11ef-849d-005056ab7584;
	Mon, 24 Feb 2025 14:09:13 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] scriptreplay: reduce two usage synopses to one, and drop the -t from it
Date: Mon, 24 Feb 2025 14:08:37 +0100
Message-ID: <20250224130840.25770-3-bensberg@telfort.nl>
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

Those two synopses still did not express several possible forms:

    scriptreplay -m.1 timings
    scriptreplay typescript -t timings -m.1
    ...

So, instead of trying to cover all possibilities, just give the
basic form of the command, which is clearest and most helpful.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/scriptreplay.1.adoc | 2 +-
 term-utils/scriptreplay.c      | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/term-utils/scriptreplay.1.adoc b/term-utils/scriptreplay.1.adoc
index acfde6ca8..7665d28f8 100644
--- a/term-utils/scriptreplay.1.adoc
+++ b/term-utils/scriptreplay.1.adoc
@@ -13,7 +13,7 @@ scriptreplay - play back typescripts, using timing information
 
 == SYNOPSIS
 
-*scriptreplay* [options] [*-t*] _timingfile_ [_typescript_ [_divisor_]]
+*scriptreplay* [options] _timingfile_ [_typescript_ [_divisor_]]
 
 == DESCRIPTION
 
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 5751e1b52..7e1eec7db 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -47,10 +47,7 @@ usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [options]\n"),
-	      program_invocation_short_name);
-	fprintf(out,
-	      _(" %s [-t] <timingfile> [<typescript> [<divisor>]]\n"),
+	      _(" %s [options] <timingfile> [<typescript> [<divisor>]]\n"),
 	      program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -71,6 +68,8 @@ usage(void)
 	fputs(_(" -m, --maxdelay <num>    wait at most this many seconds between updates\n"), out);
 	fputs(_(" -x, --stream <name>     stream type (out, in, signal or info)\n"), out);
 	fputs(_(" -c, --cr-mode <type>    CR char mode (auto, never, always)\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(25));
 
 	fputs(USAGE_SEPARATOR, out);
-- 
2.48.1

