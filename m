Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04F229B1A
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883427; cv=none; b=XhMRF0isZGa8VXFksw142nwLqgTr7lUtFgpAZ7qG1SQM4AMp53tpY9a8wbSS2we1I6xfsCX1pl2oVNPiehgvfO/LGeaIZzNpq4erxFpCoOCYZ9049EB1t8dQONA5Fj8N5rpbdFmm/DfiJ7HHI4/eIF3yl2ujqgKfNEWpSO0p69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883427; c=relaxed/simple;
	bh=EvebqqvXehwIPXKcFalAb+7fUFpVyzxxGncZE5L+B5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKnZ0UtEN6hLUJAbUhP9dORJkI53zkhZsmRaMznf7UUgbPPtNdSw1/dWhhAM1qkPQ4Dc71ktvc+dcnE6y/u8LK2qN6zwd87m2JSWIam9wj4aYwtjHchcVXQkoALKjLiy3839r75qqz8SORROq0YpfQGpXzOG6q5DVqGOeZxORQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ZMaYWIhg; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ZMaYWIhg"
X-KPN-MessageId: 48bae52f-1b71-11f0-a9b5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 48bae52f-1b71-11f0-a9b5-00505699b430;
	Thu, 17 Apr 2025 11:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=qxVSWN0L1fLMnTHfm69VVatCjBIimmoO7rlP0kt6KJE=;
	b=ZMaYWIhgq++Fh3wmzHT3z3HHYCL6OE1H6B6cO8iF+MdUOhwE3CQao39ye5L3Pm+amwbUjfphHuRB+
	 A0RaFF5+0mxGf4K8ApZs/3z3SSlfsjZMa7PkNYDyFq+MySN8g+gTrL6pExp6Hf+b0KWgwkvDBzcXbO
	 5UWW1q8jW7gd7B8k=
X-KPN-MID: 33|sPBz725zJOgIo+ldfKmD9wfmkZwnohPrKPrZXhXLIbGOipSUnWTHTyvlLyF4z21
 jELkES6FrTgqQTqlh43gznQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cPNUZCqI0ILTsbnGgF8OfbcMeRXCAIi2ef6n3GZUllz/2CpebyRjpWNKYDRis/L
 Mh1Bku1cst+SxDZk3QtPV3g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3a1f5c1d-1b71-11f0-99e7-00505699772e;
	Thu, 17 Apr 2025 11:49:17 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/10] lscpu: (man) don't refer to a missing section, and improve some wordings
Date: Thu, 17 Apr 2025 11:48:22 +0200
Message-ID: <20250417094825.20870-8-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>
References: <20250417094825.20870-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three years ago commit aa049eabb3 removed the COLUMNS section but forgot
to remove the reference to it.  Replace the reference with a referral to
the --help text.

In the bargain, join two paragraphs that belong together, improve some
wordings, and sort two options.

This fixes #2590 (https://github.com/util-linux/util-linux/issues/2590).
Reported-by: Fabien Malfoy

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/lscpu.1.adoc | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/sys-utils/lscpu.1.adoc b/sys-utils/lscpu.1.adoc
index f86f531fd..940b1bfeb 100644
--- a/sys-utils/lscpu.1.adoc
+++ b/sys-utils/lscpu.1.adoc
@@ -22,8 +22,11 @@ The default output formatting on terminal is subject to change and maybe optimiz
 
 In virtualized environments, the CPU architecture information displayed reflects the configuration of the guest operating system which is typically different from the physical (host) system. On architectures that support retrieving physical topology information, *lscpu* also displays the number of physical sockets, chips, cores in the host system.
 
-Options that result in an output table have a _list_ argument. Use this argument to customize the command output. Specify a comma-separated list of column labels to limit the output table to only the specified columns, arranged in the specified order. See *COLUMNS* for a list of valid column labels. The column labels are not case sensitive.
-
+Options that produce an output table accept an optional _list_ argument.
+This _list_ is a comma-separated series of column labels to limit the
+table to only the specified columns, arranged in the specified order.
+Use *--help* to see a list of valid column labels.
+The labels are case insensitive.
 Not all columns are supported on all architectures. If an unsupported column is specified, *lscpu* prints the column but does not provide any data for it.
 
 The cache sizes are reported as summary from all CPUs. The versions before v2.34 reported per-core sizes, but this output was confusing due to complicated CPUs topology and the way how caches are shared between CPUs. For more details about caches see *--cache*. Since version v2.37 *lscpu* follows cache IDs as provided by Linux kernel and it does not always start from zero.
@@ -44,37 +47,46 @@ Display details about CPU caches. For details about available information see *-
 +
 If the _list_ argument is omitted, all columns for which data is available are included in the command output.
 +
-When specifying the _list_ argument, the string of option, equal sign (=), and _list_ must not contain any blanks or other whitespace. Examples: *-C=NAME,ONE-SIZE* or *--caches=NAME,ONE-SIZE*.
+When specifying the _list_ argument, the option string plus the
+equal sign (=) plus the _list_ may not contain any whitespace.
+Examples: *-C=NAME,ONE-SIZE* or *--caches=NAME,ONE-SIZE*.
 +
 The default list of columns may be extended if list is specified in the format +list (e.g., **lscpu -C=+ALLOC-POLICY**).
 
 *-c*, *--offline*::
 Limit the output to offline CPUs. This option may only be specified together with option *-e* or *-p*.
 
-*--hierarchic*[**=**_when_]::
-Use subsections in summary output. For backward compatibility, the default is to use subsections only when output on a terminal and flattened output on a non-terminal. The optional argument _when_ can be *never*, *always* or *auto*. If the _when_ argument is omitted, it defaults to "always".
-
 *-e*, *--extended*[**=**_list_]::
 Display the CPU information in human-readable format.
 +
 If the _list_ argument is omitted, the default columns are included in the command output.  The default output is subject to change.
 +
-When specifying the _list_ argument, the string of option, equal sign (=), and _list_ must not contain any blanks or other whitespace. Examples: '*-e=cpu,node*' or '*--extended=cpu,node*'.
+When specifying the _list_ argument, the option string plus the
+equal sign (=) plus the _list_ may not contain any whitespace.
+Examples: *-e=cpu,node* or *--extended=cpu,node*.
 +
 The default list of columns may be extended if list is specified in the format +list (e.g., lscpu -e=+MHZ).
 
+*--hierarchic*[**=**_when_]::
+Use subsections in summary output. For backward compatibility, the default is to use subsections only when output on a terminal, and to use flattened output on a non-terminal. The optional argument _when_ can be *never*, *always*, or *auto*. If the _when_ argument is omitted, it defaults to *always*.
+
 *-J*, *--json*::
 Use JSON output format for the default summary or extended output (see
 *--extended*).  For backward compatibility, JSON output follows the default
 summary behavior for non-terminals (e.g., pipes) where subsections are missing. See
 also *--hierarchic*.
 
+*--output-all*::
+Output all available columns. This option must be combined with either *--extended*, *--parse*, or *--caches*.
+
 *-p*, *--parse*[**=**_list_]::
 Optimize the command output for easy parsing.
 +
 If the _list_ argument is omitted, the command output is compatible with earlier versions of *lscpu*. In this compatible format, two commas are used to separate CPU cache columns. If no CPU caches are identified the cache column is omitted. If the _list_ argument is used, cache columns are separated with a colon (:).
 +
-When specifying the _list_ argument, the string of option, equal sign (=), and _list_ must not contain any blanks or other whitespace. Examples: '*-p=cpu,node*' or '*--parse=cpu,node*'.
+When specifying the _list_ argument, the option string plus the
+equal sign (=) plus the _list_ may not contain any whitespace.
+Examples: *-p=cpu,online,mhz* or *--parse=cpu,online,mhz*.
 +
 The default list of columns may be extended if list is specified in the format +list (e.g., lscpu -p=+MHZ).
 
@@ -92,9 +104,6 @@ Display physical IDs for all columns with topology elements (core, socket, etc.)
 +
 The CPU logical numbers are not affected by this option.
 
-*--output-all*::
-Output all available columns. This option must be combined with either *--extended*, *--parse* or *--caches*.
-
 include::man-common/help-version.adoc[]
 
 == BUGS
-- 
2.48.1

