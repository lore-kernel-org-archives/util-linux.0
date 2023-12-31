Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1CB64C
	for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OOxErwzY"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-68083a0889dso21263796d6.2
        for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 10:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704047790; x=1704652590;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
        b=oyeLYyMeSoBpgali8zxavqABulkBH1IQkoe3F4VywWGqLtJNhgctNCU/vDe+doiYnN
         oxNgKjQ7qJTWLTsHJTlcwHyrzQaqohJ4MNThlkHoGgt1SNWf2qjAJB5CbkhRXu8ecpcw
         XcxpsY8tlQTl3ZwVWE8BKbjVZ+64KmrHixzdFufvJDhV21htENPWVEVrMeHnSOmKV+/s
         JA7NNvr3bMg2T/Oairr3HhXI8BkUL7MIfPFTYWKg7BPkwXO2FSeX1ICzxCYAllSrEDfI
         /I66odV2ajIHMZBSNAe6bhQPOx15/AlqPWDutXYGp9F+dD1VXj7wkUpmrWdbYx5hznHA
         brXA==
X-Gm-Message-State: AOJu0Yx4IUvBUwWyp39uov/7R7SIAbgQ9mgRhmeis9J+/iCU6KANViNZ
	9JIm0CyFAAlsqwqiVqeKr6G4HKAPwQjylc9hMEPCpbAomkoVwr2yj2s=
X-Google-Smtp-Source: AGHT+IHDZWw2Tcb3Qh404Uw9WCP2BXqpvp2d/AUB/1+b46X6rdM3IqjgcBA/nivlED0S51VgHHZQKbdDv5Uw
X-Received: by 2002:a0c:e90e:0:b0:67f:e030:d30a with SMTP id a14-20020a0ce90e000000b0067fe030d30amr12023538qvo.129.1704047790100;
        Sun, 31 Dec 2023 10:36:30 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id j12-20020a0cfd4c000000b0067f624d97aesm431522qvs.39.2023.12.31.10.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 10:36:30 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1704047789;
	bh=Wqw2/4KjWiGCWTXSgf14g1faccj3U/ZQmlsyK7T6b/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=OOxErwzYJlkYNmTAHKZMXOYChOnnj3b42EqgXvVkaW35oEjO++/ZzlMX42sKL2OdK
	 JIVBnF5D66QG+hsPAX5BqX2OqDHM27gcTn0GRxBvxaebNRRZM/+pbxajmXA1ry6m8S
	 5Bpd0bfxRpqr6NnpcCrsbzqd94MMBPzQYXfzSH1R6RwjSDk9QjpWVOJQ8E3ZhRX7dt
	 /zrxSqsB6zDgLMEVWNJGSfSD8nGTAHFE1xDQZr/OEeIzzKPkN8aAxegELCp2epVMn9
	 XK/2KuEm4fBpO/MnAPhSLJ0yBKOi/FnaFLfhrg4g/RGVLyodjnzY2ndrxKGPi7wRe7
	 h/vfeFw0/qo/g==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 2FF38402056;
	Sun, 31 Dec 2023 10:36:29 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 28385B8409E2; Sun, 31 Dec 2023 10:36:29 -0800 (PST)
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
Subject: [PATCH] util-linux-demsg-issue-2666-patch-4.patch
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Sun, 31 Dec 2023 10:36:25 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231231183625.26756-1-echron@arista.com>
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
