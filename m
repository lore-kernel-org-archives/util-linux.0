Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBE246BB2
	for <util-linux@vger.kernel.org>; Mon, 29 Dec 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980273; cv=none; b=LtUZCF7PH+CptXm7kFpPf8hQCBIBCdlUgnPzLo5qqp61XoVho2QWKzFVMZp3q/gf8iiRrypTXzQJCSMudKgEGbtmIqtQv8aVHhbWTIb8//mXHwCJbq+/x4Of+lH+FzY1xD6StFD0n9B50/EOmcdtnkyaehacmHJM21GIxEIi+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980273; c=relaxed/simple;
	bh=fh147bjKRK8Iha9U3NwQrz6u7WAbF87KKbEJa3y37Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnaZDPfnF43zhTruZz18EoS0L56RjO0JRPmwPwuBun7qG/d3T+PlxLqkbGUubK81UYNQ5Bk6tuwZ3UlL8V2gm81b8dA7ML0wAyORNcZp3M9bbct7L2IlVKeRMBV8ZXraT7dxD5nFVtPftAeO3BBshR2M8DfZfBTi2V4PO1eKen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXkLuyTA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXkLuyTA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c0d16bb24dso626405085a.0
        for <util-linux@vger.kernel.org>; Sun, 28 Dec 2025 19:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766980269; x=1767585069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWnoKIP9+b52CxRxZNQgfaSU8LtRGCMIuCkTmFpapj4=;
        b=QXkLuyTAfDADWB3hxZmJvtSMw0o8i7nsu4vKNZ6AK8W7EE0doPM9FNgSRWYOvYo776
         mFUuUwtqRhvlw5NrRdPqX05cCX0qEPxYqPfKZhTLSmJkjf5EpG9SOEkpUZRzzRhgngRG
         tITpPtfnrNpBKmDqUlcQPKmaWxeNeiH1QJGCDzoqNs61aNmMFEGlJGS16PUH+3l1Yq49
         pueBnpplF4SSKKVmxObXccHCBA9GehRTDtJ+U0/1jon9pp93Cekw7sW/n3hoXk9lnymB
         +SCf3rQvx1J0gsChy+FDyqjpzV0LjfstTYJEAKtpXnEd4DUaBsvnxyRNty6HJdCqJiXU
         K84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980269; x=1767585069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWnoKIP9+b52CxRxZNQgfaSU8LtRGCMIuCkTmFpapj4=;
        b=h6zzy15dDLEqEuaeFlKM9ojMrJfcJHAlVyqMn8TAc69Y5l5DqMvtP//34fhSfI/eew
         CAWYgs3EVqi1Gp4Zze/wXHbE99MBgQUPIPIOpbeLMfotMLadr7diMie+G95j6APA2iV2
         O4l+sLeiDp2zIBs3TDGBusN5t+hkTVVwqzxY7Ks95j1qkardtgbZ+jcQuXg3XXdl8a75
         UfCb3gTcgsLyXB3zUJ+OB0aoRXDg+BT+BlwXMvxkwfOgapB0f8kzutS0tz6D7wnTEJHD
         7tTdxcCYqyb03HjsnmnXclS0Vw2mg9lfWU1Daf6/8U+bbnpVoX4urq0GSd3cMQKJFIT/
         xpaw==
X-Gm-Message-State: AOJu0YzYfg+yNcmdRabulWDzJKjKWBAGhQaEyFnsh1rfNTGIhzapti6/
	ZCeeYGujV7/B0ikebf7o0VWXCopoO7vSqjlos2s+YZFJMmTLrJy4S44FJGCLGw==
X-Gm-Gg: AY/fxX5tPDq6WwPTlPswAFF95cDzfwB5pns/C8c6CktgM8uac8EcMu2SMH4EuXQNzwu
	8bpUjb+3+68Ldp4phF2hpIzgcVealsotO0y6aOPlfOFJ9x5kd+C+D7YDRP5Sc72iGFfx1yZgJa/
	GAopLAppqV/4P4YGYfJY4zPyoI405M3nqeo8r34shO/mbWT3gDkkU16g2sOo5UaHQSqC0LjLidE
	w8BdwEb3xcgcPPDGJMDIpw/BSjkAuifcZA9tFCdd19AE3cN2qgiPPHEuarO1UYuH42M/IuSEqkn
	Vie+UNcNzXJGbT/HvJD+1thLsnjE1o6f1hgYzsf/1vK7VvEZYqL8YkMx/08DaNQBwM/8pPLdg+y
	JFRpoz1tm8gNDPY5b08Vh1isOJ0PaRnq2HUpLASrDjkw5YK//vbOrQP2Z8+t7LlygDuJuyR43IJ
	2UuDps3uDZ8FLLoomOAFSiqnS0qQ==
X-Google-Smtp-Source: AGHT+IE73ftNNo0+1Hva1xiZ0QGnjrTqSjdoiZbncqeaSubfkH1a8+s9Wyu8k1u8JPbuNV/J5QyvfQ==
X-Received: by 2002:a05:620a:700d:b0:8b2:2066:ffd3 with SMTP id af79cd13be357-8c08fbb9ad7mr4564121785a.81.1766980268825;
        Sun, 28 Dec 2025 19:51:08 -0800 (PST)
Received: from penguin.lxd ([146.70.202.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm2245401385a.13.2025.12.28.19.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 19:51:08 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v5 2/4] libuuid: refactor gregorian_to_unix to populate timeval directly
Date: Sun, 28 Dec 2025 22:50:58 -0500
Message-ID: <20251229035100.5778-3-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229035100.5778-1-kiranrangoon0@gmail.com>
References: <20251229035100.5778-1-kiranrangoon0@gmail.com>
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

