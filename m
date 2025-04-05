Received: from smtp-out1-04.simnet.is (smtp-out1-04.simnet.is [194.105.232.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278091C27
	for <util-linux@vger.kernel.org>; Sat,  5 Apr 2025 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743812613; cv=none; b=loB9vAdyjK3POqkY38x5wGsGAzSPsMd+q1nK50+l/I7fWsRxu1K/+cjlxAxy7WTSP33xIwnTiTbBc0lwQ/6px0lgQCbF3CvS7hhYFe/OMrhLsrEc806UrdKkkH/pD688gx0pc9+U6VwA8mwwtBOmsO0jfeC6esJX0LVZIJejO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743812613; c=relaxed/simple;
	bh=wXteHooHb5yjNky/A/gg2zgz/1JYlw/7UlYhNMOwueY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AJsx/373z+PUSQAtwe4K07gWUH+X+nqV0jolAxT7LnCBI3MNDjLPAg4X4T1JEmoQxiZTHJ8bHHhp6i96K7Ex2PgVMX5Nh4dD84zMHQIFPrI7ZOa3BCKYqXCQJbnKOtQnDHx3ruN97TFn7mSxmn7LJa+/0wSusZj/DkB0qYEFtbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=h95OmSYO; arc=none smtp.client-ip=194.105.232.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="h95OmSYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1743812610; x=1775348610;
  h=date:from:to:subject:message-id:mime-version;
  bh=UZ/fe2d8Dtuu3NoU+LwyiZVQItTyGI3rfyBU9xKLpHk=;
  b=h95OmSYORquXK3YQlHfLgNeQnQ2+ho2wUjqZtKaNMQHwH65IxxdNE0rt
   EWTTgiqPtpTK4wW/4g++GmPn8Ai628rme4kV8EYDtpPsDpoedPBMvWKaf
   ZuvWY8s4d+cACcg3/3W7U20RdTUF7SZ60an2ia15jxo1jKbfazpVfOuCa
   7Q7FJvwhkezaHB5cFWc2AWC50R7Vj8PvfIIRQYmxR1/q7NkAphrspFfO0
   lpVnXVcSneqUIjWAlHj2ln1JqVXCo704rZPOQg83Id0cG9Z5zxp8X0bLJ
   2UwU8gYCrUMsBfB4UqFDuYIpdrpdqI2IOKaoWHEAQJm200AJ3/znGIDDD
   w==;
X-CSE-ConnectionGUID: JiwkTKf4Q9CRLwRz3qpltg==
X-CSE-MsgGUID: U8w23UhKQ7ihWD5ecPjAKg==
Authentication-Results: smtp-out-04.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2EKAAC7U/BnhVfoacJaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFCAgEBAQELAYJDfYFkiCSOI6AcBwEBAQ85CwQBAQMBA4UAi?=
 =?us-ascii?q?ysoNwYOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBgEBAQEBAQYHAhABAQEBQ?=
 =?us-ascii?q?A47hTVGDYQHgSUBAQEBAQEBAQEBAQEBAQEBAQEBFwINgip8gykBgmQUsE6BN?=
 =?us-ascii?q?IEBgxzbGIFeEIFIAYVsgmMBhWyEdzwGgg2BFTIDgXNRb4JhAoIMhhgEghYXg?=
 =?us-ascii?q?QUWjUsgky5IgSEDWSwBVRMNCgsHBYFsAzUMCy4VMkY4HYF8g3mFOoIRiyGEW?=
 =?us-ascii?q?y1Pg34dNgoDCxgNSBEsNxQbRG4HlniDGwkBJQlEATBdASsgAjYtEwMwBg8dA?=
 =?us-ascii?q?ZQUj1uBRKAkgT6EJYZcgzGCC5VKMyKDYZNDDDqSSy6SeIVYjRtqlXYZN4Rog?=
 =?us-ascii?q?X2CACwHGggwO4IzAQEBMQlJGQ+OByMDFoNYhRPECHg8AgcLAQEDCZFnAQE?=
IronPort-PHdr: A9a23:Gp/rSBL0vL9J3OyK8NmcuUoyDhhOgF2VFhUQ9oJijK9SN/z/uY/jO
 UrS+bNslwyBUYba7qdCjOzb++DlVHcb6JmM+HYFbNRXVhADhMlX1wwtCcKIEwv6efjtaSFSI
 Q==
IronPort-Data: A9a23:Bmylq6mvJnSoR6a5vwM6Udvo5gy8IERdPkR7XQ2eYbSJt16W5oEne
 lBvCjHdVaLbPHygOZtoLcjvoSVV5cOEjMhgeLZf3SpgEXxH9cbLWtmXchj5NnjOIMHOER8/4
 5pDOoKbdZ8+QiWC+BqhYubspyIkjvDZHrCtWb+UYCx9TFc1E3l4hRwLd4LV+mJNqYHR71Sl5
 Y2r+qUzQWON2yJoKnlGrOWMqQ9vof60szQd+UEiZPR/+VvfkWQFS48DJKWFan/5RJREWe+hX
 PvO19mFEhjiE2EQ5qmNzvCkGnAiQqLOJRPczT1JRLfkgRVYoCE2lKEhO70EdE0QjzSPgsA21
 clMsYf3VBsoOpmJnOUbTgkfex2SRpaqjoIrW1Dk95T78nD7T5eFL42CZmkrIIwUze1zDGhUs
 6deJDEDYHhv7MrvzbzhF7Qxi5R6JZC0ZtgVtiA8l2mIU6t8EcmcHvWQ6INW0D5o1pAeTaaHO
 ZcXMjE3MxqbPxFFYV4dUcIwzOz57pWTn0W0jXrMzUZgyzeOkmSdqYTFMMbJYsfYAoJKgVnep
 W/c+Wn9RBYAO5uH1DDC9nOqm/+IgD/6XJlVCaG58sovhFyV23xUYCH6LmBX18RV8GblHYo3F
 nEpxsZHQdDenmSkQ9/wRRS85nSZsQV0t7F4GrdltgvVkqCIuFmSV2JbQzcaZYV/7ZNnSDV7i
 w7Vwdm4WzI+uuCZFn+Q+7vM9mu4ZiIec2UObiFbEwdb6tC6+unf4v63ovNLScZZ2fWsSGCgq
 9zzkBUDulkzsSIq///g8AnL2W31rJHAE1Jp7VraUjOpv19wbd/8ONymuQGGxPsRd4zxonup5
 SNdw5fEhAwt4TBhsATXHY3hyZnwv67t3AX02AApR995sWzwpxZPRKgIiBlmPkBlL80YTjHgZ
 U7XqGt56YRaVJeQRfYfj7mZVYJzkMAMKfy/DqqJNoYWPsAqHOO61HgGiXC4jjGFfHcEycnTC
 b/DGe6wAHATD7hQzTbeb481zb8xyyki8njYTJb9wg7P+eL2iKm9EOpt3POmN4jV3YvcyOnn2
 4832/iil32zZNbDjhz/qub/G7ylwU8TXvgao+QPHgKKz5EP9GsJU5c9ypt5E2Bpcjg8ek4lM
 RhRV2cBoGcTi0ErJi2oa29gVJDhAa8uhkgfIhY+Zk+w32QsNNPHAKc3L/PbfJE59fd/iOx1S
 uEffNWRR6wWDCrG4ChbbIKVQI5KLUX3w1vWYmz/O2J5L8EIqw/ho7cIeiPl+wEVDy+xuNd4o
 qbIOgbzHcFfHVUzU52+hPSH8gOu5yMgmMFLAErIHfUOdU7U8qFJJHmk5hMwC5pQeUScl2fyO
 xytKQoEpO2Ip44z7cnhm6+JtcGqHvF4E04cGHPUhYtaLgHE/3G/hJ1BVf6SeiDMETutvrujf
 vkTzuqU3OA7cEhikYtjEIpIw/4HtvDVg6Bg3F99BHHXYAH+Yl9/GUWu0c5Kv6xL47ZWvwqqR
 06CkuW2353SZ6sJ93ZKe2IYgvS/6B0CptXFxdUOSHgWCQdp/aGbFFdTOgGWjzxMaeMsdp0k2
 vtnudV+B+2DZvgCb4fuYsN8rjXkwpk8v0MP7c1y7GjD0VND9726ScaAYhIaGbnWAzm2DmEkI
 yWPmI3JjKlGy0zJfhIbTCeRhrUM3MlW6E0blTfuwmhlfPKZ2ZfbOzUMqVwKovh9lEofuw6OE
 jE3bBMse81iAR803JcfN4xTJ+2xLEbFqh2umgdheJzxSkisXyTNIgUA1RWloSgkH5ZnVmEDp
 tmwkT+5OR60J5uZ9nVpBiZYRwnLFocZGvvqw5v/R5zt8lhTSWaNv5JCkkJR8Eu9X5hq3xaZz
 QSolc4pAZDG2ecri/VTI+GnOX44Enho+EQqrSldwZ40
IronPort-HdrOrdr: A9a23:CK35/KE9HLp559dOpLqE/ceALOsnbusQ8zAXPmRKOHpom62j5q
 eTdZsgtCMc5AxwZJhCo6HlBEDjewK4yXcd2+B4Vt3OMGaJhILCFvAB0WKN+UyCJ8SHzJ8l6Z
 td
X-Talos-CUID: =?us-ascii?q?9a23=3Aaq4KM2h2mNtLjTnOC93po5S3mzJuUHzCz0vzLRO?=
 =?us-ascii?q?BWE1TbKKvWwSJ4Kd4nJ87?=
X-Talos-MUID: 9a23:/d230AbmMXTKQ+BTim/z3mpfNORRvKWuN2xQnJ4+ueCnOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,189,1739836800"; 
   d="diff'?3'?bugs'?scan'208";a="43429973"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-04.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 00:22:18 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 3831541D3FBE
	for <util-linux@vger.kernel.org>; Sat,  5 Apr 2025 00:22:18 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id nPFYFFrCmRH3 for <util-linux@vger.kernel.org>;
 Sat,  5 Apr 2025 00:22:17 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 7DF1941D3FBF
	for <util-linux@vger.kernel.org>; Sat,  5 Apr 2025 00:22:17 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UHOYN6wT3HSr for <util-linux@vger.kernel.org>;
 Sat,  5 Apr 2025 00:22:17 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id 6582841CEF46
	for <util-linux@vger.kernel.org>; Sat,  5 Apr 2025 00:22:17 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98.2)
	(envelope-from <bg@kassi.invalid.is>)
	id 1u0rIU-000000006QZ-3ARn
	for util-linux@vger.kernel.org;
	Sat, 05 Apr 2025 00:22:06 +0000
Date: Sat, 5 Apr 2025 00:22:06 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: util-linux@vger.kernel.org
Subject: uuid_clear.3: Some remarks and a patch with editorial changes for
 this man page
Message-ID: <174381236258.24655.16865359632972588801.reportbug@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GUpKlNWjZ4+K9qcK"
Content-Disposition: inline
X-Mailer: reportbug 13.1.0


--GUpKlNWjZ4+K9qcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: uuid-dev
Version: 2.40.4-5
Severity: minor
Tags: patch

   * What led up to the situation?

     Checking for defects with a new version

test-[g|n]roff -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=10 -ww -z < "man page"

  [Use 

grep -n -e ' $' -e '\\~$' -e ' \\f.$' -e ' \\"' <file>

  to find (most) trailing spaces.]

  ["test-groff" is a script in the repository for "groff"; is not shipped]
(local copy and "troff" slightly changed by me).

  [The fate of "test-nroff" was decided in groff bug #55941.]

   * What was the outcome of this action?

troff:<stdin>:10: warning: name 'Aq' not defined

   * What outcome did you expect instead?

     No output (no warnings).

-.-

  General remarks and further material, if a diff-file exist, are in the
attachments.


-- System Information:
Debian Release: trixie/sid
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: amd64 (x86_64)

Kernel: Linux 6.12.20-amd64 (SMP w/2 CPU threads; PREEMPT)
Locale: LANG=is_IS.iso88591, LC_CTYPE=is_IS.iso88591 (charmap=ISO-8859-1), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: sysvinit (via /sbin/init)

Versions of packages uuid-dev depends on:
ii  libc6-dev [libc-dev]  2.41-6
ii  libuuid1              2.40.4-5

uuid-dev recommends no packages.

uuid-dev suggests no packages.

-- no debconf information

--GUpKlNWjZ4+K9qcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.uuid_clear.3"

Input file is uuid_clear.3

Output from "mandoc -T lint  uuid_clear.3": (shortened list)

      1 input text line longer than 80 bytes: The \fBlibuuid\fP li...
      1 input text line longer than 80 bytes: The \fBuuid_clear\fP...
      1 skipping insecure request: mso
      6 skipping paragraph macro: sp after SH
      1 skipping unknown macro:  LINKSTYLE blue R < >
      1 undefined string, using "": Aq

-.-.

Output from
test-nroff -mandoc -t -ww -z uuid_clear.3: (shortened list)

      1 name 'Aq' not defined

-.-.


Wrong distance (not two spaces) between sentences in the input file.

  Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) ("Conventions for source file layout") and
"info groff" ("Input Conventions").

  The best procedure is to always start a new sentence on a new line,
at least, if you are typing on a computer.

Remember coding: Only one command ("sentence") on each (logical) line.

E-mail: Easier to quote exactly the relevant lines.

Generally: Easier to edit the sentence.

Patches: Less unaffected text.

Search for two adjacent words is easier, when they belong to the same line,
and the same phrase.

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.

Mark a final abbreviation point as such by suffixing it with "\&".

Some sentences (etc.) do not begin on a new line.

Split (sometimes) lines after a punctuation mark; before a conjunction.

  Lines with only one (or two) space(s) between sentences could be split,
so latter sentences begin on a new line.

Use

#!/usr/bin/sh

sed -e '/^\./n' \
-e 's/\([[:alpha:]]\)\.  */\1.\n/g' $1

to split lines after a sentence period.
Check result with the difference between the formatted outputs.
See also the attachment "general.bugs"

42:Theodore Y. Ts\(cqo
58:The \fBlibuuid\fP library is part of the util\-linux package since version 2.15.1. It can be downloaded from \c

-.-.

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.
Add "\:" to split the string for the output, "\<newline>" in the source.  

Line 39, length 104

The \fBuuid_clear\fP() function sets the value of the supplied uuid variable \fIuu\fP to the NULL value.

Line 58, length 111

The \fBlibuuid\fP library is part of the util\-linux package since version 2.15.1. It can be downloaded from \c

Line 59, length 85

.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."

Longest line is number 58 with 111 characters

-.-.

Only one space character is after a possible end of sentence
(after a punctuation, that can end a sentence).

uuid_clear.3:42:Theodore Y. Ts\(cqo
uuid_clear.3:58:The \fBlibuuid\fP library is part of the util\-linux package since version 2.15.1. It can be downloaded from \c

-.-.

Put a subordinate sentence (after a comma) on a new line.

uuid_clear.3:54:For bug reports, use the issue tracker at \c

-.-.

Remove quotes when there is a printable
but no space character between them
and the quotes are not for emphasis (markup),
for example as an argument to a macro.

uuid_clear.3:10:.TH "UUID_CLEAR" "3" "2024-12-16" "util\-linux 2.40.4" "Programmer\*(Aqs Manual"
uuid_clear.3:30:.SH "NAME"
uuid_clear.3:32:.SH "SYNOPSIS"
uuid_clear.3:37:.SH "DESCRIPTION"
uuid_clear.3:40:.SH "AUTHORS"
uuid_clear.3:55:.URL "https://github.com/util\-linux/util\-linux/issues" "" "."
uuid_clear.3:56:.SH "AVAILABILITY"
uuid_clear.3:59:.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."

-.-.

Use ".na" (no adjustment) instead of ".ad l" (and ".ad" to begin the
same adjustment again as before).

15:.ad l
23:.    ad l
26:.    ad l

-.-.

Section headings (.SH and .SS) do not need quoting their arguments.

30:.SH "NAME"
32:.SH "SYNOPSIS"
37:.SH "DESCRIPTION"
40:.SH "AUTHORS"
43:.SH "SEE ALSO"
52:.SH "REPORTING BUGS"
56:.SH "AVAILABILITY"

-.-.

Put a (long) web address on a new line to reduce the posibility of
splitting the address between two output lines.
Or inhibit hyphenation with "\%" in front of the name.


55:.URL "https://github.com/util\-linux/util\-linux/issues" "" "."
59:.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=10 -ww -z ":

troff:<stdin>:10: warning: name 'Aq' not defined

-.-.

Additionally:

Add a new line (\n) to the end of the file.

-.-

Generally:

Split (sometimes) lines after a punctuation mark; before a conjunction.

--GUpKlNWjZ4+K9qcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uuid_clear.3.diff"

--- uuid_clear.3	2025-04-05 00:04:44.296483330 +0000
+++ uuid_clear.3.new	2025-04-05 00:08:47.373477627 +0000
@@ -7,6 +7,8 @@
 .\"    Source: util-linux 2.40.4
 .\"  Language: English
 .\"
+.ie \n(.g .ds Aq \(aq
+.el       .ds Aq '
 .TH "UUID_CLEAR" "3" "2024-12-16" "util\-linux 2.40.4" "Programmer\*(Aqs Manual"
 .ie \n(.g .ds Aq \(aq
 .el       .ds Aq '
@@ -56,4 +58,4 @@ For bug reports, use the issue tracker a
 .SH "AVAILABILITY"
 .sp
 The \fBlibuuid\fP library is part of the util\-linux package since version 2.15.1. It can be downloaded from \c
-.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."
\ No newline at end of file
+.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."

--GUpKlNWjZ4+K9qcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="general.bugs"

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8 <man page>

  To find trailing space use

grep -n -e ' $' -e ' \\f.$' -e ' \\"' <man page>

  The same goes for man pages that are used as an input.

  For a style guide use

  mandoc -T lint

-.-

  Any "autogenerator" should check its products with the above mentioned
'groff', 'mandoc', and additionally with 'nroff ...'.

  It should also check its input files for too long (> 80) lines.

  This is just a simple quality control measure.

  The "autogenerator" may have to be corrected to get a better man page,
the source file may, and any additional file may.

  Common defects:

  Not removing trailing spaces (in in- and output).
  The reason for these trailing spaces should be found and eliminated.

  "git" has a "tool" to point out whitespace,
see for example "git-apply(1)" and git-config(1)")

  Not beginning each input sentence on a new line.
Line length and patch size should thus be reduced.

  The script "reportbug" uses 'quoted-printable' encoding when a line is
longer than 1024 characters in an 'ascii' file.

  See man-pages(7), item "semantic newline".

-.-

The difference between the formatted output of the original and patched file
can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -d -u <out1> <out2>

and for groff, using

\"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - \"

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output from 'diff -d -u ...' with 'less -R' or similar.

-.-.

  If 'man' (man-db) is used to check the manual for warnings,
the following must be set:

  The option "-warnings=w"

  The environmental variable:

export MAN_KEEP_STDERR=yes (or any non-empty value)

  or

  (produce only warnings):

export MANROFFOPT="-ww -b -z"

export MAN_KEEP_STDERR=yes (or any non-empty value)

-.-

--GUpKlNWjZ4+K9qcK--
