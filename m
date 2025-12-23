Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9951D9A5F
	for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512869; cv=none; b=dIekrZzK09pMEIjBY32dHN/ijeJu9P44OA9f+gJcXZLYqxyyTLtsLT7Uajnc/w+f3/OUhfJGoiGr40zCLgd25gUhSifyORUC6XA4GBVoNoyWS/G5IL3AFB8JydDJTAg8F6FoLMQoT20mMHZ3IblmOIl7zBZpIt4Puou2lsHJf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512869; c=relaxed/simple;
	bh=ssgGzaMISf25Z5uHbcQLS59Ye0O760HQ6jujXFxtzIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmrK/PmLPsu4rgAlWC3X5wpn/zdOBUp/sQMyHWmZh6aQbMs0/WSCGW8OUvTOydbsP+mbejjhPepwiO3HxEw2CYbdaOn0QNvue5lIg9O2HwYXKLftwIxNStwrN3qZeBIxvvVpwZA9WUpQAzGRF/DurLegkayIHvuRaYQX8W4rk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJtYWEFf; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJtYWEFf"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8bb6a27d390so325498485a.3
        for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766512866; x=1767117666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSrzutJG0wsw1gere4gX+uh2i9CcB0OmsPh3NkqLrW8=;
        b=cJtYWEFfXyEz2i4/HZfr7OZ+UOqw7hVSyKiPQmsy/pyHhzzHN9oSPmAcqWm3x9ZGdc
         NGRnfmDK+zlZlwIdJK0RjeiuF9ZeGR8zToMi5GCQRcetgN1oiuBuc8L6lUEljTeNEkGl
         +uPg8wKmk8nCw3XKz5+RCfarBDQAfMXigZA3rAWOUcVFzmrlg0XmP7Ikcgb94nTmd7GB
         GIbgJBcsP2UXb8rdgQUT4ZH9doAd4w0rerRWT+8Hc+UKRsTDv4WJUTUlMQoQ/4C63CeM
         Db9PN9pk5wOkEpz2k7DDggZXSZtu5wYHTOFWGMIUFS1tI18/nN2ehMdi7aqzeWvxdw11
         Urww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766512866; x=1767117666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSrzutJG0wsw1gere4gX+uh2i9CcB0OmsPh3NkqLrW8=;
        b=X2+xy3u4JSLLRcD3oYhEX9tQtjtNSOAANAw95AG84LVIjgGOXhmrLBfS6epB+0kD5V
         ACU9io+WWs86mX0xBvM1HsQau0ycEiiBNgRDlLl30t0QYqijSSBdMIJOunQbLpkaccS3
         D3uZep1YP2BZAdL1/gG36zGi4HUcGK5z/YQxJYrHB+3ztD6lJYLXlWUGMYp3jm/yTx+X
         xkfCRmK/1cGagmqtLnEu8BV4ig9fwFZTNEOgpC+K/WwLsqhHkEjYXufBHmDgW88P7cku
         eoe7k+1nT8JdqHjAm0IR9Cv0xtnm7oE+d3XaftxvDmsL3uSFoKcVkYDJGRD17dkWKksi
         HrGw==
X-Gm-Message-State: AOJu0YzNAqPOiSzPbwEdQf7o1MI6jTAQPp83Iwxc2d+OUM7umdMmvuk4
	1K3EKvU4TDvOORAp/A1Xyve4sQVf+4KWuv5zQklEaLZRtkM3gZlnuv3lWkLlGg==
X-Gm-Gg: AY/fxX7fibgfVbMcpf9ifhFkpjjd6TKpkw+u27ZF3vlqbVb1zjpYDqougGlH55flwi2
	Myl8tKXvZi9jAa2wQnnIw2rl58ALW/UsZO/TlY6LgnLvdH6CS9kN32sFo/VUWvy4QvmF3OHEztc
	1mqAWR9KdEREbCwTs3EhaIcRLz1Oie4/H4K1XDw74prhLibxCoIbXr9QSCkmLX8FQdCApL5q/IW
	ALGgXGsWdKgwEuerpNdaGMQhL8S+7r1s9ItPAuYjNDd0SpKm0A7wAqE1nrapf7TEOOVdK9WffAu
	lfB1iT23VjKi0XHkwyecYyXYaTqXOCVFTfIekYOiuu8KjwLg/iDSph8qprqimvNFRmeul7aJQIl
	sirnwAZMcpJFRVx+IrttMZlrdbdhhJoNBTStGQf7DKgaVfswF4OnepHdT7SIOqMrqFu75BCltY5
	lMW954KdgM9HCn40Uf89nkLDXmFB8Smm7TdQ7voP/eNzwBG9442uBKphykzr/hvXGrXIJo
X-Google-Smtp-Source: AGHT+IGcyjys2BVcoesECBhr38u7PNHBvjiQY2SjxSLtf3/VZ56M9pm7mHnd9hk6iRbnmkhHrXga+A==
X-Received: by 2002:a05:620a:44ca:b0:8b2:6606:edaf with SMTP id af79cd13be357-8c08fbf7f2dmr2566883685a.37.1766512866031;
        Tue, 23 Dec 2025 10:01:06 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm1105444185a.13.2025.12.23.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:01:05 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v4 1/4] libuuid: simplify gregorian-to-unix offset calculation
Date: Tue, 23 Dec 2025 13:00:52 -0500
Message-ID: <20251223180055.2396-2-kiranrangoon0@gmail.com>
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

Replace complex bit-shift offset calculation with a simple constant
definition for better readability and maintainability.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 libuuid/src/uuid_time.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
index c7516152b..e2b991d74 100644
--- a/libuuid/src/uuid_time.c
+++ b/libuuid/src/uuid_time.c
@@ -62,7 +62,8 @@ time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
 
 static uint64_t gregorian_to_unix(uint64_t ts)
 {
-	return ts - ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
+	const uint64_t offset = 0x01B21DD213814000ULL;
+	return ts - offset;
 }
 
 static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
-- 
2.47.3

