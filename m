Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1E1C84AD
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883341; cv=none; b=rYx/mMwI7jvSZS1UE+fvSUYQJ5mgu7jhZTd4rUlzgWDyrUUtx/sVRYdt9twLqFc/ldHZzVr5peVGbR+5NzHUCG8oKlVlnWWlYJB4M4R3X/UzgMwQiEVKlV1mIpQaZCMW/nheYLDQ770ZShlGjDdjpuzPbc4bZY9Byn3xz6lolwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883341; c=relaxed/simple;
	bh=0yHW7VobNXLJDlCS48QYAj/2RP4Me9L7coNdU4id1Gc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odNQdIwAShlcYjQlYi5DSEO52LCHpp01VLo3H6cILJSWk5XjFujb3LzoE6u9v7XblSnPCn/dxjrs92dfuH2rR9VeaSmbmUYudj37w2QkOygHjN4Tnxqbp92zJKzCaf8dasZdgSDNzt+jINF+TTH/akFWCdewN2jyXlpbyCWJJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=fQhXOg66; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="fQhXOg66"
X-KPN-MessageId: 4f831afe-1b71-11f0-b8e8-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4f831afe-1b71-11f0-b8e8-005056999439;
	Thu, 17 Apr 2025 11:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=OlL+esr2elSvPK46wEiQ1nGeCwi/9Q3LB2FI/BPzyNo=;
	b=fQhXOg66Dc7lNeg0IGcLE7tRyGGcNHxkivsSdIn/dOrcsKPnur0q/al++ywwZUtj4N0seC/aNCU3V
	 jPLIGgzm/DDlBdtUnmsh2ByBtVlA1OlIB4+kDdTutpdwStVDOwOHr5B+C0HRMXduFhJmq2hIBpoJZn
	 1efbtUW8PybfaOlo=
X-KPN-MID: 33|u1xPh/kjGuogm2pNIUaiKQ8CriYKxH3J2SGxpIHggbX9HHikEpZmL18a2DXZsxR
 56j5gkRmOJzuywQot0Q8liGsADhaUpTmRVFfFm2nnlnM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VZfZt1cHlijNpFzeyT7vvIMLZOC1ZmvvNhhf1qPHFBGnkKokAqeY7uDYgHNqjH6
 Fe/TtqiEVo5ozvC9EKDoUUw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2e20a9fc-1b71-11f0-99e7-00505699772e;
	Thu, 17 Apr 2025 11:48:56 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/10] terminal-colors.d: (man) reduce two tables to succinct lists
Date: Thu, 17 Apr 2025 11:48:19 +0200
Message-ID: <20250417094825.20870-5-bensberg@telfort.nl>
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

Before the move to asciidoctor, these tables were succinct lists in the
man page.  Change the asciidoc text to make them into lists again.

Use {nbsp} on one line to avoid weird groff behavior for \? when .ss
is defined to be zero-width (as asciidoctor does), and reshuffle two
paragraphs to avoid an asciidoctor bug that adds a spurious \fP after
a monospace span defined with double backticks.

Also, correct some markup in a few earlier paragraphs.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 lib/terminal-colors.d.5.adoc | 103 ++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 55 deletions(-)

diff --git a/lib/terminal-colors.d.5.adoc b/lib/terminal-colors.d.5.adoc
index ed8c48727..4936947b1 100644
--- a/lib/terminal-colors.d.5.adoc
+++ b/lib/terminal-colors.d.5.adoc
@@ -47,14 +47,15 @@ The user-specific _$XDG_CONFIG_HOME/terminal-colors.d_ or _$HOME/.config/termina
 == DEFAULT SCHEME FILES FORMAT
 
 The following statement is recognized:
-
 ____
-*name color-sequence*
+_name color-sequence_
 ____
 
-The *name* is a logical name of color sequence (for example "error"). The names are specific to the utilities. For more details always see the *COLORS* section in the man page for the utility.
+The _name_ is a logical name for the color sequence (for example: *error*).
+The names are specific to the utilities. For more details always see
+the *COLORS* section in the man page for the utility.
 
-The *color-sequence* is a color name, ASCII color sequences or escape sequences.
+The _color-sequence_ is a color name, ASCII color sequences, or escape sequences.
 
 === Color names
 
@@ -63,67 +64,59 @@ black, blink, blue, bold, brown, cyan, darkgray, gray, green, halfbright, lightb
 === ANSI color sequences
 
 The color sequences are composed of sequences of numbers separated by semicolons. The most common codes are:
-
 ____
-[cols=",",]
-|===
-|0 |to restore default color
-|1 |for brighter colors
-|4 |for underlined text
-|5 |for flashing text
-|30 |for black foreground
-|31 |for red foreground
-|32 |for green foreground
-|33 |for yellow (or brown) foreground
-|34 |for blue foreground
-|35 |for purple foreground
-|36 |for cyan foreground
-|37 |for white (or gray) foreground
-|40 |for black background
-|41 |for red background
-|42 |for green background
-|43 |for yellow (or brown) background
-|44 |for blue background
-|45 |for purple background
-|46 |for cyan background
-|47 |for white (or gray) background
-|===
+     0   to restore default color
+     1   for brighter colors
+     4   for underlined text
+     5   for flashing text
+    30   for black foreground
+    31   for red foreground
+    32   for green foreground
+    33   for yellow (or brown) foreground
+    34   for blue foreground
+    35   for purple foreground
+    36   for cyan foreground
+    37   for white (or gray) foreground
+    40   for black background
+    41   for red background
+    42   for green background
+    43   for yellow (or brown) background
+    44   for blue background
+    45   for purple background
+    46   for cyan background
+    47   for white (or gray) background
 ____
 
-=== Escape sequences
-
-To specify control or blank characters in the color sequences, C-style \-escaped notation can be used:
-
-____
-[cols=",",]
-|===
-|*\a* |Bell (ASCII 7)
-|*\b* |Backspace (ASCII 8)
-|*\e* |Escape (ASCII 27)
-|*\f* |Form feed (ASCII 12)
-|*\n* |Newline (ASCII 10)
-|*\r* |Carriage Return (ASCII 13)
-|*\t* |Tab (ASCII 9)
-|*\v* |Vertical Tab (ASCII 11)
-|*\?* |Delete (ASCII 127)
-|*\_* |Space
-|*\\* |Backslash (\)
-|*\^* |Caret (^)
-|*\#* |Hash mark (#)
-|===
-____
-
-Please note that escapes are necessary to enter a space, backslash, caret, or any control character anywhere in the string, as well as a hash mark as the first character.
-
 For example, to use a red background for alert messages in the output of *dmesg*(1), use:
 
+``  *echo 'alert 37;41' >> /etc/terminal-colors.d/dmesg.scheme*``
+
+=== Escape sequences
+
+An escape sequence is necessary to enter a space, backslash, caret, or any
+control character anywhere in a string, as well as a hash mark as the first
+character. These C-style backslash-escapes can be used:
+
 ____
-*echo 'alert 37;41' >> /etc/terminal-colors.d/dmesg.scheme*
+``    *\a*   Bell (ASCII 7)``
+``    *\b*   Backspace (ASCII 8)``
+``    *\e*   Escape (ASCII 27)``
+``    *\f*   Form feed (ASCII 12)``
+``    *\n*   Newline (ASCII 10)``
+``    *\r*   Carriage Return (ASCII 13)``
+``    *\t*   Tab (ASCII 9)``
+``    *\v*   Vertical Tab (ASCII 11)``
+``    *\?*{nbsp}{nbsp}{nbsp}Delete (ASCII 127)``
+``    *\_*   Space``
+``    *\\*   Backslash (\)``
+``    *\^*   Caret (^)``
+``    *\\#*   Hash mark (#)``
 ____
 
 === Comments
 
-Lines where the first non-blank character is a # (hash) are ignored. Any other use of the hash character is not interpreted as introducing a comment.
+Lines where the first non-blank character is a *#* (hash) are ignored.
+Any other use of the hash character is not interpreted as introducing a comment.
 
 == ENVIRONMENT
 
-- 
2.48.1

