Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26C126C02
	for <util-linux@vger.kernel.org>; Thu, 18 Dec 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093493; cv=none; b=r6OzQnKlD4jp3NaXTe+WOxc8d44nJipPcaPBJZDwEc6azCefotqK9G+oan+HLJovUuYeQL4JETOpleB67XOhEOQVq+0iDFOTwzy/DR29uQjbtPDQV0N5Mj6QgweT89zrGIAbQC+bTk1Dxp7B9gZwFnQa5sx9AOCya0+5Ra5iVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093493; c=relaxed/simple;
	bh=YCSWVytvHn8aVR69BXI1IaAusl9lKYsCpRylaVVwYH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvTKKc2E8acxXo5oKFHvTiLW2l7SVdkMyZlm5WqGb1kNMb2bGpArpIs5x88tjSxBynpyJADQKq9WZ6uiDo/UuXYsX6foKZdGuVKF5+sEsLIwWYyQ3SCznjrqFT/nKfMqpIbkz3ZEJ29pkzOFUILtmmPX6dyOBrCaqsvO7T4BmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj4OCPtU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj4OCPtU"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eda057f3c0so10915191cf.2
        for <util-linux@vger.kernel.org>; Thu, 18 Dec 2025 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766093490; x=1766698290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXGr063PybtcYPs7+mtGPde2uRbsT+CAXj7zVR92++M=;
        b=fj4OCPtUU4ELzdSIkmLoKBDruNmnsIi9/bIdeY0ZSm8iYvR+UYSxFVpSJ8ND3eSMv8
         aLCCbx+EeGMWgd9DghHSw+mK92I8iJnBW3RtsAY+cUum3FLUmoH1VVg60qONNz3kVGKA
         QqgWKu8Qcz9WfRENiYz0Dv0JuK3PxfEGNH6Gz57eEVeGzQSMuiyR7GBTSwjL/AG0cSLU
         THpRBPeZjGtGDmBzV2N4dWNmvBL6qUCVQHRvwEA3khnhs+sfcaWgy2fSjUU28T/cSomD
         nCKXKneKkWqkcrClJz2+wHIlq9COUa+h2pOcSXJJFaBZROfGrVG1xm2IMSgwGAeodYS+
         ZBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766093490; x=1766698290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXGr063PybtcYPs7+mtGPde2uRbsT+CAXj7zVR92++M=;
        b=biWuAWgvm/qJDNNGHLMXGIfDIaOsSZJOo+P2VAWlfyJc8Zy4rKBqroNnZn9PdsIOYP
         wqRn9EgU+xAOts8psQ4KwXg5RdWnqQnUwWMhaefZe1+wk0tiFx+BV4IVPZlA92NAh3NV
         Z6ldtWVdR70ul+g1MhjJB1/o0033V4tEnJah7h+T+ERWWzFdzzeqNgOQecdJz0rqhrPg
         BnPhbPgXgrajaRkyNtbLuSEHs5zzTlfTPnaGKGP6jpSKs6+QgEOd74OeByx9JTdCMF3N
         J1YTLALxaIR1ETwBfvtUxrKDcDQnlzDuqGkqw/fjeovwMIPp96N79Z2b4WNumgeKbXR2
         nsKw==
X-Gm-Message-State: AOJu0YxtBzBjewRxt8bTBfFbDHBYJGis6gFOj0rczrM/RpoktCLL1i9N
	KkXodNJR+INV973EeV1LPv9MMS1NFXUiSukEBG/kFeu8I+SBg7JrEpv3gUGbPg==
X-Gm-Gg: AY/fxX59txwn4WzO3Y0mTFuCYydVMt0zf96Vg12NYVWZyUaMGjksYxcubLtfNxEGlR1
	2PJQ3QBwm0QpIfapKrESZ/EiMzHoTUinECG+ZRrKzxekIeJd/ktyBZAUvsaQLKT3FORxXJ6KrCL
	1aYGRypiRqxNc6VpJjdrebozWdCdez9Dq1H23IAvf7CxjI2LDkLGLSuv0ieJ8GmBtm6SuAk+t8f
	KUKwyrmPfg7nxDaI5pcUUF6w+FkfET3coIzg8JWaQtoo59xtK3f53h0ZR4RPE1wlb37JU0cCG2h
	8EROkiXDjOwhPlaWgZhO39VMFlLlUjIKjNrCXqZkxoKt8PbSzQMK+ZtVJl1fXW+jDaXVFsPupkA
	u02eAMEVWiboSzXg2Sgs4PBIuvkSLGxASuNrugkcckj52u1VgX+brXyD6jAyqLX+MW+9R7st1S2
	8T/WaBxCR62+rCEHM7/pJXXy398i30Eku1OLC2IigtUYE0kdGOm8yDnBK1BQ==
X-Google-Smtp-Source: AGHT+IH+z2TPKlOsj5IZKCX/u0Lec+qSPw4eQS8QXpn4VVfVd1Z0a3fsMBa73n7EZzEWqFrkrI6ONA==
X-Received: by 2002:a05:622a:7105:b0:4ee:433c:efbc with SMTP id d75a77b69052e-4f4abd79af8mr7435161cf.40.1766093490328;
        Thu, 18 Dec 2025 13:31:30 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997ae49esm4697676d6.28.2025.12.18.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:31:29 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v3 1/2] libuuid: Refactor UUID time conversion for pre-epoch dates
Date: Thu, 18 Dec 2025 16:31:21 -0500
Message-ID: <20251218213121.4961-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9dc90e33-30e2-48c3-8602-00fce280f9ef@t-8ch.de>
References: <9dc90e33-30e2-48c3-8602-00fce280f9ef@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I revised the code in response to your feedback.

> Looking at this more closely: __uuid_time() is directly exposed to users
> of libuuid as uuid_time(). This means that any change of the function's
> contract would break all external users and should be avoided at all
> costs. 

Reversed the change there.

> Fortunately it turns out that the timestamps embedded in UUIDs
> only use 60 bits. This means that the calculation can be performed in an
> int64_t without any risk of over- or underflow. Please try to implement
> it that way instead. 

I'm using signed int64_t here as suggested.

> It might be useful to change the signature of gregorian_to_unix() to
> "static void gregorian_to_unix(uint64_t ts, struct timeval *tv)".

I revised the code to use a struct timeval now. 

> Also please perform each logical step in a dedicated commit.

I made two commits, one for the code change and the other for tests, but
if there is a way you would perfer me to do it I could change it.

---
 libuuid/src/uuid_time.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
index f0d2c8f36..293fc7e68 100644
--- a/libuuid/src/uuid_time.c
+++ b/libuuid/src/uuid_time.c
@@ -60,34 +60,29 @@
 /* prototype to make compiler happy */
 time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
 
-static int64_t gregorian_to_unix(uint64_t ts)
+static void gregorian_to_unix(uint64_t ts, struct timeval *tv)
 {
-    const uint64_t offset = 0x01B21DD213814000ULL;
+	const uint64_t offset = 0x01B21DD213814000ULL;
+	int64_t t = (int64_t) ts - (int64_t) offset;
 
-    if (ts < offset) {
-        errno = EOVERFLOW;
-        return -1;
-    }
-
-    return ts - offset;
+	tv->tv_sec = t / 10000000;
+	tv->tv_usec = (t % 10000000) / 10;
 }
 
 static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
 {
 	uint32_t high;
-	int64_t clock_reg;
+	uint64_t clock_reg;
 
 	high = uuid->time_mid | ((uuid->time_hi_and_version & 0xFFF) << 16);
 	clock_reg = uuid->time_low | ((uint64_t) high << 32);
 
-	clock_reg = gregorian_to_unix(clock_reg);
-	tv->tv_sec = clock_reg / 10000000;
-	tv->tv_usec = (clock_reg % 10000000) / 10;
+	gregorian_to_unix(clock_reg, tv);
 }
 
 static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
 {
-	int64_t clock_reg;
+	uint64_t clock_reg;
 
 	clock_reg = uuid->time_low;
 	clock_reg <<= 16;
@@ -95,9 +90,7 @@ static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
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

