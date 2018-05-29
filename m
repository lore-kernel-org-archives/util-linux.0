Return-Path: util-linux-owner@vger.kernel.org
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:54718 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933135AbeE2L2f (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 29 May 2018 07:28:35 -0400
Date: Tue, 29 May 2018 13:28:31 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Samuel Thibault <sthibault@debian.org>
Subject: Re: [sthibault@debian.org: Re: Bug#891812: util-linux: FTBFS on
 hurd-i386: calls pty_init_slave unconditionally]
Message-ID: <20180529112831.yffwcz6rknc3y2an@fatal.se>
References: <20180528211617.pglxjujbbamg6skn@fatal.se>
 <20180529081358.pcmu3tleiyf4wpkw@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529081358.pcmu3tleiyf4wpkw@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

On Tue, May 29, 2018 at 10:13:58AM +0200, Karel Zak wrote:
> I have doubts we can use HAVE_* here, because the file is public
> library interface and HAVE_* are available in util-linux build tree
> only.

Oh, ok.

> I have applied another bugfix:
> 
> diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
> index 11fd759fa..c61514b59 100644
> --- a/libmount/src/libmount.h.in
> +++ b/libmount/src/libmount.h.in
> @@ -33,7 +33,7 @@ extern "C" {
>   * may be already defined by linux/fs.h or another file -- in this case we
>   * don't want to include sys/mount.h at all to avoid collisions.
>   */
> -#ifndef MS_RDONLY
> +#if defined(__linux__) && !defined(MS_RDONLY)
>  # include <sys/mount.h>
>  #endif

Thanks!

> 
> 
> Hope this bugfix (from "Typical Redhat people") will work for Svante
> too :)

Once Hurd implements the sys/mount.h interface (which Samuel hinted is
not far away) the ifdefs can be tweaked to also include hurd I guess....
so your "typical redhat" fix should work fine for now. ;)
(On a more serious note, I think everyone involved with Debian is sorry
for such energy draining comments ending up in our bug tracking system.)

Fwiw, Even though we build libmount on non-linux in Debian, it's not
really functional there yet and still needs porting work (but the
utility bits of libmount is still needed by other tools which are needed
on non-linux thus we need it to build).

Thanks again for the fix.

Regards,
Andreas Henriksson
