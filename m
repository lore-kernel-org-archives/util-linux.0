Return-Path: util-linux-owner@vger.kernel.org
Received: from awesome.dsw2k3.info ([217.188.63.246]:59688 "EHLO
	awesome.dsw2k3.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaIAH5v (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Sep 2014 03:57:51 -0400
Date: Mon, 1 Sep 2014 09:57:45 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: Debugging why fstrim doesn't work
Message-ID: <20140901075745.GA24321@citd.de>
References: <20140829093522.GA32003@citd.de>
 <54041383.2090700@bernhard-voelker.de>
 <20140901071603.GA23478@citd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140901071603.GA23478@citd.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01.09.2014 09:16, Matthias Schniedermeyer wrote:
> On 01.09.2014 08:34, Bernhard Voelker wrote:
> > On 08/29/2014 11:35 AM, Matthias Schniedermeyer wrote:
> > > $ fstrim -v /
> > > fstrim: /: discard operation not supported.
> > > 
> > > How can i debug why fstrim/the kernel thinks discard isn't supported?
> > 
> >   $ strace -v fstrim -v /
> >   ...
> >   ioctl(3, FITRIM, 0x7fff4d693590)        = -1 EOPNOTSUPP (Operation not supported)
> >   ...
> > 
> > Interestingly, fstrim's error message has changed from the more precise
> > 
> >   fstrim: /: FITRIM ioctl failed: Operation not supported
> > 
> > (e.g. in 2.23.2) to a probably more user-friendly
> > 
> >   fstrim: /: the discard operation is not supported
> > 
> > (in the current git version).
> 
> I don't get 'Operation not supported".
> 
> I get this error:
> open("/", O_RDONLY|O_LARGEFILE)         = 3
> fstat64(3, {st_dev=makedev(8, 2), st_ino=192, st_mode=S_IFDIR|0755, st_nlink=25, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=4096, st_atime=2014/07/02-21:06:38, st_mtime=2014/07/19-23:54:25, st_ctime=2014/07/19-23:54:25}) = 0
> ioctl(3, FITRIM, 0xfffa6198)            = -1 ENOTTY (Inappropriate ioctl for device)
> close(3)                                = 0

And the answer is:
32bit userspace and 64bit kernels don't mix (in this case).

I've tested the 64bit version of fstrim and it worked.




-- 

Matthias
