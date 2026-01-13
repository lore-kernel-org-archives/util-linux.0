Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE036AB41
	for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325417; cv=none; b=D5bUPPcHhdlT+GVIPOm6ZJ8Yzs/lnAsi6R0SJL3OECtXH8qyvS2cjBpZZIwerM6oTZSwfyNvKCMdCuJzWEoLFKKT4HPD2jrQ7+of7C3pmtFpUFjiP6oIObrG7YWKIKx6BKIJshD6OUCbNkaNcBeL+suisRCAzi2p9QAgNegNpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325417; c=relaxed/simple;
	bh=eL+lNzLJraCVCm65r8pZlvIWvi2N9ZUEbFTk+2HRlgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX+/XU7+GL0BCBnz/pe9MZz2/ybbSUdHJvhmF6wtMKEBibx8rHJ3rXRLnAkYXUA9ts9IRG18SiUzqnq0Dd4PrO4y6HUqPY2MKtM2Q/1MPeRTkQSr3PB6Rhu30y0IFB4B0aaBVDanIsgUQ2ujUAj1V7ywGiYsod2aODJnoH2JyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATM4InzP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATM4InzP"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-652fec696c9so1968184a12.3
        for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325414; x=1768930214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUvDbNsG7/DZqlaeJxpOEXjtnNuOjVBOqiU6eiB5r/A=;
        b=ATM4InzP4oxdwYKQ7dmplqfbdGWydbHwlajcYBifqJIDqsY/8rhjrFlk4TBhe2yvIB
         5FpDcad1u3iQyGG5WpPn0LzyyQJHnV9DLU+ZAFEP+ypQHhF0B75iHI9ooYMV84refwO9
         KvDqwqCD+JJ7lmqadUOXGSL/Y8zbxDSKQ+MJuVbAFrf0wBCvkCvM4KjDtjMtNJcGipf8
         tLUSUMu/qx8jNmXhyOLDadmpO6dvpedVKa7iDGepS6l9gRYmTnGS7er3LkH5E45ccwMt
         QX/lTCToNWyitdLUDX+MN8suHdtyGXdlGPUCvv3KKXK3fEYlUa9MZP1knngW+1q1y66m
         v1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325414; x=1768930214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUvDbNsG7/DZqlaeJxpOEXjtnNuOjVBOqiU6eiB5r/A=;
        b=uRzRoXCQiXux2a/lgwKMiwICClnX3ygyoElXwlx2gJ32pzg8ALLA+AUaMz9BIMfHja
         ISnvxxn/XkFe06l6iRNckbQGx9pWskiqVDhiT9fmtDc8pXwYpEkHvEzmogH6z8NNg4Od
         0qIxgCaIikxd5LmGEqpks76WZ5szzYpNwcquGnxOWXEk/A0ENRVjB5wRYt9s9ZT8CTC0
         wzYSj1vfIoZchrcIYHyH+LJfMBfsGPNYSoJepjqSt2AxEMo1CZzDuMxgYeNqvlhfpD2k
         qwh0TMi3DM79mkvfxudQvjK4LKy7su+9vYRRlzZAXJ37rfTIPTbcTcvguNQiHMexOCr0
         u4Zg==
X-Gm-Message-State: AOJu0YyX3b9ih4V5wioi5SluLHKCKTG3v6xpAMFAQtV4tmftgU6jjHYo
	VNJsLGJqd9RZFCoPB6aglLLqLg/JHSBT3SRVRcfhMCEp9wRKPd1r2i3jdwFJ0yUcbSQ=
X-Gm-Gg: AY/fxX7sHVHH7+1Q84ZPIl+kKuU3jlf+RQmfYm/FcTUcDbYRQYUrt1ACwiLd/o/PZcv
	fRa908/QoL+Sy+uFpqvQ+VAmgLgzRM8VsFCAr7DLnYYYIMsoBcnKfj7TdxgZ9tRD1LLv7kI4Kat
	f9O4mEEJJ+yRFmLZGoz2jkItEdulmvM96VQUWghNaegeOWSDo73AsufNg1WB0L3WeGLOBRTWjcS
	Z8IbTs/hePqxi6tIw1ME70px5eGZYcZgA9BbSKoZdqgEgFzyh9H3bNLOqHn1m6awSYlcWazEDSU
	jXeUAhRO1GNAkwiL/Smr+ZqOzGUTjTG7QDurvpGEn4z9pt+T4NiSGpzBwC6W658jrXXgjI8SbyG
	o9jcl7uVreJZqhFgRzbfK86sQSD1j4Y2ivIpeb2sJHN22WeyNO+XnEYDzpFDsf1kQkSiaGn/+3Y
	8yCa2OBvWoT1itBw==
X-Google-Smtp-Source: AGHT+IHB3WqOdZNMV0XDcPpcF3WQWWeLjocYxPIfP7xXOIua30YxkiMpyHf6BJHxFhoxDJ0V/1QTbA==
X-Received: by 2002:a05:6402:26cf:b0:64d:2082:d027 with SMTP id 4fb4d7f45d1cf-65097e6a03bmr18797391a12.29.1768325413654;
        Tue, 13 Jan 2026 09:30:13 -0800 (PST)
Received: from penguin.lxd ([149.88.27.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4484sm20835469a12.7.2026.01.13.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:30:13 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [V2 4/4] tests: add tests for unshare --forward-signals
Date: Tue, 13 Jan 2026 12:29:42 -0500
Message-ID: <20260113172942.10678-5-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113172942.10678-1-kiranrangoon0@gmail.com>
References: <3tysdpabjulwlmr3hkm4pr7romwtf6cofhghth7buyuxnmwr5r@pliehv2xicmy>
 <20260113172942.10678-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two test cases for the new --forward-signals option:
- forward-signals: verifies SIGTERM is forwarded to child
- forward-signals-kill-child: verifies compatibility with --kill-child

Both tests use test_sigreceive which exits with the signal number
received, confirming proper signal forwarding.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 tests/expected/unshare/forward-signals        |  1 +
 .../unshare/forward-signals-kill-child        |  1 +
 tests/ts/unshare/forward-signals              | 55 ++++++++++++++++++
 tests/ts/unshare/forward-signals-kill-child   | 56 +++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 tests/expected/unshare/forward-signals
 create mode 100644 tests/expected/unshare/forward-signals-kill-child
 create mode 100755 tests/ts/unshare/forward-signals
 create mode 100755 tests/ts/unshare/forward-signals-kill-child

diff --git a/tests/expected/unshare/forward-signals b/tests/expected/unshare/forward-signals
new file mode 100644
index 000000000..868dab6e1
--- /dev/null
+++ b/tests/expected/unshare/forward-signals
@@ -0,0 +1 @@
+SIGTERM forwarded successfully
diff --git a/tests/expected/unshare/forward-signals-kill-child b/tests/expected/unshare/forward-signals-kill-child
new file mode 100644
index 000000000..d4e1224da
--- /dev/null
+++ b/tests/expected/unshare/forward-signals-kill-child
@@ -0,0 +1 @@
+SIGTERM forwarded successfully with kill-child
diff --git a/tests/ts/unshare/forward-signals b/tests/ts/unshare/forward-signals
new file mode 100755
index 000000000..24aea8563
--- /dev/null
+++ b/tests/ts/unshare/forward-signals
@@ -0,0 +1,55 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2026 util-linux contributors
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="forward signals to child"
+
+. "$TS_TOPDIR/functions.sh"
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_UNSHARE"
+ts_check_test_command "$TS_HELPER_SIGRECEIVE"
+
+ts_skip_nonroot
+
+# Start unshare with --forward-signals and a child process that exits
+# with the signal number it receives
+"$TS_CMD_UNSHARE" --user --map-root-user \
+	--pid --mount-proc \
+	--fork --forward-signals \
+	"$TS_HELPER_SIGRECEIVE" < /dev/null >> $TS_OUTPUT 2>> $TS_ERRLOG &
+
+UNSHARE_PID=$!
+
+# Give child time to set up signal handlers
+sleep 2
+
+# Send SIGTERM to parent unshare process
+kill -TERM $UNSHARE_PID
+
+# Wait for completion
+wait $UNSHARE_PID
+EXIT_CODE=$?
+
+# test_sigreceive exits with the signal number it receives (15 = SIGTERM)
+if [ $EXIT_CODE -eq 15 ]; then
+	echo "SIGTERM forwarded successfully" >> $TS_OUTPUT
+else
+	echo "UNEXPECTED EXIT CODE: $EXIT_CODE" >> $TS_OUTPUT
+fi
+
+ts_finalize
diff --git a/tests/ts/unshare/forward-signals-kill-child b/tests/ts/unshare/forward-signals-kill-child
new file mode 100755
index 000000000..3065f1052
--- /dev/null
+++ b/tests/ts/unshare/forward-signals-kill-child
@@ -0,0 +1,56 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2026 util-linux contributors
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="forward signals with kill-child"
+
+. "$TS_TOPDIR/functions.sh"
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_UNSHARE"
+ts_check_test_command "$TS_HELPER_SIGRECEIVE"
+
+ts_skip_nonroot
+
+# Start unshare with both --forward-signals and --kill-child
+# The child should receive SIGTERM from forwarding first
+"$TS_CMD_UNSHARE" --user --map-root-user \
+	--pid --mount-proc \
+	--fork --forward-signals --kill-child \
+	"$TS_HELPER_SIGRECEIVE" < /dev/null >> $TS_OUTPUT 2>> $TS_ERRLOG &
+
+UNSHARE_PID=$!
+
+# Give child time to set up signal handlers
+sleep 2
+
+# Send SIGTERM to parent unshare process
+kill -TERM $UNSHARE_PID
+
+# Wait for completion
+wait $UNSHARE_PID
+EXIT_CODE=$?
+
+# test_sigreceive exits with the signal number it receives (15 = SIGTERM)
+# With --kill-child, it should still receive SIGTERM first via forwarding
+if [ $EXIT_CODE -eq 15 ]; then
+	echo "SIGTERM forwarded successfully with kill-child" >> $TS_OUTPUT
+else
+	echo "UNEXPECTED EXIT CODE: $EXIT_CODE" >> $TS_OUTPUT
+fi
+
+ts_finalize
-- 
2.47.3

