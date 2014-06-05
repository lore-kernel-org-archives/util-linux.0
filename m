Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51604 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbaFEMpf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Jun 2014 08:45:35 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: tests: hwclock questions
Date: Thu, 5 Jun 2014 14:45:31 +0200
Cc: util-linux@vger.kernel.org
References: <201406050032.24233.sweet_f_a@gmx.de> <20140605074805.GV9000@x2.net.home>
In-Reply-To: <20140605074805.GV9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406051445.31366.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 05 June 2014, Karel Zak wrote:
> On Thu, Jun 05, 2014 at 12:32:24AM +0200, Ruediger Meier wrote:
> > But before doing this I have two questions.
>
>  Maybe we can remove the test at all (or use --force to enable the
> test). It was always very problematic test 

I will try to make it a bit more robust and then see if we still should 
make it optional. IMO these time sync problems are some kind of 
science. Could be too much for being solved within one simple shell 
script.

> and I have doubts it's
> still necessary as relevant hwclock code is completely different and
> more robust now.

Ok, then I would do --systohc and --hctosys just one time instead of 10.

BTW how could I get the offset between sys and hw clock? What does the 
last "xxx seconds" in --show output mean? Obviously not the whole 
offset:

$ export LANG=C; export TZ=UTC
$ date
Thu Jun  5 12:38:21 UTC 2014
$ hwclock --show --utc
Thu Jun  5 13:07:28 2014  -0.062807 seconds

> > 1. I wonder what is the original purpose of this test. Are we
> > really testing hwclock or the kernel or hardware? I mean setting
> > and reading
>
>  The purpose is to test how precisely is able hwclock to set HW time.
>  Long time ago we had problem that each iteration added extra 0.5s to
>  the time.

> > cock 10 times ... could this really discover a bug in our hwclock
> > code?
>
>  Yes.
>
> > 2. Why do we _set_ the time from ntp server at the beginning?
> > Wouldnt it be enough to check whether the offset to ntp is the same
> > before and after the test?
>
>  Probably yes.

Maybe getting sys vs. ntp offset like this:

$ ntp_ip=$(dig 0.fedora.pool.ntp.org ANY +short | head -n 1)
$ sntp -K /tmp/kod "$ntp_ip"
 5 Jun 13:00:38 sntp[6547]: Started sntp
2014-06-05 13:00:38.263771 (-0100) -0.002546 +/- 0.022034 secs

Note we have to use fixed IP to get comparable offsets.

cu,
Rudi
