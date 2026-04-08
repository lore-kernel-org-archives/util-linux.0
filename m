Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006D37F75C
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644554; cv=none; b=u0Jao/Ux+CGhJvZmhObTRggJwZo753er2UTk9+EaJi5sT1p6mUir1uiML9bQesuFkajn4pVvmps6lmyE+aQ6lae59pOwBR94zsZ5+wVL/U1gz4Kj63s0HfAQGvHyF1Ralkd3//EKTCjLSUgZRe0w8Ea+eZO1ws4CuLhYxrIQzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644554; c=relaxed/simple;
	bh=rYsG/gXBXegG0kKZhH8KTK3HIQ+JjeLfQF72gjRCtgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEZ9rGuAZ4UaNnY1ac9wahopdn8wN4cngQ8uQxK8qB+5YhMdoxQeTsJ6MgkxbD9a21CbjNROs4laYZIRnbvUxYOhdFCNqfyoQo78sFfN1Kl5dDju4w4s8xX9+qLKREcKqasbNkFnRpKLrYQC7n6HOHt4X32CytSiqeHHKRuNizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo2Q83P4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo2Q83P4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C67C19421;
	Wed,  8 Apr 2026 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644553;
	bh=rYsG/gXBXegG0kKZhH8KTK3HIQ+JjeLfQF72gjRCtgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qo2Q83P42rL1UAo/nADViJegN+udZfHIVwhqbHjHmd+5k8te0Nsz+wTx4QgdUksKa
	 ZFvo9EKP75+dZqjQXyzQaOzX8BgE9y1TnuPqLI5RP+bfy8OYP8TamUfvQ8bbbWb159
	 cCrZKWokYK8uzUEb5T8SGD6gHXFnzAyKbYzvsJHg2ihI12p6jvfuEOK0F0tRBE/96h
	 //+puObLBF8pWs+it2YQRypvrXJPQJZOiVtzOjRxVn29tBgHK0X/bg0NoSWII5yFP8
	 HzETBu1S2IpEHaE3FgToScId5ZUKZvwoK3lXHNL0aeqqJEeN+ILAPx9fmZMqWM+Gz0
	 zrDJddJjLlpew==
From: cem@kernel.org
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org,
	zkabelac@redhat.com,
	amulhern@redhat.com
Subject: [PATCH RFC 1/2] Revert "libblkid: add debug message for private DM device skip"
Date: Wed,  8 Apr 2026 12:35:25 +0200
Message-ID: <20260408103538.134308-2-cem@kernel.org>
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

This reverts commit b85d46a2edf3f871504ca86080102cde93e3725c.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 libblkid/src/probe.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index fba7eb1240af..d47c22c72043 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -224,11 +224,8 @@ blkid_probe blkid_new_probe_from_filename(const char *filename)
 	 * DM_DEVICE_REMOVE would otherwise see EBUSY.
 	 */
 	if (stat(filename, &sb) == 0 && S_ISBLK(sb.st_mode) &&
-	    sysfs_devno_is_dm_private(sb.st_rdev, NULL)) {
-		DBG(LOWPROBE, ul_debug("ignore private device mapper device"));
-		errno = EINVAL;
+	    sysfs_devno_is_dm_private(sb.st_rdev, NULL))
 		return NULL;
-	}
 
 	fd = open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
 	if (fd < 0)
-- 
2.53.0

