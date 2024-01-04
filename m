Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE01E503
	for <util-linux@vger.kernel.org>; Thu,  4 Jan 2024 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="J7qapKU5"
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-dbd715ed145so787639276.1
        for <util-linux@vger.kernel.org>; Thu, 04 Jan 2024 12:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704401087; x=1705005887;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
        b=BCnj6ENySJ6qKByuZIWtM3Ca7n1r+jb+QYwv4x9yAO2KT7PxcwUEyqmEv/4Ot7FXeS
         ojTsyO5Hs5YwFAhtib2s1FE6MuJyomtb71OjF1j3cStBPAWrhBFqoX40QCzCU3vzdWWl
         qMEXvwDGEOQJEu0CMyrCukhTjxomFg8/IL9jLAz7C64NHLVdcPUklF158sMmX/AdVO9s
         SW6Mq8BVtGFhn0YfLj9xEb2+uKeLVYhhwKSMb8Jjfyv7QhcJy838pb8uzZfXkaOiGslB
         8ve8T+kU8SFSYa0WiAlENF1OqnBWAzOhFMh9gyy+9vLwjLVIFrih/huvzM2+Dvz04wwe
         a/Ng==
X-Gm-Message-State: AOJu0YxWm6U8q/9FNupGPpV76SV6Z5F9b62Ddj8w64xcboHcP9WZgQyd
	iJS2FYj7ZdKMDXJVSuvwe8mwMXvcI/I9aHr79Ly3P7/bDuPRQ+mJ/is=
X-Google-Smtp-Source: AGHT+IHrpVTI3Yl8Xcze2WEJk409tDazh33j0xaYXHvzNPXryYzINMi82sFwSezO/ZApS50NUUQbu1yMfbK3
X-Received: by 2002:a25:ad95:0:b0:d9a:4b0f:402b with SMTP id z21-20020a25ad95000000b00d9a4b0f402bmr1137486ybi.38.1704401087020;
        Thu, 04 Jan 2024 12:44:47 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id z68-20020a25a14a000000b00dbe9f2f801bsm3929ybh.3.2024.01.04.12.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:44:47 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1704401086;
	bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=J7qapKU5qAjumHiebtsBYzbkdCDkqTkKYWeE+NfDJVR246d13DS/MOI5gv0DEVf+c
	 BLOd+vFCDCpE+CCFflwdZoQZKwc+fBRK11aYcr/M00SNZVw3CFNGBYDSkDsBfrWq87
	 y913tVlzKZ5tdiZtR0rn2RVef1erBaTtMT64e4w2LBvMYhrfQeBZLcyl0yEGL8Q5uS
	 a/dUR3OriLVu/+LTrnnNWaaCrojz4Xw+4ynOQVQ/V2U4d2Bo4ohce15dHQiTqanxyh
	 nADz/LCNJ2s5KA0493HPGZ/7ZILBijqOHl+AVwaFsbpo8DMlhVETtgwOuS78je9XM0
	 YSF4LeOWh7Krw==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 36CAC400F80;
	Thu,  4 Jan 2024 12:44:46 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 2D47AB84076D; Thu,  4 Jan 2024 12:44:46 -0800 (PST)
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
Subject: [PATCH] util-linux add dmesg caller_id Issue: 2666 patch 4 of 4
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Thu,  4 Jan 2024 12:44:44 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20240104204444.23011-1-echron@arista.com>
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
