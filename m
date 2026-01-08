Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8D2FA0C6
	for <util-linux@vger.kernel.org>; Thu,  8 Jan 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897104; cv=none; b=MSiIXCMg9XX2IepO6w5TX+mRqNNE7FYjUjZSk03K7P/VM8FTCMaU8vBhDMJxcfzHEPSdZGdczWEPnQFoIKsLFyAcnsyr60rDtRwh6PdE2iBmDLGSUiQ2z+hLTP8TFR7ydQCkQNqj16jS6EQ3Yx291LWM1Thz0GGG6+1r0fCrHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897104; c=relaxed/simple;
	bh=blbekZ/a+oQTbwqJaXpycTRCo8sx4p02a7ZVpMsq220=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuu2fVZ/hXJwSlkjNNJ4JSVKoyWPQJhMZCh45CZ/IQH18RYu7ggsx9Ak2WuitQ7tOYV9xKe9Wx6VGowjWKJa+HOkO7qzANx/gcq+dE+suSyKJBVRWPKq20kSTxUjAFG0pJpCiNHLfa5noz7JiI35i61Sn5VTW+2aslwrndshdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la4/9O+z; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la4/9O+z"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-55982d04792so2527434e0c.1
        for <util-linux@vger.kernel.org>; Thu, 08 Jan 2026 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897102; x=1768501902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEtfSVDdHB4gjucM9boKCxB8IpaKtezbQ1BNp+cguqY=;
        b=la4/9O+zPTn6jXZtGh/Vdgh/ehFxvGPZg/g4/ZUsO0fAU/+6CJjJpLiFMtUxcmCxan
         l46vKbkP921c3dcS2hm6jF7RMxaGsD7goyihQCdwWHn6D8ch7ydMdHlnf3YaJPIjGtFD
         xfJDlsDc7p6huPFoGQEgmhsz5sK9J6hc4cUDwL1KnoFxXiV6YM9IRlYEef7f9njbFp0U
         p/ubVRpJk5dvDj680+iOQrUMWw9Tb2T/7eaZlNwiq4C8d9VTk7PB81Hn0BPD19v1MoFk
         c8YWuXbECbAUb3U+b2QeFMTjiJneaucfqQqL3bNXvlzE4npYtuzemj/SudfesoZZ2NFe
         xA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897102; x=1768501902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEtfSVDdHB4gjucM9boKCxB8IpaKtezbQ1BNp+cguqY=;
        b=E3UGnf0OMJVU7EzjY9DLP+NR0izl6IOxkDsq210hEX518/I40oSSgPBKeWme96HGJt
         lKoHEleFMUMPOW/RZy/939x/WmPqjMM9HREFWc5dFgLM7zN8W3BxyMQ5J/AKnOtUqC54
         RhmwnMYUXzEeW/DWla5s+WVwxTqToPOS+QS2lwPPKKrdpALlYVPfM3XSANVxCuEpVZAn
         u34ieemd9CM1yNZn+vc753yZL7wC5IHGJQ9nSINIX6xtk1b6WG3Dxp3zyZbODsav3pX3
         MCbwtGzt2qJOwDDttcGvY/wR2XjmaWZX7hqKm9hNtO2aRqWQbt0ORRaU3sNcbKSj+scf
         /aCA==
X-Gm-Message-State: AOJu0Yz/0ttKxOO3tfzmYwUZS2Ca86wheyjgBBkdufwfZ4v7IEguT7k5
	I5133OdRtiWNjxNU8RyTMWjBHYNdr1gt+PCt1iEtD7I+SS7CDH5Ng1Yfks4LvQ==
X-Gm-Gg: AY/fxX4zbFaxmi/9d6oUlyZm8W8sut2kFiEF8hzUhP3yhZ+0S4tas9Q5NwEWwBysjVu
	RFx0xshZlBTMbx3dKRRW3le3+LGy0V1+xjkAGUcPfFyTy5QIuR+gSh5iMGGS7JjJgkp2RjGB4na
	bM47k9L1q9uGq7uMDTWv/Jk1QByw2fq+X4z5qAs5lFh011tshhFnruLWVHe615i8IJdp58RvZaw
	0cXm4BAOF1hWLWWQjWFCxX2Zc/bGA2MRwxb4NQRo7by5LmU2zVaEXRN/t2iBGqdf0Pg7HbiHe0N
	9gZX0p0KSvRqFjlO5PTKgaCYYajBpVCUNLICxLC3h1tFW93+rDX4L1X0IlE+16gn/Kug+iD8GyR
	bPDVDJc6vyPV8P/w5prYLHdZIEn/tBr4HhWWWrIyr/Wo4S+YS5qOdWxEnA59+bbqwNNqYQf0VCh
	YtUlGdm45m1BM+CS8o
X-Google-Smtp-Source: AGHT+IERY+GWodZsQ+TXCAJt9aiD3zu2+II/wH6slwvCNPEsie0YxHQcR5jkJ7WI/xZQgmczCFY6Bg==
X-Received: by 2002:a05:6122:616e:b0:55b:305b:4e35 with SMTP id 71dfb90a1353d-56348014f57mr2369467e0c.21.1767897101533;
        Thu, 08 Jan 2026 10:31:41 -0800 (PST)
Received: from penguin.lxd ([155.117.189.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea753sm7087287e0c.4.2026.01.08.10.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:31:41 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH 1/5] unshare: add global child_pid variable for signal forwarding
Date: Thu,  8 Jan 2026 13:31:30 -0500
Message-ID: <20260108183134.23980-2-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108183134.23980-1-kiranrangoon0@gmail.com>
References: <20260108183134.23980-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a global variable to store the child process PID, which will be
used by the signal handler to forward SIGTERM/SIGINT to the child.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 5370ab981..6df53666a 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -74,6 +74,9 @@ static struct namespace_file {
 
 static int npersists;	/* number of persistent namespaces */
 
+/* Global PID of child process for signal forwarding */
+static volatile pid_t child_pid = 0;
+
 enum {
 	SETGROUPS_NONE = -1,
 	SETGROUPS_DENY = 0,
-- 
2.47.3

