Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27312 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbaIVL1O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 07:27:14 -0400
Date: Mon, 22 Sep 2014 13:27:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] build-sys: swaplabel needs libmount
Message-ID: <20140922112703.GH5366@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411086439-8247-1-git-send-email-andreas@fatal.se>
 <1411083397-8056-4-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 19, 2014 at 01:36:36AM +0200, Andreas Henriksson wrote:
> The swaplabel utility uses libmount functionality and
> thus libmount has to be available if we want to build
> swaplabel. This change makes swaplabel be automatically
> disabled when we don't.
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
> 

On Fri, Sep 19, 2014 at 02:27:19AM +0200, Andreas Henriksson wrote:
> The swapoff utility seems to need linking with libblkid otherwise
> this build error occurs:
> 
> $ git describe
> v2.25-180-g29607ed
> $ ./autogen.sh && ./configure --without-python  && make
> [....]
>   CCLD     swapoff
> /usr/bin/ld: sys-utils/swapoff-swapon-common.o: undefined reference to symbol 'blkid_probe_lookup_value@@BLKID_2.15'
> //home/ah/opt/pkg-util-linux/util-linux/.libs/libblkid.so.1: error adding symbols: DSO missing from command line
> collect2: error: ld returned 1 exit status
> Makefile:5992: recipe for target 'swapoff' failed
> make[2]: *** [swapoff] Error 1
> make[2]: Leaving directory '/home/ah/opt/pkg-util-linux/util-linux'
> Makefile:10220: recipe for target 'all-recursive' failed
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory '/home/ah/opt/pkg-util-linux/util-linux'
> Makefile:4433: recipe for target 'all' failed
> make: *** [all] Error 2
> 
> ---
>  sys-utils/Makemodule.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


 I have modified swapoff, swapon and swaplabel to use separate file
 lib/swapprobe.c for libblkid stuff. So now:

    swapon    - requires libmount and libblkid
    swapoff   - requires libmount
    swaplabel - requires libblkid


 link directly both libs everywhere is overkill. Please, test the
 current git tree. Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
