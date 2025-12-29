Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC9246BB2
	for <util-linux@vger.kernel.org>; Mon, 29 Dec 2025 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980275; cv=none; b=TXFVhfq6S6dfWjjbLBZoSvphh1YPzpmGr0MU8fnPAA1jXBHiNZ/MGZq6f9a83NBWlPMbpVovxf1H9OKLSuERsc1mY2gQV6HrPtW3m43wZfBkFsJSWemMqJkcuN6iVPKAStHmVX6B1QobjDtHNYO/tgWoIjcABMkyIGUzcbtqA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980275; c=relaxed/simple;
	bh=efs0b0Dnb01RfT9h88KJR0eg+JpZS0ZqWSo/G+IpZTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e09OSdEZ1E/RlTGKKCrqpEhuY/+GnJv8ms123z5BPvkcgr5W1LQ5Vk1jQVyCQoM77tH+RzUPaXIAcIC/yuM45Da0smYeaLw/VzfrmHo4Npn/lvWduW+8eB2Dvu9ZR5kZeb/TMWMY5LKquwsrIdBGKZmzH0syiSbr6A7eehPWzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Q7O5hc; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Q7O5hc"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b144ec3aa8so923906385a.2
        for <util-linux@vger.kernel.org>; Sun, 28 Dec 2025 19:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766980272; x=1767585072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bii+hPbuTm4sFowQ8dJR+Z51jxea2JVsZS0acq44r0=;
        b=A8Q7O5hcOrnbD1pRGQLnV2wemgHOeFIMCPBmbhI+xT7F3pkz5Eg4kgcn9imh8baTKi
         1LnbFd8sCpin2xynvfdNaUkKzD7l9mwktk8pijfsvXeMZ12I4JoALiXub4635pNzUdeT
         Nfc7gpra+hrJqhUMdGIRpFYIzQ0j9u0kbqRdpiXE/8B6U/Tt6w3T9IP2XKaJKlJYcbnp
         +yhNzg+G2OsZxcqJ/xjE1FtXuRCRIbM8lPkZLnoMXVc76PxUDptumSAy2A+9WCFBd1sO
         jslce3BZELW7QeOGlPmgxZNE8Ynqujf9QBD7Zwx5YgVbWAhnh62iYQsdruhgMS3Mldhx
         7zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980272; x=1767585072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bii+hPbuTm4sFowQ8dJR+Z51jxea2JVsZS0acq44r0=;
        b=gUTVTVThT7jFiw+yhLDPQ1jqeabHdbdPwZnKvckF4pjRWm8bkpSSHVnEZwHz4XU9x0
         plbCOuC2ozKFhmLefGirr5CWe5xxQYkxtDwKZsYnBWQ5l1sehFccFf2+TErwvuZOI7Xp
         ZwLVTx48+/oSumo4OGG0kIGYJUXEz20NwLYLz22+DcOwg50sLHBlTwKslfvbVb6X6H/u
         bfrvQs4TWFkdg2QxXdeXARWePJYq3yCjZ54niWPPBSFvLvi+hm4dK5Mbj7jz1c4lsySm
         Lc6gIOeGVVnPBJk6pRnMtf8Ywk2Y0zbQUeoLZEyA/L9SRor5DgquuIdATaQvbJorLk71
         5xsg==
X-Gm-Message-State: AOJu0Yxn7FkVfV6hOievbl2uFJZIHt7sc89u8+VYYpog731XqI75vefh
	1WaoaH1GPKAwcKjkLYwAIMdz8CfGgFuNJAZq8eb4RJitYc6LmpNXrQemWhq/8w==
X-Gm-Gg: AY/fxX7aX0x/2iOKBjaS3z83QMFLXKPb6/VyEjAVZ6JtKKBz8g6M081xL82HYS1Ow4E
	xiapSGo6/E1FSOgA8F93vvBCCHXDRYiR0IH9gHwtu2cMkjsah3rEjWETrvvD/tkL6xmfhaIgtSR
	yNXzU4Pjy+9F/22udosuyataP5pMZ/YU4+BZIMDaSQhPaIGXeNz5WH0OV8s9BiHUH5Vel+ZhR7z
	IkWCEQRS553b/8dIIWJPvAtwiOHioXMW5vvadXOZ88JJM/Wlt6XGnf98mQEUlW1dDFXzIA3+qXX
	sRMJZ+u18ZL0mA20XVu83tJBA8sydTRXW8/sJ9N6s+ELB5V3IguquzuoRx+0wNLn693mJqQbhgs
	pW1n2Nj6V/E4YTKb/dQmNZsvNvi4SuBSVOQmkIXEGX/yIYouut0nytep+hi86xBmjVc5U7OFPaM
	lKVVlWlDeH+SdP++xHAW5y8fVs9w==
X-Google-Smtp-Source: AGHT+IHHUT+4Fl/l5vyFK52R2dcqCgknrsJUClrqGc+m+dmM3k41erxrujRi3tXjHWTs78akiHYXSg==
X-Received: by 2002:a05:620a:2950:b0:8b2:f269:f8a1 with SMTP id af79cd13be357-8c08fabf8f5mr5156332885a.71.1766980271845;
        Sun, 28 Dec 2025 19:51:11 -0800 (PST)
Received: from penguin.lxd ([146.70.202.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e3d4sm2245401385a.13.2025.12.28.19.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 19:51:11 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v5 4/4] tests: correct UUID timestamp test expectations
Date: Sun, 28 Dec 2025 22:51:00 -0500
Message-ID: <20251229035100.5778-5-kiranrangoon0@gmail.com>
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

Update expected timestamps for additional test UUIDs to match actual
output. These test cases provide coverage for various timestamp ranges
including pre-epoch, historical, and far-future dates.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 tests/expected/uuid/uuidparse | 3 +++
 tests/ts/uuid/uuidparse       | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidparse
index e44964b30..61b49ef66 100644
--- a/tests/expected/uuid/uuidparse
+++ b/tests/expected/uuid/uuidparse
@@ -29,6 +29,9 @@ UUID                                  VARIANT   TYPE       TIME
 9b274c46-544a-11e7-a972-00037f500001  DCE       time-based 2017-06-18 17:21:46,544647+00:00
 1ec9414c-232a-6b00-b3c8-9f6bdeced846  DCE       time-v6    2022-02-22 19:22:22,000000+00:00
 017f22e2-79b2-7cc3-98c4-dc0c0c07398f  DCE       time-v7    2022-02-22 19:22:22,002000+00:00
+bf2eb110-d788-1003-aa59-ce1e9e293641  DCE       time-based 1586-03-19 15:05:26,3611398+00:00
+f81d4fae-7dec-11d0-a765-00a0c91e6bf6  DCE       time-based 1997-02-03 17:43:12,216875+00:00
+01234567-89ab-1def-8000-123456789abc  DCE       time-based 4764-11-18 19:35:47,841162+00:00
 5c146b14-3c52-8afd-938a-375d0df1fbf6  DCE       vendor     
 invalid-input                         invalid   invalid    invalid
 return value: 0
diff --git a/tests/ts/uuid/uuidparse b/tests/ts/uuid/uuidparse
index 2903ce56d..f131986ba 100755
--- a/tests/ts/uuid/uuidparse
+++ b/tests/ts/uuid/uuidparse
@@ -56,6 +56,9 @@ echo '00000000-0000-0000-0000-000000000000
 9b274c46-544a-11e7-a972-00037f500001
 1ec9414c-232a-6b00-b3c8-9f6bdeced846
 017f22e2-79b2-7cc3-98c4-dc0c0c07398f
+bf2eb110-d788-1003-aa59-ce1e9e293641
+f81d4fae-7dec-11d0-a765-00a0c91e6bf6
+01234567-89ab-1def-8000-123456789abc
 5c146b14-3c52-8afd-938a-375d0df1fbf6
 
 invalid-input' | $TS_CMD_UUIDPARSE >> $TS_OUTPUT 2>> $TS_ERRLOG
-- 
2.47.3

