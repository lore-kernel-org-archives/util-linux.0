Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52306 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbbARV3l (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 16:29:41 -0500
Message-ID: <54BC25BF.2020706@gmx.com>
Date: Sun, 18 Jan 2015 16:29:35 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] docs: remove obsolete and unneeded comments from
 man-page files
References: <1421011678-5890-1-git-send-email-bensberg@justemail.net> <1421011678-5890-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421011678-5890-2-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/11/2015 04:27 PM, Benno Schulenberg wrote:

>
> --- a/sys-utils/mount.8
> +++ b/sys-utils/mount.8
> @@ -1,4 +1,3 @@
> -'\" t
>  .\" Copyright (c) 1996-2004 Andries Brouwer
>  .\" Copyright (C) 2006-2012 Karel Zak <kzak@redhat.com>
>  .\"

Isn't it still considered best practice to hint for
preprocessors in this way?


> @@ -28,7 +27,6 @@
>  .\" with this program; if not, write to the Free Software Foundation, Inc.,
>  .\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  .\"
> -.\"
>  .TH MOUNT 8 "July 2014" "util-linux" "System Administration"
>  .SH NAME
>  mount \- mount a filesystem
> @@ -3215,4 +3213,3 @@ Karel Zak <kzak@redhat.com>
>  .SH AVAILABILITY
>  The mount command is part of the util-linux package and is available from
>  ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
> -
> diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
> index c410f81..78990bf 100644
> --- a/sys-utils/mountpoint.1
> +++ b/sys-utils/mountpoint.1
> @@ -1,4 +1,3 @@
> -.\" -*- nroff -*-
>  .TH MOUNTPOINT 1 "July 2014" "util-linux" "User Commands"
>  .SH NAME
>  mountpoint \- see if a directory or file is a mountpoint
> @@ -57,4 +56,3 @@ for sysvinit suite was written by Miquel van Smoorenburg.
>  .SH AVAILABILITY
>  The mountpoint command is part of the util-linux package and is available from
>  ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
> -
> diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
> index ec505bf..4acdfb0 100644
> --- a/sys-utils/renice.1
> +++ b/sys-utils/renice.1
> @@ -29,7 +29,7 @@
>  .\" OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>  .\" SUCH DAMAGE.
>  .\"
> -.\"     @(#)renice.8   8.1 (Berkeley) 6/9/93
> +.\"     @(#)renice.8	8.1 (Berkeley) 6/9/93
>  .\"
>  .TH RENICE "1" "July 2014" "util-linux" "User Commands"
>  .SH NAME
> diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
> index 7a30587..f7c020b 100644
> --- a/sys-utils/setsid.1
> +++ b/sys-utils/setsid.1
> @@ -1,6 +1,5 @@
>  .\" Rick Sladkey <jrs@world.std.com>
>  .\" In the public domain.
> -.\" Path modifications by faith@cs.unc.edu
>  .TH SETSID 1 "July 2014" "util-linux" "User Commands"
>  .SH NAME
>  setsid \- run a program in a new session
> diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
> index 23da280..e571a5f 100644
> --- a/sys-utils/swapon.8
> +++ b/sys-utils/swapon.8
> @@ -31,13 +31,6 @@
>  .\"
>  .\"     @(#)swapon.8	6.3 (Berkeley) 3/16/91
>  .\"
> -.\" Sun Dec 27 12:31:30 1992: Modified by faith@cs.unc.edu
> -.\" Sat Mar  6 20:46:02 1993: Modified by faith@cs.unc.edu
> -.\" Sat Oct  9 09:35:30 1993: Converted to man format by faith@cs.unc.edu
> -.\" Sat Nov 27 20:22:42 1993: Updated authorship information, faith@cs.unc.edu
> -.\" Mon Sep 25 14:12:38 1995: Added -v and -p information
> -.\" Tue Apr 30 03:32:07 1996: Added some text from A. Koppenhoefer
> -.\"
>  .TH SWAPON 8 "October 2014" "util-linux" "System Administration"
>  .SH NAME
>  swapon, swapoff \- enable/disable devices and files for paging and swapping
> diff --git a/sys-utils/tunelp.8 b/sys-utils/tunelp.8
> index 444cfb4..c706236 100644
> --- a/sys-utils/tunelp.8
> +++ b/sys-utils/tunelp.8
> @@ -1,10 +1,9 @@
> -.\" This file Copyright (C) 1992-1997 Michael K. Johnson <johnsonm@redhat.com>
> -.\" This file Copyright (C) 1998      Andrea Arcangeli   <andrea@e-mind.com>
> +.\" Copyright (C) 1992-1997 Michael K. Johnson <johnsonm@redhat.com>
> +.\" Copyright (C) 1998      Andrea Arcangeli   <andrea@e-mind.com>
>  .\" It may be distributed under the terms of the GNU General Public License,
>  .\" version 2, or any higher version.  See section COPYING of the GNU General
>  .\" Public license for conditions under which this file may be redistributed.
>  .\"
> -.\" Polished a bit - aeb
>  .TH TUNELP 8 "October 2011" "util-linux" "System Administration"
>  .SH NAME
>  tunelp \- set various parameters for the lp device
> diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
> index c9e159d..ab0614e 100644
> --- a/sys-utils/unshare.1
> +++ b/sys-utils/unshare.1
> @@ -1,6 +1,3 @@
> -.\" Process this file with
> -.\" groff -man -Tascii lscpu.1
> -.\"
>  .TH UNSHARE 1 "July 2014" "util-linux" "User Commands"
>  .SH NAME
>  unshare \- run program with some namespaces unshared from parent
> diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
> index a901e24..7525d41 100644
> --- a/term-utils/setterm.1
> +++ b/term-utils/setterm.1
> @@ -1,13 +1,9 @@
>  .\" Copyright 1990 Gordon Irlam (gordoni@cs.ua.oz.au)
>  .\" Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
> -.\" Most of this was copied from the source code.
> +.\" Copyright 2000 Colin Watson (cjw44@cam.ac.uk)
>  .\" Do not restrict distribution.
>  .\" May be distributed under the GNU General Public License
>  .\"
> -.\" Most options documented by Colin Watson (cjw44@cam.ac.uk)
> -.\" Undocumented: -snow, -softscroll, -standout; these are
> -.\" commented out in the source
> -.\"
>  .TH SETTERM 1 "May 2014" "util-linux" "User Commands"
>  .SH NAME
>  setterm \- set terminal attributes
> diff --git a/term-utils/wall.1 b/term-utils/wall.1
> index fd6c029..33cd352 100644
> --- a/term-utils/wall.1
> +++ b/term-utils/wall.1
> @@ -31,8 +31,6 @@
>  .\"
>  .\"     @(#)wall.1	6.5 (Berkeley) 4/23/91
>  .\"
> -.\" Modified for Linux, Mon Mar  8 18:07:38 1993, faith@cs.unc.edu
> -.\"
>  .TH WALL "1" "August 2013" "util-linux" "User Commands"
>  .SH NAME
>  wall \- write a message to all users
> diff --git a/term-utils/write.1 b/term-utils/write.1
> index ad321f4..5ad58b2 100644
> --- a/term-utils/write.1
> +++ b/term-utils/write.1
> @@ -34,8 +34,6 @@
>  .\"
>  .\"     @(#)write.1	8.1 (Berkeley) 6/6/93
>  .\"
> -.\" Modified for Linux, Sun Mar 12 10:21:01 1995, faith@cs.unc.edu
> -.\"
>  .TH WRITE 1 "March 1995" "util-linux" "User Commands"
>  .SH NAME
>  write \- send a message to another user
> diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
> index 8237fd9..f992763 100644
> --- a/text-utils/hexdump.1
> +++ b/text-utils/hexdump.1
> @@ -29,7 +29,7 @@
>  .\" OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>  .\" SUCH DAMAGE.
>  .\"
> -.\"	from: @(#)hexdump.1	8.2 (Berkeley) 4/18/94
> +.\"	@(#)hexdump.1	8.2 (Berkeley) 4/18/94
>  .\"
>  .TH HEXDUMP "1" "April 2013" "util-linux" "User Commands"
>  .SH NAME
> diff --git a/text-utils/more.1 b/text-utils/more.1
> index 589eaf7..af1fdd4 100644
> --- a/text-utils/more.1
> +++ b/text-utils/more.1
> @@ -32,8 +32,7 @@
>  .\"
>  .\"	@(#)more.1	5.15 (Berkeley) 7/29/91
>  .\"
> -.\" 25Dec92: Extensive changes made by Rik Faith (faith@cs.unc.edu) to
> -.\" conform with the more 5.19 currently in use by the Linux community.
> +.\" Copyright (c) 1992 Rik Faith (faith@cs.unc.edu)
>  .\"
>  .TH MORE "1" "February 2014" "util-linux" "User Commands"
>  .SH NAME
> diff --git a/text-utils/pg.1 b/text-utils/pg.1
> index 7431cd1..ad6c8e3 100644
> --- a/text-utils/pg.1
> +++ b/text-utils/pg.1
> @@ -1,4 +1,4 @@
> -.\" @(#)pg.1	1.7 (gritter) 4/25/01
> +.\" Copyright 2001 Gunnar Ritter
>  .TH PG 1 "July 2014" "util-linux" "User Commands"
>  .SH NAME
>  pg \- browse pagewise through text files
> diff --git a/text-utils/rev.1 b/text-utils/rev.1
> index a8945a9..d1eaed5 100644
> --- a/text-utils/rev.1
> +++ b/text-utils/rev.1
> @@ -29,9 +29,7 @@
>  .\" OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>  .\" SUCH DAMAGE.
>  .\"
> -.\"	from: @(#)rev.1	6.3 (Berkeley) 3/21/92
> -.\"     Modified for Linux by Charles Hannum (mycroft@gnu.ai.mit.edu)
> -.\"                       and Brian Koehmstedt (bpk@gnu.ai.mit.edu)
> +.\"	@(#)rev.1	6.3 (Berkeley) 3/21/92
>  .\"
>  .TH REV "1" "September 2011" "util-linux" "User Commands"
>  .SH NAME
> diff --git a/text-utils/tailf.1 b/text-utils/tailf.1
> index bfe97bc..d59c531 100644
> --- a/text-utils/tailf.1
> +++ b/text-utils/tailf.1
> @@ -1,16 +1,15 @@
> -.\" tailf.1 -- 
> -.\" Created: Thu Jan 11 16:43:10 1996 by faith@acm.org
> +.\" tailf.1 -- man page for tailf
>  .\" Copyright 1996, 2003 Rickard E. Faith (faith@acm.org)
> -.\" 
> +.\"
>  .\" Permission is granted to make and distribute verbatim copies of this
>  .\" manual provided the copyright notice and this permission notice are
>  .\" preserved on all copies.
> -.\" 
> +.\"
>  .\" Permission is granted to copy and distribute modified versions of this
>  .\" manual under the conditions for verbatim copying, provided that the
>  .\" entire resulting derived work is distributed under the terms of a
>  .\" permission notice identical to this one.
> -.\" 
> +.\"
>  .\" Since the Linux kernel and libraries are constantly changing, this
>  .\" manual page may be incorrect or out-of-date.  The author(s) assume no
>  .\" responsibility for errors or omissions, or for damages resulting from
> @@ -18,10 +17,10 @@
>  .\" have taken the same level of care in the production of this manual,
>  .\" which is licensed free of charge, as they might when working
>  .\" professionally.
> -.\" 
> +.\"
>  .\" Formatted or processed versions of this manual, if unaccompanied by
>  .\" the source, must acknowledge the copyright and authors of this work.
> -.\" 
> +.\"
>  .TH TAILF 1 "July 2014" "util-linux" "User Commands"
>  .SH NAME
>  tailf \- follow the growth of a log file
> 
