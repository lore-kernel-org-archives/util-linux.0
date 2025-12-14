Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4C261B8C
	for <util-linux@vger.kernel.org>; Sun, 14 Dec 2025 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765674085; cv=none; b=DvBrn/7Fjam755GfB+ZYpVQZG3/hhbHEnRuP1bqd8ADfXPFPuRq7wOLnw+5U6tWjhg5Bh9oj3U209nmHQAfVKTnws+8gLpBNFL53somQ/4rPS09zBZgAdBvVYMMSWFZ5FwEqMftNxUtPS2cyfpnWMFyqdCtu7G/w8Ba5R4dDLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765674085; c=relaxed/simple;
	bh=bV9HjO9gZmss19eXB8pGXCdcLFNKBOW5R7JgQXh/loM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXxa5wnpzjx9xMhA4taN9XyF1ONWXx3gIpRIiY/rvXUBLdyBx0lTG/RAtmAncRFrXhshshK33AmUgvhw2uBwb+k8WUUMPG7Tve5Y5KPvLl8UXQNYr6Pg5OupS8d4ZxqM5U/r4h05oFhGqUbfEy8z3Z3gWnUUTe4zn++QIQ7LIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfgXMiqW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfgXMiqW"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8824ce9812cso26290966d6.0
        for <util-linux@vger.kernel.org>; Sat, 13 Dec 2025 17:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765674082; x=1766278882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmQbVZA56fBKgEbnqvnsf3I0K4wmZfODm7Byqe5tvkg=;
        b=RfgXMiqWkHGOsRWWSBm7KKn+6TSoak5vlam9lsJ+j5/7635FJk7Jb0vp7XeX/38Lfx
         Ts4TojU+LwazG6M2r2zr4SYouD3nwBB+0Frd8rmuLcjXoXFQpleO3pe2mPquumGUNFoK
         SNcFSierbTT2pEW+uoq0Rby2ZTIz24z/6/mn5xnfhmfXF4+Y06Njd7BsBvFQJ0FeNqo3
         i2H2u66jNtASIJwIWjKCZxivdw5P1GVq+S/2g8oP869kt1MUC5sjodr0io2/Mc06MRgR
         4x2B2zMYmcxwF3ycUqaFet/zRFnvEO4EJ+5yOmEjQrWBcL24jxHWNHLwoMILGIBWOBrJ
         1YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765674082; x=1766278882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JmQbVZA56fBKgEbnqvnsf3I0K4wmZfODm7Byqe5tvkg=;
        b=Ln/NzsSI4GENDxarDnV/BnI2zfsp6xYWPJuOtsSN9syCAOkg6FXtbP684EbgS8JSIM
         eIghjv2XbKZvvF7yQRYWZPC2uc4pp8PIEICFuqMZgKiya1i78E/x4rh5M0KEDzfsP6AJ
         xsa2GdbBOid+JSyBMB4c9d+jP/4qMHhV7A7SG81itxYKIMxrKngGgCi3/eam8tQwGBZP
         9GNCs3gO2ZrR/BjOjrQb+Pxbymm+wzwRHyEZ3Ek98JwFwPn0PO+jxI0T0ZXUVm8xEFu1
         h00D4qnRan3F4ialATI4qw0Rh6SqX0isHTmNF0+ltbM52ifwgA6JAglIOco8qPAINorZ
         uoVw==
X-Gm-Message-State: AOJu0YwQx40401BItDmhvxBtKOoL68yfds5/wa7i9+RURQP9T098FBEH
	7csryTsumE8rJaMspr/2TqS4KwKpGggDsLtc/egG2qQUGxbA6GTWgoPhksGMrQ==
X-Gm-Gg: AY/fxX6oxGsUcY7Mx3uOp9qgir0I8bEXXqgz5kT5Bixm7Xdlqu+bHvzuyFQFZNr6DG4
	N9JzQtWFXS/YqygR4t6QCU7wlEAgSHsKuI1G7dm2cPVUA2Ozd2AYkYMDbeGaaQUqXYUWB+UOe+6
	I+cSRpPnk/OCX6588q8VKoXf4iIYe8fm3dC4sg5bU8Q+Cbq4SKMgKUfMUvoOiMHy8vQHYQwaJRZ
	b7oQeZF+VlNYLe1x72WLIbHE2zTKJT2iogVOXaOotuuZs8BVHMnzcJc3NFkIOal72BjiUvTrX4p
	tLQloluttSgtYMAt3bQT+ine73eze/IlQDDaq0E6gB5m0wjuWmcYe9ewj2N3AVBELFNc1DwAmfu
	M7H1Iw7V79c7ukeXiaB94v41jWRDTWv46blEmcJmdksrHoXxU8em2Lb7/sGDMvuZzdfnHmVmsBF
	3ixHToB6js/qghucChft1cQdYjfDtVJZrlWwQUI25VYzFtnqsNuO9VdVv2oQ==
X-Google-Smtp-Source: AGHT+IFU3ALIr7Z3qZJ0FLedlJSye9w3hV675+Pnujp5c2WoTWIVlf8Etx5+WxYiG6Bvi4vIFabWDw==
X-Received: by 2002:a05:6214:3c9e:b0:888:58e9:fdaa with SMTP id 6a1803df08f44-8887e19cad0mr114776896d6.21.1765674082373;
        Sat, 13 Dec 2025 17:01:22 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860bd0bsm23823466d6.54.2025.12.13.17.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 17:01:22 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v2] libuuid: Fix pre-1970 UUID v1 timestamp wraparound
Date: Sat, 13 Dec 2025 20:01:08 -0500
Message-ID: <20251214010108.29535-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251213200410.31256-1-kiranrangoon0@gmail.com>
References: <20251213200410.31256-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gregorian_to_unix now returns -1 and sets errno=EOVERFLOW
for timestamps before the Unix epoch. uuid_time_v1 and uuid_time_v6
now use signed arithmetic to prevent unsigned wraparound.

This fixes uuidparse displaying far-future dates for historical UUIDs.

The regression test has been updated to show actual result instead of hardcoded wrong
date.

Example output:
    $ ./build/uuidparse bf2eb110-d788-1003-aa59-ce1e9e293641
Before:
    60041-08-13 16:41:36,271592-04:00
After:
    1969-12-31 19:00:00,000000-05:00

Handling negative timestamps gracefully would require broader changes, so I’ve kept this patch focused on preventing pre-1970 wraparound.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 libuuid/src/uuid_time.c       | 15 +++++++++++----
 tests/expected/uuid/uuidparse |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
index c7516152b..f0d2c8f36 100644
--- a/libuuid/src/uuid_time.c
+++ b/libuuid/src/uuid_time.c
@@ -60,15 +60,22 @@
 /* prototype to make compiler happy */
 time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
 
-static uint64_t gregorian_to_unix(uint64_t ts)
+static int64_t gregorian_to_unix(uint64_t ts)
 {
-	return ts - ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
+    const uint64_t offset = 0x01B21DD213814000ULL;
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
diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidparse
index 9edb05e4e..0f521a760 100644
--- a/tests/expected/uuid/uuidparse
+++ b/tests/expected/uuid/uuidparse
@@ -11,7 +11,7 @@ UUID                                  VARIANT   TYPE       TIME
 00000000-0000-3000-8000-000000000000  DCE       name-based 
 00000000-0000-4000-8000-000000000000  DCE       random     
 00000000-0000-5000-8000-000000000000  DCE       sha1-based 
-00000000-0000-6000-8000-000000000000  DCE       time-v6    60038-03-11 05:36:10,955161+00:00
+00000000-0000-6000-8000-000000000000  DCE       time-v6    1970-01-01 00:00:00,000000+00:00
 00000000-0000-0000-d000-000000000000  Microsoft            
 00000000-0000-1000-d000-000000000000  Microsoft            
 00000000-0000-2000-d000-000000000000  Microsoft            
-- 
2.47.3

