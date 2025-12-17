Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F819AD5C
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005216; cv=none; b=my67skpFdWfm7aAKoJzhdDPGPrfsOvpkMRg1vDgUFH5UhKYPDjEmj4Xo/1HQ3oJ/q6CWzMMg0YUNwUuLGiqsVXJVF3FgrzJ0ciscomzQVeuCFH6EWAVpeYpWsh7kr5t2Q769IlPbTIpFKq+fOXjUEKXdrEx3Q+SlJ1E+gjYTdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005216; c=relaxed/simple;
	bh=YCSWVytvHn8aVR69BXI1IaAusl9lKYsCpRylaVVwYH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2xO3yjXfO+bdnsS31WQihYM9wEF/Q15sx13q+19fwo2uxNOD3TlMMII8Bd9aCbnv+Z6wEST5YLt3Uv2MtUL9UwL8KDWSGIIJ5bZ20im8Pvudkn5w+lhtGh19qXNvpXn5QFs58ETbcDXL/HCIPJbjfEnaoNX55xh6BAfdXw9ARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebts1pZZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebts1pZZ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8888a444300so48871636d6.1
        for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 13:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766005214; x=1766610014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXGr063PybtcYPs7+mtGPde2uRbsT+CAXj7zVR92++M=;
        b=Ebts1pZZZjyZ9EPlWtG6ymuFxp7OmxQ8xr6ULV6Jy4JzO26v8U5wc2MDq9LHVzAw5O
         196B3BJs6XjLzdSDPyhmRYhp3jdLxQ7F3dFhJXdk5bwR6bf2Ozh1U48u52ggbAi6d8EJ
         U9bKk71LSiJuCWyCC3admb8o4rqZP6Na/nNHj1FJpBW6WmsXSonGWWICoNB3BTVYGQoV
         lHZaR4mda+NAZH6DIeKhKEb4/XjsxoZmDxjJjc8GIvOWaXVAR9Jj8U6ZF0DDFakBa/nZ
         TKDLi4JLS97wfU7RPVMZIAAFPwYTFy0t8Oj2O4Cro7SXysmpUytdtuztkhnjvKimsA25
         b/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005214; x=1766610014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXGr063PybtcYPs7+mtGPde2uRbsT+CAXj7zVR92++M=;
        b=rKzI0E8GDjoQgtXNYxFA2L4RRbjNLloD5Cmo1/IUSc6L6FviAUi5ZNrnHNYnArw9CK
         C8umAvkutnHe454IEI8dxj5gANGn/GaMbqbJy5idEPhNeDmhK7JDivGMIDf27EN/6mju
         i5h3IEywjUoXm1V5GbLMmsEg1XN9rGu1dSPZWrwCotbC4hS5NxG6/3bvY0iGG5QA0DKr
         mcwsJsEYVWinoZgBarHoF322xghfAOFRRvqM1Q8HVCuDMYVnhJFcxjHm6/YuXsTKsig1
         zL3UObgObtr6rAf8WT4+uGVS+Fax6RU508SDk4vwxeoNl+qenpyoFPvLeKWLduCCtgJa
         sOww==
X-Gm-Message-State: AOJu0Yx0/j2gfBh7b86tObWVFooTO+BeHbxEE0DK6sifJwdJnaf5tO+1
	pG4z/2vxoEYb7ZC864qXGHGESCvGWoi8huSRQWPz3KUMbGSFkFuPSodCusuwrApt
X-Gm-Gg: AY/fxX4T9SIcF1ey/T7Y9adE5FiyyxCK8SVTW4CMbgRvaa38Fslf0V+70XvGY/+zriV
	RHO9L63jx+0fRoFqYlcJzr5LbsFbZqnKK3PqNHBWw8D9r3zVnGi4GNNTTgybbxTVdLn0RM35r67
	7AkWdZV3qV1DuqsRMKJ6zSBLefSbZTWdiXvtHQQk+Y1xo37R1HMdtAB7bJ4ZVeQFsb00eNlC227
	MQU6QWqFJIJvLX4h07GDZ3kg2laCwPUlTbLHIn8OZRveaSY8UsenJAqRGoX5lIXWlIb+i+qEw9Q
	c/IFb4fsTJ6aEytzW0JTGygG45SvfvYohRlwxsTczuYuZ+L9OacSFfv/svGXqhBTq64bhGo0tdT
	zPilUYtNwE018lDPV7FW/aAZPXXDmcDZzP5kfAiF3sTyS5n438dJvnB8iFFjBnNj/oBHNiJ2vEE
	9OZNnyxqYo5k4xd1Lne/GffVbbccIJfMpr2MCPwwmVXBo/e53XiAnS2Ny2FN+BaqSoRvVV
X-Google-Smtp-Source: AGHT+IFI6lSExKbmdgMLe80cWOzUxc10rDCA+kHt63pmXhUZ4NO8GHXH5rQQFfimFTaNYHtIoW3qkQ==
X-Received: by 2002:a05:622a:4c07:b0:4e8:9ca2:b9ea with SMTP id d75a77b69052e-4f1d05dd3f7mr259010731cf.56.1766005213724;
        Wed, 17 Dec 2025 13:00:13 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fc9704bsm2431021cf.9.2025.12.17.13.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:00:13 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v3 1/2] libuuid: Refactor UUID time conversion for pre-epoch dates
Date: Wed, 17 Dec 2025 15:59:52 -0500
Message-ID: <20251217205952.10904-1-kiranrangoon0@gmail.com>
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

