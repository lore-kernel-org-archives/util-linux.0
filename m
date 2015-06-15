Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbbFONFj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Jun 2015 09:05:39 -0400
Date: Mon, 15 Jun 2015 15:05:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Felipe Franciosi <felipe.franciosi@citrix.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: losetup race on -f file
Message-ID: <20150615130537.GT1992@ws.net.home>
References: <9F2C4E7DFB7839489C89757A66C5AD62BA1A0C@AMSPEX01CL03.citrite.net>
 <20150615090347.GR1992@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150615090347.GR1992@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 15, 2015 at 11:03:47AM +0200, Karel Zak wrote:
> On Fri, Jun 12, 2015 at 09:44:03AM +0000, Felipe Franciosi wrote:
> > Hi All,
> > 
> > I'm seeing a race when using "losetup -f file". Some research
> > pointed me to a 2007 path that introduced a "retry" mechanism if the
> > module returned EBUSY. At some point before the project went into
> > git.kernel.org this commit went away.
> 
> I still see EBUSY sensitivity:
> 
>   https://github.com/karelzak/util-linux/blob/master/sys-utils/losetup.c#L684
> 
> the problem is probably loopcxt_setup_device() where we does not save
> errno and does not set proper return value.
> 
> I'll try to fix it. Thanks for you report!

I'm not able to reproduce the problem, but I have pushed a small
improvement to make the code less fragile:

 https://github.com/karelzak/util-linux/commit/2cde9865c27248bb1f7685b66a0a5830884f5869

My test:

 # for i in {0..99}; do dd if=/dev/zero of=$i.img count=1 bs=1MiB; done
 # for i in {0..99}; do strace -o $i.log losetup -f ./$i.img & done

all devices created (100 device + header line):

 # losetup  | wc -l
 101

and many EBUSY detected:

 # grep BUSY *.log | wc -l
 201

and from "losetup" output is obvious than many <n>.img files are
associated with /dev/loop<n> where <n> is not the same number (due to
EBUSY).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
