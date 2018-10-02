Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbeJBQ52 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Oct 2018 12:57:28 -0400
Date: Tue, 2 Oct 2018 12:14:54 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
Message-ID: <20181002101454.qm5gzasb5naamnbg@ws.net.home>
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
 <5BB15D3A.8040507@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5BB15D3A.8040507@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 30, 2018 at 04:33:14PM -0700, L A Walsh wrote:
> On 9/25/2018 3:47 AM, Karel Zak wrote:
> > The commands mount and umount
> ---
>   I note that umount has a static option umount.static, but I don't see
> the same for mount (i.e. mount.static).

 $ ./configure --enable-static-programs=mount,umount
 $ make mount.static umount.static

works for me:

 $ ./mount.static -V; ./umount.static -V
 mount.static from util-linux 2.33-rc1 (libmount 2.33.0: btrfs, assert, debug)
 umount.static from util-linux 2.33-rc1 (libmount 2.33.0: btrfs, assert, debug)

 $ ldd mount.static umount.static
 mount.static:
 	not a dynamic executable
 umount.static:
 	not a dynamic executable

>  How does rename compare with 'mmv'?  I note that in the manpage "SEE ALSO"
> section,  'mv' is listed, (not quite sure why?), but not a more related tool
> like 'mmv'.

 $ mmv
 bash: mmv: command not found...
 Similar command is: 'mv'

Not sure about another distros, but on Fedora is not installed by
default.

We have rename(1) in util-linux since v2.10 (year 1999/2000) and according
to http://www.guckes.net/mmv/ mmv is from the same year :-) Not sure
if mmv is still maintained. The functionality is probably the same.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
