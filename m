Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFB27C15B
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386136; cv=none; b=efH7vI7bGjU8+08UFDZ06dwtb3KFGxofA50SvOrhdRxfurSIAixnSaUHLAkRzk21dILa0GxtusqL5GzBDxL8Zm2V7cSofupXX9GIAaCJgomuCClekQ1x36CdIAVBNB7Twm9+AGFL5YC0Fuwe/mToMFm3arJmd7tYmw8O50s00G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386136; c=relaxed/simple;
	bh=0CcBaw3WJyj6Wr7QSBERVPuY+s0F5EwfXPL/K8CJ1pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJeQZV5ahNqiWbvXcb0yb5cOEGQ7mzQgcepgNdw2nNYpZBQFhrjV9brZ9XT5u3a7w7r1vlOXgVTujPzauOr9mTonuQZhrEg4NneHCf+AWjU7VOVqekGL1mS+xn0eoBxbqLmyWQaxtNUBxWDzgHbxtiO4NrlsjPO8MjH2IQCaA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id 2f1c0c6a;
	Tue, 1 Jul 2025 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=from:to
	:cc:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=20241213_132553; bh=0CcBaw3WJyj6Wr
	7QSBERVPuY+s0F5EwfXPL/K8CJ1pc=; b=aPeNc4ZbUNxFEkdu38BdzBmisYJdgX
	qnpz1XodkgO757WgtPYhI7SOdEU6rCxMl7MGffYxF+eLDeLQ4fTN0UPqAaiTX4JC
	oSnlzau+7cZoAM8X2DJEIs51Ob0fhjfUtewJWGfFcVFuEB+4bSZOc9lJGmUkqVcJ
	jBleIPaNaYModO7GxPKd98i9Uf0JOlpjYxLheMQqq6J5YrSq85oYM6xQLipF4FXC
	5CKJ5PAEnHu95eCm6KJte/LyDPZrvFOl+IiRli5y/veUIigwWpRFZpSdjCQXiGya
	JYX0geUqVXNKp8YjOLSxFCHU3snld85p8FGe6hdN+wvtAFR5q/+4z/pd/xoy3JBf
	t4GkAM9Nj+BIm+I7iWh2TB0wMK2SXsBXY+KVGuZ8l/VS9kGUrOQXfgHdrDb8fOUn
	sx3Z4YNJS5Sz3yD9pNXKPywBxtPXbxv/PAiVVmZJTS62CWz6RsTxaX6B9yzlMiut
	8lzL01d6J2H0ZBdETRM9vibOUEMYK8VxxeNVRdmLhs4T4iDkO2CIo6dcTomSMSeP
	Vy/5btlQ1evAJ1GFMbJp6HIFVkio2xErBK9EbtK4wtGYVryqfqpiWWRmdZ559Y3k
	R/7sZS77GISjsYXbw9VvFYrXYI/am2LlGgaVAUHzevo4FTDQ9DqP0OlY6tWcTkCs
	rCh8/uJu1d8B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=from:to:cc
	:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; q=dns; s=20241213_132553; b=0cqsMGyu
	D7beZhRVlia1FPbhuBXtWNRGay1SAbQWTO5Klw0GsP9/OafrIR4cAnOagDQTQ+30
	wQ4XdAgS8f8YARWL0BwTiBql8Kh2rOxi/do5dX94rxvsF0WT53lcvVtyjmLCG0nr
	/J5vW2IAh+x4ouwKA0//1NNxcvHHpa87BwnJP4h+aemd4iM4VwkfrpKyv3mkMj0r
	yZGOMHc3aOLD3w67HGSX6L5et7XKdoBD8uQMCMMcEwmfnew/lNKzJS5OMIO3TeyE
	Dg5TVYvMJ4auliut0dp6J1Gl8iZa+Wh6fWxpRhJdcqn62QYgsIBsu++JreDMT8qa
	7p10mccH8kTZCRbtYIDYfKW8nuQPkp3ZbXkHMxDgJR2CZfnv4UGFfoBWC4ZsWfAg
	3aN7s1ZsAnb/uzlUYiQP7T/uRKfFThXEYysPXx/FJaM4tU3QQtia1/CupfakE9Gp
	QrcgODicK1Z/HdFksmagdAaEKC3YVs+u0e93iK9Tg15F5SqLANBa2X1kc8tFtTvj
	OJv8VXMsWXCp+a9Nc1Nqquz3fiW8mavqULMyv8T33rl7gWlZYaqDmerUpeNIvMYW
	wM6/nHFwduQ6l3xDCoa2xZMSpYQ2yOXEs31/RYSgcM/RX9ZalLePAP9esHTP+ok7
	+TQAItggr+T/kgo7hX/auBZbTE1mXVA3yQo=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id fc6e162a;
	Tue, 1 Jul 2025 16:02:09 +0000 (UTC)
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: util-linux@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Subject: [PATCH v2] rename: change "expression" to "substring"
Date: Tue,  1 Jul 2025 18:01:05 +0200
Message-ID: <20250701160139.24110-1-contact@hacktivis.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621232642.17613-2-contact@hacktivis.me>
References: <20250621232642.17613-2-contact@hacktivis.me>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As rename(1) doesn't uses an expression (like regex or glob) but rather a substring.
---
 misc-utils/rename.1.adoc | 12 ++++++------
 misc-utils/rename.c      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/rename.1.adoc b/misc-utils/rename.1.adoc
index b8ea2bfdf..fc7df4f1c 100644
--- a/misc-utils/rename.1.adoc
+++ b/misc-utils/rename.1.adoc
@@ -20,11 +20,11 @@ rename - rename files
 
 == SYNOPSIS
 
-*rename* [options] _expression replacement file_...
+*rename* [options] _substring replacement file_...
 
 == DESCRIPTION
 
-*rename* will rename the specified files by replacing the first occurrence of _expression_ in their name by _replacement_.
+*rename* will rename the specified files by replacing the first occurrence of _substring_ in their name by _replacement_.
 
 == OPTIONS
 
@@ -38,10 +38,10 @@ Show which files were renamed, if any.
 Do not make any changes; add *--verbose* to see what would be made.
 
 *-a*, *--all*::
-Replace all occurrences of _expression_ rather than only the first one.
+Replace all occurrences of _substring_ rather than only the first one.
 
 *-l*, *--last*::
-Replace the last occurrence of _expression_ rather than the first one.
+Replace the last occurrence of _substring_ rather than the first one.
 
 *-o*, *--no-overwrite*::
 Do not overwrite existing files. When *--symlink* is active, do not overwrite symlinks pointing to existing targets.
@@ -57,9 +57,9 @@ The renaming has no safeguards by default or without any one of the options *--n
 
 == EDGE CASES
 
-If the _expression_ is empty, then by default _replacement_ will be added to the start of the filename. With *--all*, _replacement_ will be inserted in between every two characters of the filename, as well as at the start and end.
+If _substring_ is empty, then by default _replacement_ will be added to the start of the filename. With *--all*, _replacement_ will be inserted in between every two characters of the filename, as well as at the start and end.
 
-Normally, only the final path component of a filename is updated. (Or with *--symlink*, only the final path component of the link.) But if either _expression_ or _replacement_ contains a _/_, the full path is updated. This can cause a file to be moved between folders. Creating folders, and moving files between filesystems, is not supported.
+Normally, only the final path component of a filename is updated. (Or with *--symlink*, only the final path component of the link.) But if either _substring_ or _replacement_ contains a _/_, the full path is updated. This can cause a file to be moved between folders. Creating folders, and moving files between filesystems, is not supported.
 
 == INTERACTIVE MODE
 
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index bb2e3103d..d7bf4c5d7 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -251,7 +251,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [options] <expression> <replacement> <file>...\n"),
+	      _(" %s [options] <substring> <replacement> <file>...\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);

base-commit: c8e5b8a818323af30ec656f079c7feadaeeb13c3
-- 
2.49.0

