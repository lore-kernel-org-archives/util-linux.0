Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A81D61B9
	for <util-linux@vger.kernel.org>; Wed, 16 Oct 2024 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115889; cv=none; b=bLQ8zrb7H5vFSi9OcaG89xUbHRo2tPN4ogPWdorb2nNkEy5YPQDLXXbDmc1MaLOBbnwyEzADgyMRE8acZz+uQxkfkaSDH1qkgriNUAJdt2Q3tWf7YRufhTUDu3lkBy+5ei463emmb0SnDuTjcJimHnk1I0lwwQx+E+GtEKJGwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115889; c=relaxed/simple;
	bh=q7sVFrIJDI9eW5hEJEFhExOS6vHMYdgZovit6daO7P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6iHg0vQwUhEEPOlUa+cTjSo87lI34hZwmFMv6qbPOu81SB4nYF+eMikOkUUP9Rbbm7cbTfDrGULKnJs6amQRXwMvGH11ofFhGrZxJftfp1FkphhQj7qetaXUZ19vbYMChEMCS87cFCBQFNkjys+xgQpRXTPakEy71i9EYumQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc; spf=pass smtp.mailfrom=jarry.cc; dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b=8mlG9CVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L91F9wpm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jarry.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b="8mlG9CVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L91F9wpm"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBB26114011A;
	Wed, 16 Oct 2024 17:58:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 16 Oct 2024 17:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729115885; x=
	1729202285; bh=TdmVempQd+kJTXOvSulIltDGGrRnlfQQNWd/uoPW4gk=; b=8
	mlG9CVO0qmWyN+DC3GYm++blujruhzKniaYMccaa+xxbSFuUK5KCy/ObZ+4DVcgb
	Y19TcnzQXhNqGXRv49H+s4/WjHJiTXXJIoH5nmoIjmt75wHbz4TgtwjIJF1LeVFd
	kRUiJkEHeoiWwca4/KB7rd5yFHESxKd9cR2nYOpjiAIkGar2NSY8TA+yS9vnNonB
	bYE6z6nNmfEFn3XlO7mLaeFAItPwoOaTjpu1y65hREoEklc3XSMOzfswWeLsDxuo
	8eae7ZYCpgHKqXYt4+Nu2uwNS0mYgoL9j1PaCBt7xLUsgmUv9g5X+ZW15TifUVJb
	fCSDNVuI9uyfdv20Lqobw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729115885; x=
	1729202285; bh=TdmVempQd+kJTXOvSulIltDGGrRnlfQQNWd/uoPW4gk=; b=L
	91F9wpmREMe2Wp4i08kmop0pXfIKrv6iewBVC+SXRaPpUCIkkLGWpQyhmSYZWV5l
	K1gRVu9lliKV89AhN7yNtIcTDFqDNrqwzBHwUf5otGYgjKmVYrQBA0mft5Y3nmzm
	C7X8K7eHHvp97GzjTU8cK5m3Dc3t3IcMQecXLbrBLTCK2Oo4iHmxn3muikhIaHCy
	wVHomusVcaLp5bNGxGZwAqq7KGCwiQ4vUbaHH8rIBL6LJWfEE5zQZ28GUXgBgF6R
	9UPEYFN3V4JzghA3JxnJvp9Ss6XtnIwaL8V/gzl4SKXQkmy9v1YDCQJdc3014zEN
	bCC51zF2C2XkBTe98T0Xw==
X-ME-Sender: <xms:7TYQZ6BbfruvDLMwveyPW-9K8ODcwl2_A_leDta6w3H7a8FepU7MdQ>
    <xme:7TYQZ0jflNpi_WbYmD5HXzIcqd53A1sHrhrw2KbV8Guu8XU-wx4C_oPQCklEsObfO
    RZz375y4f2baaOQDxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpefohffvvefufffk
    ofgjfhgggfestdekredtredttdenucfhrhhomheptfhosghinhculfgrrhhrhicuoehroh
    gsihhnsehjrghrrhihrdgttgeqnecuggftrfgrthhtvghrnhepgfdujeffvdejueeiudej
    udejtdfggeeltdevieegjeeitefgleeludetgfehgfefnecuffhomhgrihhnpehsrhdrhh
    htnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhho
    sghinhesjhgrrhhrhidrtggtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehthhhomhgrshesthdqkegthhdruggvpdhrtghpthhtohepuhht
    ihhlqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7TYQZ9kZvg9uNnU1J7CQcRuY3Bjkgije0f5saMJ2Nk0imqXRBWs_mg>
    <xmx:7TYQZ4xjGcYaly_oLLLnnAIQEWRDQpGUDbJbgrDQU0LRA_aKP2duEQ>
    <xmx:7TYQZ_TukpFjvKjik0rGYHqZ5Pvt5XinhJG_pUM2B0Y65hVNqGfdpw>
    <xmx:7TYQZzaSFWCme-bvJueSjyfbBlCRdLqhn3FVdN3PE48FfiJL4lUDKA>
    <xmx:7TYQZ2LUrMAhghkaaNWg9lAnakg8_tqyCvx5pODZPRfYzmFDEDYhu69C>
Feedback-ID: ic641498e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 452302220071; Wed, 16 Oct 2024 17:58:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Robin Jarry <robin@jarry.cc>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH util-linux v2] text-utils: add bits command
Date: Wed, 16 Oct 2024 23:57:47 +0200
Message-ID: <20241016215747.2161812-1-robin@jarry.cc>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016202621.2124554-2-robin@jarry.cc>
References: <20241016202621.2124554-2-robin@jarry.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new text utility to convert bit masks in various formats.

This can be handy to avoid parsing affinity masks in one's head and/or
to interact with the kernel in a more human friendly way. It is
a rewrite in C of the bits command from my linux-tools python package so
that it can be more widely available.

Here is an example:

 ~# cat /sys/kernel/debug/tracing/tracing_cpumask
 ffffffff,ffffffff,ffffffff,ffffffff
 ~# bits -l ,$(cat /sys/kernel/debug/tracing/tracing_cpumask)
 0-128
 ~# bits -g 58,59,120,123
 9000000,00000000,0c000000,00000000
 ~# bits -g 58,59,120,123 > /sys/kernel/debug/tracing/tracing_cpumask
 ~# echo 1 > /sys/kernel/debug/tracing/tracing_on

Add man page and basic tests.

Link: https://git.sr.ht/~rjarry/linux-tools#bits
Signed-off-by: Robin Jarry <robin@jarry.cc>
---

Notes:
    v2:
    
    - Fixed grouped-mask parsing (e.g.: bits -l ,0c000000,00000000). Updated
      unit tests to verify that it works.
    - Changed code wrapping to keep arg strings in a single line.
    - s/BUFSIZ/LINE_MAX/
    - s/strdup/xstrdup/
    - Removed unnecessary string copies.
    - Added check for strv_push() return value.
    - Removed "bitvise_op_t" enum and replaced with inline char values.
    - Exit with explicit errors in parse_mask_or_list().
    - Replaced license with SPDX in test file.
    - Fixed configure.ac + Makemodule.am. Tested build with make.
    - Fixed commit message example.
    - Fixed typos.

 .gitignore                                  |   1 +
 bash-completion/bits                        |  21 ++
 configure.ac                                |   3 +
 meson.build                                 |  11 +
 tests/commands.sh                           |   1 +
 tests/expected/misc/bits                    |   0
 tests/expected/misc/bits-and                |   1 +
 tests/expected/misc/bits-binary             |   1 +
 tests/expected/misc/bits-default            |   1 +
 tests/expected/misc/bits-grouped-mask       |   1 +
 tests/expected/misc/bits-list               |   1 +
 tests/expected/misc/bits-mask               |   1 +
 tests/expected/misc/bits-not                |   1 +
 tests/expected/misc/bits-or                 |   1 +
 tests/expected/misc/bits-overflow           |   1 +
 tests/expected/misc/bits-parse-grouped-mask |   1 +
 tests/expected/misc/bits-parse-mask         |   1 +
 tests/expected/misc/bits-parse-range        |   1 +
 tests/expected/misc/bits-stdin              |   1 +
 tests/expected/misc/bits-xor                |   1 +
 tests/ts/misc/bits                          |  81 +++++++
 text-utils/Makemodule.am                    |   9 +-
 text-utils/bits.1.adoc                      | 126 ++++++++++
 text-utils/bits.c                           | 256 ++++++++++++++++++++
 text-utils/meson.build                      |   4 +
 25 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 bash-completion/bits
 create mode 100644 tests/expected/misc/bits
 create mode 100644 tests/expected/misc/bits-and
 create mode 100644 tests/expected/misc/bits-binary
 create mode 100644 tests/expected/misc/bits-default
 create mode 100644 tests/expected/misc/bits-grouped-mask
 create mode 100644 tests/expected/misc/bits-list
 create mode 100644 tests/expected/misc/bits-mask
 create mode 100644 tests/expected/misc/bits-not
 create mode 100644 tests/expected/misc/bits-or
 create mode 100644 tests/expected/misc/bits-overflow
 create mode 100644 tests/expected/misc/bits-parse-grouped-mask
 create mode 100644 tests/expected/misc/bits-parse-mask
 create mode 100644 tests/expected/misc/bits-parse-range
 create mode 100644 tests/expected/misc/bits-stdin
 create mode 100644 tests/expected/misc/bits-xor
 create mode 100755 tests/ts/misc/bits
 create mode 100644 text-utils/bits.1.adoc
 create mode 100644 text-utils/bits.c

diff --git a/.gitignore b/.gitignore
index 316f3cdcc76c..af5a1184472e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@ ylwrap
 #
 /addpart
 /agetty
+/bits
 /build*/
 /blkdiscard
 /blkid
diff --git a/bash-completion/bits b/bash-completion/bits
new file mode 100644
index 000000000000..763e8669cfb2
--- /dev/null
+++ b/bash-completion/bits
@@ -0,0 +1,21 @@
+_bits_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+	'-h'|'--help'|'-V'|'--version')
+		return 0
+		;;
+	esac
+	case $cur in
+	-*)
+		OPTS="--version --help --mask --grouped-mask --bit --list"
+		COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+		return 0
+		;;
+	esac
+	return 0
+}
+complete -F _bits_module bits
diff --git a/configure.ac b/configure.ac
index b360e448ea95..6d7451f2f3b8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2233,6 +2233,9 @@ UL_REQUIRES_HAVE([scriptlive], [pty], [openpty function (libutil)])
 AM_CONDITIONAL([BUILD_SCRIPTLIVE], [test "x$build_scriptlive" = xyes])
 
 
+UL_BUILD_INIT([bits], [yes])
+AM_CONDITIONAL([BUILD_BITS], [test "x$build_bits" = xyes])
+
 UL_BUILD_INIT([col], [check])
 UL_REQUIRES_COMPILE([col], [#include <limits.h>], [__GLIBC__], [building for glibc])
 AM_CONDITIONAL([BUILD_COL], [test "x$build_col" = xyes])
diff --git a/meson.build b/meson.build
index a78ebd6b8934..db1c28f42bd3 100644
--- a/meson.build
+++ b/meson.build
@@ -1201,6 +1201,17 @@ endif
 
 ############################################################
 
+exe = executable(
+  'bits',
+  bits_sources,
+  include_directories : includes,
+  link_with : lib_common,
+  install_dir : usrbin_exec_dir,
+  install : true)
+exes += exe
+manadocs += ['text-utils/bits.1.adoc']
+bashcompletions += ['bits']
+
 if is_glibc
   exe = executable(
     'col',
diff --git a/tests/commands.sh b/tests/commands.sh
index 9eef92ccbb72..4402e38b4118 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -64,6 +64,7 @@ TS_HELPER_TIMEUTILS="${ts_helpersdir}test_timeutils"
 # paths to commands
 TS_CMD_ADDPART=${TS_CMD_ADDPART:-"${ts_commandsdir}addpart"}
 TS_CMD_DELPART=${TS_CMD_DELPART:-"${ts_commandsdir}delpart"}
+TS_CMD_BITS=${TS_CMD_BITS-"${ts_commandsdir}bits"}
 TS_CMD_BLKDISCARD=${TS_CMD_BLKID-"${ts_commandsdir}blkdiscard"}
 TS_CMD_BLKID=${TS_CMD_BLKID-"${ts_commandsdir}blkid"}
 TS_CMD_CAL=${TS_CMD_CAL-"${ts_commandsdir}cal"}
diff --git a/tests/expected/misc/bits b/tests/expected/misc/bits
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/expected/misc/bits-and b/tests/expected/misc/bits-and
new file mode 100644
index 000000000000..1d8ffee8c97a
--- /dev/null
+++ b/tests/expected/misc/bits-and
@@ -0,0 +1 @@
+75-100
diff --git a/tests/expected/misc/bits-binary b/tests/expected/misc/bits-binary
new file mode 100644
index 000000000000..ba7b220e9354
--- /dev/null
+++ b/tests/expected/misc/bits-binary
@@ -0,0 +1 @@
+0b1_0000_0000_0010_0000_0000_0100_0000_0000_1000_0000_0000
diff --git a/tests/expected/misc/bits-default b/tests/expected/misc/bits-default
new file mode 100644
index 000000000000..a56502d4c880
--- /dev/null
+++ b/tests/expected/misc/bits-default
@@ -0,0 +1 @@
+0x100200400800
diff --git a/tests/expected/misc/bits-grouped-mask b/tests/expected/misc/bits-grouped-mask
new file mode 100644
index 000000000000..427fc5c2a6ca
--- /dev/null
+++ b/tests/expected/misc/bits-grouped-mask
@@ -0,0 +1 @@
+1002,00400800
diff --git a/tests/expected/misc/bits-list b/tests/expected/misc/bits-list
new file mode 100644
index 000000000000..7511e5378ea4
--- /dev/null
+++ b/tests/expected/misc/bits-list
@@ -0,0 +1 @@
+11,22,33,44
diff --git a/tests/expected/misc/bits-mask b/tests/expected/misc/bits-mask
new file mode 100644
index 000000000000..a56502d4c880
--- /dev/null
+++ b/tests/expected/misc/bits-mask
@@ -0,0 +1 @@
+0x100200400800
diff --git a/tests/expected/misc/bits-not b/tests/expected/misc/bits-not
new file mode 100644
index 000000000000..2487fcfecb22
--- /dev/null
+++ b/tests/expected/misc/bits-not
@@ -0,0 +1 @@
+50-74
diff --git a/tests/expected/misc/bits-or b/tests/expected/misc/bits-or
new file mode 100644
index 000000000000..753370ac5c3b
--- /dev/null
+++ b/tests/expected/misc/bits-or
@@ -0,0 +1 @@
+50-150
diff --git a/tests/expected/misc/bits-overflow b/tests/expected/misc/bits-overflow
new file mode 100644
index 000000000000..9982566dc094
--- /dev/null
+++ b/tests/expected/misc/bits-overflow
@@ -0,0 +1 @@
+0x0
diff --git a/tests/expected/misc/bits-parse-grouped-mask b/tests/expected/misc/bits-parse-grouped-mask
new file mode 100644
index 000000000000..3ed39af60315
--- /dev/null
+++ b/tests/expected/misc/bits-parse-grouped-mask
@@ -0,0 +1 @@
+58,59,120,123
diff --git a/tests/expected/misc/bits-parse-mask b/tests/expected/misc/bits-parse-mask
new file mode 100644
index 000000000000..59dd4b4c1696
--- /dev/null
+++ b/tests/expected/misc/bits-parse-mask
@@ -0,0 +1 @@
+1,3,6,7,9,11,14-16,18,19,21,23-25,27
diff --git a/tests/expected/misc/bits-parse-range b/tests/expected/misc/bits-parse-range
new file mode 100644
index 000000000000..5afeb0332629
--- /dev/null
+++ b/tests/expected/misc/bits-parse-range
@@ -0,0 +1 @@
+7fffff,ffffffff,ffffffff,fffc0000,00000000
diff --git a/tests/expected/misc/bits-stdin b/tests/expected/misc/bits-stdin
new file mode 100644
index 000000000000..00ff99b2a15c
--- /dev/null
+++ b/tests/expected/misc/bits-stdin
@@ -0,0 +1 @@
+11,33,44
diff --git a/tests/expected/misc/bits-xor b/tests/expected/misc/bits-xor
new file mode 100644
index 000000000000..55289438dc57
--- /dev/null
+++ b/tests/expected/misc/bits-xor
@@ -0,0 +1 @@
+50-74,101-150
diff --git a/tests/ts/misc/bits b/tests/ts/misc/bits
new file mode 100755
index 000000000000..ebdf816713f0
--- /dev/null
+++ b/tests/ts/misc/bits
@@ -0,0 +1,81 @@
+#!/bin/bash
+
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# Copyright (c) 2024 Robin Jarry
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="bits"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_BITS"
+ts_cd "$TS_OUTDIR"
+
+ts_init_subtest "default"
+$TS_CMD_BITS 11,22,33,44 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "mask"
+$TS_CMD_BITS --mask 11,22,33,44 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "grouped-mask"
+$TS_CMD_BITS --grouped-mask 11,22,33,44 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "list"
+$TS_CMD_BITS --list 11,22,33,44 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "binary"
+$TS_CMD_BITS --binary 11,22,33,44 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "overflow"
+$TS_CMD_BITS 129837984734 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "parse-mask"
+$TS_CMD_BITS -l 0x0badcaca >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "parse-range"
+$TS_CMD_BITS -g 50-100 75-150 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "parse-grouped-mask"
+$TS_CMD_BITS -l ,9000000,00000000,0c000000,00000000 >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "or"
+$TS_CMD_BITS -l 50-100 '|75-150' >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "and"
+$TS_CMD_BITS -l 50-100 '&75-150' >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "xor"
+$TS_CMD_BITS -l 50-100 '^75-150' >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "not"
+$TS_CMD_BITS -l 50-100 '~75-150' >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_init_subtest "stdin"
+{
+	echo 11,22,33,44
+	echo ^22
+} | $TS_CMD_BITS --list >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
+ts_finalize
diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index af1bf0238664..b135e3a02819 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -1,3 +1,11 @@
+if BUILD_BITS
+usrbin_exec_PROGRAMS += bits
+MANPAGES += text-utils/bits.1
+dist_noinst_DATA += text-utils/bits.1.adoc
+bits_SOURCES = text-utils/bits.c
+bits_LDADD = $(LDADD) libcommon.la
+endif
+
 if BUILD_COL
 usrbin_exec_PROGRAMS += col
 MANPAGES += text-utils/col.1
@@ -105,4 +113,3 @@ test_more_CFLAGS = -DTEST_PROGRAM $(more_CFLAGS)
 test_more_LDADD = $(more_LDADD)
 
 endif # BUILD_MORE
-
diff --git a/text-utils/bits.1.adoc b/text-utils/bits.1.adoc
new file mode 100644
index 000000000000..b6de8c5936f0
--- /dev/null
+++ b/text-utils/bits.1.adoc
@@ -0,0 +1,126 @@
+//po4a: entry man manual
+////
+
+SPDX-License-Identifier: GPL-2.0-or-later
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+Copyright (c) 2024 Robin Jarry
+
+////
+= bits(1)
+:doctype: manpage
+:man manual: User Commands
+:man source: util-linux {release-version}
+:page-layout: base
+:command: bits
+
+== NAME
+
+bits - convert bit masks from/to various formats
+
+== SYNOPSIS
+
+*bits* [*-h*] [*-V*] [_<MODE>_] [_<MASK_OR_LIST>_...]
+
+== DESCRIPTION
+
+The *bits* utility converts bit masks into various formats. It supports
+combining multiple masks together using bitwise operations.
+
+== POSITIONAL ARGUMENTS
+
+_<MASK_OR_LIST>_::
+A set of bits specified as a hexadecimal mask value (e.g. _0xeec2_) or as
+a comma-separated list of bit IDs.
+
+If no argument is specified, the sets of bits will be read from standard input;
+one group per line.
+
+Consecutive ids can be compressed as ranges (e.g. _5,6,7,8,9,10_ -> _5-10_).
+
+Optionally, if an argument starts with a comma, it will be parsed as a single
+hexadecimal mask split in 32bit groups (e.g. _,00014000,00000000,00020000_ ->
+_17,78,80_).
+
+By default all groups will be OR'ed together. If a group has one of the
+following prefixes, it will be combined with the resulting mask using
+a different binary operation:
+
+**&**__<MASK_OR_LIST>__::
+The group will be combined with a binary AND operation. I.e. all bits that are
+set to 1 in the group AND the combined groups so far will be preserved to 1.
+All other bits will be reset to 0.
+
+**^**__<MASK_OR_LIST>__::
+The group will be combined with a binary XOR operation. I.e. all bits that are
+set to 1 in the group AND to 0 the combined groups so far (or the other way
+around) will be set to 1. Bits that are both to 1 or both to 0 will be reset to
+0.
+
+**~**__<MASK_OR_LIST>__::
+All bits set to 1 in the group will be cleared (reset to 0) in the combined
+groups so far.
+
+== OPTIONS
+
+include::man-common/help-version.adoc[]
+
+== CONVERSION MODE
+
+One of the following conversion modes can be specified. If not specified, it
+defaults to *-m*, *--mask*.
+
+*-m*, *--mask*::
+Print the combined args as a hexadecimal mask value (default).
+
+*-g*, *--grouped-mask*::
+Print the combined args as a hexadecimal mask value in 32bit comma separated
+groups.
+
+*-b*, *--binary*::
+Print the combined args as a binary mask value.
+
+*-l*, *--list*::
+Print the combined args as a list of bit IDs. Consecutive IDs are compressed as
+ranges.
+
+== EXAMPLES
+
+....
+~$ bits --mask 4,5-8 16,30
+0x400101f0
+
+~$ bits --list 0xeec2
+1,6,7,9-11,13-15
+
+~$ bits --binary 4,5-8 16,30
+0b100_0000_0000_0001_0000_0001_1111_0000
+
+~$ bits --list ,00300000,03000000,30000003
+0,1,28,29,56,57,84,85
+
+~$ bits --list 1,2,3,4 ~3-10
+1,2
+
+~$ bits --list 1,2,3,4 ^3-10
+1,2,5-10
+
+~$ bits --grouped-mask 2,22,74,79
+8400,00000000,00400004
+....
+
+== AUTHORS
+
+Robin Jarry.
+
+include::man-common/bugreports.adoc[]
+
+include::man-common/footer.adoc[]
+
+ifdef::translation[]
+include::man-common/translation.adoc[]
+endif::[]
diff --git a/text-utils/bits.c b/text-utils/bits.c
new file mode 100644
index 000000000000..00a9ce57a4dc
--- /dev/null
+++ b/text-utils/bits.c
@@ -0,0 +1,256 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Copyright (c) 2024 Robin Jarry
+ *
+ * bits - convert bit masks from/to various formats
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "c.h"
+#include "closestream.h"
+#include "cpuset.h"
+#include "nls.h"
+#include "strutils.h"
+#include "strv.h"
+#include "xalloc.h"
+
+static void parse_mask_or_list(const char *cmdline_arg, cpu_set_t *all_bits)
+{
+	char bitwise_op = '|';
+	cpu_set_t bits, copy;
+	const char *arg;
+
+	arg = cmdline_arg;
+
+	/* strip optional operator first */
+	if (startswith(arg, "&")) {
+		bitwise_op = '&';
+		arg++;
+	} else if (startswith(arg, "^")) {
+		bitwise_op = '^';
+		arg++;
+	} else if (startswith(arg, "~")) {
+		bitwise_op = '~';
+		arg++;
+	} else if (startswith(arg, "|")) {
+		arg++;
+	}
+
+	if (startswith(arg, ",") || startswith(arg, "0x")) {
+		if (startswith(arg, ","))
+			arg++;
+		if (cpumask_parse(arg, &bits, sizeof(bits)) < 0)
+			errx(EXIT_FAILURE, _("error: invalid bit mask: %s"), cmdline_arg);
+	} else {
+		if (cpulist_parse(arg, &bits, sizeof(bits), 1) < 0)
+			errx(EXIT_FAILURE, _("error: invalid bit list: %s"), cmdline_arg);
+	}
+
+	switch (bitwise_op) {
+	case '&':
+		copy = *all_bits;
+		CPU_AND(all_bits, &copy, &bits);
+		break;
+	case '|':
+		copy = *all_bits;
+		CPU_OR(all_bits, &copy, &bits);
+		break;
+	case '^':
+		copy = *all_bits;
+		CPU_XOR(all_bits, &copy, &bits);
+		break;
+	case '~':
+		for (int i = 0; i < CPU_SETSIZE; i++) {
+			if (CPU_ISSET(i, &bits))
+				CPU_CLR(i, all_bits);
+		}
+		break;
+	}
+}
+
+enum output_mode {
+	MODE_BINARY,
+	MODE_GROUPED_MASK,
+	MODE_LIST,
+	MODE_MASK,
+};
+
+static void print_bits(cpu_set_t *bits, enum output_mode mode)
+{
+	bool started = false;
+	char buf[LINE_MAX];
+	ssize_t n = 0;
+
+	switch (mode) {
+	case MODE_MASK:
+		cpumask_create(buf, sizeof(buf), bits, sizeof(*bits));
+
+		/* strip leading zeroes */
+		while (buf[n] == '0')
+			n++;
+		if (buf[n] == '\0')
+			printf("0x0\n");
+		else
+			printf("0x%s\n", buf + n);
+		break;
+
+	case MODE_GROUPED_MASK:
+		cpumask_create(buf, sizeof(buf), bits, sizeof(*bits));
+
+		/* strip leading zeroes */
+		while (buf[n] == '0')
+			n++;
+
+		while (buf[n] != '\0') {
+			if (started && (n % 8) == 0)
+				printf(",");
+			if (buf[n] != '0')
+				started = true;
+			printf("%c", buf[n]);
+			n++;
+		}
+		printf("\n");
+		break;
+
+	case MODE_BINARY:
+		printf("0b");
+		for (n = CPU_SETSIZE; n >= 0; n--) {
+			if (started && ((n + 1) % 4) == 0)
+				printf("_");
+			if (CPU_ISSET(n, bits)) {
+				started = true;
+				printf("1");
+			} else if (started) {
+				printf("0");
+			}
+		}
+		printf("\n");
+		break;
+
+	case MODE_LIST:
+		cpulist_create(buf, sizeof(buf), bits, sizeof(*bits));
+		printf("%s\n", buf);
+		break;
+	}
+}
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	fputs(USAGE_HEADER, stdout);
+	fprintf(stdout, _(" %s [options] [<mask_or_list>...]\n"),
+		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_("Convert bit masks from/to various formats."), stdout);
+
+	fputs(USAGE_ARGUMENTS, stdout);
+	fputsln(_(" <mask_or_list>      A set of bits specified as a hex mask value (e.g. 0xeec2)\n"
+		  "                     or as a comma-separated list of bit IDs."),
+		stdout);
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_("                     If not specified, arguments will be read from stdin."),
+		stdout);
+
+	fputs(USAGE_OPTIONS, stdout);
+	fprintf(stdout, USAGE_HELP_OPTIONS(21));
+
+	fputs(_("\nMode:\n"), stdout);
+	fputsln(_(" -m, --mask          Print the combined args as a hex mask value (default)."),
+		stdout);
+	fputsln(_(" -g, --grouped-mask  Print the combined args as a hex mask value in 32bit\n"
+		  "                     comma separated groups."), stdout);
+	fputsln(_(" -b, --binary        Print the combined args as a binary mask value."),
+		stdout);
+	fputsln(_(" -l, --list          Print the combined args as a compressed list of bit IDs."),
+		stdout);
+
+	fprintf(stdout, USAGE_MAN_TAIL("bits(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	enum output_mode mode = MODE_MASK;
+	char **stdin_lines = NULL;
+	cpu_set_t bits;
+	int c;
+
+	static const struct option longopts[] = {
+		{ "version",      no_argument, NULL, 'V'},
+		{ "help",         no_argument, NULL, 'h'},
+		{ "mask",         no_argument, NULL, 'm'},
+		{ "grouped-mask", no_argument, NULL, 'g'},
+		{ "binary",       no_argument, NULL, 'b'},
+		{ "list",         no_argument, NULL, 'l'},
+		{ NULL, 0, NULL, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	while ((c = getopt_long(argc, argv, "Vhmgbl", longopts, NULL)) != -1)
+		switch (c) {
+		case 'm':
+			mode = MODE_MASK;
+			break;
+		case 'g':
+			mode = MODE_GROUPED_MASK;
+			break;
+		case 'b':
+			mode = MODE_BINARY;
+			break;
+		case 'l':
+			mode = MODE_LIST;
+			break;
+		case 'V':
+			print_version(EXIT_SUCCESS);
+		case 'h':
+			usage();
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+
+	argc -= optind;
+	argv += optind;
+	if (argc == 0) {
+		/* no arguments provided, read lines from stdin */
+		char buf[LINE_MAX];
+
+		while (fgets(buf, sizeof(buf), stdin)) {
+			/* strip LF, CR, CRLF, LFCR */
+			rtrim_whitespace((unsigned char *)buf);
+			if (strv_push(&stdin_lines, xstrdup(buf)) < 0)
+				errx(EXIT_FAILURE, _("cannot allocate memory"));
+		}
+
+		argc = strv_length(stdin_lines);
+		argv = stdin_lines;
+	}
+
+	CPU_ZERO(&bits);
+
+	for (; argc > 0; argc--, argv++)
+		parse_mask_or_list(*argv, &bits);
+
+	strv_free(stdin_lines);
+
+	print_bits(&bits, mode);
+
+	return EXIT_SUCCESS;
+}
diff --git a/text-utils/meson.build b/text-utils/meson.build
index f3b25d382160..4a25fa478328 100644
--- a/text-utils/meson.build
+++ b/text-utils/meson.build
@@ -1,3 +1,7 @@
+bits_sources = files(
+  'bits.c',
+)
+
 col_sources = files(
   'col.c',
 )
-- 
2.47.0

