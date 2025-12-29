Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECD15B971
	for <util-linux@vger.kernel.org>; Mon, 29 Dec 2025 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980271; cv=none; b=cvhlELQgg15WRS9hcB72QH8S3BtUN0DAJvZANnis6bElwH68Ou9GpBaVr8a0izkdeNAU8WyYbMdxW9cifBt4rEcNiIjNpjibQSXRzR7e6Q8C/2Ap79UxhAovmOYLE6imEonafgzSbcrDUYlNpHOKwg7Xur5LQXsJb3nu6aZPFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980271; c=relaxed/simple;
	bh=ssgGzaMISf25Z5uHbcQLS59Ye0O760HQ6jujXFxtzIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGluGiN81DP/4aT7LX42PC0tWXk0bhWTMWKAkfONCwhuw/rproQ0vYiu89wYLb600RFz0NX3ox4sLo5Ud4Zp0NZFTKdLAe9NNLymuP3sZLc/9p4o1SHrKec53wKSCz+UvTzo6bo529r5IyYTJQPfXgOsCOqnleNiFZ1cPbhFdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg7xQnFn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg7xQnFn"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8bb6a27d390so561125585a.3
        for <util-linux@vger.kernel.org>; Sun, 28 Dec 2025 19:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766980267; x=1767585067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSrzutJG0wsw1gere4gX+uh2i9CcB0OmsPh3NkqLrW8=;
        b=gg7xQnFn6gzUWrPYb7Ww3+f731KT5CXL4oiG6jwMPkYF5ol5Cs0rwBSMqSz3PDSyj3
         gw/vY1DdYvjseCE89Kb/F4GESQ36GE66hqgA57SrxLSgUAgcL17PEWEo5xizg1jRckW8
         3Jey91gGPG3ntcHKHCPG258IrJMHNalAPXcLQEkFKQ3Ko4sWY0rubjYAPSfxMYI6GuDG
         BuG6QPrHTJpptWceokXfXFWXxtK5D5nAhSDFFyswPBYg637XZZqahWgik794qOB+RH5T
         GtfM28K/TT9mhhEHMGgL6SqO5xvD1cIpp2NwZY7t0SWUvJViZSEmiDmeQmt/IK1iqp9/
         +18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980267; x=1767585067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSrzutJG0wsw1gere4gX+uh2i9CcB0OmsPh3NkqLrW8=;
        b=I+SzMUcG1gqD1KQLtGghALR/itbqMK0vYOZUQAkAC4+thx8eadcO7x8amDYOkg/UlK
         cVU/5yqDD+uJFU06SKnIejjd6U29r+qDHSYqWAEmbfMFvZoZw8VMdzxaItziydSnjMmr
         DshtRKTTxFtbUkXU65W10qe58bB7JT5FwH+jcclJ1lmXnLrndoRxoM3rMuGG+M4Oqkzi
         YkTLyYvLNFAQtFz2M6kJR00WFnKBJSRO6iXHsBOX6I7nDyH0LvCW9LoMNfP7dj2NWrGP
         sm/OCHDnyVLVyFQA6/nEMzAD5wn+o1Uk4mJXwt+4hNiab2LlEFD4hGWUxy0aD1fpLZ+/
         6lOQ==
X-Gm-Message-State: AOJu0YyKBGF/VFPoi9Y6kde/UwZoNnHiRmkrDP8m/x46BYc3g5UyMPQr
	14e/B9sdXli0cv4d7UXgk/j8bsS+Wr0STUdEXTqk6eVM7GYqsMte0nDOZ08yZw==
X-Gm-Gg: AY/fxX5K5B2jrW9tssRxYoRPvffhikxnlfTHS4VZi8tOu76LLMay7pejm3wP9oP+veB
	ZEgODTyFK6pZOZXNFsj1282AvxUJEZ6/iB47bhgDUpgcrKkgmPG8OZJ/r3QUJ9iA2upKJiytz6y
	K+26Jq1tRIIAaChXKxGTct8B6cpr9vluxX2KIAf/OpUarpiUjrMjYveOK9aZVMyZgyOgKGHw7Sa
	WXA+gtvHhVkO6M6xI2YYhP2Yhz0idyU3D7tAQ/B6dvFs4kSlQ2PdHUYcB7ROwSOrzrwYZkcCGOW
	MgHfl1fJGNqTJCUaGftCMTnchS4JBMboLNDt/w9XqQuvcOcJHsAh5FnyXCjs6XoY+lafa7y1wPG
	ZOk2MfAw84wDDd71Bs70cJ9Yn8iH4ZmSwjmgXhjEnS9KWdKUNcMrg562RzvFJn9dfwqWTsUbo6s
	kVkCzau29u22/MkTg=
X-Google-Smtp-Source: AGHT+IEt37Tjr2YsJxRVKWRjN8HbKtic0niLqNf7TNSOLSb50hXadqbA8E65/Y+1mj2hI0AgFAIs6A==
X-Received: by 2002:a05:620a:3195:b0:8a3:cd9e:e40e with SMTP id af79cd13be357-8c0900282fbmr3968887885a.86.1766980267301;
        Sun, 28 Dec 2025 19:51:07 -0800 (PST)
Received: from penguin.lxd ([146.70.202.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm2245401385a.13.2025.12.28.19.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 19:51:07 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v5 1/4] libuuid: simplify gregorian-to-unix offset calculation
Date: Sun, 28 Dec 2025 22:50:57 -0500
Message-ID: <20251229035100.5778-2-kiranrangoon0@gmail.com>
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

