Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDD802
	for <util-linux@vger.kernel.org>; Mon, 24 Feb 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402595; cv=none; b=KK3DD0F08FlZw3r/DYnZDFvxaiT9oJ42ViKVbFHp7yu1LWlX445uEXifpa3pA8Et8p4dGLvxTu6Ib3v8F/Hb3GzIlIUeZrAcHWovWBH7GwBGBV1pi5mh9hi0ehyyWqZ2OBGjFsZ24J7MNMzuA3ZMCUPJRT/zJcOGMUCwI3WVRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402595; c=relaxed/simple;
	bh=+8LMHBL6u91pnc0ZhOwuyNSvS32aL6hOMYZDcWxPYwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgLrGb7Dd/w7dRTlYXYbyGT43NnFSCAV2dQZg1LO3wXt62WGPOqsIzpIkOxo0K+g4Hiq1nzrOl3AF/RwxLKBxyBjjmDBKWYI378bv+Jfux1bhehD88GF2aAw8lUxLWDGIljIW2U+a1rK9HmgKmAQwd0QoW6ocNVAo+bOHCagV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=fEGjauI8; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="fEGjauI8"
X-KPN-MessageId: a869afd6-f2b0-11ef-86c8-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a869afd6-f2b0-11ef-86c8-005056aba152;
	Mon, 24 Feb 2025 14:10:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Ui+r0tXOI2UUEKLEyWW01AcP0VsDbn8tg4uH+oPpcPA=;
	b=fEGjauI8y2wok6fy/nNiOuD2xi9wlWm3xz6er6ENC3v3yx0o1OwGrd/ANh4oQoRQXSfmoltwMWSm0
	 GfguKqxRDQadcV+9l2qd0R7YN9qZxVAVe8a9cSxEGX86fcYRPsfOisAHGT+HYrQEqq1hNsbXIPE7zw
	 vWo52f/hu1iwwwaA=
X-KPN-MID: 33|R3kyWpXZ1+v20hyQZe5JlvhxOZT3guERuPhdHdZvsO927NmZ9Nn0fX2Xjcn0TMM
 ElM/kKh8yvy0KA19mlbaJcJhjfD1kb5z6puTb8pxUOGw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zdhAoPiPNMNN/ADSgN20ao/Y3Nd/lunhGk3TkVlJMmFke0Wo7WZCcet5gWgMiz6
 bT15Kck926yZ+Dzx3HDLBCA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id a1edf524-f2b0-11ef-9583-005056abf0db;
	Mon, 24 Feb 2025 14:09:51 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] scriptlive: improve some descriptions, markup, and grammar in the manpage
Date: Mon, 24 Feb 2025 14:08:40 +0100
Message-ID: <20250224130840.25770-6-bensberg@telfort.nl>
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

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/scriptlive.1.adoc | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/term-utils/scriptlive.1.adoc b/term-utils/scriptlive.1.adoc
index 58aeb4ce1..10e299875 100644
--- a/term-utils/scriptlive.1.adoc
+++ b/term-utils/scriptlive.1.adoc
@@ -21,9 +21,14 @@ This program re-runs a typescript, using stdin typescript and timing information
 
 The *session is executed* in a newly created pseudoterminal with the user's $SHELL (or defaults to _/bin/bash_).
 
-*Be careful!* Do not forget that the typescript may contains arbitrary commands. It is recommended to use *"scriptreplay --stream in --log-in typescript"* (or with *--log-io* instead of *--log-in*) to verify the typescript before it is executed by *scriptlive*.
+*Be careful!* The typescript may contain arbitrary commands. It is
+recommended to use *"scriptreplay --stream in --log-in typescript"*
+(or with *--log-io* instead of *--log-in*) to verify the typescript
+before it is executed with *scriptlive*.
 
-The timing information is what *script*(1) outputs to file specified by *--log-timing*. The typescript has to contain stdin information and it is what script1 outputs to file specified by *--log-in* or *--log-io*.
+The timing information is what *script*(1) outputs to the file specified by
+*--log-timing*. The typescript has to contain stdin information, and is what
+*script*(1) outputs to the file specified by *--log-in* or *--log-io*.
 
 == OPTIONS
 
@@ -34,15 +39,19 @@ File containing *script*'s terminal input.
 File containing *script*'s terminal output and input.
 
 *-E*, *--echo* _when_::
-This option controls the *ECHO* flag for the slave end of the session's pseudoterminal. The supported modes are _always_, _never_, or _auto_.
+This option controls the *ECHO* flag for the slave end of the session's
+pseudoterminal. The supported modes are *always*, *never*, and *auto*.
 +
-The default is _auto_ -- in this case, *ECHO* enabled; this default behavior is subject to change.
+The default is *auto* -- in which case *ECHO* is enabled. This default
+behavior is subject to change.
 
 *-t*, *--timing* _file_::
-File containing *script*'s timing output. This option overrides old-style arguments.
+File containing *script*'s timing output.
+This option replaces the _timingfile_ positional argument.
 
 *-T*, *--log-timing* _file_::
-Aliased to *-t*, maintained for compatibility with *script*(1) command-line options.
+An alias for *-t*; maintained for compatibility with the *script*(1)
+command-line options.
 
 *-d*, *--divisor* _number_::
 Speed up the replay displaying this _number_ of times. The argument is a floating-point number. It's called divisor because it divides the timings by this factor. This option overrides old-style arguments.
-- 
2.48.1

