Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2327281E
	for <util-linux@vger.kernel.org>; Mon, 16 Mar 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659398; cv=none; b=Dx5deAsIRtFrfRYItuHq/SHzxAPMSxTKFWCA5UvnhGdNuEwm7FGfxLV5rXUMuUe4ItnFKckBzh3ewOJscotw3PpTXrbG0a3G+ZhX0kclMrt2oQx9WBaogIzz/txk7fgdlahdny3+nDU+JviiImmCg2U4IqOp0lAmgu3wOGvp8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659398; c=relaxed/simple;
	bh=kwYzeSz0z6hJIv2Nab8HiC5EhXGIgkQoMqZ/SElA9FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6wGv1tl6YH/lPS4JGzg2TknBFe1vvTRlfqiyodmC2zwwjdKMX6WOkNXbrq0Vxoyvoum71cS+aRcawPLW4sVM/1xb0jx/1Y3n/6GIgqUudenMBaNrzxN7pFYHMNKfISSia0Auwr6qjkn9qI3ROdiudLBL4B2AR+RApu0//2kwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=bEYvxfJ5; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="bEYvxfJ5"
X-KPN-MessageId: a5445798-2128-11f1-8a99-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a5445798-2128-11f1-8a99-005056ab378f;
	Mon, 16 Mar 2026 12:09:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=mX6BNp+u4evCyEoJv/kd+x4QXsL2dpMztxGu2fcggY8=;
	b=bEYvxfJ58XHkk65Ri8+H4RB92NNqFVhjQxWnNP0yd6Bf3t1gUqPnh7+ib+yK5XcptOb4ex2tf2WEP
	 sh6B60awuJR8WBw2O0bW0LPc4o+JPth32rsa5n4qCX02VhD7lDq+E+lqqJ+ypTW5sJxdSgHuIJ3vWv
	 T7eou3bnINAFLxw4=
X-KPN-MID: 33|xp5Sg07oYXDUuVOUMORbyIdf3xgYCb0XAebQlo6LpkE+/sihtghpWdZLx+OmGur
 kgTJdyV5aWCm+HGv5N6DP6c1g6sw8XsSGHGtRjAeu9wg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2OmXKdDA/DQJ/JPV7qBQkVIHXDLrDXysKv/4VATEogRCZbPYFBDNwzHBB1I5FM4
 G4tR8vn3t+BDjFo/cXQdKzw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id a51a5ce0-2128-11f1-8011-005056ab7447;
	Mon, 16 Mar 2026 12:09:47 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 1/2] copyfilerange: wrap some overlong lines (in a tabsize-independent way)
Date: Mon, 16 Mar 2026 12:09:37 +0100
Message-ID: <20260316110938.5119-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most tools in util-linux seem to assume a tabsize of 8, judging from
the alignments of several continuation lines.  But `copyfilerange.c`
appears to have assumed a tabsize of 2, because with a tabsize of 8
the text on line 147 started in column 209!

But even with a tabsize of 2, three lines were much wider than the
reasonable 100 columns.  So, wrap those, and in the bargain improve
the wording of the affected messages, and add a space before %m.

CC: Dick Marinus <dick@mrns.nl>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/copyfilerange.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/misc-utils/copyfilerange.c b/misc-utils/copyfilerange.c
index 20f0373bd..71b21bb28 100644
--- a/misc-utils/copyfilerange.c
+++ b/misc-utils/copyfilerange.c
@@ -135,19 +135,23 @@ static void copy_range(struct rangeitem *range) {
 	uintmax_t remaining = range->length;
 
 	if (range->in_offset > range->in_st_size)
-		errx(EXIT_FAILURE, _("%s offset %"PRId64" beyond file size of %"PRId64""), range->in_filename, range->in_offset, range->in_st_size);
+		errx(EXIT_FAILURE, _("%s offset %"PRId64" is beyond file size of %"PRId64""),
+		                     range->in_filename, range->in_offset, range->in_st_size);
 
 	while (remaining > 0) {
 		const size_t chunk = remaining > SIZE_MAX ? SIZE_MAX : remaining;
 		if (verbose)
-			printf("copy_file_range %s to %s %"PRId64":%"PRId64":%zu\n", range->in_filename,
-							range->out_filename, range->in_offset, range->out_offset, chunk);
+			printf("copy_file_range %s to %s %"PRId64":%"PRId64":%zu\n",
+			       range->in_filename, range->out_filename,
+			       range->in_offset, range->out_offset, chunk);
 
-		const ssize_t copied = copy_file_range(range->in_fd, &range->in_offset, range->out_fd,
-																										&range->out_offset, chunk, 0);
+		const ssize_t copied = copy_file_range(range->in_fd, &range->in_offset,
+		                                       range->out_fd, &range->out_offset, chunk, 0);
 		if (copied < 0)
-			errx(EXIT_FAILURE, _("failed copy file range %"PRId64":%"PRId64":%ju from %s to %s with remaining %ju:%m\n"),
-							range->in_offset, range->out_offset, range->length, range->in_filename, range->out_filename, remaining);
+			errx(EXIT_FAILURE, _("failed to copy range %"PRId64":%"PRId64":%ju "
+			                     "from %s to %s with %ju remaining: %m\n"),
+			                     range->in_offset, range->out_offset, range->length,
+			                     range->in_filename, range->out_filename, remaining);
 		if (copied == 0)
 			break;
 
-- 
2.53.0

