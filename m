Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942A34D384
	for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513115; cv=none; b=lialAZIMowYlGjvlprZxCT6DayvdmXVf46fBuMJa/un/pgC6QaVxyjlaWNgtzHTkcrWiGYOU+KnxPMEDskBdTyp8v7f3cca/HS1k0E+zjZp15xWVohhlIUimoq0JzYD4KkainBdprZZCryXS9jWxhxy1FPpC5jEWoWzvTfrzf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513115; c=relaxed/simple;
	bh=efs0b0Dnb01RfT9h88KJR0eg+JpZS0ZqWSo/G+IpZTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiLvQqzlozkAf+LXIKN5I5mFdEaC80HW5ZXFn36KZzTJb3yMBVTG5YFzw2dgEf3h3P772f+vHf/sXl+c3pCRtStSQ19Vocyh7W5PUq1L38gsQQxjKBL8XIJ4oQDKGHLr/f9i9KbZ4lEPsHFqp93XAHmjkr3XCvpiT6l2TTiwXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g35MW2k/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g35MW2k/"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88fca7bce90so34355976d6.3
        for <util-linux@vger.kernel.org>; Tue, 23 Dec 2025 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766513113; x=1767117913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bii+hPbuTm4sFowQ8dJR+Z51jxea2JVsZS0acq44r0=;
        b=g35MW2k/RJj/i0cbEheTQoOjK4EHoJvTrM4PJKS3alNOgaGNQUXYoDdwYlwr38dAUX
         cYMlMV1fLJtwJu66imdH6RzOMPdd0pqH2ldOXLPxOXclaBbcjk/fctmGQBrwJrmPDrnh
         4VrogamlrjfQdLZGgyyRNtLgXNWQJzFgWGu2AQOeea3yuYGaflrPO5l8CjDtGROCsF6V
         vLoCn0vJ1Q8/nT8YGsNsmWVdWVHUSHlBnwL8vNNkNlxAH7LzphGZvM0rpGkr5SNcR+KD
         IuUaDf5909lz24p63/oecMxV+SJe7WAsxy4D0UfhedL7uie7FXD+AZnZpW/GVlgHYeto
         QKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766513113; x=1767117913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bii+hPbuTm4sFowQ8dJR+Z51jxea2JVsZS0acq44r0=;
        b=ZcMYl7ONgyTbSZzNM9eOs5dftvwlT9BXB6KybT8a2CqHmB7cBZQb1n0lSKN1sygira
         a0RW+2W1B7hGyRX9HjudEcYvQ6dH7MDlrFAkILztZdYmbnSw+S6M3JoqbpFzLUA40g2D
         weqjaTH9Iqa7j48sFP08qLYB2E0+O+9CPEIOsLfShEk9ETiJdFYvO2moaGmCYMYeGHNw
         U+sIjWEmdMG+R1LpZrSLDgCbd2FnMrfWgR/cl+EHHG2UidXaW3sFDvpA1kRHgXjQC4Z1
         5mX5ds2OwPzF0RwwP/NQkYiDQQ19pLUFyri2k8ElAxiD7egzvYqVuLpHb9+b5C78CNga
         kUnA==
X-Gm-Message-State: AOJu0Yy5GJSh1kHkK28dLe1dZUimeUD8aq44vOtd4EUOrOA2cOgXDkBb
	1bVSt27TSmmiMzctjZ/P30YC4d8VbHqF/vWEDFrLDLVTMEbI2rzLu60OndRX9g==
X-Gm-Gg: AY/fxX6V/K045dW4a6B+uLBRGHc1qzvWxm+ZAsS1PwKHqtFJsH6WLCxQglEm2JuaaUp
	3sH19xTm+hVqrjiFqa9/knZlE7b28wdccB6RTzDHeJA8HG+V7JX2/axLMugg8VpQcaUboAppLgB
	sI5bsUXkMDr+Yj7s+Wc1UlwtYukmk4RcOmcwD82DStrwVZVhNrO3bqoSVTRk7YF+uTf5aiwL/c5
	aTnRTZH9iGVEoEqAgv95pZfuPuj4qhX7zZyNs9PSAFIRzrl49OTncBDrjB5vIz3V9Jdv78U7MoG
	isvGjgXM7WgxqgSU+bObV7Yns9Rfkf24NULFdKZwmbEWe5wV9mKk6aNMHpG1J0AoqXjY1BN0te1
	wOI3S4V8agGl8P42RyeN3u5TrJ62OMT7poRr7LCpnbb5d8nx33sjuu1yUW59sC3zCPs1WrOyVtM
	XOTHixdfAOtN3BLQbEmBGHB3rI2WO1+KLnKBwhOi9vJbfPBzSwzbBNkJpJzs8VrsYcJhz/
X-Google-Smtp-Source: AGHT+IFcSHdoPkcmwOT58orax5CgJfL6Yb8YOM1AJgDR4BKrNmM2ZNqA8fFOglHgAmaw+1DOa6+C3A==
X-Received: by 2002:a05:622a:1b29:b0:4ee:61f8:68d6 with SMTP id d75a77b69052e-4f4abcceca4mr234674581cf.6.1766513112469;
        Tue, 23 Dec 2025 10:05:12 -0800 (PST)
Received: from penguin.lxd (d-23-244-101-146.oh.cpe.breezeline.net. [23.244.101.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d969fed73sm110246716d6.15.2025.12.23.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:05:12 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: thomas@t-8ch.de,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH v4 4/4] tests: correct UUID timestamp test expectations
Date: Tue, 23 Dec 2025 13:05:08 -0500
Message-ID: <20251223180508.3287-1-kiranrangoon0@gmail.com>
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

