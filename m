Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD6189B8C
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883329; cv=none; b=qReULkHQYF8lSyum4PJAYhuHhDxV1ecuPyRsUDlqbufLee/GJ/5yODgjaTCVsbgGULKo5LydCmEtuAI6cB/m95upMn5A2LFsGxEqPiWHbRf0NtcPme5tl6pRUvMNbHpWz4AnOpKZNoH3x6w2TprDjtTIsikn53WGQ750sBarsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883329; c=relaxed/simple;
	bh=QGEx315rMKRo4x00esJ52GxeeCIXcDzOk/NKkUvNa2U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6Uy1VIQ2kHu65fcwQ+NlGbXF12+rVIJuhoaAECpYerNIkVpXJkgyKiXVg0dBD4zXmiSFbrAtZdgoX/yOZPcNITJRRrSR5NT668inwEz4UY74omM3vDFnTgxW5BrCg5MxfltWnMjkIUDH4SXVLi6/tOa7i/lSsb6deh5yzy68jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=O1mAWg7W; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="O1mAWg7W"
X-KPN-MessageId: 4794c67b-1b71-11f0-b8e8-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4794c67b-1b71-11f0-b8e8-005056999439;
	Thu, 17 Apr 2025 11:49:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=R+tpjfQa8ZZjVvPTnAwGZ/aWHA1wExr+u1AtnUtgut0=;
	b=O1mAWg7WjAv1ZPjIDcThopeO6IMo5EvR0YXPebMvRRu+thZ71QLZZ3T0DAr2obK5c1WvWL/LuC9sO
	 RvNSI12Zetfu9TmuYC4CdF4Fym0vU2B/7hUkPiquX/UVJA/C4QmL+YKh0kLy6aEASB+YjWAZw4ND2h
	 uJJcWEC9dsd+KkUE=
X-KPN-MID: 33|o7A5GAGKZA+uxfRaRwsb5SS6w9HpwDTFiDoqMBZYem8+G4188dAh5mG6zZyzv9Y
 oOoqx3/7AfNQ7gDqJr0FQQvb7CGiuYrIrXfmsjGuiIhY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|L1exaxzGBIGLguiIdqcvdmyETCuW32QG3z2nPhRqSlMRbHxOC7tBVrB5Pm1ZsdQ
 WhIRaxjXnhHNADMPeE+o6Dw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 26363e00-1b71-11f0-afa6-005056998788;
	Thu, 17 Apr 2025 11:48:43 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/10] last: (man) reduce an inflated table to sane proportions
Date: Thu, 17 Apr 2025 11:48:17 +0200
Message-ID: <20250417094825.20870-3-bensberg@telfort.nl>
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

Also, reword some things for better flow, improve some markup, and
combine username and tty to [username|tty]... in the synopsis, as
this better indicates that the two identifiers can be mixed.

Furthermore, use quotes around the time formats that contain a space,
as otherwise the time would be understood as a user name / tty name.
Drop the "tomorrow" and "+5min" examples, as they don't make sense
here.  And change the "-5days" example to a true format that covers
most possibilities, and give a few examples of it after the table.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/last.1.adoc | 77 +++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/login-utils/last.1.adoc b/login-utils/last.1.adoc
index 8da52c766..adf82ae73 100644
--- a/login-utils/last.1.adoc
+++ b/login-utils/last.1.adoc
@@ -29,15 +29,21 @@ last, lastb - show a listing of last logged in users
 
 == SYNOPSIS
 
-*last* [options] [_username_...] [_tty_...]
+*last* [options] [_username_|_tty_]...
 
-*lastb* [options] [_username_...] [_tty_...]
+*lastb* [options] [_username_|_tty_]...
 
 == DESCRIPTION
 
-*last* searches back through the _/var/log/wtmp_ file (or the file designated by the *-f* option) and displays a list of all users logged in (and out) since that file was created. One or more _usernames_ and/or _ttys_ can be given, in which case *last* will show only the entries matching those arguments. Names of _ttys_ can be abbreviated, thus *last 0* is the same as *last tty0*.
+*last* searches back through the _/var/log/wtmp_ file (or the file given with the *-f* option)
+and displays a list of all users who logged in (and out) since that file was created.
+One or more _usernames_ and/or _ttys_ can be given, in which case *last* will show only
+the entries matching those arguments. (Names of _ttys_ can be abbreviated, thus *last 0*
+is the same as *last tty0*.)
 
-When catching a *SIGINT* signal (generated by the interrupt key, usually control-C) or a *SIGQUIT* signal, *last* will show how far it has searched through the file; in the case of the *SIGINT* signal *last* will then terminate.
+When catching a *SIGINT* or *SIGQUIT* signal, *last* will show how far it has searched through
+the file, and in case of the *SIGINT* signal (generated by the interrupt key, usually control-C)
+*last* will then terminate.
 
 The pseudo user *reboot* logs in each time the system is rebooted. Thus *last reboot* will show a log of all the reboots since the log file was created.
 
@@ -46,32 +52,37 @@ The pseudo user *reboot* logs in each time the system is rebooted. Thus *last re
 == OPTIONS
 
 *-a*, *--hostlast*::
-Display the hostname in the last column. Useful in combination with the *--dns* option.
+Display the hostname in the last column. Useful in combination with the *-d* option.
 
 *-d*, *--dns*::
 For non-local logins, Linux stores not only the host name of the remote host, but its IP number as well. This option translates the IP number back into a hostname.
 
 *-f*, *--file* _file_::
-Tell *last* to use a specific _file_ instead of _/var/log/wtmp_. The *--file* option can be given multiple times, and all of the specified files will be processed.
+Tell *last* to use a specific _file_ instead of _/var/log/wtmp_. The *-f* option
+can be given multiple times, and all of the specified files will be processed.
 
 *-F*, *--fulltimes*::
 Print full login and logout times and dates.
 
 *-i*, *--ip*::
-Like *--dns ,* but displays the host's IP number instead of the name.
+Like *-d*, but displays the host's IP number instead of the name.
 
-**-**__number__; *-n*, *--limit* _number_::
-Tell *last* how many lines to show.
+*-n*, *--limit* _number_::
+The maximum amount of logins to show.
+
+**-**_number_::
+The same as *-n* _number_.
 
 *-p*, *--present* _time_::
-Display the users who were present at the specified time.
+Display the users who were present at the specified _time_.
+For ways to specify _time_, see the section *TIME FORMATS* below.
 
 *-R*, *--nohostname*::
 Suppresses the display of the hostname field.
 
 *-s*, *--since* _time_::
 Display the state of logins since the specified _time_.
-The option is often combined with *-t*/*--until* to cover a period.
+The option can be combined with *-t* to cover a period.
 
 *-t*, *--until* _time_::
 Display the state of logins until the specified _time_.
@@ -80,10 +91,18 @@ Display the state of logins until the specified _time_.
 Use ASCII *tab* characters to separate the columns in the output instead of spaces.
 
 *--time-format* _format_::
-Define the output timestamp _format_ to be one of _notime_, _short_, _full_, or _iso_. The _notime_ variant will not print any timestamps at all, _short_ is the default, and _full_ is the same as the *--fulltimes* option. The _iso_ variant will display the timestamp in ISO-8601 format. The ISO format contains timezone information, making it preferable when printouts are investigated outside of the system.
+Define the appearance of the timestamp to be one of: *notime*, *short*, *full*, or *iso*.
+The *notime* variant will not print any timestamps at all, *short* is the default,
+and *full* is the same as the *--fulltimes* option.
+The *iso* variant will display the timestamp in ISO-8601 format.
+The ISO format contains timezone information, making it preferable when
+printouts are investigated outside of the system.
 
 *-w*, *--fullnames*::
-Display full user names and domain names / IP addresses in the output.  Domain names and IP addresses are truncated to 16 characters, and user names are truncated to 8 characters when this flag is not specified.  An asterisk is set as the last character of truncated fields.
+Display full user names and domain names / IP addresses.
+When this option is not specified, user names are truncated to 8 characters,
+and domain names and IP addresses to 16 characters.
+An asterisk is shown as the last character of truncated fields.
 
 *-x*, *--system*::
 Display the system shutdown entries and run level changes.
@@ -92,23 +111,21 @@ include::man-common/help-version.adoc[]
 
 == TIME FORMATS
 
-The options that take the _time_ argument understand the following formats:
-
-[cols=",",]
-|===
-|YYYYMMDDhhmmss |
-|YYYY-MM-DD hh:mm:ss |
-|YYYY-MM-DD hh:mm |(seconds will be set to 00)
-|YYYY-MM-DD |(time will be set to 00:00:00)
-|hh:mm:ss |(date will be set to today)
-|hh:mm |(date will be set to today, seconds to 00)
-|now |
-|yesterday |(time is set to 00:00:00)
-|today |(time is set to 00:00:00)
-|tomorrow |(time is set to 00:00:00)
-|+5min |
-|-5days |
-|===
+The argument _time_ allows the following forms:
+....
+ YYYYMMDDhhmmss
+ "YYYY-MM-DD hh:mm:ss"
+ "YYYY-MM-DD hh:mm"      (seconds is 00)
+ YYYY-MM-DD              (time is 00:00:00)
+ hh:mm:ss                (date is today)
+ hh:mm                   (date is today, seconds is 00)
+ now
+ today                   (time is 00:00:00)
+ yesterday               (time is 00:00:00)
+ -number[smhd]           (seconds/minutes/hours/days before now)
+....
+Examples of the **-**_number_[*smhd*] format are: *-5m*, *-6h*, *-2d*.
+The unit specifier may be longer: *-5min*, *-6hours*, *-2days*.
 
 == FILES
 
-- 
2.48.1

