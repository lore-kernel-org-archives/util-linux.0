Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836EF21E3C2
	for <util-linux@vger.kernel.org>; Wed, 16 Oct 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110399; cv=none; b=Y27GTTOYg+25xB7FPrrHrY3foO5MVigOU4iaP9IjrPeK17cYoxdEEsFkp3EgMScciUUYHHieDBTIy+0CxZ5tShYx9i9v33R+LMfr4Cx6esIIzjdHCqv/+hdMWnVPJ2IcpcykF521ri0ztFdqshrUfBl42Sg+9lmJnqN0SUtXRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110399; c=relaxed/simple;
	bh=iD+uCD7LC/n99xyrgkq2Wopsn3YKJO67ZEa9pOH+BV4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t1wilfb+Zb14BRzAt54QBGw74XB9tc6hQXxcR/ISymSz7SALYWvcb76hBeBHMk1niOI5YK+iPTG+N3DG2H9A95MJW5AArfTD1A5HMNu1kwa0vLcO5L5oVySWESmtFB0/XmslzBrRzuVqwDcugbQ+GjIYOX0rEy6tfHNTywMPCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc; spf=pass smtp.mailfrom=jarry.cc; dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b=NUQYXfeT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTDYj/ys; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jarry.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b="NUQYXfeT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTDYj/ys"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A6C2114018A
	for <util-linux@vger.kernel.org>; Wed, 16 Oct 2024 16:26:35 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 16 Oct 2024 16:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1729110395; x=1729196795; bh=3Qqw+po7ZQqgDCeqSPlbT
	4OFs7BXL82ndHYBn/PQn54=; b=NUQYXfeTDUPaKQdpIL3Cn13Te9nNUmDjqgKve
	O4W5nqUA5insYV/iasAfmF9RXSj4JaQQWeDcEYo2wKHHHMc4v8m4W/yqf1nxAR1R
	sAVMBSZh17Rv9Qzx9vp8RXIPnsM0IV7DZYbCPow0YLDp75HEkDWruP1dwZF1QIlk
	Z84c66x7pQR8dCjNme9ixyd8KqrVCv4q+E49xlpvLTIdDnBX7V9d4l/jAyFFVx7E
	aqLUNvlZI+xjoqe/i/asjvCapPycxrYA6/ZhAQ7r1pkS4mQ02jv7JnkzgNmY+EuA
	Xn4BoH/iNgSA4XDgTyEYbzU+ERMWqOftnQzwgkldG2h/AN3Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729110395; x=1729196795; bh=3Qqw+po7ZQqgDCeqSPlbT4OFs7BX
	L82ndHYBn/PQn54=; b=DTDYj/ysinC7PrC6R+zqi/QmpxcFbN/hQpLIMa48G7n7
	XjrQO8N8SmDBO0VCTbR9xb716zJJnuNAWlVW0ATwUOrbjZZl7FCdrpoDIigGAQhI
	1v+WMqpQO6QOhurb1/E32nQ/Faut2PKoNkOwFJUtagOpjYLpHxr0vbxG+QdnqDKs
	+5NNtATpAiHmlmm8bLfHZMWOVZ1N00yeI7iw5qqA3AIaDLwaYhP3hAe47FGffU9t
	lVLNR0FM1UsdQmEbHLiPbkB8nGD4+pfXRkcTGDcCc9uFYJq/mfs0gBgMc93/Jw95
	t+KzEdXJP870TPZcKvuVLbH/AWSIemy5ZGRz5chnkg==
X-ME-Sender: <xms:eyEQZ1oM6Um1lis8TCThzKuQY16yxJwR1pd5L5YfLBMZ5-stfkGfxg>
    <xme:eyEQZ3o6QZAk1jGZ_cya7vwGfCNaMYIv-RVItgHes1R_xKnpg3cSlzELZ7soxo9zI
    RZD9lb1xx3dTckFMYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    duhedmnecujfgurhepoffhvffufffkofgggfestdekredtredttdenucfhrhhomheptfho
    sghinhculfgrrhhrhicuoehrohgsihhnsehjrghrrhihrdgttgeqnecuggftrfgrthhtvg
    hrnhephfdtudehtdettdeftdfhheffjeetleevhfduheethfffvdekkeefgeeljefhffef
    necuffhomhgrihhnpehsrhdrhhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhhosghinhesjhgrrhhrhidrtggtpdhnsggprhgtphhtthho
    pedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehuthhilhdqlhhinhhugiesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eyEQZyPaJ7LWRgNq7svYa65xM72gsDh4BLqtl8Aj3C54RccUMutqJg>
    <xmx:eyEQZw6_GmBYZgDqA3Aj0R2u_AfNcmYQcWwnJ2GS0Pflhx5ZqPLzig>
    <xmx:eyEQZ06xNXSNUNI8z7sDAnD8fgmCBM7-1iu6DwSNitvgRE4FUQp8uQ>
    <xmx:eyEQZ4gu91BNsTj-QiB_0QvyJsJGq9OfZJfmDw-KBTGe2kS4T_FQOw>
    <xmx:eyEQZ5j4-iNINqibGC3WzRTsLCxkbVyQ8tedJc4SXzviW3-AQC2fdjv1>
Feedback-ID: ic641498e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 331872220071; Wed, 16 Oct 2024 16:26:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Robin Jarry <robin@jarry.cc>
To: util-linux@vger.kernel.org
Subject: [RFC PATCH util-linux] text-utils: add bits command
Date: Wed, 16 Oct 2024 22:26:22 +0200
Message-ID: <20241016202621.2124554-2-robin@jarry.cc>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new test utility to convert between bit masks in various formats.
This can be handy to avoid parsing affinity masks in one's head and/or
to interact with the kernel in a more human friendly way.

This is a rewrite in C of the bits command from my linux-tools python
package so that it can be more widely available.

Here is an example:

 ~# cat /sys/kernel/debug/tracing/tracing_cpumask
 fffffff,ffffffff,ffffffff,ffffffff
 ~# bits -l ,$(cat /sys/kernel/debug/tracing/tracing_cpumask)
 0-128
 ~# bits -g 58,59,120,123
 9000000,00000000,0c000000,00000000
 ~# bits -g 58,59 > /sys/kernel/debug/tracing/tracing_cpumask
 ~# echo 1 > /sys/kernel/debug/tracing/tracing_on

Add man page and basic tests.

Link: https://git.sr.ht/~rjarry/linux-tools#bits
Signed-off-by: Robin Jarry <robin@jarry.cc>
---
 bash-completion/bits                  |  21 ++
 meson.build                           |  11 ++
 tests/commands.sh                     |   1 +
 tests/expected/misc/bits              |   0
 tests/expected/misc/bits-and          |   1 +
 tests/expected/misc/bits-binary       |   1 +
 tests/expected/misc/bits-default      |   1 +
 tests/expected/misc/bits-grouped-mask |   1 +
 tests/expected/misc/bits-list         |   1 +
 tests/expected/misc/bits-mask         |   1 +
 tests/expected/misc/bits-not          |   1 +
 tests/expected/misc/bits-or           |   1 +
 tests/expected/misc/bits-overflow     |   1 +
 tests/expected/misc/bits-parse-mask   |   1 +
 tests/expected/misc/bits-parse-range  |   1 +
 tests/expected/misc/bits-stdin        |   1 +
 tests/expected/misc/bits-xor          |   1 +
 tests/ts/misc/bits                    |  82 ++++++++
 text-utils/Makemodule.am              |   6 +
 text-utils/bits.1.adoc                | 147 ++++++++++++++
 text-utils/bits.c                     | 265 ++++++++++++++++++++++++++
 text-utils/meson.build                |   4 +
 22 files changed, 550 insertions(+)
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
 create mode 100644 tests/expected/misc/bits-parse-mask
 create mode 100644 tests/expected/misc/bits-parse-range
 create mode 100644 tests/expected/misc/bits-stdin
 create mode 100644 tests/expected/misc/bits-xor
 create mode 100755 tests/ts/misc/bits
 create mode 100644 text-utils/bits.1.adoc
 create mode 100644 text-utils/bits.c

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
index 000000000000..e76677dd56b0
--- /dev/null
+++ b/tests/ts/misc/bits
@@ -0,0 +1,82 @@
+#!/bin/bash
+
+#
+# Copyright (c) 2024 Robin Jarry
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
index af1bf0238664..28aa7963561d 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -106,3 +106,9 @@ test_more_LDADD = $(more_LDADD)
 
 endif # BUILD_MORE
 
+if BUILD_BITS
+usrbin_exec_PROGRAMS += bits
+MANPAGES += text-utils/bits.1
+dist_noinst_DATA += text-utils/bits.1.adoc
+bits_SOURCES = text-utils/bits.c
+endif
diff --git a/text-utils/bits.1.adoc b/text-utils/bits.1.adoc
new file mode 100644
index 000000000000..1cbe3f95ff37
--- /dev/null
+++ b/text-utils/bits.1.adoc
@@ -0,0 +1,147 @@
+//po4a: entry man manual
+////
+Copyright (c) 2024 Robin Jarry
+
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice, this list of conditions and the following disclaimer.
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+3. All advertising materials mentioning features or use of this software
+   must display the following acknowledgement:
+   This product includes software developed by the University of
+   California, Berkeley and its contributors.
+4. Neither the name of the University nor the names of its contributors
+   may be used to endorse or promote products derived from this software
+   without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+SUCH DAMAGE.
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
index 000000000000..6dd0db81a5de
--- /dev/null
+++ b/text-utils/bits.c
@@ -0,0 +1,265 @@
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
+
+typedef enum {
+	OP_OR,
+	OP_AND,
+	OP_NOT,
+	OP_XOR,
+} bitvise_op_t;
+
+static int parse_mask_or_list(const char *cmdline_arg, cpu_set_t *all_bits)
+{
+	bitvise_op_t op = OP_OR;
+	cpu_set_t bits, copy;
+	char buf[BUFSIZ];
+	char *arg = buf;
+
+	/* copy to allow modifying the argument contents */
+	strlcpy(buf, cmdline_arg, sizeof(buf));
+	buf[sizeof(buf) - 1] = '\0';
+
+	/* strip optional operator first */
+	if (startswith(arg, "&")) {
+		op = OP_AND;
+		arg++;
+	} else if (startswith(arg, "^")) {
+		op = OP_XOR;
+		arg++;
+	} else if (startswith(arg, "~")) {
+		op = OP_NOT;
+		arg++;
+	} else if (startswith(arg, "|")) {
+		op = OP_OR;
+		arg++;
+	}
+
+	if (startswith(arg, ",") || startswith(arg, "0x")) {
+		if (cpumask_parse(arg, &bits, sizeof(bits)) < 0)
+			return -EINVAL;
+	} else {
+		if (cpulist_parse(arg, &bits, sizeof(bits), 1) < 0)
+			return -EINVAL;
+	}
+
+	switch (op) {
+	case OP_AND:
+		copy = *all_bits;
+		CPU_AND(all_bits, &copy, &bits);
+		break;
+	case OP_OR:
+		copy = *all_bits;
+		CPU_OR(all_bits, &copy, &bits);
+		break;
+	case OP_XOR:
+		copy = *all_bits;
+		CPU_XOR(all_bits, &copy, &bits);
+		break;
+	case OP_NOT:
+		for (int i = 0; i < CPU_SETSIZE; i++) {
+			if (CPU_ISSET(i, &bits))
+				CPU_CLR(i, all_bits);
+		}
+		break;
+	}
+
+	return 0;
+}
+
+typedef enum {
+	MODE_BINARY,
+	MODE_GROUPED_MASK,
+	MODE_LIST,
+	MODE_MASK,
+} output_mode_t;
+
+static void print_bits(cpu_set_t *bits, output_mode_t mode)
+{
+	bool started = false;
+	char buf[BUFSIZ];
+	ssize_t n = 0;
+
+	buf[0] = '\0';
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
+
+}
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	fputs(USAGE_HEADER, stdout);
+	fprintf(stdout, _(" %s [options] [<mask_or_list>...]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fputsln(_("Convert bit masks from/to various formats."), stdout);
+
+	fputs(USAGE_ARGUMENTS, stdout);
+	fputsln(_(" <mask_or_list>      A set of bits specified as a hex mask value (e.g. 0xeec2)\n"
+		"                     or as a comma-separated list of bit IDs.\n"
+		"                     If not specified, arguments will be read from stdin."), stdout);
+
+	fputs(USAGE_OPTIONS, stdout);
+	fprintf(stdout, USAGE_HELP_OPTIONS(21));
+
+	fputs(_("\nMode:\n"), stdout);
+	fputsln(_(" -m, --mask          Print the combined args as a hex mask value (default).\n"), stdout);
+	fputsln(_(" -g, --grouped-mask  Print the combined args as a hex mask value in 32bit\n"
+			"                     comma separated groups."), stdout);
+	fputsln(_(" -b, --binary        Print the combined args as a binary mask value."), stdout);
+	fputsln(_(" -l, --list          Print the combined args as a compressed list of bit IDs."), stdout);
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fprintf(stdout, USAGE_MAN_TAIL("bits(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	output_mode_t mode = MODE_MASK;
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
+		char buf[BUFSIZ];
+
+		while (fgets(buf, sizeof(buf), stdin)) {
+			/* strip LF, CR, CRLF, LFCR */
+			buf[strcspn(buf, "\r\n")] = '\0';
+			strv_push(&stdin_lines, strdup(buf));
+		}
+
+		argc = strv_length(stdin_lines);
+		argv = stdin_lines;
+	}
+
+	CPU_ZERO(&bits);
+
+	for (; argc > 0; argc--, argv++)
+		if (parse_mask_or_list(*argv, &bits) < 0) {
+			fprintf(stderr, _("error: invalid argument: %s\n"), *argv);
+			errtryhelp(EXIT_FAILURE);
+		}
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

