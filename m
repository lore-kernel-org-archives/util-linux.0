Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60312F8BD3
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185853; cv=none; b=G1iZywUF2gme+98/f0RIx8NNszQmjh3COsY8nRxlB5NigQ0tCYpNlecfJvoqe9D5nfn1XacjkkFVpRqj0LpsZdEtEgOp5kKXcaQw7P/kCTJva9oFc5xvM9X4Uh9fXSnU6qr8pfyaOEccfuLeLqKYxsxobatgVNQhRutfrOoD0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185853; c=relaxed/simple;
	bh=1h09mzDJ16eCu22OJk2S45q8MvJhG2n4d72uI0HFNC4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/tiH6xczb2C1N02Gwt2O8NlWvQHf54CQIiPF2tbCVKNISpCMyeRbRsoUDDaS0bH69Lv9EaHJda3tTMfyxKwdf7fegvwwXnzF+QaZwpBzlW8WR7OfLlTvqnbnz7KRxHi3FsrmXF+m5Uapk5xmndswMJkPt/rzwyN0Q6E5QYMeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=cykW3kNn; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="cykW3kNn"
X-KPN-MessageId: 166918c3-946e-11f0-a4bf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 166918c3-946e-11f0-a4bf-005056abad63;
	Thu, 18 Sep 2025 11:01:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=IBu849lHM1H8V+K/saFrscxXKJFFfQRAA1F5ZQZxavw=;
	b=cykW3kNnNMI2/aIOtyMqyAAllxv56WLvzWhLEca92kGCzi1OyU+ZZ16S62auSAaktoU2wQq0JUcVc
	 pjBnUxHnR8eQQI4SzjN4JuRQt/sYc57CGK3McRxdbOIjb65fUD7I9iA8T3UZKOASGivV9rkfHM0IOZ
	 EANZDY2AUfE4/EAc=
X-KPN-MID: 33|HhFJSQfGLJxI/ZqAG6Jn5Uj5+feqoUWNmLZl+JLradYcUp+qVZk/7m9p0P/rzQg
 GEvID0Xph3lpVvKuK+TjoG7v90rRGmbZyWBU5OymrdJw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+vojwW6wQidi/cb2k1VXZz3z02MCJaCSK1tVnuYRsG2SUYxZrVdgj7qLoZ4hn31
 vyaQVwQOe0w6Eo1LgKuJpFQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 7d3fe151-946d-11f0-abc8-005056abf0db;
	Thu, 18 Sep 2025 10:57:22 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/6] column: (usage) correct the description of --wrap-separator
Date: Thu, 18 Sep 2025 10:57:03 +0200
Message-ID: <20250918085707.41785-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918085707.41785-1-bensberg@telfort.nl>
References: <20250918085707.41785-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Option --wrap-separator does not imply --table-wrap, but requires it
in order to have any effect.

Also, shorten the text a bit to fit within 80 columns.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/column.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 656d4f14a..29ed25b2f 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -1007,7 +1007,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -R, --table-right <columns>      right align text in these columns\n"), out);
 	fputs(_(" -T, --table-truncate <columns>   truncate text in the columns when necessary\n"), out);
 	fputs(_(" -W, --table-wrap <columns>       wrap text in the columns when necessary\n"), out);
-	fputs(_("     --wrap-separator <string>    wrap text at this separator (implies --table-wrap)\n"), out);
+	fputs(_("     --wrap-separator <string>    wrap at this separator (requires --table-wrap)\n"), out);
 	fputs(_(" -L, --keep-empty-lines           don't ignore empty lines\n"), out);
 	fputs(_(" -J, --json                       use JSON output format for table\n"), out);
 
-- 
2.51.0

