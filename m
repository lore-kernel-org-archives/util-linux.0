Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70E233737
	for <util-linux@vger.kernel.org>; Mon, 24 Feb 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402576; cv=none; b=HsLNXygRuV9Okn3H0P7ns9aWdoVlVyDuVVpIind7WWJ2HhKT1I8loNqFCtADrl9dE5C2AkRFMJXbA5Gg1FU8JAq0zBXaItECE1zL1vIgGmEL02hKApuS0ss7oo7Qrnt/St7kvbneHbCe1c8cW5m7GZbF6CHXAfIMXy8iq0lZcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402576; c=relaxed/simple;
	bh=1Yhcm2g/P5pSBss1N0SyLTDpgyEsCI7mW+6dVKIal4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhn1qwLNLfewUJiWlqv96BSay2OvPlLYrzkDuoi9y8zHGyg63fZhoiJPQoZquZ0chqdcWaCnPnuIG3f7DnwaZ65dVursyzCKqxvXYAdda5sNtey5PC96+lkPj6daRd5cRHMBiqqzIEe3IDCdszyj2hERVHQoSL5/YoVHn/gPYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Hqxv3cvR; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Hqxv3cvR"
X-KPN-MessageId: 9257a117-f2b0-11ef-a82b-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9257a117-f2b0-11ef-a82b-005056abad63;
	Mon, 24 Feb 2025 14:09:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=CuarOaP7nI6BqYWHWWvbs5oVJ5BvVarKggMXLDDhP7Q=;
	b=Hqxv3cvR4FnGgBmyUPu4pIL9Rq6N951IfYFLRGDsqkxvvYfiFr5dE5U53J+cKoo5FEliccocRSZfj
	 l6RbzYdx17YOsrmXY7Wlul6IyGOKn34PU7wXyVd9SC0E3ioigKVyAHJUosvXuhOUEmnzKanc3Zsnnk
	 WoxygRSlKJTfqQ7c=
X-KPN-MID: 33|dFqgUr4RhMchHh3LHIMN8bsXihB2mgAvEWxO950O+rOag43yE6AKJemcB6mx5vr
 WD/36RMY17titixqewCiSmY46PckwKUM8kHlhrosl4nE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8gIEo71MSBZtlMo4PTrMdXEFCQ24oRysmlvQZf3lAzM1f4yE4ve4HQn6E6+MtTS
 bVgGX52EjXWbm4EZ0ZK3lpw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 92d7b67c-f2b0-11ef-9583-005056abf0db;
	Mon, 24 Feb 2025 14:09:26 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] scriptreplay: mark literal values in the man page in bold, not italic
Date: Mon, 24 Feb 2025 14:08:38 +0100
Message-ID: <20250224130840.25770-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224130840.25770-1-bensberg@telfort.nl>
References: <20250224130840.25770-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, mention which keys can be used to speed up, slow down, and pause
the replay.  Shorten the description of '-s' as it is deprecated.  And
improve the description of '-t': it does not override the _timingfile_
positional argument, but takes the place of it, makes it unneeded.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/scriptreplay.1.adoc | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/term-utils/scriptreplay.1.adoc b/term-utils/scriptreplay.1.adoc
index 7665d28f8..deabb7b16 100644
--- a/term-utils/scriptreplay.1.adoc
+++ b/term-utils/scriptreplay.1.adoc
@@ -23,11 +23,14 @@ The replay simply displays the information again; the programs that were run whe
 
 The timing information is what *script*(1) outputs to file specified by *--log-timing*.
 
-By default, the typescript to display is assumed to be named _typescript_, but other filenames may be specified, as the second parameter or with option *--log-out*.
+By default, the _typescript_ to display is assumed to be named *typescript*,
+but other filenames may be specified, as the second parameter or with option
+*--log-out*.
 
 If the third parameter or *--divisor* is specified, it is used as a speed-up multiplier. For example, a speed-up of 2 makes *scriptreplay* go twice as fast, and a speed-down of 0.1 makes it go ten times slower than the original session.
 
-During the replay, you can interactively speed up, slow down, or pause the playback using key bindings.
+During the replay, you can interactively speed up, slow down, or pause the
+playback using the Up, Down, and Space keys.
 
 == OPTIONS
 
@@ -41,16 +44,20 @@ File containing *script*'s terminal output.
 File containing *script*'s terminal output and input.
 
 *-t*, *--timing* _file_::
-File containing *script*'s timing output. This option overrides old-style arguments.
+File containing *script*'s timing output.
+This option replaces the _timingfile_ positional argument.
 
 *-T*, *--log-timing* _file_::
 This is an alias for *-t*, maintained for compatibility with *script*(1) command-line options.
 
 *-s*, *--typescript* _file_::
-File containing *script*'s terminal output. Deprecated alias to *--log-out*. This option overrides old-style arguments.
+Deprecated alias of *--log-out*.
 
 *-c*, *--cr-mode* _mode_::
-Specifies how to use the CR (0x0D, carriage return) character from log files. The default mode is _auto_, in this case CR is replaced with line break for stdin log, because otherwise *scriptreplay* would overwrite the same line. The other modes are _never_ and _always_.
+Specifies how to handle the CR (carriage return, 0x0D) character from log
+files. The default mode is *auto*, in which case CR is replaced with a
+line break for the stdin log, because otherwise *scriptreplay* would
+overwrite the same line. The other modes are *never* and *always*.
 
 *-d*, *--divisor* _number_::
 Speed up the replay displaying this _number_ of times. The argument is a floating-point number. It's called divisor because it divides the timings by this factor. This option overrides old-style arguments.
@@ -59,10 +66,15 @@ Speed up the replay displaying this _number_ of times. The argument is a floatin
 Set the maximum delay between updates to _number_ of seconds. The argument is a floating-point number. This can be used to avoid long pauses in the typescript replay.
 
 *--summary*::
-Display details about the session recorded in the specified timing file and exit. The session has to be recorded using _advanced_ format (see *script*(1) option *--logging-format* for more details).
+Display details about the session recorded in the specified timing file and
+exit. The session must have been recorded using the *advanced* format (see
+*script*(1) option *--logging-format* for more details).
 
 *-x*, *--stream* _type_::
-Forces *scriptreplay* to print only the specified stream. The supported stream types are _in_, _out_, _signal_, or _info_. This option is recommended for multi-stream logs (e.g., *--log-io*) in order to print only specified data.
+Forces *scriptreplay* to print only the specified stream. The supported stream
+types are *in*, *out*, *signal*, and *info*. This option is recommended for
+multi-stream logs (created with *--log-io*) in order to print only the desired
+data.
 
 include::man-common/help-version.adoc[]
 
-- 
2.48.1

