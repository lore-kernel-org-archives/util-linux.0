Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81E140E3C
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038932; cv=none; b=HIghqW//FCuNPSW+ibnAMfPVu2XTQfv+bTceB9Y0OeC0OK/h5KxR2CNdB4xRF7NW2EF3GE+eDdym0JlCqRZirJ9jM2n/h4PkTix4ur/7eb8hoL//x5m0herc/nXOIv8dpKH8HmfcJDM7IW0nYI71XS3d1pNzRwad8pZMFlUwucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038932; c=relaxed/simple;
	bh=Mk0abJaJE0jIuuceNvxpgO6e7gjJVpmLYWOMh74Vdg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjfzL0nUEHYtQwDqU9KT9VOvgS8QfRG2uNpHiR5tjA2Uspc+X0UQF6eZL9IeeiFBP4jh4hxOp02njpFtn1c72plGktFcmJJnHvjwbtdx2M4YnXw/McrJbVo5FMRNiv1oGi4DUFxzaX5dzfQ9Aqzh9Hghfy8dbhG1/bvk2ZS0jx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=gZuEVUyx; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="gZuEVUyx"
X-KPN-MessageId: 41b38370-13c3-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 41b38370-13c3-11f0-b9a0-005056abbe64;
	Mon, 07 Apr 2025 17:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=yNCZVfaTJCG/MNM/LR344RFpR3150WQLWmJ69ni3yrM=;
	b=gZuEVUyxSruRB41Y3a1UnIxwked08iozy2BwuIUrxJcMZ3091jmhxpDdwYaqSBjIsaqMNc+DLSr6y
	 S2nPA4luKFpvkY8JFmEVTB5z1erOYZSIfMYz5MRLBeI9j6yzjUgjzqXnvKzzT7tlE3M3X7g+pkP8vt
	 5ma9Zezvb01gsoCo=
X-KPN-MID: 33|UJuozaph1DdxZLpo3V9jFaOB3+l8GMm0rtGcbBkV3V6Iux16WGOeBW3ubLVq3xy
 r4avyIS3W9/vt1lL/JwSNk1L/1AQCfL6lgCga8nJRtbs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Uns9C1eVLqGuLvHoi/LjUvJJPAY+mlP2URRIs+Fl3EPWq+EWNrBUOuHZ7Fc3OmL
 g3BbQe5wqRaFewoZELYD0Yw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 21bd7699-13c3-11f0-9bf0-005056ab7447;
	Mon, 07 Apr 2025 17:15:25 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/8] hexdump: (man) normalize the synopsis, and shrink a list and two tables
Date: Mon,  7 Apr 2025 17:14:34 +0200
Message-ID: <20250407151503.23394-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simply use blocks of preformatted text for the tables, as asciidoctor
inflates true tables to overblown proportions on a man page.

Also, correct the code for DEL from FF to 7F.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/hexdump.1.adoc | 55 ++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/text-utils/hexdump.1.adoc b/text-utils/hexdump.1.adoc
index 153953817..c92733a51 100644
--- a/text-utils/hexdump.1.adoc
+++ b/text-utils/hexdump.1.adoc
@@ -48,9 +48,9 @@ hexdump - display file contents in hexadecimal, decimal, octal, or ascii
 
 == SYNOPSIS
 
-*hexdump* _options file_ ...
+*hexdump* [options] _file_ ...
 
-*hd* _options file_ ...
+*hd* [options] _file_ ...
 
 == DESCRIPTION
 
@@ -116,29 +116,24 @@ If an iteration count and/or a byte count is specified, a single slash must be p
 
 The format is required and must be surrounded by double quote (" ") marks. It is interpreted as a fprintf-style format string (see *fprintf*(3)), with the following exceptions:
 
-1.::
-An asterisk (*) may not be used as a field width or precision.
+. An asterisk (*) may not be used as a field width or precision.
 
-2.::
-A byte count or field precision _is_ required for each *s* conversion character (unlike the *fprintf*(3) default which prints the entire string if the precision is unspecified).
+. A byte count or field precision _is_ required for each *s* conversion character
+(unlike the *fprintf*(3) default which prints the entire string if the precision is unspecified).
 
-3.::
-The conversion characters *h*, *l*, *n*, *p*, and *q* are not supported.
-
-4.::
-The single character escape sequences described in the C standard are supported:
+. The conversion characters *h*, *l*, *n*, *p*, and *q* are not supported.
 
+. The single character escape sequences described in the C standard are supported:
++
 ____
-|===
-|NULL |\0
-|<alert character> |\a
-|<backspace> |\b
-|<form-feed> |\f
-|<newline> |\n
-|<carriage return> |\r
-|<tab> |\t
-|<vertical tab> |\v
-|===
+ \0   NULL
+ \a   alert character
+ \b   backspace
+ \f   form-feed
+ \n   newline
+ \r   carriage return
+ \t   tab
+ \v   vertical tab
 ____
 
 === Conversion strings
@@ -159,16 +154,16 @@ Output characters in the default character set. Non-printing characters are disp
 
 *_u*::
 Output US ASCII characters, with the exception that control characters are displayed using the following, lower-case, names. Characters greater than 0xff, hexadecimal, are displayed as hexadecimal strings.
-
++
 ____
-|===
-|000 nul |001 soh |002 stx |003 etx |004 eot |005 enq
-|006 ack |007 bel |008 bs |009 ht |00A lf |00B vt
-|00C ff |00D cr |00E so |00F si |010 dle |011 dc1
-|012 dc2 |013 dc3 |014 dc4 |015 nak |016 syn |017 etb
-|018 can |019 em |01A sub |01B esc |01C fs |01D gs
-|01E rs |01F us |0FF del | | |
-|===
+ 00 nul     08 bs      10 dle     18 can     7F del
+ 01 soh     09 ht      11 dc1     19 em
+ 02 stx     0A lf      12 dc2     1A sub
+ 03 etx     0B vt      13 dc3     1B esc
+ 04 eot     0C ff      14 dc4     1C fs
+ 05 enq     0D cr      15 nak     1D gs
+ 06 ack     0E so      16 syn     1E rs
+ 07 bel     0F si      17 etb     1F us
 ____
 
 === Colors
-- 
2.48.1

