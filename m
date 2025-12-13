Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5E4C92
	for <util-linux@vger.kernel.org>; Sat, 13 Dec 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765656257; cv=none; b=Dfh/bO8/3Y+miki8BzM2JrB3hUluZIsL/hFqnn/CDq4SxVIfVKTYvOsCbCZ0f/NL8s+uUySfxfsQm833mc533rVWfw3gPKnogegDn7fb8xC00PVvYF8ktYNE8LJPnHvvYhpNO6vCYWGkrHriVMtlVcobkOtP8XHHpg+ZXVJYqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765656257; c=relaxed/simple;
	bh=bvo8E065l8r21ylowEhU4D33l5WQsaNifmZxpuPI25A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+I78LuSgYU/cqPJSEXUG29Qs49IsyMoSvY0RE/iDNO4bN4pcS36X6mWsmXzMuckTVhiGXu+jIg1CY+sZIE7HX44gUge75skm5IGCHT09CeL6aFGKjhn5OvuUkr4AA95JGvFTQDJlu12FEew0c0lz+yZul5UCJ0xNeO20AcA4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuVNWK10; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuVNWK10"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8826b83e405so34576726d6.0
        for <util-linux@vger.kernel.org>; Sat, 13 Dec 2025 12:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765656254; x=1766261054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Iyvd6k4fKyK0UICEys0Z3uDVRuyu1z6GneyR8YLtH4=;
        b=iuVNWK10sCA7gP6bMWIbBlbvB/TPs75WLnpIiWmkot5R3HWRdKv9wwpdZcx59dWm1r
         m9njtAbrspYvnIWlMGmIlAPp7q6HJdheC8LzYSiqV8UAbnFZhO//OAvy8xar0g1b1qWp
         BehTDXBsoF+632+nm0Aj5RAVtXnK+QxZQcUpWa7sarCHYJPJpQV6PQXhyK4DyUcGBtz+
         PiPI4dFKi/6+EgonC8YPEh7qw2swzqWAvz97Ybz1lQC7G9NR6ElxvnSOJwxbDYEwFvzu
         PXk8fBp/m2T2ANbbn08t2D6Oo3y5zwvwzC5l3eXJiwg8y+jwLJSy14hZ0LFYzjStFDxY
         vRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765656254; x=1766261054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Iyvd6k4fKyK0UICEys0Z3uDVRuyu1z6GneyR8YLtH4=;
        b=LzS1GnNJFVJ2Kb4EZz1ySOHruyqMjvYkE+whQ9YFuwOAk2BUCQgClXORai+neP1w6r
         Xh6ZUNMNF1h91t56ggP3AjRbmK3Y2/VIFBOtLYfetQ0trcfpYQPOJhIWTfHc4PxJnQ24
         4Isoj00OD47dgmLBVJWRRB6IzLcLlxD5zV/NijaVRyYQeYw610RkAxwjNHa6b5RCYcaC
         53FJm47eRZVjzgaE0uiFDxsOtr1dZpyFZ53p+ywqHPejmXhfpY1d4AWKvKDXabNaVnJd
         jebprk0X7Zo3HQBkyxAKjee5LfzQb0lNZUV7b/xaM/VrnJAlisMPpEMbjuqBfX6Y1ew/
         3KaA==
X-Gm-Message-State: AOJu0Yy31oWxXPD8mOb9UAzREJhw7j11sSrTSqtUNEa49EfUnHB7fonv
	k+q7XSR4MqIdBRaMB9eySTxTKyGMefOVpXbh14ZEAH2t6Yyg/P9ZhjNX+qkkKHFoHR6Z/g==
X-Gm-Gg: AY/fxX4QprLMgUMn4U9N3OuKwD90Uz3D9uqCNIeS7xD0FqvqBWWPZVqxRcbffBdkGI/
	EykUBn6X0HawsUX11FbPMi9JqzDVGrc0Q3g7x24L83vNZ6asWVw3JIoGjpysL7UQANV3ZniyLjk
	Phtta8xek7bObUC6+dJMB9HBgcPaErHbPKDjSzqveC+l7VBb4gS9ZScAZ14pPnOzHJd6JJChAbO
	bVWB8YEeQPoSeFxk6spnTeNaqSIE9e5hi3PbvPVCIAbv+0naeRuyouaCGlMdLaBfmhL9pi3wp2+
	iPkRZETi1H57ED3sZexukepiWvDXw6Yl9QZ8oki6/w6G6dlIbU2rAqUR7cu3Xl2f9HFBjiHFl6I
	FJe/WbzPEqzrEPWvLdPWedr2DzYGRm2dXG1jxpwNj4S3N9dfiVhWxwMROVBcs+vlLQFjxUdC4Pe
	npOFU4IPx2BVr0LhpgulGnMCit0me62P+y9dFJUAygK+ztVmByVJvnPel9AA==
X-Google-Smtp-Source: AGHT+IE62xuvmxiieXvu02hyPfAqTADzeZKO8Kqa9TWUYaWnH+pzI7GymKsQzXWXxdfCPaVN9LBYTg==
X-Received: by 2002:a05:6214:518b:b0:880:9151:2dfe with SMTP id 6a1803df08f44-8887e1129f9mr97922946d6.44.1765656254446;
        Sat, 13 Dec 2025 12:04:14 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85f02efsm19262456d6.46.2025.12.13.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 12:04:14 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH] libuuid: Fix pre-1970 UUID v1 timestamp wraparound
Date: Sat, 13 Dec 2025 15:04:10 -0500
Message-ID: <20251213200410.31256-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gregorian_to_unix now returns -1 and sets errno=EOVERFLOW
for timestamps before the Unix epoch. uuid_time_v1 and uuid_time_v6
now use signed arithmetic to prevent unsigned wraparound.

This fixes uuidparse displaying far-future dates for historical UUIDs.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 libuuid/src/uuid_time.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
index c7516152b..b7fcc892d 100644
--- a/libuuid/src/uuid_time.c
+++ b/libuuid/src/uuid_time.c
@@ -60,15 +60,22 @@
 /* prototype to make compiler happy */
 time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
 
-static uint64_t gregorian_to_unix(uint64_t ts)
+static int64_t gregorian_to_unix(uint64_t ts)
 {
-	return ts - ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
+    uint64_t offset = ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
+
+    if (ts < offset) {
+        errno = EOVERFLOW;
+        return -1;
+    }
+
+    return ts - offset;
 }
 
 static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
 {
 	uint32_t high;
-	uint64_t clock_reg;
+	int64_t clock_reg;
 
 	high = uuid->time_mid | ((uuid->time_hi_and_version & 0xFFF) << 16);
 	clock_reg = uuid->time_low | ((uint64_t) high << 32);
@@ -80,7 +87,7 @@ static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
 
 static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
 {
-	uint64_t clock_reg;
+	int64_t clock_reg;
 
 	clock_reg = uuid->time_low;
 	clock_reg <<= 16;
-- 
2.47.3

