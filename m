Received: from out-utut-a192.jellyfish.systems (out-utut-a192.jellyfish.systems [198.177.127.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E82495AFB
	for <util-linux@vger.kernel.org>; Wed, 16 Sep 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579581; cv=none; b=I7xb6ufGKZQgHlxLUCYnt4EYSMZSLUVbYU2NUMX5G+iNVSKJav6kAVB7hv/z68WRQ1bn6DlReoy0NShxu43CgW88g0qSlRqX08ZFrp8a/qB4WsdG0wv0zafQnfJt8xsFSRqYwIkVKhUBTM2issXynlrR4xcn9Qm9wmEFH4ylgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579581; c=relaxed/simple;
	bh=LFoPHNKHZi3EcDvumD4/5emd8rym68gHwTniOVjPndI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRlqOR6x0wc03c5dV5URIj7CYEVd14Av9L2islUcYCnxIKN5hAqqfCIgtyLOQQpV73O3AQEokGQki3oGxhdnDNFe4NmH2Vj68RNiygZGYHwp6uaktFLdWO97KL7lNH3Oz22OxexaL+A+Vq/uPxc6lTQOyuDwWZgpOpaxVoxB94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=nLExfA/h; arc=none smtp.client-ip=198.177.127.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="nLExfA/h"
Received: from fedora (unknown [117.147.120.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hlQHn5vL0z2x9B;
	Wed, 16 Sep 2026 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789578328;
	bh=g7+RUvwmS6qNEju/yHBCcDA5InLmFSGAfwZLJP3NRhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLExfA/h0FVlQKe9ZMq+aAPjBke45BomSrm0QkqR8XSMAmxiIUq3fZKw/yVEiooSV
	 sWRdlp+huhT/+yWPO+ETpb7srvsuaiQINZl+x+pSYoetJq+925BF+fAJMneTWMrQ+D
	 x2aSC47wskYhPD7Gw6JG8L2amPDo5nw53c4mmAQOND40IjBIZIUke4AlcEII9TECNB
	 DMxF/6UtcQAE9sYBo4wH+GvnyyXYcsd91l5r9OcT0C/qTRls+spqeeiK+6BhYvxd4g
	 6CWYLxO7MLPLETGYeqEIiregfCnEIfIvfdaJPYZN8wNy0fx0NB6UIpHManhdheIPUf
	 IEao90cPK606Q==
From: Tianyi Chen <hi@tychen.cc>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH 1/3] libfdisk: propagate errors from fdisk_reread_changes()
Date: Thu, 17 Sep 2026 01:05:12 +0800
Message-ID: <20260916170514.2595842-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916170514.2595842-1-hi@tychen.cc>
References: <20260916170514.2595842-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Failed BLKPG operations emit warnings but leave the return value at zero,
so callers cannot detect that the kernel partition layout was not fully
updated. Return -EIO if any operation fails, while still attempting the
remaining updates.

Also stop if reading the current partition layout fails instead of
proceeding with an incomplete table.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 libfdisk/src/context.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index 2c407029..f06667c6 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -985,7 +985,9 @@ int fdisk_reread_changes(struct fdisk_context *cxt, struct fdisk_table *org)
 	fdisk_reset_iter(&itr, FDISK_ITER_FORWARD);
 
 	/* the current layout */
-	fdisk_get_partitions(cxt, &tb);
+	rc = fdisk_get_partitions(cxt, &tb);
+	if (rc)
+		goto done;
 	/* maximal number of partitions */
 	nparts = max(fdisk_table_get_nents(tb), fdisk_table_get_nents(org));
 
@@ -1052,10 +1054,12 @@ int fdisk_reread_changes(struct fdisk_context *cxt, struct fdisk_table *org)
 			err++;
 		}
 	}
-	if (err)
+	if (err) {
 		fdisk_info(cxt,	_(
 			"The kernel still uses the old partitions. The new "
 			"table will be used at the next reboot. "));
+		rc = -EIO;
+	}
 done:
 	free(rem);
 	free(add);
-- 
2.55.0

