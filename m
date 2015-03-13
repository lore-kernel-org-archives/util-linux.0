Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:36122 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbCMLhi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 Mar 2015 07:37:38 -0400
Message-ID: <5502CBFF.6090405@draigBrady.com>
Date: Fri, 13 Mar 2015 11:37:35 +0000
From: =?windows-1252?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: tailf, really needed?
References: <201503131000.29307.sweet_f_a@gmx.de>
In-Reply-To: <201503131000.29307.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 13/03/15 09:00, Ruediger Meier wrote:
> Hi,
> 
> As far as I understood tailf's advantage over "tail -f" is that it does 
> not access the file when it does not grow. But nowadays 
> coreutils "tail -f" also does not seem to access the file. So do we 
> really need tailf?
> 
> The point is that I've noticed that our tailf fails to deal with 
> filesystems where inotify is broken. For example it does not work for 
> overlayfs. coreutils tail code looks quite complicated and seems to 
> manage such cases. Is it worth to fix our tailf or better just remove 
> it and use "tail -f"?
> 
> BTW coreutils tail is much more comfortable. It has many important 
> options. For example watching log files without -F or --retry does not 
> make sense to me (because of logrotate).
> 
> Last but not least, is anybody using tailf at all? Google does not find 
> much about people who are using this.

tailf is a strange one. If there was an issue with tail(1) accessing
the files, then why not fix it? In any case it seems without inotify
that tailf(1) does access the file?

  nanosleep({0, 250000000}, NULL)         = 0
  open("file", O_RDONLY)    = 3
  fstat(3, {st_mode=S_IFREG|0664, st_size=7048, ...}) = 0
  close(3)

while tail -f does not:

  nanosleep({0, 1000000000}, NULL)         = 0
  fstat(3, {st_mode=S_IFREG|0664, st_size=7048, ...}) = 0

debian codesearch turned up just a single user in a test:
http://sources.debian.net/src/atheist/0.20110402-2/test/conditions/process-running.test/?hl=5#L5

A deprecation warning makes sense to me.

cheers,
Pádraig.
