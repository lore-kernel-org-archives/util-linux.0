Return-Path: heiko.carstens@de.ibm.com
Date: Tue, 14 Jun 2016 12:08:35 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add drawer support
References: <1465888954-62716-1-git-send-email-heiko.carstens@de.ibm.com>
 <20160614084349.bmut3xx3aorkievj@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160614084349.bmut3xx3aorkievj@ws.net.home>
Message-Id: <20160614100835.GE3754@osiris>
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 14, 2016 at 10:43:49AM +0200, Karel Zak wrote:
> 
>  Hi,
> 
> On Tue, Jun 14, 2016 at 09:22:33AM +0200, Heiko Carstens wrote:
> > the recent IBM z13 machines added yet another cpu topology level which
> > is called 'drawer'. I'd like to have support for this within lscpu as
> > well. The kernel patch that makes the new sysfs interfaces available
> > will be merged during the next merge window. Therefore the first
> > kernel release that contains the required interfaces will be v4.8.
> 
> maybe you can use tests/ts/lscpu/mk-input.sh to create a dump from 
> /proc and /sys. Then we can test this new feature independently on 
> HW and kernel.

I had a test case but threw it away, since the "lscpu -p" output does not
contain the new drawer column.

However I will send a patch which replaces one of the existing s390
testcases, so we get at least a bit of coverage for the summary output.

> > Please consider this patch for inclusion.
> 
> The patch seem good. I'll merge it before the next release. Thanks.

Thank you!
