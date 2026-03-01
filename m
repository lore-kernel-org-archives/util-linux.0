Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C7145A1F
	for <util-linux@vger.kernel.org>; Sun,  1 Mar 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383518; cv=none; b=Fry9sg6sdiZrOdaVV8PIHhxn+3XC561dIi8cam5BSWDt5ed+SfLR8rs4d5c+tXN0dbhJa8SjtSAb23acB9Owl2tlG0Osh20EjY1vw9/+DyTrhvzY/Zu312ZUR0B8palgSXODgJI3FvEUCmA6xZIqM9f3CMUEA5ABF13DQh9WRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383518; c=relaxed/simple;
	bh=O2bfRJg5R7oZUwDYjrZu32FEyMOjcwPl9ZQfN3Opvno=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qMgipA50REjOyha2cyhcBbKgsVB36ejk9ixEL9hIb8h5fY2thx1Afnt0vBxRgqcYx8vqCebTdWDrkgIImAiTgE9J2TQ08PU/Tg5N8gb50o8Qlhx/PdYXs7bIg8r8xbHeV3Jq9DLpoDySQ54wCeI0je8HaicnJB7YxiWX4Bjd+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=GsBVGr/G; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="GsBVGr/G"
X-KPN-MessageId: 017422a6-158e-11f1-b182-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 017422a6-158e-11f1-b182-005056abad63;
	Sun, 01 Mar 2026 17:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=j0USeofnzsp35Oj5bS1CbVECGO+UOtM7VNc6DcBNLkQ=;
	b=GsBVGr/GH0NiIN2dzqp6FxFDlniOULXjQEyHK8YjYqExgRNnK72xQPXFiYRYVnjsLiJE5hHmp3TBv
	 k7djQgsMnaeSxWIo3a7WGfswPV0wPJrtt47/LHBvoediBkYzDYMXCoRu8eZwhT25LImhzeDeq3+spF
	 +9d92I5qpO0QZq5U=
X-KPN-MID: 33|F4Yu5Xz3QlgK0G/eVDfdfSBEmh3lbo71lJnu/K6Bqfr+RSa8Kn+9CtJH5j3V+RM
 6LuoihffZaSC+aMuqQGQeDF8EpV1CL9xubYlmRyDStX4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|bNklamVyyJ8w7y25gHZXHAClDxGww1yo512hANwPLdTaro3L/3J81IQpIKL9Goh
 w2bX1dHIjfso2gIXl//wwCA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0156e38f-158e-11f1-a6ca-005056abf0db;
	Sun, 01 Mar 2026 17:45:07 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] terminal-colors.d: (man) do not show 'type' as an optional part
Date: Sun,  1 Mar 2026 17:45:05 +0100
Message-ID: <20260301164505.24409-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That is: remove the square brackets from around 'type' in the synopsis.

Also, do not give the impression that a leading dot by itself is fine
before the 'type'.  That is: a dot is required only when 'name' and/or
'@term' is present.

Also, do not colorize the square brackets as if they were part of the
placeholders.  (And use ++double plus++ passthroughs for the opening
square brackets, to prevent asciidoctor from misinterpreting them.)

Indent the list of file types, for clarity.

And correct or improve some wordings, and remove an inconvenient
blank line in an example.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 lib/terminal-colors.d.5.adoc | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/lib/terminal-colors.d.5.adoc b/lib/terminal-colors.d.5.adoc
index 40ed8b966..9704fe413 100644
--- a/lib/terminal-colors.d.5.adoc
+++ b/lib/terminal-colors.d.5.adoc
@@ -21,7 +21,7 @@ terminal-colors.d - configure output colorization for various utilities
 
 == SYNOPSIS
 
-/etc/terminal-colors.d/_[[name][@term].][type]_
+*/etc/terminal-colors.d/*++[++_name_**.**|++[++_name_]**@**_term_**.**]_type_
 
 == DESCRIPTION
 
@@ -32,14 +32,14 @@ The _name_ is a utility name. The name is optional and when none is specified th
 The _term_ is a terminal identifier (the *TERM* environment variable). The terminal identifier is optional and when none is specified then the file is used for all unspecified terminals.
 
 The _type_ is a file type. Supported file types are:
-
+____
 *disable*::
 Turns off output colorization for all compatible utilities. See also the NO_COLOR environment variable below.
 *enable*::
 Turns on output colorization; any matching *disable* files are ignored.
-
 *scheme*::
 Specifies colors used for output. The file format may be specific to the utility, the default format is described below.
+____
 
 If there are more files that match for a utility, then the file with the more specific filename wins. For example, the filename "@xterm.scheme" has less priority than "dmesg@xterm.scheme". The lowest priority are those files without a utility name and terminal identifier (e.g., "disable").
 
@@ -56,15 +56,15 @@ The _name_ is a logical name for the color sequence (for example: *error*).
 The names are specific to the utilities. For more details always see
 the *COLORS* section in the man page for the utility.
 
-The _color-sequence_ is a color name, ASCII color sequences, or escape sequences.
+The _color-sequence_ can be a color name, an ANSI color sequence, or an escape sequence.
 
 === Color names
 
-black, blink, blue, bold, brown, cyan, darkgray, gray, green, halfbright, lightblue, lightcyan, lightgray, lightgreen, lightmagenta, lightred, magenta, red, reset, reverse, and yellow.
+Valid color names are: black, blink, blue, bold, brown, cyan, darkgray, gray, green, halfbright, lightblue, lightcyan, lightgray, lightgreen, lightmagenta, lightred, magenta, red, reset, reverse, and yellow.
 
 === ANSI color sequences
 
-The color sequences are composed of sequences of numbers separated by semicolons. The most common codes are:
+An ANSI color sequence is composed of sequences of numbers separated by semicolons. The most common codes are:
 ____
      0   to restore default color
      1   for brighter colors
@@ -94,7 +94,7 @@ For example, to use a red background for alert messages in the output of *dmesg*
 
 === Escape sequences
 
-An escape sequence is necessary to enter a space, backslash, caret, or any
+An escape sequence is needed to enter a space, backslash, caret, or any
 control character anywhere in a string, as well as a hash mark as the first
 character. These C-style backslash-escapes can be used:
 
@@ -137,31 +137,27 @@ _$HOME/.config/terminal-colors.d_
 
 _/etc/terminal-colors.d_
 
-== EXAMPLE
+== EXAMPLES
 
 Disable colors for all compatible utilities:
-
 ____
 *touch /etc/terminal-colors.d/disable*
 ____
 
 Disable colors for all compatible utils on a vt100 terminal:
-
 ____
 *touch /etc/terminal-colors.d/@vt100.disable*
 ____
 
 Disable colors for all compatible utils except *dmesg*(1):
-
 ____
-*touch /etc/terminal-colors.d/disable*
-
+*touch /etc/terminal-colors.d/disable* +
 *touch /etc/terminal-colors.d/dmesg.enable*
 ____
 
 == COMPATIBILITY
 
-The *terminal-colors.d* functionality is currently supported by all util-linux utilities which provides colorized output. For more details always see the *COLORS* section in the man page for the utility.
+The *terminal-colors.d* functionality is currently supported by all util-linux utilities which provide colorized output. For more details always see the *COLORS* section in the man page for the utility.
 
 include::man-common/bugreports.adoc[]
 
-- 
2.53.0

