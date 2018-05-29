Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755063AbeE2IOC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 29 May 2018 04:14:02 -0400
Date: Tue, 29 May 2018 10:13:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org, Samuel Thibault <sthibault@debian.org>
Subject: Re: [sthibault@debian.org: Re: Bug#891812: util-linux: FTBFS on
 hurd-i386: calls pty_init_slave unconditionally]
Message-ID: <20180529081358.pcmu3tleiyf4wpkw@ws.net.home>
References: <20180528211617.pglxjujbbamg6skn@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528211617.pglxjujbbamg6skn@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 28, 2018 at 11:16:17PM +0200, Andreas Henriksson wrote:
> As Svante mentioned it will not work because GNU/Hurd does not provide
> the linuxish mount() interface (which is about to change, btw ;)
> The attached patch fixes the build.
> 
> Samuel
> 
> diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
> index 11fd759fa..39568a37c 100644
> --- a/libmount/src/libmount.h.in
> +++ b/libmount/src/libmount.h.in
> @@ -34,7 +34,9 @@ extern "C" {
>   * don't want to include sys/mount.h at all to avoid collisions.
>   */
>  #ifndef MS_RDONLY
> -# include <sys/mount.h>
> +# ifdef HAVE_SYS_MOUNT_H
> +#  include <sys/mount.h>
> +# endif
>  #endif

I have doubts we can use HAVE_* here, because the file is public
library interface and HAVE_* are available in util-linux build tree
only. I have applied another bugfix:

diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 11fd759fa..c61514b59 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -33,7 +33,7 @@ extern "C" {
  * may be already defined by linux/fs.h or another file -- in this case we
  * don't want to include sys/mount.h at all to avoid collisions.
  */
-#ifndef MS_RDONLY
+#if defined(__linux__) && !defined(MS_RDONLY)
 # include <sys/mount.h>
 #endif


Hope this bugfix (from "Typical Redhat people") will work for Svante
too :)


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
