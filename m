Received: from smtp-out1-03.simnet.is (smtp-out1-03.simnet.is [194.105.232.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD611F7574
	for <util-linux@vger.kernel.org>; Tue, 12 Nov 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373843; cv=none; b=NJz7lCHlSJxKUkE9dTC/uxPLuz1iikjomPfdAfBR4YDyi3h16XwcSrr2FMeDu6qnWrQxSymi0XGQhuV8AsMlrdlao3STqYwMoPC3YdqJ8FJIw0VyTLvf4kX47mgwHwQ/9as8usthbFfvYV/Dgh0PcYcbyniEuoTJHUoXtSynKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373843; c=relaxed/simple;
	bh=QK3ZnZYBRh04wBVv4bkLOxSToWmzSUmUEwr1cdOnUQU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O+GQlLvwy0hASnf1C/+4DZnbN5oNlRPmsZUwY+hx1mnf52EGzsq0z4MpKcCvBoMEiwfLgIKiSO/Kz4z0Sxv3wGwGZdHZ8j6bP4gmOq6NTU0ja46uq+aOheqDUWD4pCdz4RpxZ3/NeXNVySr++upyA7G3zPq7+WE1f/1za9HZlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=a/OPW/x9; arc=none smtp.client-ip=194.105.232.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="a/OPW/x9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1731373838; x=1762909838;
  h=date:from:to:subject:message-id:mime-version;
  bh=UB0hHqo19QpSke4jtJx/SS8D8jXwzbahI0tVqHvSDV4=;
  b=a/OPW/x9XBI5QzVPIqY+LIw67nZbWcv2CrlPDzLaPoo7Q2WQdo4KXls0
   WwQPL5k2ekH2o6QrA9aFIc/BXfi4ub5l7ZKY1NAKR6l/A7eXtJgE2qr9m
   jAn1DA162PzGbff3gValbWRSYDeq/od2dLPJi0n3heiP5hyl+yRmTezVI
   qqWL4qFEigll5ilzLdkKJKpM+s5RwJRYKxOgbJwnDkz50b92K1DAwj0eo
   OIGuop1wBVKfm3SfdJw9kfG/Yj0/BghsEAMVSM95WY+Ly19adobuxrrIO
   JHz4ZfDqZBrgKrA6VPDEuVaHsyLkgYOCXTRaIWPC2uyDL189JIpOnrDcO
   w==;
X-CSE-ConnectionGUID: lHObTzABQLGxUsRGFyTRYg==
X-CSE-MsgGUID: nJje1MglTUyNUnqdVIwQfQ==
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2ENAACepDJnhVjoacJaGwEBAgIBAQUBARQBAQMDAQFBg?=
 =?us-ascii?q?UEEAQEMAYJDfZgogRaQNYxNggYHAQEBDzkHBAQBAQMEjz0oNgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBDgEBBgEBAQEBAQYHAhABAQEBQA47hTVGDYQHgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg2BHlg0fIMoAYJkFLEhgTSBAd4zgV0KBoFIAYVpgmIBhWmFM?=
 =?us-ascii?q?waCDYEVMgNigRFKB2+EJYZiBIIlChJ8gXQMgiAlgRaBGYEQg2uBa4gckDVIg?=
 =?us-ascii?q?SEDWSERAVUTDQoLBwWBdgOCVnorgQ6BFzqBfoEiSoUaRj83ghNpTTcCDQI2g?=
 =?us-ascii?q?iR9gk+FGIRthGaCIR02CgMLGA1IESw1FBtEbgeeMUeCMQkBJRkUGQYBATAoI?=
 =?us-ascii?q?hMBChwFIAEBJBItEwECMAYJBgsTBgkBL5J3WI9JgUSgHoE+hCSGW4Mwl04zI?=
 =?us-ascii?q?oNikTqCAQw6kTKBFph3o24BGDaEZoFuA4IMLAcaCDA7gjMBAQEyURkPjgcjA?=
 =?us-ascii?q?xaIbMBGgTMCBwsBAQMJkRQBAQ?=
IronPort-PHdr: A9a23:thqYlRe6pGlGfkGD3VdNhAz4lGM/noqcDmcuAvsPkLdSauGk4oinZ
 BeZ/vRoilLVG4TAuLpIiOvT5qbnX2FIoZOMq2sLf5EEURgZwd4XkAotDI/NCUDyIPPwKS1vG
 sNEWTdY
IronPort-Data: A9a23:Nej/LqA825xEtRVW/5Tjw5YqxClBgxIJ4kV8jC+esSAN5kpxj25ok
 zNBRzzEeOHWITCpIMd+WDmFhUtVv5Ddn9BmS1Y+/HpgHylG85SfXd7JI0n8YX2ed8TPHEhu4
 59ON4aRfJ9tFifWrUymaebo8HUkif7VF+PwBees1kydPeNBYH5JZUVLwbBl3tIAbaGFKwORp
 cvp8YqYJ0C6nT15KGQZ7+SEshwopOn4/zcZuEEuIu1XvVvF0GQJDZYrYKWwKWboBeFo8pWBq
 5D+IMuRpSWBlyoQN+5JsooXU2UHS7KMYAbX0HALCqap30EY+31pjK8wZaMSZxgHgG/Sx/l8m
 Y5H3XCSYV5yZ/WTwozxcPX5/wVWZ/AuFGrveCDn2SCr5xSbNSOqm7M3VB1e0bQwoo5fGXtJ+
 eETNAcDZxWCg/Pe6L+gQ4GAvOx6RCXQFN1Z4ysIIQ3xV658HcmaGvySv7e04R9p7ixwNaePD
 yYmQWIHgCToO3VnJloRAZQiq+ak7lGXn+pw8Q/9SQIfugA//SQpuFTfGIO9lu+iGa25qn2lS
 lfupAwVNP212Ou3klJp+lr07gPGcLiStIg6TNVU/dYy6LGfK/B65LT7mjJXrNHg4nNSVe6zJ
 GQQ2g0kkbob3nWPYcnARCeXjm+4hC8TDo84/+0SsGlhy4LK4h2FQ3oFSyZbb8w38ZdsAyIrz
 UPPnsiB6T5H6ezJDyvFq/HO9mn0aXh9wWwqPEfoSSMP7PH4oYQ1gw6JT80L/Kud1ICsQGyon
 2jiQC4WgZcRgJcu2KGHwEHhvjS1qqboUTc731CCNo6ixlglNN/6NtDABULgxetcLYLcSliHo
 WgshceT9qYNAIuLmSjLR/8CdIxF/N6bMSbAxExuGoE78CS8vib5O55R+y04JVwB3ts4lSHBZ
 G/0sz9DzbVqGFS6ULRNTKygN/4bwv21fTj6bcz8Yt1La5l3UQaI+iByeEKdt1wBdmBwzsnT3
 r/HIa6R4WYmNEhx8Nahb8YmuYLHKwggxHjPAIL6ygy91qqPISbPD6kEK0fIb/tRAEK4TOf9r
 Yw32yiikkQ3vAjCjs//qtZ7wbcidiJTOHwOg5YLHtNv2yI/cI3bN9ffwKk6Z6tulLlPm+HD8
 xmVAxADkQGj1C2WeFzaOhiPjY8Du74j/RrX2gRwbD6VN4QLONr+hEviX8JrJud+qoSPM9YqF
 aJZEyl/Phi/Ym+bq2VCPMWVQH1KcRWvjEqOMUKYjMsXIvZdq/jy0oa8JGPHrXBSZgLp7pFWi
 +P7iWvmrW8rHF8K4DD+M6n3lwvZULl0sL4aYnYk1fEIJhSwqtUwdHaZYz1eC5hkFCgvDwCyj
 26+aSr0b8GXy2Pp2LElXZy5kro=
IronPort-HdrOrdr: A9a23:DdLT3qpNA3FVWyFzjR9AgTcaV5o+eYIsimQD101hICG9Vvbo8f
 xG/c5rsiMc5wxxZJhNo7C90cq7MBfhHPxOkOws1N6ZNWGM0gbFQ+9fBODZsl/d8kPFh41gPN
 9bAtFDNOE=
X-Talos-CUID: =?us-ascii?q?9a23=3A771IqWp37YmPCqJ7KDp9i5PmUcQFVXfh3l76Gmu?=
 =?us-ascii?q?XGVtycpK7WGOqyawxxg=3D=3D?=
X-Talos-MUID: 9a23:slQsKQQk6kaxtwN3RXTqpjNvbeJn55iTGWYwl4wKheibDCJJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,146,1728950400"; 
   d="8'?scan'208";a="25115040"
Received: from vist-zimproxy-02.vist.is ([194.105.232.88])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:10:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTP id B3A154428663
	for <util-linux@vger.kernel.org>; Tue, 12 Nov 2024 01:10:28 +0000 (GMT)
Received: from vist-zimproxy-02.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-02.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id WmXCtf-qHajY for <util-linux@vger.kernel.org>;
 Tue, 12 Nov 2024 01:10:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTP id 678ED442887F
	for <util-linux@vger.kernel.org>; Tue, 12 Nov 2024 01:10:27 +0000 (GMT)
Received: from vist-zimproxy-02.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-02.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id K417Z7kQoip4 for <util-linux@vger.kernel.org>;
 Tue, 12 Nov 2024 01:10:27 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-02.vist.is (Postfix) with ESMTPS id 515114428663
	for <util-linux@vger.kernel.org>; Tue, 12 Nov 2024 01:10:27 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1tAfQK-000000001li-3twK
	for util-linux@vger.kernel.org;
	Tue, 12 Nov 2024 01:10:28 +0000
Date: Tue, 12 Nov 2024 01:10:28 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: util-linux@vger.kernel.org
Subject: lsblk.8: Some remarks about this man page
Message-ID: <173137362659.6709.15759538146215293511.reportbug@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pQOb6zAiycogBfL3"
Content-Disposition: inline
X-Mailer: reportbug 13.0.1


--pQOb6zAiycogBfL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: util-linux (Debian testing)
Version: 2.40.2-9
Severity: minor

   * What led up to the situation?

     Checking for defects with

test-[g|n]roff -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z < "man page"

  [Use "groff -e ' $' <file>" to find trailing spaces.]

  ["test-groff" is a script in the repository for "groff"; is not shipped]
(local copy and "troff" slightly changed by me).

  [The fate of "test-nroff" was decided in groff bug #55941.]

   * What was the outcome of this action?


troff: backtrace: file '<stdin>':276
troff:<stdin>:276: warning: [page 4, 3.6i]: cannot break line


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

Kernel: Linux 6.11.5-amd64 (SMP w/2 CPU threads; PREEMPT)
Locale: LANG=is_IS.iso88591, LC_CTYPE=is_IS.iso88591 (charmap=ISO-8859-1), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: sysvinit (via /sbin/init)

Versions of packages util-linux depends on:
ii  libblkid1       2.40.2-9
ii  libc6           2.40-3
ii  libcap-ng0      0.8.5-3
ii  libcrypt1       1:4.4.36-5
ii  libmount1       2.40.2-9
ii  libpam-modules  1.5.3-7+b1
ii  libpam-runtime  1.5.3-7
ii  libpam0g        1.5.3-7+b1
ii  libselinux1     3.7-3
ii  libsmartcols1   2.40.2-9
ii  libsystemd0     256.7-3
ii  libtinfo6       6.5-2+b1
ii  libudev1        256.7-3
ii  libuuid1        2.40.2-9

Versions of packages util-linux recommends:
ii  sensible-utils  0.0.24

Versions of packages util-linux suggests:
pn  dosfstools          <none>
ii  kbd                 2.6.4-3
ii  util-linux-extra    2.40.2-9
pn  util-linux-locales  <none>
ii  wtmpdb              0.13.0-1

-- no debconf information

--pQOb6zAiycogBfL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.lsblk.8"

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8  <man page>

  The same goes for man pages that are used as an input.

  For a style guide use

  mandoc -T lint

-.-

  So any 'generator' should check its products with the above mentioned
'groff', 'mandoc',  and additionally with 'nroff ...'.

  This is just a simple quality control measure.

  The 'generator' may have to be corrected to get a better man page,
the source file may, and any additional file may.

  Common defects:

  Input text line longer than 80 bytes.

  Not removing trailing spaces (in in- and output).
  The reason for these trailing spaces should be found and eliminated.

  Not beginning each input sentence on a new line.
Lines should thus be shorter.

  See man-pages(7), item 'semantic newline'.

-.-

The difference between the formatted output of the original and patched file
can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -u <out1> <out2>

and for groff, using

"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - "

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output of 'diff -u' with 'less -R' or similar.

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

-.-.

Output from "mandoc -T lint lsblk.8": (possibly shortened list)

mandoc: lsblk.8:28:4: ERROR: skipping unknown macro:  LINKSTYLE blue R < >
mandoc: lsblk.8:33:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:36:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:39:305: STYLE: input text line longer than 80 bytes: By default, the comm...
mandoc: lsblk.8:41:253: STYLE: input text line longer than 80 bytes: The tree\-like outpu...
mandoc: lsblk.8:43:362: STYLE: input text line longer than 80 bytes: The default output, ...
mandoc: lsblk.8:47:243: STYLE: input text line longer than 80 bytes: Note that \fBlsblk\f...
mandoc: lsblk.8:49:475: STYLE: input text line longer than 80 bytes: The relationship bet...
mandoc: lsblk.8:51:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:59:82: STYLE: input text line longer than 80 bytes: Disable all built\-i...
mandoc: lsblk.8:75:111: STYLE: input text line longer than 80 bytes: List the available c...
mandoc: lsblk.8:80:82: STYLE: input text line longer than 80 bytes: Print information ab...
mandoc: lsblk.8:85:129: STYLE: input text line longer than 80 bytes: Do not print holder ...
mandoc: lsblk.8:90:233: STYLE: input text line longer than 80 bytes: Use \fIcolumn\fP as ...
mandoc: lsblk.8:92:106: STYLE: input text line longer than 80 bytes: The usual use case i...
mandoc: lsblk.8:97:334: STYLE: input text line longer than 80 bytes: Exclude the devices ...
mandoc: lsblk.8:102:227: STYLE: input text line longer than 80 bytes: Output info about fi...
mandoc: lsblk.8:107:241: STYLE: input text line longer than 80 bytes: Include devices spec...
mandoc: lsblk.8:117:196: STYLE: input text line longer than 80 bytes: Use JSON output form...
mandoc: lsblk.8:122:288: STYLE: input text line longer than 80 bytes: Produce output in th...
mandoc: lsblk.8:127:129: STYLE: input text line longer than 80 bytes: Group parents of sub...
mandoc: lsblk.8:132:114: STYLE: input text line longer than 80 bytes: Output info about de...
mandoc: lsblk.8:152:232: STYLE: input text line longer than 80 bytes: Specify which output...
mandoc: lsblk.8:154:127: STYLE: input text line longer than 80 bytes: The default list of ...
mandoc: lsblk.8:164:205: STYLE: input text line longer than 80 bytes: Produce output in th...
mandoc: lsblk.8:181:83: STYLE: input text line longer than 80 bytes: exclude sda  and sdb...
mandoc: lsblk.8:207:100: STYLE: input text line longer than 80 bytes: The \fIname\fP is th...
mandoc: lsblk.8:212:86: STYLE: input text line longer than 80 bytes: If the \fIparam\fP i...
mandoc: lsblk.8:215:92: STYLE: input text line longer than 80 bytes: For example, \fB\-\-...
mandoc: lsblk.8:234:94: STYLE: input text line longer than 80 bytes: Define a restriction...
mandoc: lsblk.8:254:207: STYLE: input text line longer than 80 bytes: Produce output in ra...
mandoc: lsblk.8:259:91: STYLE: input text line longer than 80 bytes: Output info about SC...
mandoc: lsblk.8:264:128: STYLE: input text line longer than 80 bytes: Print dependencies i...
mandoc: lsblk.8:269:127: STYLE: input text line longer than 80 bytes: Force tree\-like out...
mandoc: lsblk.8:291:402: STYLE: input text line longer than 80 bytes: Specifies output wid...
mandoc: lsblk.8:296:229: STYLE: input text line longer than 80 bytes: Sort output lines by...
mandoc: lsblk.8:301:406: STYLE: input text line longer than 80 bytes: The column name will...
mandoc: lsblk.8:311:282: STYLE: input text line longer than 80 bytes: Gather data for a Li...
mandoc: lsblk.8:314:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:335:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:361:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:362:94: STYLE: input text line longer than 80 bytes: For partitions, some...
mandoc: lsblk.8:364:328: STYLE: input text line longer than 80 bytes: The \fBlsblk\fP comm...
mandoc: lsblk.8:366:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:370:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:376:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:380:2: WARNING: skipping paragraph macro: sp after SH
mandoc: lsblk.8:381:90: STYLE: input text line longer than 80 bytes: The \fBlsblk\fP comm...

-.-.

Lines containing '\c' (' \c' does not make sense):

377:For bug reports, use the issue tracker at \c
381:The \fBlsblk\fP command is part of the util\-linux package which can be downloaded from \c

-.-

Strings longer than 3/4 of a standard line length (80)
Use "\:" to split the string at the end of an output line, for example a
long URLs (web address)

276 \fB\-o NAME,ALIGNMENT,MIN\-IO,OPT\-IO,PHY\-SEC,LOG\-SEC,ROTA,SCHED,RQ\-SIZE,RA,WSAME\fP.

-.-.

Wrong distance between sentences in the input file.

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


37:\fBlsblk\fP lists information about all available or the specified block devices. The \fBlsblk\fP command reads the \fBsysfs\fP filesystem and \fBudev db\fP to gather information. If the udev db is not available or \fBlsblk\fP is compiled without udev support, then it tries to read LABELs, UUIDs and filesystem types from the block device. In this case root permissions are necessary.
39:By default, the command prints all block devices (except RAM disks) in a tree\-like format. The same device can be repeated in the tree if it relates to other devices. The \fB\-\-merge\fP option is recommended for more complicated setups to gather groups of devices and describe complex N:M relationships.
41:The tree\-like output (or \fBchildren[]\fP array in the JSON output) is enabled only if NAME column it present in the output or when \fB\-\-tree\fP command line option is used. See also \fB\-\-nodeps\fP and \fB\-\-list\fP to control the tree formatting.
43:The default output, as well as the default output from options like \fB\-\-fs\fP and \fB\-\-topology\fP, is subject to change. So whenever possible, you should avoid using default outputs in your scripts. Always explicitly define expected columns by using \fB\-\-output\fP \fIcolumns\-list\fP and \fB\-\-list\fP in environments where a stable output is required.
47:Note that \fBlsblk\fP might be executed in time when \fBudev\fP does not have all information about recently added or modified devices yet. In this case it is recommended to use \fBudevadm settle\fP before \fBlsblk\fP to synchronize with udev.
49:The relationship between block devices and filesystems is not always one\-to\-one. The filesystem may use more block devices, or the same filesystem may be accessible by more paths. This is the reason why \fBlsblk\fP provides MOUNTPOINT and MOUNTPOINTS (pl.) columns. The column MOUNTPOINT displays only one mount point (usually the last mounted instance of the filesystem), and the column MOUNTPOINTS displays by multi\-line cell all mount points associated with the device.
67:power of 2^10 (1024). Abbreviations of symbols are exhibited truncated in order
85:Do not print holder devices or slaves. For example, \fBlsblk \-\-nodeps /dev/sda\fP prints information about the sda device only.
90:Use \fIcolumn\fP as a de\-duplication key to de\-duplicate output tree. If the key is not available for the device, or the device is a partition and parental whole\-disk device provides the same key than the device is always printed.
97:Exclude the devices specified by the comma\-separated \fIlist\fP of major device numbers. Note that RAM disks (major=1) are excluded by default if \fB\-\-all\fP is not specified. The filter is applied to the top\-level devices only. This may be confusing for \fB\-\-list\fP output format where hierarchy of the devices is not obvious.
102:Output info about filesystems. This option is equivalent to \fB\-o NAME,FSTYPE,FSVER,LABEL,UUID,FSAVAIL,FSUSE%,MOUNTPOINTS\fP. The authoritative information about filesystems and raids is provided by the \fBblkid\fP(8) command.
107:Include devices specified by the comma\-separated \fIlist\fP of major device numbers. The filter is applied to the top\-level devices only. This may be confusing for \fB\-\-list\fP output format where hierarchy of the devices is not obvious.
117:Use JSON output format. It\(cqs strongly recommended to use \fB\-\-output\fP and also \fB\-\-tree\fP if necessary. Note that \fBchildren[]\fP is used only if NAME column or \fB\-\-tree\fP is used.
122:Produce output in the form of a list. The output does not provide information about relationships between devices and since version 2.34 every device is printed only once if \fB\-\-pairs\fP or \fB\-\-raw\fP not specified (the parsable outputs are maintained in backwardly compatible way).
127:Group parents of sub\-trees to provide more readable output for RAIDs and Multi\-path devices. The tree\-like output is required.
132:Output info about device owner, group and mode. This option is equivalent to \fB\-o NAME,SIZE,OWNER,GROUP,MODE\fP.
152:Specify which output columns to print. Use \fB\-\-list\-columns\fP to get a list of all supported columns. The columns may affect tree\-like output. The default is to use tree for the column \*(AqNAME\*(Aq (see also \fB\-\-tree\fP).
164:Produce output in the form of key="value" pairs. The output lines are still ordered by dependencies. All potentially unsafe value characters are hex\-escaped (\(rsx<code>). See also option \fB\-\-shell\fP.
174:Print only the devices that meet the conditions specified by the expr. The
175:filter is assessed prior to lsblk collecting data for all output columns. Only
177:the system. This approach can enhance performance when compared to
180:This feature is EXPERIMENTAL. See also \fBscols\-filter\fP(5). For example
201:This feature is EXPERIMENTAL. See also \fBscols\-filter\fP(5).
206:Define a custom counter. The counters are printed after the standard output.
209:the aggregation function, supported functions are: count, min, max, or sum. The
212:If the \fIparam\fP is not specified, then the counter counts the number of lines. This
213:feature is EXPERIMENTAL. See also \fB\-\-ct\-filter\fP.
234:Define a restriction for the next counter. This feature is EXPERIMENTAL. See also \fB\-\-ct\fP
235:and \fBscols\-filter\fP(5). For example, aggregate sizes by device type:
254:Produce output in raw format. The output lines are still ordered by dependencies. All potentially unsafe characters are hex\-escaped (\(rsx<code>) in the NAME, KNAME, LABEL, PARTLABEL and MOUNTPOINT columns.
259:Output info about SCSI devices only. All partitions, slaves and holder devices are ignored.
264:Print dependencies in inverse order. If the \fB\-\-list\fP output is requested then the lines are still ordered by dependencies.
269:Force tree\-like output format. If \fIcolumn\fP is specified, then a tree is printed in the column. The default is NAME column.
274:Output info about block\-device topology. This option is equivalent to
291:Specifies output width as a number of characters. The default is the number of the terminal columns, and if not executed on a terminal, then output width is not restricted at all by default. This option also forces \fBlsblk\fP to assume that terminal control characters and unsafe characters are not allowed. The expected use\-case is for example when \fBlsblk\fP is used by the \fBwatch\fP(1) command.
296:Sort output lines by \fIcolumn\fP. This option enables \fB\-\-list\fP output format by default. It is possible to use the option \fB\-\-tree\fP to force tree\-like output and than the tree branches are sorted by the \fIcolumn\fP.
301:The column name will be modified to contain only characters allowed for shell variable identifiers, for example, MIN_IO and FSUSE_PCT instead of MIN\-IO and FSUSE%. This is usable, for example, with \fB\-\-pairs\fP. Note that this feature has been automatically enabled for \fB\-\-pairs\fP in version 2.37, but due to compatibility issues, now it\(cqs necessary to request this behavior by \fB\-\-shell\fP.
311:Gather data for a Linux instance other than the instance from which the \fBlsblk\fP command is issued. The specified directory is the system root of the Linux instance to be inspected. The real device nodes in the target directory can be replaced by text files with udev attributes.
364:The \fBlsblk\fP command needs to be able to look up each block device by major:minor numbers, which is done by using \fI/sys/dev/block\fP. This sysfs block directory appeared in kernel 2.6.27 (October 2008). In case of problems with a new enough kernel, check that \fBCONFIG_SYSFS\fP was enabled at the time of the kernel build.

-.-.

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.

Line 37, length 385

\fBlsblk\fP lists information about all available or the specified block devices. The \fBlsblk\fP command reads the \fBsysfs\fP filesystem and \fBudev db\fP to gather information. If the udev db is not available or \fBlsblk\fP is compiled without udev support, then it tries to read LABELs, UUIDs and filesystem types from the block device. In this case root permissions are necessary.

Line 39, length 305

By default, the command prints all block devices (except RAM disks) in a tree\-like format. The same device can be repeated in the tree if it relates to other devices. The \fB\-\-merge\fP option is recommended for more complicated setups to gather groups of devices and describe complex N:M relationships.

Line 41, length 253

The tree\-like output (or \fBchildren[]\fP array in the JSON output) is enabled only if NAME column it present in the output or when \fB\-\-tree\fP command line option is used. See also \fB\-\-nodeps\fP and \fB\-\-list\fP to control the tree formatting.

Line 43, length 362

The default output, as well as the default output from options like \fB\-\-fs\fP and \fB\-\-topology\fP, is subject to change. So whenever possible, you should avoid using default outputs in your scripts. Always explicitly define expected columns by using \fB\-\-output\fP \fIcolumns\-list\fP and \fB\-\-list\fP in environments where a stable output is required.

Line 47, length 243

Note that \fBlsblk\fP might be executed in time when \fBudev\fP does not have all information about recently added or modified devices yet. In this case it is recommended to use \fBudevadm settle\fP before \fBlsblk\fP to synchronize with udev.

Line 49, length 475

The relationship between block devices and filesystems is not always one\-to\-one. The filesystem may use more block devices, or the same filesystem may be accessible by more paths. This is the reason why \fBlsblk\fP provides MOUNTPOINT and MOUNTPOINTS (pl.) columns. The column MOUNTPOINT displays only one mount point (usually the last mounted instance of the filesystem), and the column MOUNTPOINTS displays by multi\-line cell all mount points associated with the device.

Line 59, length 82

Disable all built\-in filters and list all empty devices and RAM disk devices too.

Line 75, length 111

List the available columns, use with \fB\-\-json\fP or \fB\-\-raw\fP to get output in machine\-readable format.

Line 80, length 82

Print information about the discarding capabilities (TRIM, UNMAP) for each device.

Line 85, length 129

Do not print holder devices or slaves. For example, \fBlsblk \-\-nodeps /dev/sda\fP prints information about the sda device only.

Line 90, length 233

Use \fIcolumn\fP as a de\-duplication key to de\-duplicate output tree. If the key is not available for the device, or the device is a partition and parental whole\-disk device provides the same key than the device is always printed.

Line 92, length 106

The usual use case is to de\-duplicate output on system multi\-path devices, for example by \fB\-E WWN\fP.

Line 97, length 334

Exclude the devices specified by the comma\-separated \fIlist\fP of major device numbers. Note that RAM disks (major=1) are excluded by default if \fB\-\-all\fP is not specified. The filter is applied to the top\-level devices only. This may be confusing for \fB\-\-list\fP output format where hierarchy of the devices is not obvious.

Line 102, length 227

Output info about filesystems. This option is equivalent to \fB\-o NAME,FSTYPE,FSVER,LABEL,UUID,FSAVAIL,FSUSE%,MOUNTPOINTS\fP. The authoritative information about filesystems and raids is provided by the \fBblkid\fP(8) command.

Line 107, length 241

Include devices specified by the comma\-separated \fIlist\fP of major device numbers. The filter is applied to the top\-level devices only. This may be confusing for \fB\-\-list\fP output format where hierarchy of the devices is not obvious.

Line 117, length 196

Use JSON output format. It\(cqs strongly recommended to use \fB\-\-output\fP and also \fB\-\-tree\fP if necessary. Note that \fBchildren[]\fP is used only if NAME column or \fB\-\-tree\fP is used.

Line 122, length 288

Produce output in the form of a list. The output does not provide information about relationships between devices and since version 2.34 every device is printed only once if \fB\-\-pairs\fP or \fB\-\-raw\fP not specified (the parsable outputs are maintained in backwardly compatible way).

Line 127, length 129

Group parents of sub\-trees to provide more readable output for RAIDs and Multi\-path devices. The tree\-like output is required.

Line 132, length 114

Output info about device owner, group and mode. This option is equivalent to \fB\-o NAME,SIZE,OWNER,GROUP,MODE\fP.

Line 152, length 232

Specify which output columns to print. Use \fB\-\-list\-columns\fP to get a list of all supported columns. The columns may affect tree\-like output. The default is to use tree for the column \*(AqNAME\*(Aq (see also \fB\-\-tree\fP).

Line 154, length 127

The default list of columns may be extended if \fIlist\fP is specified in the format \fI+list\fP (e.g., \fBlsblk \-o +UUID\fP).

Line 164, length 205

Produce output in the form of key="value" pairs. The output lines are still ordered by dependencies. All potentially unsafe value characters are hex\-escaped (\(rsx<code>). See also option \fB\-\-shell\fP.

Line 181, length 83

exclude sda  and sdb, but print everything else (\*(Aq!~\*(Aq is a negative regular

Line 207, length 100

The \fIname\fP is the custom name of the counter, the optional \fIparam\fP is the name of the column

Line 212, length 86

If the \fIparam\fP is not specified, then the counter counts the number of lines. This

Line 215, length 92

For example, \fB\-\-ct MyCounter:SIZE:sum\fP will count the summary for SIZE from all lines;

Line 224, length 91

lsblk \-\-ct\-filter \*(AqTYPE=="disk" && TRAN=="sata"\*(Aq \-\-ct "Number of SATA devices"

Line 234, length 94

Define a restriction for the next counter. This feature is EXPERIMENTAL. See also \fB\-\-ct\fP

Line 254, length 207

Produce output in raw format. The output lines are still ordered by dependencies. All potentially unsafe characters are hex\-escaped (\(rsx<code>) in the NAME, KNAME, LABEL, PARTLABEL and MOUNTPOINT columns.

Line 259, length 91

Output info about SCSI devices only. All partitions, slaves and holder devices are ignored.

Line 264, length 128

Print dependencies in inverse order. If the \fB\-\-list\fP output is requested then the lines are still ordered by dependencies.

Line 269, length 127

Force tree\-like output format. If \fIcolumn\fP is specified, then a tree is printed in the column. The default is NAME column.

Line 276, length 88

\fB\-o NAME,ALIGNMENT,MIN\-IO,OPT\-IO,PHY\-SEC,LOG\-SEC,ROTA,SCHED,RQ\-SIZE,RA,WSAME\fP.

Line 291, length 402

Specifies output width as a number of characters. The default is the number of the terminal columns, and if not executed on a terminal, then output width is not restricted at all by default. This option also forces \fBlsblk\fP to assume that terminal control characters and unsafe characters are not allowed. The expected use\-case is for example when \fBlsblk\fP is used by the \fBwatch\fP(1) command.

Line 296, length 229

Sort output lines by \fIcolumn\fP. This option enables \fB\-\-list\fP output format by default. It is possible to use the option \fB\-\-tree\fP to force tree\-like output and than the tree branches are sorted by the \fIcolumn\fP.

Line 301, length 406

The column name will be modified to contain only characters allowed for shell variable identifiers, for example, MIN_IO and FSUSE_PCT instead of MIN\-IO and FSUSE%. This is usable, for example, with \fB\-\-pairs\fP. Note that this feature has been automatically enabled for \fB\-\-pairs\fP in version 2.37, but due to compatibility issues, now it\(cqs necessary to request this behavior by \fB\-\-shell\fP.

Line 311, length 282

Gather data for a Linux instance other than the instance from which the \fBlsblk\fP command is issued. The specified directory is the system root of the Linux instance to be inspected. The real device nodes in the target directory can be replaced by text files with udev attributes.

Line 362, length 94

For partitions, some information (e.g., queue attributes) is inherited from the parent device.

Line 364, length 328

The \fBlsblk\fP command needs to be able to look up each block device by major:minor numbers, which is done by using \fI/sys/dev/block\fP. This sysfs block directory appeared in kernel 2.6.27 (October 2008). In case of problems with a new enough kernel, check that \fBCONFIG_SYSFS\fP was enabled at the time of the kernel build.

Line 381, length 90

The \fBlsblk\fP command is part of the util\-linux package which can be downloaded from \c

Line 382, length 85

.URL "https://www.kernel.org/pub/linux/utils/util\-linux/" "Linux Kernel Archive" "."


-.-.

Put a parenthetical sentence, phrase on a separate line,
if not part of a code.
See man-pages(7), item "semantic newline".

lsblk.8:39:By default, the command prints all block devices (except RAM disks) in a tree\-like format. The same device can be repeated in the tree if it relates to other devices. The \fB\-\-merge\fP option is recommended for more complicated setups to gather groups of devices and describe complex N:M relationships.
lsblk.8:41:The tree\-like output (or \fBchildren[]\fP array in the JSON output) is enabled only if NAME column it present in the output or when \fB\-\-tree\fP command line option is used. See also \fB\-\-nodeps\fP and \fB\-\-list\fP to control the tree formatting.
lsblk.8:49:The relationship between block devices and filesystems is not always one\-to\-one. The filesystem may use more block devices, or the same filesystem may be accessible by more paths. This is the reason why \fBlsblk\fP provides MOUNTPOINT and MOUNTPOINTS (pl.) columns. The column MOUNTPOINT displays only one mount point (usually the last mounted instance of the filesystem), and the column MOUNTPOINTS displays by multi\-line cell all mount points associated with the device.
lsblk.8:122:Produce output in the form of a list. The output does not provide information about relationships between devices and since version 2.34 every device is printed only once if \fB\-\-pairs\fP or \fB\-\-raw\fP not specified (the parsable outputs are maintained in backwardly compatible way).
lsblk.8:152:Specify which output columns to print. Use \fB\-\-list\-columns\fP to get a list of all supported columns. The columns may affect tree\-like output. The default is to use tree for the column \*(AqNAME\*(Aq (see also \fB\-\-tree\fP).
lsblk.8:154:The default list of columns may be extended if \fIlist\fP is specified in the format \fI+list\fP (e.g., \fBlsblk \-o +UUID\fP).
lsblk.8:362:For partitions, some information (e.g., queue attributes) is inherited from the parent device.
lsblk.8:364:The \fBlsblk\fP command needs to be able to look up each block device by major:minor numbers, which is done by using \fI/sys/dev/block\fP. This sysfs block directory appeared in kernel 2.6.27 (October 2008). In case of problems with a new enough kernel, check that \fBCONFIG_SYSFS\fP was enabled at the time of the kernel build.

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: file '<stdin>':276
troff:<stdin>:276: warning: [page 4, 3.6i]: cannot break line

-.-.


--pQOb6zAiycogBfL3--
