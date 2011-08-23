Return-Path: heiko.carstens@de.ibm.com
Date: Tue, 23 Aug 2011 10:45:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] new chcpu tool
Message-ID: <20110823084540.GA2540@osiris.boeblingen.de.ibm.com>
References: <20110815152453.052584040@de.ibm.com>
 <20110822120641.GA7549@osiris.boeblingen.de.ibm.com>
 <20110822132817.GD20457@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110822132817.GD20457@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 22, 2011 at 03:28:17PM +0200, Karel Zak wrote:
> On Mon, Aug 22, 2011 at 02:06:41PM +0200, Heiko Carstens wrote:
> > Do you think it would be ok to have it in util-linux? Or should it live
> > somewhere else?
> 
> It makes sense to have it in util-linux. I'm going to merge it after
> v2.20 release.

Ok, great!

I set up a chcpu git branch where you could pull the chcpu stuff easily:

  git://git.kernel.org/pub/scm/linux/kernel/git/heiko/util-linux.git chcpu

It contains just the two patches posted here and doesn't interfer with the
lscpu branch that is also there.

Heiko Carstens (2):
      cpuset: add option to allow cpulist_parse() to fail
      chcpu: new tool

 include/cpuset.h      |    2 +-
 lib/cpuset.c          |    7 +-
 schedutils/taskset.c  |    2 +-
 sys-utils/.gitignore  |    1 +
 sys-utils/Makefile.am |    3 +
 sys-utils/chcpu.1     |   94 ++++++++++++++
 sys-utils/chcpu.c     |  337 +++++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu.1     |    2 +
 sys-utils/lscpu.c     |    2 +-
 9 files changed, 445 insertions(+), 5 deletions(-)
 create mode 100644 sys-utils/chcpu.1
 create mode 100644 sys-utils/chcpu.c

> > +static int path_exist(const char *path, ...)
> 
>  It seems that we need to move the path_*() functions from lscpu(1) to
>  lib/ and hare the stuff.

Yes, I thought so as well. But laziness won ;)

Thanks,
Heiko
