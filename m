Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF652C1B8
	for <util-linux@vger.kernel.org>; Thu,  4 Jan 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XNTSjHNV"
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-dbd5b96b12eso882787276.2
        for <util-linux@vger.kernel.org>; Thu, 04 Jan 2024 12:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704399063; x=1705003863;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
        b=YR7LN2O/ntL/GdVwchBzHRZewPNdq23ogDlX5dkaZc4QAJHuPLgMT9MJEj8n1ibrc5
         TZzxk54RV/Y7eS5YnwOybYRBgZ9/H/elyRBe053w8T0Y6Y+DljxL57bjXlNBcQ4OMHMC
         TuWrDQZteEZ0aJT79V38eDRfEyyz3cBgrl4Ydxo/H2blnIqH1mDCedWXyDHBY/32l50n
         IeKThfo5v8HrBKpIZwQOUx5OCreNM8fMwJPvHDSn8YYaIpxDAE6nO5qLpDURvWm8c/PC
         iemgEdNi1Vx3nGnpDayvhIsQHQNYPuFXTF7Mg/MRyN9bvXF5mVop3ifS+4dyH2sB6dwr
         C8jw==
X-Gm-Message-State: AOJu0Ywx/X0ikWPpYjKP3pAj7XJQb8EZD0pQ/HlcE9OS1wh3n16s3T7x
	KVtdAILGm8HhD2msGprzuRp3zmLGzXwU318ZsFXY/ABQGIK+z5bo7/0=
X-Google-Smtp-Source: AGHT+IFZb8Miqphgag/KVJIyfih2BErMu6Zh1P12o87++TTBCyjphTLQyZnbwaaANlLcH5csVkyJWlSarp3r
X-Received: by 2002:a05:6902:cca:b0:dbd:457c:ba1a with SMTP id cq10-20020a0569020cca00b00dbd457cba1amr1126002ybb.4.1704399063058;
        Thu, 04 Jan 2024 12:11:03 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id w21-20020a25ac15000000b00dbdb488cbd5sm1331ybi.30.2024.01.04.12.11.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:11:03 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1704399062;
	bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=XNTSjHNV37NPQFX+2Xw6s2KsgvaTgDPvXgjzqZriJT2a3AZIKl5KyncJ8JQN9hi6r
	 vjikf1VIVxHQDUKtDed1hzWQp2419jup2NNw0C+QtVEmPVt7jVbM+tpxU/2PBnUfCf
	 rKbzVxzAIyW0g+wRgF4ji7ufW6cKXuo0vlZqelT+OC1TwxNxAAz4zE/AkyqhB1g3p+
	 qV0kiVhSwQsUzCbWUEvlLN/XPbJeTBo9ooMjVpSX9PBJq6K6MNUT+6QxL4ybVAZY/j
	 YysEIKpV/B2wzGgbSjttQcazTMO2glHBvPt+yiRa7CAe0ukcn62IeMPcO2OXr1cRlM
	 NOlKJTqpFODoA==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 7A596400F82;
	Thu,  4 Jan 2024 12:11:02 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 6C2A8B8407EB; Thu,  4 Jan 2024 12:11:02 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Edward Chron <echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
To: util-linux@vger.kernel.org
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Cc: colona@arista.com,
	echron@arista.com,
	echron@gmail.com
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Subject: [PATCH] Add standard dmesg kmsg interface tests Issue: #2663 patch #2
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Thu,  4 Jan 2024 12:11:00 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20240104201100.27281-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Submission to Project: util-linux
Open Incident: #2663 at github.com/util-linux/util-linux/issues/2663
Component: util-linux/sys-utils
Files: tests/ts/dmesg kmsg interface files and related expected files
Testing on Fedora 39 with Linux-6.6.6 Kernel and CONFIG_PRINTK_CALLER
config option set.
Patch tested and generated with the latest util-linux code pulled.
Revision: no caller optional fields in any of the kmsg-input entries
Revision: retrofitted to apply on top of Issue: #2609 and Issue #2637
This is patch 2 of 2 (second in the series)
A second patch needed to hold 2nd binary file (git binary files issue)

This patch is needed because git format does not produce correct
output if two binary files are included in the same patch.
So adding the second binary file in a second patch to resolve the
issue.

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 tests/ts/dmesg/kmsg-newlines | Bin 0 -> 182 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/ts/dmesg/kmsg-newlines

diff --git a/tests/ts/dmesg/kmsg-newlines b/tests/ts/dmesg/kmsg-newlines
new file mode 100644
index 0000000000000000000000000000000000000000..a1f96c562ec4da27e24117908a7a1e78f10f9f97
GIT binary patch
literal 182
zcmZ9GQ3`-C3`6(bQ+R*~-JJO0c`6EOVNL{3?>7CJf##!mg!EuoE<!u5%P!3=LCM(k
zhpQ9ag)&0MF&uoI#!D$*CJr(kqr>n+<{(0`_@?1)ORQ&j*x!yx&p^cr8s&&zH$C?_
BGAjT8

literal 0
HcmV?d00001

-- 
2.43.0
