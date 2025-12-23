Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2561D9A5F
	for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512889; cv=none; b=mGh0+hTr3+bs61Csa7gOu24LyfleI9AM9wTSxS+GU0Nl7/rIZcRgXZbOvei4zP9iOMgVvdIaPlV9nwZGnp4FWL4wRavlC2Cb0XVuEDG4E03iPheYqjPgGW1Chb4afcAMwDcN5OmQ0fb3/ndABZkune/bhroF8fMUXJw3Bwd98cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512889; c=relaxed/simple;
	bh=fh147bjKRK8Iha9U3NwQrz6u7WAbF87KKbEJa3y37Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQZcgtwYDT2BIAqAN5yzSzpDpfm4IiSa1VImKoTHigeD8yRyPYCPuMK8BclQsP1VntAdUPCe0jfDzoOzVFHg7+78DWTNCGzuiW3DAmfrAOLWTuVrNZqqYQgANrJ9Ghb76NkPSMqFSd6aqYrH16jRzII98bsG2vTrxeGWmeRRVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZUAL8Dh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZUAL8Dh"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8885b3c06caso79357236d6.1
        for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766512887; x=1767117687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWnoKIP9+b52CxRxZNQgfaSU8LtRGCMIuCkTmFpapj4=;
        b=SZUAL8DhsnTjqYckbx1/q2NbZclAjVGFRg+S+vDr6l07b1X4sl4+TUOLjraUtB4Uvu
         +J2hCm+nnckGcw3/cAd8o1n1Jo5WIw1F0svPkGzXEl0R55jrkjReDxYdawhOAm0PKlif
         er2pT9jOkflbJMvkbSCPoOCFlTFA/z1pOOzbs3kRtAuo65tyfoZjohEgQXhzIPJug2Ct
         VvcIJWvvE/8VyrlN7azOXcSHUiGYR6cg8kz95/5NrqNkbg0ovRSasobmdouA1L3nbiD3
         NCfzSl8U5ruhbX5bKQIJ6F3J+SuPQifvx+FY1wR352JW8XQWsfA9UmBVbWQ1f0WKoYVM
         dwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766512887; x=1767117687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWnoKIP9+b52CxRxZNQgfaSU8LtRGCMIuCkTmFpapj4=;
        b=HYyD3CMmB3NVzmQj+sszNVJQwg4eVVBYvD9nmoK/Z2eBiLfh4o9/q201wGfflziG6y
         U7YwYn2HcFEYiIgYYhgDUl5nzKeyX1cy3mZ5DNGkQT1VAS5Xstv0PD/SYus3NYaZWi+D
         kn+lJ1eam6zuewf/0F9+7ULhvifrvoJKNda5MZbzXDSqTijv+vidqiEj1ob8S1ZM6Oxa
         O8QGVzNsRqGe/rHiWSwkPkz0RzujIMN2uHDostfNJE8Xxt+DYuxwQw9lcu/BEBN0yd99
         X5qglezWuqCkw8teukWMLqNhZAuBPq+Nc4y/QzStMtn/GD+SuzqfpsuzZX0w5aTG0QnM
         ACKQ==
X-Gm-Message-State: AOJu0YyhWigrnn1c3kJR0Bh+CopMEV3VjWU/BEH95iCjqSkuS0VSxSK/
	8CnHw+Bk2gX62mpyt0+LntkYnJ2m3R7lH7T0xag3pXU9MWXiSZnYHTso/8J0KA==
X-Gm-Gg: AY/fxX5vG4DiEgEjM001zWKIpTGfmdtImsehin59AUHYfd92Xo0Tony+Y8BNMMMgN/+
	iDk0m0AJ2muf98J8YVDEnVpuZVSEMSK3/vS1x1VEx2/PrhUA/Ntx/WXA+T7v2i56agpKQjdD9nI
	PDob4bBLarhTKV+Chs9lX/7LYpPDvEadbkMovzvXrxlSi1WzDnVNedZY2FgKLRiZ9cfYI8+MG7x
	+DfFJ85UaomN8z2k63+I1gxCbMSkQ9rA3Twhf2snAVFfIEKvzpNQif8AoWydGX4LNVNzs8DIZ45
	kiA6ocpLBZAosfjRTQNT/56PYkAheii8ildcPzfXmZ3/oC1A7hSwAg0rUo6KNkHwt1ecCF7QwN2
	X6SLCpYzgmeAmGpg5iBGlKXJMc/78WODB//LhMTR/Le9qW2EN2g0ZFUunK7qgwg9dS77dP09usP
	fKaoOJJ12XKyc1JXxWfFYyqrNPZCHuZtkdictSRVQhEG6aLT1J7f/Cvvu5LQ==
X-Google-Smtp-Source: AGHT+IFK4qDQuREfw8F+ojz3xfYfk11Dy8mOraf9LA2pBABfEwXTAZ1gyoE/mR5qeOxQGLADGW8XXg==
X-Received: by 2002:a05:6214:448b:b0:882:3b63:f7fc with SMTP id 6a1803df08f44-88d87605d3cmr239468916d6.36.1766512886707;
        Tue, 23 Dec 2025 10:01:26 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm1105444185a.13.2025.12.23.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:01:26 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v4 2/4] libuuid: refactor gregorian_to_unix to populate timeval directly
Date: Tue, 23 Dec 2025 13:00:53 -0500
Message-ID: <20251223180055.2396-3-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223180055.2396-1-kiranrangoon0@gmail.com>
References: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de>
 <20251223180055.2396-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change function signature to take struct timeval pointer and populate
it directly, eliminating duplicate conversion code in callers.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 libuuid/src/uuid_time.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
index e2b991d74..2f7c6652c 100644
--- a/libuuid/src/uuid_time.c
+++ b/libuuid/src/uuid_time.c
@@ -60,10 +60,12 @@
 /* prototype to make compiler happy */
 time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
 
-static uint64_t gregorian_to_unix(uint64_t ts)
+static void gregorian_to_unix(uint64_t ts, struct timeval *tv)
 {
 	const uint64_t offset = 0x01B21DD213814000ULL;
-	return ts - offset;
+	uint64_t clock_reg = ts - offset;
+	tv->tv_sec = clock_reg / 10000000;
+	tv->tv_usec = (clock_reg % 10000000) / 10;
 }
 
 static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
@@ -74,9 +76,7 @@ static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
 	high = uuid->time_mid | ((uuid->time_hi_and_version & 0xFFF) << 16);
 	clock_reg = uuid->time_low | ((uint64_t) high << 32);
 
-	clock_reg = gregorian_to_unix(clock_reg);
-	tv->tv_sec = clock_reg / 10000000;
-	tv->tv_usec = (clock_reg % 10000000) / 10;
+	gregorian_to_unix(clock_reg, tv);
 }
 
 static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
@@ -89,9 +89,7 @@ static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
 	clock_reg <<= 12;
 	clock_reg |= uuid->time_hi_and_version & 0xFFF;
 
-	clock_reg = gregorian_to_unix(clock_reg);
-	tv->tv_sec = clock_reg / 10000000;
-	tv->tv_usec = (clock_reg % 10000000) / 10;
+	gregorian_to_unix(clock_reg, tv);
 }
 
 static void uuid_time_v7(const struct uuid *uuid, struct timeval *tv)
-- 
2.47.3

