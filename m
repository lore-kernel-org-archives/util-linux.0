Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D42F39B8
	for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513012; cv=none; b=PceeaxJJcADIpC2xmyDNHMfFEmkL3acepw9FrD75TI+WIw9x56CBIjBYSnAoLOFbOblB3+b7xqjbj/u1PCfgxriP83mQ13hTv/Hd3PFn8ujVKsimV5wO2sP0LZCVpx2cZIls2THPJzVz36/7ByIaFWla8oLFZIt0HKfQTp0A1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513012; c=relaxed/simple;
	bh=ssgGzaMISf25Z5uHbcQLS59Ye0O760HQ6jujXFxtzIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBr1XneSWHyAsqWYNuZ1kCkcZvUiVgvJHqJLbZGI7GEnOylx1kyGC5Ws66TqfQg1fZ2CD6qvUv1NkKRI9Ghskr54/HsdbxSaftOnE3K2j5hu/Xy6EF9hPONuP7CyV2Rnfgr7AmOaf3kJ9OdCBnsZN3lQ8yjH2LuNCLA1uMK9PBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epmIFekD; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epmIFekD"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93f63d46f34so1823165241.2
        for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766513008; x=1767117808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSrzutJG0wsw1gere4gX+uh2i9CcB0OmsPh3NkqLrW8=;
        b=epmIFekDHxl6ndgqwFIlVGUfuJiN9PDA9tz5e5+0cz7fNCAYAqaeci6y60G9qVxoQX
         IfNZWHr81D8kc0rWSWt7Dgqn01TJ4m7NZLn5IZEj3UA02fNZwjx9QnXnHwWQRWmL5j1w
         rSMx6et0lNJx7yuMDVy6nwClS2isxbWRp5+wDk2TnrRIdIAiKY5/0MpQA/ZbBhi07yZb
         KNyVK0CEdzRBvTHFksQVm24V54pIjN5E+vdKdwzdEPTesxN1r/q9+wXqikJ/xym4mxb4
         R/xNs+cOwBVR5HpDcPxvqtmBcI1BFWnbTohqIDzDc5C8VmgCv5aQovrURCPgQf7Qd0rP
         vvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766513008; x=1767117808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSrzutJG0wsw1gere4gX+uh2i9CcB0OmsPh3NkqLrW8=;
        b=XqB2EUq4HPD9ze+zlWbZOW8+5qvFAz2VGA/5cQEkZ8wUSnVJE2+rDJ3ihbuIsZ6uPL
         ezSujVuSLpSrMPBMbtTc5rG1vSCtMGWYZwZfb126qBGGAO0cn2XUdXK0oFyvu/hHRvaJ
         cJd/8mOywL1b4iHRaMWJILJND7I6OJ2kNtoIzOyGzj0CEjn5+RFvac77RSx6L4dwR869
         14P6JLyGBukOWqP9wKoAULnqAGhG6V8tpUBIQnUgUidUnVqYQkUIq+FHexpL5JfjH511
         2v8isYHrRNbAkLtivyYdbvYEtAPCtoyb9Xo78OggyYJzoR6njn+8HoYlxA4uDQxjsVWW
         8Ckw==
X-Gm-Message-State: AOJu0YwtXaABMpv9ToUa0iAWBBhysuPmt74rnSRUDXejasq1HaTJp1fL
	MJT7Qrl7jWFWD+thaLrt5kH8m1V65yoeQm1WuRkFoco0F17F3akTXDvKc/rtlQ==
X-Gm-Gg: AY/fxX42HkuJZwGgMoJcBEyx86fbmpwL0ACQvEPBG0IP73iChMtpXisYU9N485yc2sI
	ho/UfrsvfnXaUvnBWkX+XFndTH+5TGyde+8bzESk43rwjh4SFgOuH7E2Io17xECniJ8O09uOdv2
	yy8pLsucD0usjJ8cpHZAmKlmJn4fi5RjDa3wFncc7NDPqkRjP2K+PdGFLwys98d3dqm9dZ7QKW8
	KD1f3FjlLgVj7h3xACxp3gTsqgSK9bSYgIm8Z7BOazdU1Ep2sD1hUdaZ+sXbccd0fheNCKZUEnZ
	pUrBND+XSuAnYydR0uDNByV/JDXGTQbSl/QFShJGk6kKTTtuCkZcZFCKJonM2au2Do9SRKb0HEn
	Y0PjbT2xWmovEpAH2QTFUaA3L3goZm96SZ1LnaaRVoz/0GG60UB2veFKez5aE41/E4bsVtxQERn
	j69eLRDR46hiGGNkC9PVleMRLOOE38sk3cVGZPjxAQlAkH+Zh8wVNCixRsSw==
X-Google-Smtp-Source: AGHT+IE+guYAscyxZfGQVDIQDMRJBvIR4aNLljSnIzNohZgqpwXSYoGTu+fk827r1w2iyYJyp2ZZfw==
X-Received: by 2002:a05:6122:3197:b0:53b:1998:dbf5 with SMTP id 71dfb90a1353d-5615bcdc744mr4641173e0c.1.1766513008036;
        Tue, 23 Dec 2025 10:03:28 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96240314sm111204046d6.7.2025.12.23.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:03:27 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v4 1/4] libuuid: simplify gregorian-to-unix offset calculation
Date: Tue, 23 Dec 2025 13:03:24 -0500
Message-ID: <20251223180324.2733-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223180055.2396-1-kiranrangoon0@gmail.com>
References: <20251223180055.2396-1-kiranrangoon0@gmail.com>
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

