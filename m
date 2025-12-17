Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737530B51A
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004202; cv=none; b=Q3OAP5NATAUymoECItF00RAExoc+M0WmqVH0eZBn/4Ik9K83/GnAL8BQDI1vWn5Eyc/S18JmH1QaYr8K9SAcYbj/LjVak/c4XIjkOA4+v7iFhurs+aJeTm+aMvauoZOK+VMv4+ralC8fZ+hiqzJwAF3vloBv7ZfiZM3qbnqdHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004202; c=relaxed/simple;
	bh=YCSWVytvHn8aVR69BXI1IaAusl9lKYsCpRylaVVwYH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j39wK55/Hf0n9ztGTmqmtmphnCQ7xVaCOEkevoVjfcCz48KkKVPntwmM0uOx0zLFnhFRVbv37haKL7XA+7wzyvo0DbuSSrTx6y4DUmaL89iBYLUvkP4oH/XtfXpSZezmz8G5XxiFkCxE9fgjr6GNiUQPj4Vf9YodJo1P9QS/kwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5yKnJ/B; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5yKnJ/B"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed861eb98cso67637111cf.3
        for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 12:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766004199; x=1766608999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXGr063PybtcYPs7+mtGPde2uRbsT+CAXj7zVR92++M=;
        b=P5yKnJ/B6YykF4FZylsw/Zdsy6DseweBy+CjdlAmO1HUsOmcGt6MzzJsd3JUJCioe5
         txxzGbyQcMebLQY2IiC/zXkcmZXxSlc5kAJE7Li/4FTj0Qy0mbwHvTjN704PXtdhopTh
         q80G3BngKvPMhZybpI8CVlXFUe2K/Go320n6xj7c0DA7syza4JGohWruNjLpAo7ZnXFW
         wGbXmeoFnHuPT3hayGRZTMSGZWVxxfYRybKbOwO07y5e4h8SzpBoqkL/T3YSo7VwiC/p
         vGfpYADpMc9i+S+dlKLGin159BL42/rvcCu2SqptdlfwqvVye9If2aUIuyqSVsFtKwXU
         tg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766004199; x=1766608999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXGr063PybtcYPs7+mtGPde2uRbsT+CAXj7zVR92++M=;
        b=jB3PVpojKZPxu29u4bmFJydHoQv0pHXSsDNLTRRzNl+vQo9WjudGu1VE6tDXcwzA7o
         TvRn5kPNcd8+sQNPewR94KmRx3haaX4mJC65j7ygVIWLkNZbhXaoN7/SS4/4/iM2vneu
         RIvdarD7Ony8jMisFD+JKgO0nQ2dwSzNQM7eZaMjh7IojqHmp1MX3xZf0LeySTGCnOi9
         VYCrkZwXI2CYUneqBJic67W0KWT9HkJPypzzjMgbkoofUdbIWCgUebDiwyrXdgUriRVZ
         j8ZnUE4AIhIcT4IcbvuNgWNn8xhscSYcu+unulMJCWNo15m6l6PfNdOIXyAhODnjyAgj
         hQpQ==
X-Gm-Message-State: AOJu0Yy/yPB8eyp81uXoIxIq+AqZsf6jpPUfXR3CIVDE7FQgfLiCaWKJ
	Ck1dQ4bQzW/7+WA1qJET8XPx/0BVDsxR1zGTakFLDqAOT7UqNhqjU5E9ZL/hXOF8
X-Gm-Gg: AY/fxX5lVQ5vRQ9GXCKr/wjd/YEeUSyMUjvlInNVnbjkSM/ayRfAzLbNSgVFGOS+E8d
	qKobcSY1MfYzJZo8nLhill/MwnUOlwUUBAY/ChCqFE/5Km24NCfYX49FyB1b5ODcLWPbRr6oNyE
	Bg+//RidpYXflUrEHae9qCsjDdWA6cMxB+d1UtGujwbmStebM4DZIA+mTnc7pn2smZJnU9jzojH
	JxwpDUXOvOC2V2VhH2SaLoggF2jOPZZ2UQLOsZ3PzWHBPXs/jULgqK49V4zxtIB+ocG0yRLny/J
	M0ndRHms/LNEm5vFD9PPEJIQdCZwrgqhjVvMnXZ5UeVo9X6wIyKZn7wRSCVH8pnEoQy0GPsl9N8
	SDafxwHc3l27jG8nBr8trNkJXZ+s3Vfzm3TPZ3kBMfEQI8OmCVNLcrrmEAQVYfUj0EIPtonREhs
	vy0cArlWAqsr9cQuHHQU0BiG0JyycNnKw/SbJALgBAx9H5Jrta4ibIUmZqIg==
X-Google-Smtp-Source: AGHT+IETOwD7FSKAKEfmOWkGYto2lIiHlt4M/nrxx71z5yS7pZMmnUCwq/4IkabrDwV+5qDC/toUKw==
X-Received: by 2002:a05:622a:8356:b0:4f1:e939:347 with SMTP id d75a77b69052e-4f1e9390356mr171392971cf.35.1766004198913;
        Wed, 17 Dec 2025 12:43:18 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c6089a305sm3084626d6.37.2025.12.17.12.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:43:18 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v3 1/2] libuuid: Refactor UUID time conversion for pre-epoch dates
Date: Wed, 17 Dec 2025 15:42:46 -0500
Message-ID: <20251217204246.9692-1-kiranrangoon0@gmail.com>
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

