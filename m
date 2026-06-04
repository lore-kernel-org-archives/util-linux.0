Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD7380FEC
	for <util-linux@vger.kernel.org>; Thu,  4 Jun 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566799; cv=none; b=qlAODv6qz5CFsC0+lYl4kMqjHlSFcoomTpvuLNOw2o0hWxWr3omnV/VKSbDqyJc2+r1V2jUQq55Ka1YCYYysukS/wFz+jAoO0087SGu+1l9j7ekvMBhH0PMnsXhn9ZxOHLUjOR/VC8ECVoOWF1r4w5KeB4axeiQS9Dgxu5ETqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566799; c=relaxed/simple;
	bh=38lvjwTcKFbxPY5EZSU0ePC0QTrQU4DfMNmyO69RL94=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O4qWTZuvz5+glLDnkfK/5CI0ZhrETxLKGeTFCdSMvHwgB1axtas3OVpzQQfsswj+fLdPCSRqzlN91XsBZashAVu3gYfrMz6FNWW6vj8TC5ky2CvX7F/OpRuawZ6sKUH+mJcRbbl4XaF0BmvRYsH6toupvmdJUuzVoHRDNAMRGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=txrZFLml; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="txrZFLml"
X-KPN-MessageId: 2fa7cc73-5ffb-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2fa7cc73-5ffb-11f1-96a9-005056abbe64;
	Thu, 04 Jun 2026 11:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=MSw2ot8ckFwl7gnlfC4v4p0w5HFhR98nG6nhkwV4M/c=;
	b=txrZFLml5/XWNrGx7NG4hQGH75l+AuaZP+jA4+PtPQ7G8qPmXXZvijfwudekY0ms4vHdzMBoFwsSH
	 5QEKgQ/2xmc8gXdDiZqEn5EL7+E0l48eIntB9SEIQGwdG6/e0b8Evee4FTsmUYpW+MeT9t6sJZYFcB
	 54plDz4SYwM5hA4M=
X-KPN-MID: 33|pQg9p4dgEGVbq3B/Jsv318SHLyjnpIdAf41Q65VFNKPFzLsaHYcYnaEaZphpEny
 t50BheTiqYJ8XFSY0DsXBSA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ehj36Q9t/yW2M1MycEhX0TkVDRp0ktxR5/wTQvg5V7tYkHZOPBvDEhax9WpKecH
 79VgBrFk9BkiLD0kxnAkePg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2fa39d88-5ffb-11f1-bdb3-005056ab1411;
	Thu, 04 Jun 2026 11:53:06 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] lsmem: (usage) list possible values for <when> like for the other <when>
Date: Thu,  4 Jun 2026 11:52:50 +0200
Message-ID: <20260604095252.162210-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That is: use vertical bars between the values instead of commas and "or".

(Noticed because of the missing space before "always".)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/lsmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index d8196215c..c3c39e8cb 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -678,7 +678,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -r, --raw                 use raw output format\n"), out);
 	fputs(_(" -S, --split <list>        split ranges by specified columns\n"), out);
 	fputs(_(" -s, --sysroot <dir>       use the specified directory as system root\n"), out);
-	fputs(_("     --summary[=<when>]    print summary information (never,always or only)\n"), out);
+	fputs(_("     --summary[=<when>]    print summary information (always|never|only)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(27));
-- 
2.54.0

