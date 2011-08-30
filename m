Return-Path: heiko.carstens@de.ibm.com
Date: Tue, 30 Aug 2011 13:18:38 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [patch 0/8] various lscpu patches
Message-ID: <20110830111838.GA2443@osiris.boeblingen.de.ibm.com>
References: <20110810083645.135814950@de.ibm.com>
 <20110815084530.GA2400@osiris.boeblingen.de.ibm.com>
 <20110830101242.GS1855@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110830101242.GS1855@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 30, 2011 at 12:12:42PM +0200, Karel Zak wrote:
> On Mon, Aug 15, 2011 at 10:45:30AM +0200, Heiko Carstens wrote:
> > FWIW, I set up a git branch with the lscpu changes:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/heiko/util-linux.git lscpu
> 
>  Merged, thanks.
> 
>  Heiko, it would be nice to have a regression tests for various s390
>  boxes. See tests/ts/lscpu/, there is mk-input.sh which is able to
>  gather all necessary files and create a tarball from /sys and /proc.
>  For s390 it will be probably necessary to extend the list of the files
>  (e.g add /proc/sysinfo).

Ok, I add that on my todo list. I have a couple of more patches for lscpu
and chcpu that I'd like to send to you this week. Afterwards I'll create
the regression test(s).

Thanks,
Heiko
