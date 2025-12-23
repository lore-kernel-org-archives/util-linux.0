Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A2FBF0
	for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513103; cv=none; b=ctmh4AzpDPzR7iAqLOaNthobEqchCS/KFedTAttpyFunWRmePKaT0zPnxDtI3xNESGyFpBGIloWWK7CE7HOlzd7POeY9k9mmfGjsDL2/2Blu0ozy+xb96z1z7kCyu9onIMa4x/n9W4dj52H6bYKM0tNvnT18ahc3h7Z7ibSTxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513103; c=relaxed/simple;
	bh=Ufa0tg5plI8X2wi10ftsEp5NQO+H/skFsfBMKOLuBZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJtjK+43K86dJUV8SmOrprzndJe2klEoOBo0Z49O/JA4iiiBZuc8RH7+KwuhnOY8XKgfYdtaDV9lPRp2HZKk33TmhVFmXsmsm1wao5RPPnDGZzOM6X3+RHM6BzBiDfxX4P6tZ2o4lrd6Es3H0azxVa12rvfCK1v9y9x7eS/TQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HapqyzS4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HapqyzS4"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ba0d6c68a8so572561185a.1
        for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 10:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766513100; x=1767117900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4bretwmNKCWymzrZyDX9RcpSv0AXkYpvzK6odtXnoY=;
        b=HapqyzS4xYBx1Zc5b4J/KIIzGfgmF5H5zTpihQSzOWwaadb7U+WYwOByqemXyIcFJ5
         RvctGlTNzdal14jbmlwNVDqq+yHYme4RyO8ihdNbTS1GCRyNpbOdfoYIKTPPUqSvTUIs
         ADEH2QlDZimUGRy1Sj/8QNkVhcb3y764rs//aKg+9g4lttRAw63IwWramfUzzpkWmTVj
         FfUE9q6gJmYW3DZ2kdldw2Kk8GVzL3LfVOGDrBsv1ln/on8QkVxykFHAUsSxrPmjXNS/
         zv9rlNvc5TFhOc2vQEzM2YWLdtdPO1ZGerFBY/r7ONv0HJGVhrBSBG1/ThPwxpbuLq5g
         d6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766513100; x=1767117900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4bretwmNKCWymzrZyDX9RcpSv0AXkYpvzK6odtXnoY=;
        b=Oljtwo9M8FjHlJmFJlT0ot6u7SYyxDM3tR/8JEbyVebsI9vi852uSXD/PVi64O/k/h
         M9WPkWDXi0xgtqKgNl5gqmQoAAgeM7LULjNcpblbLBeWUbFprzP/jeDZ6xmILDc5eoCS
         6fmAH/uikGh1crFQlyCdyIQBfitY0OokyRkISq3N2GURA/DrfEsMzRSY1CxDFV6e1TKN
         962Fkg1zXVe9yl5euxrPozQFdNKkisa8fo6QiTQ0fmX7w6SRIxMPKGn6A/F7nVTRaa3g
         wwzcX14wPa7va7gVNM8eGKGZiIscltvW/WcCZnWTnMgeqFSWpuBY1qMIBjAFDQHGLiNq
         haLg==
X-Gm-Message-State: AOJu0YzaFI0JjljSly9ACtbP1JKzf5fQ8mqI4Ba9W4Si3ThtaJ94qICc
	BkoER6/TsvCdWCJvG+En+xsJXbwoz47K5X765QoC/WRmiATe8W7skA/TyWmNYw==
X-Gm-Gg: AY/fxX4WeA80AqhMaW0xvfXp+BFN0NonRSnPrU+8sEK2ubzZKycctHMW79dR+cWiwA1
	6F5vhfy5KK5t3dm92MdZXlAmoyllcJ9ilIhjne2yJk1rfOO7PHo57URSWLkT68kzv9RHotpyLcp
	ClohAIdNmUCX4e4+sBeUGLuF5tgLJ+D+XPJGLCFf0x3Fr2AF37tuLigAZCdSjbrvlGRBMeXlNT+
	6LthKzwmxCOdwXp5iQaQoo8RqetkFh8TNjIT34aP34aRkbr8nd6J9gnGhCuxQPigjFtS0JamM+7
	ETEgkKh/w4axjADmxPPgk5E65R5PtY6gDSgziqPyLvHum9ZEg1bEeUHFn4L+RMQGQmp/rl64t+E
	GXU5qNCfSGpPhmPzDEglVLsP8vbfonQd8dSAzdwxTjsCY2COBgFhNUGSsXkBXMTfMdP+vBpnqK3
	64SZidUbGUHtvS8em/9G5SAPjBz4ztqJSJC4fohLq5JkEb6b77UbQz/Bu81AWQBmA0m1WU
X-Google-Smtp-Source: AGHT+IEzV93AshCWlG7oXPaYpsMrBSl/U2f1wbQC1gsiUt3Rg78UEZ1OdbbnggFzp4UyvutvNxRNrQ==
X-Received: by 2002:a05:6214:5544:b0:880:5edf:d0fc with SMTP id 6a1803df08f44-88d833b775cmr250638126d6.44.1766513099890;
        Tue, 23 Dec 2025 10:04:59 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623ffd2sm110329936d6.9.2025.12.23.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:04:59 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v4 3/4] libuuid: fix timestamp overflow for pre-1970 dates
Date: Tue, 23 Dec 2025 13:04:53 -0500
Message-ID: <20251223180453.3133-1-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de>
References: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de>
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

