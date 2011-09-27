Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab1I0Lak (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Sep 2011 07:30:40 -0400
Date: Tue, 27 Sep 2011 13:30:36 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] some sys-utils improvements
Message-ID: <20110927113036.GB1982@nb.net.home>
References: <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com> <20110914174600.GD1829@nb.net.home> <CAG27Bk3FNu-ofpfCZAZ3Ln34wggcJ6Djbx9jkK4dn-__gvAM5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3FNu-ofpfCZAZ3Ln34wggcJ6Djbx9jkK4dn-__gvAM5A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 17, 2011 at 03:10:39PM +0200, Sami Kerola wrote:
> >   printf(_("-x, --extra-mega-cool <file>    enable the best feature for <file>\n");
> >   printf(USAGE_SEPARATOR);
> >   printf(USAGE_HELP);
> >   printf(USAGE_USAGE);
> >   printf(USAGE_MAN_TAIL("foo(1)");
[...]
> The usage howto is already telling --help and --version are expected to be
> last in list, so that should be OK. The separator in between specific and
> 'common' options is added to howto and code. Obvious good thing about the
> separator is that if we end up not liking it it's trivial to make
> ineffective.

 Note that the separator should not be used after USAGE_OPTIONS (I
 have fixed this in the code).

[...]

> My suggestion is to expand utility we alrady have
> 
> tools/checkincludes.pl

 no problem, go ahead.

>  Documentation/howto-contribute.txt     |   18 ++
>  Documentation/howto-usage-function.txt |    6 +-
>  include/c.h                            |    4 +-
>  sys-utils/Makefile.am                  |    2 +
>  sys-utils/arch.c                       |    5 +-
>  sys-utils/ctrlaltdel.8                 |   20 +-
>  sys-utils/ctrlaltdel.c                 |   39 +++-
>  sys-utils/ipcmk.1                      |   52 ++--
>  sys-utils/ipcmk.c                      |  144 ++++-----
>  sys-utils/ipcrm.1                      |   65 ++---
>  sys-utils/ipcrm.c                      |  515 ++++++++++++++++++++------------
>  sys-utils/ipcs.1                       |  101 ++++---
>  sys-utils/ipcs.c                       |  278 +++++++++---------
>  sys-utils/pivot_root.8                 |   10 +-
>  sys-utils/pivot_root.c                 |   60 +++-
>  sys-utils/setarch.8                    |   21 +-
>  sys-utils/setarch.c                    |   74 +++---
>  17 files changed, 841 insertions(+), 573 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
