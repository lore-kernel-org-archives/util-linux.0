Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5623717F
	for <util-linux@vger.kernel.org>; Mon, 29 Dec 2025 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980273; cv=none; b=rtWbGK1112ucR3SeaOKiHuZZVVFZcQPjqtzVEG/GVYT1mn4QzPCszEg+ZjqwdkOp1quDDiaWD49zqhhO8hiJr2avPA58rii9+6rrVS/OwbH99/QP2uXIT3YeSP5AxeNRn0CmaIH6mrOAb3vpamqW+N6wAb0vME89cAVbpiYQUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980273; c=relaxed/simple;
	bh=Ufa0tg5plI8X2wi10ftsEp5NQO+H/skFsfBMKOLuBZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zit7MjQr7kQhZfwpDBpHbaPHJg95+Ep+RqqWYrQ/97tSnFTtwGGn6DqvCt8nvBqMhnx9k+MYkCF+dMyjOUzzVYBj9sREZxEuVlCfPq56Td9n/Tw560nLLQdHNnU5pLcOPzhhe4o3KQHlqVZInymtMMzUUqSd+0E4n7TuxsKWqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fcv9D0+E; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fcv9D0+E"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b29ff9d18cso1034944485a.3
        for <util-linux@vger.kernel.org>; Sun, 28 Dec 2025 19:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766980270; x=1767585070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4bretwmNKCWymzrZyDX9RcpSv0AXkYpvzK6odtXnoY=;
        b=Fcv9D0+Eh47lSijra3NefQdGiSQqV/IETBPU5SVFQJAlsYutsO0hSGIEcyOVMbYbyA
         cK1hfi1rgiaBFbUAyBZVmjjnYlMkrlXdj17fpG4DsVRx509Jq9dbBmYdZlGDUQpT2/M9
         oJ4LYG0kZivW02vGWnIGmNMEcXIbeKkNmiur4GDCbqtqE6bSp71QFblu7RV2v5hqo9MZ
         kxc8rlx7NqX65k6uQzrylFI5n73imPur9M778leOi6feBY/mRbKl5J5L58FQIpfkqczQ
         kFWyZWzvf+HeFt1A2XoMY9N+LgRIpt9bFblbCA6Kvx1oUH1wgfknBkupI4otjdghaIkB
         ybJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980270; x=1767585070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4bretwmNKCWymzrZyDX9RcpSv0AXkYpvzK6odtXnoY=;
        b=ZA/1OYT+b0LX5jAocW8Zt/g+7PSLWEhRYfTzUx5KfRV4KAM5fzNxogIxeCAnGyGFf8
         bIzy0h2DQ/BbjEi++L7chkZja10ZpsRW8WZKnQrztWyC2ooub+3iOmsvQm1BLcnVyPKo
         aP/Wn5ac0xTTP33o7UNuJP7OmibA8wDWVvwIZEreklTqY/2dfNT/f0r7NynuzjsTlAaj
         T4JjtevZKX/vYVtu4EG9z+GdDPygsKY1qrGYuN4595fzl8wEMp2RUQs1/5WvZ8IooTYb
         bshy9JK5oBy2Gx7M7204NLw04Jx5rQmRVVMGRJB+/RjnMoJy0wZigyN1DFy0HhOKONtX
         NzHw==
X-Gm-Message-State: AOJu0Yy0OwPeGBtK+E9LKG0MmyviXPgvONG6aQKPgJ16tX7PyjEaRgQn
	VjliMg2RT//oMHRBfd//Ss3VjXJUaMGMuNfPsF2oZaWVAc9a0eGNKd/xfWBcHQ==
X-Gm-Gg: AY/fxX7adfnTKmTvN6uo8a6TKn5pZN1m3A4SKwnLDtOypuQB8YsI+rV/MxOqYoO3KW5
	DO0PY5w4vfF/fbbglUkkqmc/RKMRLAJu60rWyOSS17JfntR9M9XB9pWdrZYx2HDpD+aL586fSAt
	/hDzevag8UWyFibdn6gBohpGQH+jsnLgqqo5cngqHCbeG09XSdO5V177En6mX7pKFnqajMOd17M
	40ev3Y1aAtp8jNAWNAGs/2Trg1Zi7CGkJsUYPsjyN8X2sIFS5k8iPran1xPcLGvB9xPAvjp0/qz
	3jaiNk7//RtB1CaPRG2cMvsvWpk5E4gNyFKorRAzQY8KIAXfvsfLi06bWMCBcadBoC2SnMhNR0J
	3hByC4wus+On019QjGS6FNGnPkvJXqk3crInXTxETXCR6MrGm+GRv6+KwodJQk6xqPM0pqKuOGx
	IsJ0/EGPsdMJiF6WY=
X-Google-Smtp-Source: AGHT+IF9Bl4kY0KAxvEQFBLuz7N7L7QfRp3KOmuN3488kXEsok+qd4Tqi1jZEXUoBKqmTlP0+sWedg==
X-Received: by 2002:a05:620a:44d5:b0:8b2:d6eb:8203 with SMTP id af79cd13be357-8c090501db3mr4289933185a.69.1766980270248;
        Sun, 28 Dec 2025 19:51:10 -0800 (PST)
Received: from penguin.lxd ([146.70.202.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm2245401385a.13.2025.12.28.19.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 19:51:10 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v5 3/4] libuuid: fix timestamp overflow for pre-1970 dates
Date: Sun, 28 Dec 2025 22:50:59 -0500
Message-ID: <20251229035100.5778-4-kiranrangoon0@gmail.com>
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

Use int64_t arithmetic to correctly handle timestamps before Unix epoch.
This fixes the overflow that was causing UUID timestamps from 1582 to
appear as far-future dates. Update test expectations accordingly.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 libuuid/src/uuid_time.c       | 2 +-
 tests/expected/uuid/uuidparse | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
index 2f7c6652c..63179fd76 100644
--- a/libuuid/src/uuid_time.c
+++ b/libuuid/src/uuid_time.c
@@ -63,7 +63,7 @@ time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
 static void gregorian_to_unix(uint64_t ts, struct timeval *tv)
 {
 	const uint64_t offset = 0x01B21DD213814000ULL;
-	uint64_t clock_reg = ts - offset;
+	int64_t clock_reg = (int64_t)(ts - offset);
 	tv->tv_sec = clock_reg / 10000000;
 	tv->tv_usec = (clock_reg % 10000000) / 10;
 }
diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidparse
index 9edb05e4e..e44964b30 100644
--- a/tests/expected/uuid/uuidparse
+++ b/tests/expected/uuid/uuidparse
@@ -11,7 +11,7 @@ UUID                                  VARIANT   TYPE       TIME
 00000000-0000-3000-8000-000000000000  DCE       name-based 
 00000000-0000-4000-8000-000000000000  DCE       random     
 00000000-0000-5000-8000-000000000000  DCE       sha1-based 
-00000000-0000-6000-8000-000000000000  DCE       time-v6    60038-03-11 05:36:10,955161+00:00
+00000000-0000-6000-8000-000000000000  DCE       time-v6    1582-10-15 00:00:00,000000+00:00
 00000000-0000-0000-d000-000000000000  Microsoft            
 00000000-0000-1000-d000-000000000000  Microsoft            
 00000000-0000-2000-d000-000000000000  Microsoft            
-- 
2.47.3

