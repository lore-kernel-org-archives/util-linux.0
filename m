Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60999 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbaF1S3w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 28 Jun 2014 14:29:52 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so6031170pdj.1
        for <util-linux@vger.kernel.org>; Sat, 28 Jun 2014 11:29:52 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140625121153.GC30418@x2.net.home>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
	<1403433117-32652-6-git-send-email-kerolasa@iki.fi>
	<20140625121153.GC30418@x2.net.home>
Date: Sat, 28 Jun 2014 19:29:52 +0100
Message-ID: <CAG27Bk39i4Jv7fKoTSNVWi=-Q=gATg_m+F9H3v_BNM9SX4srQA@mail.gmail.com>
Subject: Re: [PATCH 5/6] rename: continue despite something failed
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 25 June 2014 13:11, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jun 22, 2014 at 11:31:56AM +0100, Sami Kerola wrote:
>> Try to do all file operations even when one or some of them fail.
>
>  It would be nice to have a special return code for situation when
>  something failed. See for example "mount -a" of kill(1) where we have
>
>     #define KILL_EXIT_SOMEOK      64
>
>  and add to man page:
>
>        0      success
>        1      failure
>        64     partial success

Hi Karel,

Good idea, and I extended it a little. I added four different exit values,
that are hopefully useful.

  0    all requested rename operations were successful
  1    all rename operations failed
  2    some rename operations failed
  4    nothing was renamed
  64   unanticipated error occurred

The changes can be found from my git repository below, and I will
submit the patches 0005 and 0006 again to email list. There is also
new change, 0007, that is a check the exit values are working as
expected.

--- snip
The following changes since commit 575718a04aa0c053875041dc387e360f2dcaa70d:
  fallocate: use O_CREAT only for the default behavior (2014-06-26
14:45:02 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git
for you to fetch changes up to 40cbaab8022ba9e0dfeb3358655c0631bd1143bc:
  tests: add rename(1) return value check (2014-06-28 19:11:30 +0100)
-- snip

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
