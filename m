Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813C23BCE3
	for <util-linux@vger.kernel.org>; Fri, 25 Apr 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577206; cv=none; b=E+rbdO4EbVUfUbWH/Ws3np19GLmke7TrkXApJd5yZMaj6+yGmA1cgBMpWYPNqoUAidUpLG8VN4rY1McNeaIZCWjkrpmN3nWZPnPRzgF8KX/PAt/pVNN6EyC2XkszuZVXQ2bF/urC96iPrTBo3d8uurhLPTodhUA2gXfeus4+9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577206; c=relaxed/simple;
	bh=zu90CnVupWV0nK2MGURi/aX725W2Yfa0p5ypdt30zNQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lpSEw6G/5MAAmx8/Mp/fTJ4FpQ2RuSCreiS8K76vCXTTplahhzUytDfJ5wygH51jUm1nZsZjLDVB6Gp88jMMC23ovgLfSPsB6sbHBLSv869p5GI6IQ4DkoD//7n8j/e2knew9wJ/3Rz+lGNM0hAvK0kIDVI50MtvDWvL60K5NIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=BJT+z6Jq; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="BJT+z6Jq"
X-KPN-MessageId: a611d1c3-21c0-11f0-a82e-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a611d1c3-21c0-11f0-a82e-005056abad63;
	Fri, 25 Apr 2025 12:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=PBXXX2b3TJZD9NukdA2LGiLJjorwl4opigYlF3+K3s0=;
	b=BJT+z6JqYvkDSA1X51UH+wbJH1Qy2uDvA71UTEa7aR695d3/KHhYtEXYlGjP/tk39yDBdgoSyezR+
	 L+hkBJuNNT5DW98WgoRgFH5EN6lgJi6zrLCbhoQnH7o6umsl9BNpBslNkZBjj8qsY2GJ4yEcsK1y4m
	 yC3Ir7VQmaenkng4=
X-KPN-MID: 33|tDlTLxc692ub32MQqdhmfvG3u1fm0+GQDFVUfRVEiIUMKHrYbUWdrXewG5pN7y/
 8iO3ktXxn5Q8UObWQJ/bIcY2SkOfnL/5a5PFjSeTFDkA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hySN2JVEX476Tq0xbwD0Knk24h73Cc2x8Egg+DCN/XdV4juEC/szWhVh9jtYvoQ
 G6fH18gkmyVr1/PVlsuYDlA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8d1d14b5-21c0-11f0-855b-005056ab7584;
	Fri, 25 Apr 2025 12:32:13 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/7 V2] lsfd: improve grammar, and use angular brackets around placeholder word
Date: Fri, 25 Apr 2025 12:32:08 +0200
Message-ID: <20250425103209.11876-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use <list> (the standard way to indicate multiple arguments) as
argument of --pid,  and don't use "<when>" when the possible arguments
differ from "always", "never", "auto".

In addition, improve some wording and markup in the man page.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 lsfd-cmd/lsfd.1.adoc | 33 ++++++++++++++++-----------------
 lsfd-cmd/lsfd.c      |  6 +++---
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/lsfd-cmd/lsfd.1.adoc b/lsfd-cmd/lsfd.1.adoc
index b0ba2ba53..2654e8eaf 100644
--- a/lsfd-cmd/lsfd.1.adoc
+++ b/lsfd-cmd/lsfd.1.adoc
@@ -60,22 +60,22 @@ Use raw output format.
 *--notruncate*::
 Don't truncate text in columns.
 
-*-p*, *--pid* _pids_::
-Collect information only for specified processes.
-_pids_ is a list of pids. A comma or whitespaces can be used as separators.
-You can use this option with *pidof*(1). See *FILTER EXAMPLES*.
-+
-Both *-Q* option with an expression including PID, e.g. -Q (PID == 1),
-and *-p* option, e.g. -p 1, may print the same output but using *-p*
-option is much more efficient because *-p* option works at a much earlier
-stage of processing than the *-Q* option.
+*-p*, *--pid* _list_::
+Collect information only for the specified processes.
+The _list_ is a comma-separated list of PIDs.
+See also *FILTER EXAMPLES*.
 
-*-i*[4|6], *--inet*[=4|=6]::
+*-i*[*4*|*6*], *--inet*[**=4**|**=6**]::
 List only IPv4 sockets and/or IPv6 sockets.
 
-*-Q*, *--filter* _expr_::
-Print only the files matching the condition represented by the _expr_.
+*-Q*, *--filter* _expression_::
+Print only the files matching the condition represented by the _expression_.
 See also *scols-filter*(5) and *FILTER EXAMPLES*.
++
+The *-Q* option with a PID (for example: *-Q PID==1*) and the *-p*
+option (for example: *-p 1*) can be used to achieve the same result,
+but using the *-p* option is much more efficient because it works at
+a much earlier stage of processing than the *-Q* option.
 
 *-C*, *--counter* __label__:__filter_expr__::
 Define a custom counter used in *--summary* output. *lsfd* makes a
@@ -85,14 +85,13 @@ counter named _label_. *lsfd* applies filters defined with *--filter*
 options before counting; files excluded by the filters are not counted.
 +
 See *scols-filter*(5) about _filter_expr_.
-_label_ should not include `{` nor `:`. You can define multiple
+_label_ should not include *{* nor *:*. You can define multiple
 counters by specifying this option multiple times.
-+
 See also *COUNTER EXAMPLES*.
 
-*--summary*[**=**__when__]::
-This option controls summary lines output. The optional argument _when_
-can be *only*, *append* or *never*. If the _when_ argument is omitted,
+*--summary*[**=**_mode_]::
+This option controls summary lines output. The optional argument _mode_
+can be *only*, *append*, or *never*. If the _mode_ argument is omitted,
 it defaults to *only*.
 +
 The summary reports counters. A counter consists of a label and an
diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
index 2eb53935c..9e9cb52ac 100644
--- a/lsfd-cmd/lsfd.c
+++ b/lsfd-cmd/lsfd.c
@@ -2190,14 +2190,14 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -o, --output <list>          output columns (see --list-columns)\n"), out);
 	fputs(_(" -r, --raw                    use raw output format\n"), out);
 	fputs(_(" -u, --notruncate             don't truncate text in columns\n"), out);
-	fputs(_(" -p, --pid  <pid(s)>          collect information only specified processes\n"), out);
+	fputs(_(" -p, --pid <list>             collect information only for specified processes\n"), out);
 	fputs(_(" -i[4|6], --inet[=4|=6]       list only IPv4 and/or IPv6 sockets\n"), out);
 	fputs(_(" -Q, --filter <expr>          apply display filter\n"), out);
 	fputs(_("     --debug-filter           dump the internal data structure of filter and exit\n"), out);
 	fputs(_(" -C, --counter <name>:<expr>  define custom counter for --summary output\n"), out);
 	fputs(_("     --dump-counters          dump counter definitions\n"), out);
-	fputs(_("     --hyperlink[=mode]       print paths as terminal hyperlinks (always, never, or auto)\n"), out);
-	fputs(_("     --summary[=<when>]       print summary information (only, append, or never)\n"), out);
+	fputs(_("     --hyperlink[=<when>]     print paths as terminal hyperlinks (always|never|auto)\n"), out);
+	fputs(_("     --summary[=<mode>]       print summary information (append|only|never)\n"), out);
 	fputs(_("     --_drop-privilege        (testing purpose) do setuid(1) just after starting\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-- 
2.48.1

