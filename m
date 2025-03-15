Received: from smtp-out1-03.simnet.is (smtp-out1-03.simnet.is [194.105.232.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426611185
	for <util-linux@vger.kernel.org>; Sat, 15 Mar 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068945; cv=none; b=R/HzVG3xJANoEgtlW6Ev4LyLz67HrLzd8jiweOh4tsLgNmax+UHECItrJR8YnPobEZzrESbqC3a4/fm6Jn9LCqpsLdDL1lteFK4Uj6kraNm+Rw3ksGe5igINjY5Vrzhv0hqzyiFc/dEdFYnj441jsRP++q6voVlenNOoFk9nwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068945; c=relaxed/simple;
	bh=dxUI1kCeFbjjubgiFZKS3WgIpJ+BLV6ehMN82Ow3HXI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XnrAOJBKZ+z0qKCcS67j5ZRxYZgsqoMvsKeUNuHdWjpdGH9SqbphZ1WFLg/vudLCvGCP3JS/xB9htcU+v8+oGzLX0hPkf++WS4TfnL4lXD+Xo+odheufZgMVMEssWG5ZTdLWeSdANkp8glrCp6VFvoSAJq5dBuMz9O4UVviqgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=PDe5N8Am; arc=none smtp.client-ip=194.105.232.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="PDe5N8Am"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1742068941; x=1773604941;
  h=date:from:to:subject:message-id:mime-version;
  bh=zuBm8jgwfZLchKtFwfymrAr5DvfmHZzpZ/eHZXJgt1g=;
  b=PDe5N8Amy+gJLW/kpMUcHmIvIOzGZ8jsUaPwSFrEQ4I0GS5ImQ+1PZHl
   YDxXuLWCspYV7d2UyNXi8+w9JY+mQrS6CglhL51gyv4cKxP3KZ+t1csFX
   86M8u6cSCPqEJ3/0+kbHPDr3HWM82O+yxGquNJ1zOq5F/6tB1NzfQ8OR1
   4TISL1zAiRD0bs3f3X6AayIEBiUP4GwTr4h0v1QlKC0K97y8ym2dbGjm0
   tFM4WerfaOwMkWUlDUKZc5mc6Xlw3pVe6SCiStc4ouin7A+GHf6BUtOFv
   JgELt9+Jc3b5g1aZSs3kiZYCRDvwCUdkPphgBpluVE8F4i2Nu0rB1NV2X
   w==;
X-CSE-ConnectionGUID: KFAy2YCjRo65glCSRGRv9w==
X-CSE-MsgGUID: 92IGms8MR8uyj3IttTxR6A==
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2FVAADE19VnhVnoacJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDfZgrgRadFYFyBwEBAQ85CwQBAQMEggyCdIsgKDcGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQYBAQEBAQEGBwIQAQEBAUBJhTVGDYQHgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAg2CKnyDKQGCZBSuf4E0gQHeNIFeCgaBSAGFb?=
 =?us-ascii?q?IJjAYVshTMGgg2BFTIDgXNKB2+CYQKBRkaGGASCGBeBO4ICgWqHHYNuizYgk?=
 =?us-ascii?q?xFIgSEDWSwBVRMNCgsHBYFsAzUMCy4VgUZDNzWCDmlJOgINAjWCG3yCK4RNh?=
 =?us-ascii?q?DyEQoVQghGLNIRhLVCBHh02CgMLGA1IESw3FBtEbgeiADuDSAkBJQlDAQEwD?=
 =?us-ascii?q?FEBKyACNkADMAYPHQFKk0qPW4FEjFCTVIE+hCWGXIMxgguVSjMig2GTQww6k?=
 =?us-ascii?q?kuYfo0bapVpDRk3hGiBfYIALAcaCDA7gjMBAQEyURkPjgcjAxaDWIUTxBqBN?=
 =?us-ascii?q?AIHCwEBAwmRZwEB?=
IronPort-PHdr: A9a23:nKQUJRFfWPgRdGp4QZuPE51Gfg0Y04WdBeZ0woEil6oLdbm/usy5e
 lfe4PNgkBnIRtaT5/FFjr/QtKbtESwF7I2auX8POJpLS1ceiMoQkgBhSM6IAEH2NrjrOio9G
 skqaQ==
IronPort-Data: A9a23:qTGXCqBgKsSULxVW/9Lkw5YqxClBgxIJ4kV8jC+esSAN5kpxj25ok
 zNBRzzEeOHSNyqhPoQ2doyGQXl2u5PQyIAxSAtoqCg0Ri5Gp8CbVdnEJRivMX3NI5aaRh46s
 5pBMYifIc5pFi6B+0ygOLG58yV3j/yFS7byBL/KZ0idKeMcpAIJ0HqPzMZk0tYx6TTAPyuNp
 c/quJ+Yf1Ckxz5pOCQf7KfEtQ9uuMC3vDIeo0x5eOxKuGubk3gTEYJYJLqqMnbjKrW4ZdVWM
 dsvtpnluDyxwj8tFs+9ieS8NVIVXfjRMBKIh34QXLKtxQBfrGs206AmJL0BdUZTkHKUg9F1/
 JBJtJqtWUBBAkG3owhrbvUiO3o4ZcV7xYL7zRFTySD550LLdXb2yvEoBlw5JuX0kc4sXT5E/
 KxDIz1dYxyOjrzoye+1FONm1pxyfMS6Md8R4C5qkmHSA6l/GM+ZGfqXu4dUgWY+i58fQ/uCP
 5ZIZzE3BPisj2WjH39OYH5ptL753COXn0RklW+oSYoLD0n7nQJ/i+Hmb9GFdILbSZ1cxxaR/
 j6fo22iW0EQbIGVwmus/yP3jIcjvwuiA9tKS+fQGt2GIbG37jZOYPHDfQLj+ZFVsmbnBZQHb
 RRSondyxUQL3BTDZsHnWBGlq2KzsBcZWt5Be8U38wjlJpD8um51PUBaCGcdADAanJVuH2Fyj
 QbUx4mB6QFH6dV5d1rMp994khvqUcQlBTdqTTMJSwID/+7irOkb5jrTTsxuGbKCldb8Hzf92
 Vii9EDSUJ1K0Kbnf43ilbz2q2rESqrhF2bZ1S2LNo6R1T6VUab+D2CeBfc32t4bRGqRZgHpU
 HHpAKFy5shWZX2GvHTlrOnggNhFThtKWdHRqQcHInUvy9ii012NVJEK0Rp8HkA3b8kAUgTTT
 3XN6BwEsfe/PFPyBUN2S5ywENhv36nlDc7iRuGRNoEIfJlqaEmG50mCZ2bJjjyryRBx1/tkY
 9HLIK5ADl5DYUhj5DC5b/wc1Lkm2mY/3gs/QLinl0X7juHFOxZ5T59Uanqha/tpyZnUvRTXq
 PdDK/ea8Ut2BbiWji7/qtJDfA9bcRDXH6vettBWcquHIwx7CEk/BPLLh7AsYYpom+JSjOigw
 52mclFZ00a6l3zCMR+NemEmMOipQ5dksTQ6JkTAIGpExVAAT6++tpY0daEwI+Qo8MdY99FOU
 agaLpDo7ut0dhzL/DEUbJ/YpYNkdQi2iQ/mA8ZDSGRvF3KHb1GQkuIIbjfSGD8y4j2flPBWn
 lFN/h3aWoZGVQVnFNzReOPqlwj3o3kGhKRzRCMkw+W/mm2xoOCGyASo35fbxv3gzz2YnlN2M
 C7NWX8lSRHl+dNdzTUwrfnsQ32VO+V/BFFGOGLQ8Ky7MyLXlkL6ntMZAbnXJG6ACDqkkElHW
 Qmz562tWBHgtAsT27eQ754xnf5WCybH/uMBkF06dJk1RwT2UuoIzoa6MTln7fEdl+AI5WNaq
 2qK+91TcbWHUP4J43ZMTDfJmt+rjKlO8hGLtKRdCBuhvkdfouHYOXi+yjHX00Sx2pMua9t9m
 Y/Meac+t2SCt/bdGozW334KqjnVdSNovmdOnshyPbIHQzEDkjlqCaEwwAeviH1TQ72g6nUXH
 wI=
IronPort-HdrOrdr: A9a23:wrd0k6oR2JCv/DMEi+Ntv/oaV5o2eYIsimQD101hICG9E/bo8/
 xG885rtyMc5Ax+ZJhCo6HkBED/ewK6yXcd2+B4Vt3OMGbbUQ2TTb2KhrGSoAEIdRefytJg
X-Talos-CUID: 9a23:iZf8rGFj8gUwRnGXqmJE2mcFQPEOcEfakirfJ2SDM0lTVuyKHAo=
X-Talos-MUID: 9a23:MbHjfAngKF9LlxIma5v4dnozbuZH5r/+LXpdjIQE4OiYKRBgAWm02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,250,1736812800"; 
   d="1'?bugs'?scan'208";a="40947337"
Received: from vist-zimproxy-03.vist.is ([194.105.232.89])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 20:02:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 96C0E400D3AE
	for <util-linux@vger.kernel.org>; Sat, 15 Mar 2025 20:02:12 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CDtqwOsBrI84 for <util-linux@vger.kernel.org>;
 Sat, 15 Mar 2025 20:02:12 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id ECBBF41F8563
	for <util-linux@vger.kernel.org>; Sat, 15 Mar 2025 20:02:11 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id krMVx0a4AYus for <util-linux@vger.kernel.org>;
 Sat, 15 Mar 2025 20:02:11 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTPS id D77CF400D3AE
	for <util-linux@vger.kernel.org>; Sat, 15 Mar 2025 20:02:11 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1ttXhz-000000000sg-2ZlM
	for util-linux@vger.kernel.org;
	Sat, 15 Mar 2025 20:02:11 +0000
Date: Sat, 15 Mar 2025 20:02:11 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: util-linux@vger.kernel.org
Subject: hexdump.1: Some remarks about this man page
Message-ID: <174199631212.5163.10505648256735324620.reportbug@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IhmDU+H9OsW3YjY5"
Content-Disposition: inline
X-Mailer: reportbug 13.1.0


--IhmDU+H9OsW3YjY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: bsdextrautils
Version: 2.40.4-5
Severity: minor
Tags: upstream

   * What led up to the situation?

     Checking for defects with a new version

test-[g|n]roff -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=10 -ww -z < "man page"

  [Use "groff -e ' $' -e '\\~$' <file>" to find obvious trailing spaces.]

  ["test-groff" is a script in the repository for "groff"; is not shipped]
(local copy and "troff" slightly changed by me).

  [The fate of "test-nroff" was decided in groff bug #55941.]

   * What was the outcome of this action?


<stdin>:1: warning: table wider than line length minus indentation
an.tmac:<stdin>:366: warning: .l = 1584u = 66n = 66m, .i = 192u, TW (table width) = 1440u = 60n = 60m


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

Kernel: Linux 6.12.17-amd64 (SMP w/2 CPU threads; PREEMPT)
Locale: LANG=is_IS.iso88591, LC_CTYPE=is_IS.iso88591 (charmap=ISO-8859-1), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: sysvinit (via /sbin/init)

Versions of packages bsdextrautils depends on:
ii  libc6          2.41-4
ii  libsmartcols1  2.40.4-5
ii  libtinfo6      6.5+20250216-2

bsdextrautils recommends no packages.

bsdextrautils suggests no packages.

-- no debconf information

--IhmDU+H9OsW3YjY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.hexdump.1"

Output from "mandoc -T lint  hexdump.1": (shortened list)

      1 input text line longer than 80 bytes: A byte count or fiel...
[...]
      1 skipping insecure request: mso
      2 skipping paragraph macro: br after sp
     10 skipping paragraph macro: sp after SH
      3 skipping paragraph macro: sp after SS
      1 skipping unknown macro:  LINKSTYLE blue R < >

-.-.

Output from "test-nroff -mandoc -t -ww -z hexdump.1": (shortened list)

      1 .l = 1584u = 66n = 66m, .i = 192u, TW (table width) = 1440u = 60n = 60m
      1 table wider than line length minus indentation

-.-.

Lines containing '\c':

501:For bug reports, use the issue tracker at \c
502-.URL "https://github.com/util\-linux/util\-linux/issues" "" "."
--
505:The \fBhexdump\fP command is part of the util\-linux package which can be downloaded from \c
506-.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."

  Are not needed!

-.-.

Show if asciidoctor generated this.

Who is actually generating this man page?  Debian or upstream?

Is the generating software out of date?

4:.\" Generator: Asciidoctor 2.0.20

N.B. Outdated version, current is 2.0.23.

-.-.

Change a HYPHEN-MINUS (code 0x2D) to a minus(-dash) (\-),
if it
is in front of a name for an option,
is a symbol for standard input,
is a single character used to indicate an option,
or is in the NAME section (man-pages(7)).
N.B. - (0x2D), processed as a UTF-8 file, is changed to a hyphen
(0x2010, groff \[u2010] or \[hy]) in the output.

153:.ll -.6i
247:.ll -.6i
478:.ll -.6i
487:.ll -.6i

Output line gets shorter with each call.
What is the purpose?
Comments are missing!

  Generators of man pages should not change the line length in any way!

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

[List of affected lines removed.]

-.-

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.
Add "\:" to split the string for the output, "\<newline>" in the source.  

[List of affected lines removed.]

Longest line is: 474 characters.

-.-.

Put a parenthetical sentence, phrase on a separate line,
if not part of a code.
See man-pages(7), item "semantic newline".

[List of affected lines removed.]

-.-

No space is needed before a quote (") at the end of a line

445:   "%06.6_ao "  12/1 "%3_u "
446:   "\(rst" "%_p "

-.-.

Only one space character after a possible end of sentence
(after a punctuation, that can end a sentence).

[List of affected lines removed.]

-.-

Put a subordinate sentence (after a comma) on a new line.

[List of affected lines removed.]


-.-.

Remove quotes when there is a printable
but no space character between them
and the quotes are not for emphasis (markup),
for example as an argument to a macro.

hexdump.1:10:.TH "HEXDUMP" "1" "2024-12-16" "util\-linux 2.40.4" "User Commands"
hexdump.1:31:.SH "NAME"
hexdump.1:33:.SH "SYNOPSIS"
hexdump.1:38:.SH "DESCRIPTION"
hexdump.1:41:.SH "OPTIONS"
hexdump.1:121:.SH "FORMATS"
hexdump.1:371:.SS "Colors"
hexdump.1:400:.SS "Counters"
hexdump.1:438:.SH "EXAMPLES"
hexdump.1:473:.SH "COLORS"
hexdump.1:502:.URL "https://github.com/util\-linux/util\-linux/issues" "" "."
hexdump.1:503:.SH "AVAILABILITY"
hexdump.1:506:.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."

-.-.

Use ".na" (no adjustment) instead of ".ad l" (and ".ad" to begin the
same adjustment again as before).

15:.ad l
23:.    ad l
26:.    ad l

-.-.

Section headings (.SH and .SS) do not need quoting their arguments.

31:.SH "NAME"
33:.SH "SYNOPSIS"
38:.SH "DESCRIPTION"
41:.SH "OPTIONS"
121:.SH "FORMATS"
218:.SS "Conversion strings"
371:.SS "Colors"
400:.SS "Counters"
432:.SH "EXIT STATUS"
435:.SH "CONFORMING TO"
438:.SH "EXAMPLES"
473:.SH "COLORS"
499:.SH "REPORTING BUGS"
503:.SH "AVAILABILITY"

-.-.

Put a (long) web address on a new line to reduce the posibility of
splitting the address between two output lines.
Or inhibit hyphenation with "\%" in front of the name.


502:.URL "https://github.com/util\-linux/util\-linux/issues" "" "."
506:.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=10 -ww -z ":

<stdin>:1: warning: table wider than line length minus indentation
an.tmac:<stdin>:366: warning: .l = 1584u = 66n = 66m, .i = 192u, TW (table width) = 1440u = 60n = 60m

-.-.

Generally:

Split (sometimes) lines after a punctuation mark; before a conjunction.

--IhmDU+H9OsW3YjY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="general.bugs"

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8 <man page>

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

  The option \"-warnings=w\"

  The environmental variable:

export MAN_KEEP_STDERR=yes (or any non-empty value)

  or

  (produce only warnings):

export MANROFFOPT=\"-ww -b -z\"

export MAN_KEEP_STDERR=yes (or any non-empty value)

-.-

--IhmDU+H9OsW3YjY5--
