Return-Path: util-linux-owner@vger.kernel.org
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:54712 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934145AbeE1VXt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 28 May 2018 17:23:49 -0400
Date: Mon, 28 May 2018 23:16:17 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Samuel Thibault <sthibault@debian.org>
Subject: [sthibault@debian.org: Re: Bug#891812: util-linux: FTBFS on
 hurd-i386: calls pty_init_slave unconditionally]
Message-ID: <20180528211617.pglxjujbbamg6skn@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Please consider Samuels patch as forwarded below to fix 
(debian package) build on Hurd.

Sorry for messy formatting and lack of s-o-b.
If it helps, raw patch can be downloaded from:
https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=891812;filename=patch;msg=34

( Original discussion at http://bugs.debian.org/891812 )

Regards,
Andreas Henriksson

----- Forwarded message from Samuel Thibault <sthibault@debian.org> -----

Date: Sun, 27 May 2018 18:00:02 +0200
From: Samuel Thibault <sthibault@debian.org>
To: Andreas Henriksson <andreas@fatal.se>
Cc: "Aaron M. Ucko" <ucko@debian.org>, 891812@bugs.debian.org
Subject: Re: Bug#891812: util-linux: FTBFS on hurd-i386: calls pty_init_slave
	unconditionally
User-Agent: NeoMutt/20170113 (1.7.2)

Hello,

Andreas Henriksson, le lun. 21 mai 2018 22:45:54 +0200, a ecrit:
> On Thu, Mar 01, 2018 at 01:55:22AM +0100, Samuel Thibault wrote:
> > Aaron M. Ucko, on mer. 28 févr. 2018 19:47:40 -0500, wrote:
> > >   login-utils/su-common.c:1427:3: warning: implicit declaration of function 'pty_init_slave'; did you mean 'initstate'? [-Wimplicit-function-declaration]
> > >   [...]
> > >   ./login-utils/su-common.c:1427: undefined reference to `pty_init_slave'
> > 
> > IIRC I got a fix commited upstream
> 
> Your fix should now be part of the latest upload (2.32-0.1),
> unfortunately there's another problem now.
> 
> Any chance you can test if by any chance the following upstream commit
> fixes the (libmount-related) build issue on hurd (or if additional
> upstream fixing is needed for hurd)?
> 
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=061d1a51097c3c025ff46173f10aa135f9a610d4

As Svante mentioned it will not work because GNU/Hurd does not provide
the linuxish mount() interface (which is about to change, btw ;)
The attached patch fixes the build.

Samuel

diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 11fd759fa..39568a37c 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -34,7 +34,9 @@ extern "C" {
  * don't want to include sys/mount.h at all to avoid collisions.
  */
 #ifndef MS_RDONLY
-# include <sys/mount.h>
+# ifdef HAVE_SYS_MOUNT_H
+#  include <sys/mount.h>
+# endif
 #endif
 
 #define LIBMOUNT_VERSION   "@LIBMOUNT_VERSION@"


----- End forwarded message -----
