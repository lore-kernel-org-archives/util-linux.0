Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704637F738
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644556; cv=none; b=iGWXyFHKWOr49h15KezP/auP+PO/5gqsxYz4UVIO+AtkJMChyCpnDhizLWG9dvrL7O1vPbs7tF9vbN4j7LuMIRPYdW8Zg3pjag7ul/iboapmzawhX1sOdA9mOOrlFQWWBUHftrsLK7MVYmZzCGjSG32Jz+8qAD/bqwGSYq90Pho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644556; c=relaxed/simple;
	bh=uxXmkFTRHHSnlmWKFR9FBEQRLsF2FoJWAdB+cduBilA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5pSi7nUhe1MujtWTNoT76T0qVAmv9Wb54tQWsHaYpQtaob+omSkEoJXCrgXzg2h7uahV2VDWbxt+3V2tsZXWW2hz3SKtlmNPmj8XciSNTpK+8dcF10O67BRIQTU9KHl/URd2zhWJrDayz2ZIXyW+xxSBPr/86AeVNQj8ts61AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmYfCJ47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmYfCJ47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFBAC19421;
	Wed,  8 Apr 2026 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644556;
	bh=uxXmkFTRHHSnlmWKFR9FBEQRLsF2FoJWAdB+cduBilA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmYfCJ47+kxBBByKN/YHinb5Yr1ho3KH73z/H4jucH/iTYYkhxxlvwZ+Ruk6pBZMB
	 V+JF6UydAlapczftC6EtmwZtAYqxC6qMXHMpgXff4to3WQzgLO6atBG50TkeGtAdtn
	 Xdv5mPr+9QoHLSg8Wu1cG6q4xtmpipZBzjfOZvhArtk0K+c5NGZn4lfCh2eF2+75W5
	 ext6Yei9esl4cXV7oVAtGeg6JrpjVBUXFGypIOK1Xm9bcSICgH+LgN3Zr64FgU6cfi
	 weIwbHPr3uaFWFqHDnumBmLhJIJrsIZFUdAK4a5EI2QZxH661oLAJVwvvlFHJ5OvAU
	 SwxsGg33VqQWg==
From: cem@kernel.org
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org,
	zkabelac@redhat.com,
	amulhern@redhat.com
Subject: [PATCH RFC 2/2] Revert "libblkid: check for private DM device before open"
Date: Wed,  8 Apr 2026 12:35:26 +0200
Message-ID: <20260408103538.134308-3-cem@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408103538.134308-1-cem@kernel.org>
References: <20260408103538.134308-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

This reverts commit d05a84b22e549527cbcbcc7d5efc6bad06668170.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 libblkid/src/probe.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index d47c22c72043..60af2915c0d7 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -216,18 +216,8 @@ blkid_probe blkid_new_probe_from_filename(const char *filename)
 {
 	int fd;
 	blkid_probe pr = NULL;
-	struct stat sb;
-
-	/*
-	 * Check for private device-mapper devices (LVM internals, etc.)
-	 * before open() to avoid bumping the kernel open count.  A racing
-	 * DM_DEVICE_REMOVE would otherwise see EBUSY.
-	 */
-	if (stat(filename, &sb) == 0 && S_ISBLK(sb.st_mode) &&
-	    sysfs_devno_is_dm_private(sb.st_rdev, NULL))
-		return NULL;
 
-	fd = open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
+	fd = open(filename, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
 	if (fd < 0)
 		return NULL;
 
-- 
2.53.0

