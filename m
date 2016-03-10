Return-Path: sweet_f_a@gmx.de
From: =?iso-8859-1?q?R=FCdiger_Meier?= <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: sfdisk, stderr/stdout output order
Date: Thu, 10 Mar 2016 15:35:43 +0100
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
References: <201603101140.50532.sweet_f_a@gmx.de> <56E17FDC.6010604@bernhard-voelker.de> <20160310142450.rqx2yfah5waotnag@ws.net.home>
In-Reply-To: <20160310142450.rqx2yfah5waotnag@ws.net.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201603101535.43195.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>



On Thursday 10 March 2016 15:24:50 Karel Zak wrote:
> On Thu, Mar 10, 2016 at 03:08:28PM +0100, Bernhard Voelker wrote:
> > On 03/10/2016 12:16 PM, Karel Zak wrote:
> > >On Thu, Mar 10, 2016 at 11:40:50AM +0100, R=FCdiger Meier wrote:
> > >>I've found such test diffs with musl libc. Maybe it needs some
> > >> fflush(3) calls.
> > >
> > >  Yes, good point. I'll fix it.
> >
> > I don't think you can enforce stdout/stderr to be synchronous.
> > Well, you can try with "stdbuf(1)", but only having coreutils >v7.5
> > (2009).  Why not check the output of both streams separately?
>
> Well, it's not about tests (although check both streams separately
> will be improvement). The problem is that we write to stderr and=20
> stdout in fdisks, fflush(stdout) before warnings will make things
> more deterministic.

Yep, I had found more problems like in rename below. For rename we
should probably fix the test rather than adding fflush().

=2D-- /home/rudi/devel/util-linux/tests/expected/rename/exit_codes
+++ /tmp/build-musl/tests/output/rename/exit_codes=20
@@ -2,6 +2,6 @@
 `rename_exit_codes.1' -> `rename_exit_values.1'
 `rename_exit_codes.2' -> `rename_exit_values.2'
 EXIT_SUCCESS: 0
=2Drename: rename_exit_values.2: rename to rename_exit_codes.2 failed: Is a=
 directory
 `rename_exit_values.1' -> `rename_exit_codes.1'
+rename: rename_exit_values.2: rename to rename_exit_codes.2 failed: Is a d=
irectory
 RENAME_EXIT_SOMEOK: 2

cu,
Rudi
