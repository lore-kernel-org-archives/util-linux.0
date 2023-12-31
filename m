Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F091944D
	for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nQ/XYzrz"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-680adbf077dso6339816d6.1
        for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 10:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704047291; x=1704652091;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
        b=iEM2ljV071cTuc5fj5wFdxvayC3S0lW+j/hXYSciGpAJvlOZgi4u0wjVExnhRLQYE1
         QW4Wd+B9p+IzplE9fbCibGZOjz68V+B7SNkoGSTnEfHaPbE/8I2XxdTPC2hdK7a7NjVj
         kBaltFvkWYRWXk0UipTN7zplEHaMdqYd8OgndyiEs4WzPQFIdX/Y2De7CryU3Dxx6dke
         /uATIF/LiuDFvIKmepBPDCyJFQfxKaPa0ugrskM0JK6pcZ2N07pcbDOEWw1QZdX80FGT
         oYgqZVshm7dv5p989Pz/hUTvcXPuYSGC5mUXmtdoCawmWJ6WYf/+1f9UJ5KDoLeftzIs
         kdpA==
X-Gm-Message-State: AOJu0YzNdBouKOY/2D+HtpWNcrGRwI1XSBQ1zTHDWWJ/LoF6Rf1z8Jqe
	DmGVr973DR2pO9+7p6Sclj4fhLAuPXuomg2+vc/36CoaiLJq/aDFu80=
X-Google-Smtp-Source: AGHT+IFqSQt5F6eaQyibGxjd80pVOjOKXiBbjM0I43tKudq9sgNme/7jcX9JwJJy3Z0TJkHrbJmxyOQpeYYy
X-Received: by 2002:a05:6214:da1:b0:67f:54d1:1359 with SMTP id h1-20020a0562140da100b0067f54d11359mr24716935qvh.131.1704047290911;
        Sun, 31 Dec 2023 10:28:10 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id dj14-20020a056214090e00b0067f70a5c1d8sm894077qvb.51.2023.12.31.10.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 10:28:10 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1704047290;
	bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=nQ/XYzrzIArEyuuYAwEWQGTJST9KnaWXnloL10HAixoTvKMZrj5vIqc++RflBPtzU
	 tRDcMHluAJfendEq2zr/C/mkeinYEGX5OVF/mEWbHgetjeVROptcP0cTHxDxCb5Pr0
	 1BLE9gjfwiFu0E22LcrFqwjygvr3UhUKidwDw4VLUWZN6NEjV8RjBAfu2t/DVB/z7S
	 npKkbSkPkzufPsbcfq8kZbOb7YK+BW77xORmRAGEW2mdPE+0mvbHXVpjPDCK8xU1TA
	 ukRKhlXFKdgMDHRmRJ+bcLOjJiOAQ1IbMbO+/z8K6DMUQNwqzWRUJDF2qLSL56Znsd
	 /yOiDvB/Uo6hA==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 50E4E400F82;
	Sun, 31 Dec 2023 10:28:10 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 46FE4B84091E; Sun, 31 Dec 2023 10:28:10 -0800 (PST)
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
Date: Sun, 31 Dec 2023 10:28:08 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231231182808.3387-1-echron@arista.com>
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
