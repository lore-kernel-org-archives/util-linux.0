Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590A26A08F
	for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583229; cv=none; b=XbQTcA7V8B/GYLpbT8W4bkBmamem2J3Y7RIj87zLofLz3cEAn9+OOuB7APbEx8KkGFeSeYtg6pTGG7ascRY3TiVQdp4VeEhxHCMwAMN1a7TA2oX5cIoyD0I3N1iAenWk0v6i5bpE6vJQUm01RIJ9vaaHttYnIjsV0GCfcZ/c5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583229; c=relaxed/simple;
	bh=0ygkDIfCu8TCCbsUH4Y/WQU50NfJ4ExcQwlW2CBsiTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwCjeFtnEkldPcOo6WYb1GKM+VhMqAHbq+VkKm6auqbDIBiNWV8tcVIPpemhaTvwReONH945gQ8UAufbwI2GyimdhMHZm31CG5/zsog/RDRPVduPm7apbCOxhOi0xJeU0hqn4pfrq1m1ASnbxxtKloGt94vNVEJiE3oRgaGEuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5lg8RYP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5lg8RYP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801bc328easo16051035e9.3
        for <util-linux@vger.kernel.org>; Fri, 16 Jan 2026 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768583226; x=1769188026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5hth7EsrcHyYkkhIsCnzk0F6xXqJMbjG/ezYP30NrQ=;
        b=T5lg8RYPetWmk4vLYQ4sFS+tR/UPxWALSSyyPRDwv2du/PDf/lhyt7lLtlVmfnsWRl
         BK8analQnmNLUnOm6Ec2mQ5TcIpeVyj7//zufuQuEuvOlNlNsGfoVM/wpOT1CJmaEZpm
         DgKUxTL3sXgwAL4M0Gdqun+36IbHDx3x63Zbq3ZqtIrnr32b3Ar4+AoBA0wqJU/dmgOg
         UJgC1iRtt4c8malDbO29upAdE2v1TZVo5SG5Jyq+xiCAD8YxfC8AQc1RKsz7gaU04epm
         4dcNmeelqrzOQW3lDeoeQMn6n/A++/fvZUDPDTIPm7Thh9WwGPkRHtTnZl7wezDBeJSX
         Ab6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768583226; x=1769188026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5hth7EsrcHyYkkhIsCnzk0F6xXqJMbjG/ezYP30NrQ=;
        b=SkMcTNPJSkkoTd/DC+AnLM5JhXXWOxuNwhGMx7f5PNQNAmPeVQpp55eBdn2WVE5Lui
         P1hYWKfcuGVik2uH3Y6oKQE4tButkyy1FsRL1EnKxyq17dycLnaCGiIXhhFAhL8WNnaU
         frf4QOxmQewBH/lliSVCTVz+Y3HD0GpGtTdw4/mr1C8T62SsIAKrgXw/LzVbGO66EkVf
         8sd4vMcY8kbCvhKmnwEDsvIgGc/K/xUCuRVnPBUfjvXXDh3yey3049XScbxomPZXiL7W
         BXQ5z1PH85A69In+n9esqgdFIioIlYhXH/fpQZYLKQegTvrvcH7kLN265T1VafLggJ8i
         SSdw==
X-Gm-Message-State: AOJu0YxJlBVYeEoefnu8wuBR+viq1veyChHke3C4EM+K4yyZ1MBDrHg3
	vbrKvAVb2wOHonfgovwd3UpllhFDuypLGYmrC1lkEjX4MZxrwB+H5TUb9qhuQJ7xMAs=
X-Gm-Gg: AY/fxX7gEkQx6P0mlWaUrAyMXGWdGfmDLZBCPdsDtTdcf+55Z8zGsTr473YV0jnUUsr
	Cx82X294njiNn3pztFd6cpX0MO7SbbnJW+X42Go6/HOQModJpdvA6xh/C3+IzQ6+GU5bfAnUtX5
	a4n/YaPYAwiCvR89gqK7j3kfU1ueWckfwF6C5M4ez8oAUeaWEsZYMIv8hGuR73MXTVlkzYNj7rc
	nSE8+KfKolTwnpvILQDFuoMnV1K6iYJqsSxcrIUL0m210YfP6VOn/KcqAlFp9VNDAcrh1qrhh3M
	Koq9bnu8V3+ARDkcsqe6TpO0GQiFWiKdaVkvyt1BrpESH8ThrL+l5rvzM2ZP8fV7rPxrF5N9deP
	15RPd6xcjla5PsbLDLZr1XNnmkrsMrW7ptiEnV7Nev/aeZvFA0EW/LnLrlNzwwPkuft6fGVKHZg
	WnH6lbxjgtQKnVUJyWMrt85a0Gx7U=
X-Received: by 2002:a05:600c:37c8:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-4801eb0e1cfmr35702975e9.29.1768583226012;
        Fri, 16 Jan 2026 09:07:06 -0800 (PST)
Received: from penguin.lxd ([149.102.244.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm6526709f8f.42.2026.01.16.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:07:05 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [Patch V3 4/4] tests: add tests for unshare --forward-signals
Date: Fri, 16 Jan 2026 12:06:48 -0500
Message-ID: <20260116170648.26439-5-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116170648.26439-1-kiranrangoon0@gmail.com>
References: <20260113172942.10678-5-kiranrangoon0@gmail.com>
 <20260116170648.26439-1-kiranrangoon0@gmail.com>
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
 tests/ts/unshare/forward-signals              | 73 ++++++++++++++++++
 tests/ts/unshare/forward-signals-kill-child   | 74 +++++++++++++++++++
 4 files changed, 149 insertions(+)
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
index 000000000..042ee0a58
--- /dev/null
+++ b/tests/ts/unshare/forward-signals
@@ -0,0 +1,73 @@
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
+# Verify that user namespaces work
+"$TS_CMD_UNSHARE" --user --map-root-user /bin/true &> /dev/null || \
+	ts_skip "user namespaces not supported"
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
+# Wait for child to be ready - poll for up to 10 seconds
+# The child process tree should exist
+TIMEOUT=10
+ELAPSED=0
+while [ $ELAPSED -lt $TIMEOUT ]; do
+	# Check if the process still exists
+	if ! kill -0 $UNSHARE_PID 2>/dev/null; then
+		ts_skip "unshare process died prematurely"
+	fi
+	# Give it a bit more time to set up namespaces and signal handlers
+	if [ $ELAPSED -ge 2 ]; then
+		break
+	fi
+	sleep 0.5
+	ELAPSED=$((ELAPSED + 1))
+done
+
+# Send SIGTERM to parent unshare process
+kill -TERM $UNSHARE_PID 2>/dev/null
+
+# Wait for completion with timeout
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
index 000000000..766f9fe56
--- /dev/null
+++ b/tests/ts/unshare/forward-signals-kill-child
@@ -0,0 +1,74 @@
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
+# Verify that user namespaces work
+"$TS_CMD_UNSHARE" --user --map-root-user /bin/true &> /dev/null || \
+	ts_skip "user namespaces not supported"
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
+# Wait for child to be ready - poll for up to 10 seconds
+# The child process tree should exist
+TIMEOUT=10
+ELAPSED=0
+while [ $ELAPSED -lt $TIMEOUT ]; do
+	# Check if the process still exists
+	if ! kill -0 $UNSHARE_PID 2>/dev/null; then
+		ts_skip "unshare process died prematurely"
+	fi
+	# Give it a bit more time to set up namespaces and signal handlers
+	if [ $ELAPSED -ge 2 ]; then
+		break
+	fi
+	sleep 0.5
+	ELAPSED=$((ELAPSED + 1))
+done
+
+# Send SIGTERM to parent unshare process
+kill -TERM $UNSHARE_PID 2>/dev/null
+
+# Wait for completion with timeout
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

