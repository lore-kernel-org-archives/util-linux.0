Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f177.google.com ([209.85.220.177]:55322 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063Ab3A0U12 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jan 2013 15:27:28 -0500
Received: by mail-vc0-f177.google.com with SMTP id m18so1442115vcm.8
        for <util-linux@vger.kernel.org>; Sun, 27 Jan 2013 12:27:27 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1359294676.11908.140661182937001.6C73CAEF@webmail.messagingengine.com>
References: <1359294676.11908.140661182937001.6C73CAEF@webmail.messagingengine.com>
Date: Sun, 27 Jan 2013 20:27:26 +0000
Message-ID: <CAG27Bk3C2duf6Oe0sZDpC6zNbw2q=obX9LsEuT9hZo37fFP0gQ@mail.gmail.com>
Subject: Re: [patch] ipcs (in git) produces too much output
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 27, 2013 at 1:51 PM, Benno Schulenberg
<bensberg@justemail.net> wrote:
> According to the synopses in the help output and in the man page,
> it should be possible to use 'ipcs' with just the '-i' option and
> an ID.
>
> $ ./ipcs --help | grep '<id>'
>  ipcs [resource] -i <id>
>  -i, --id <id>  print details on resource identified by id
>
> But when trying that, ipcs blurts out its entire help text.
>
> $ ./ipcs -i 111111
>  [...]
>
> In the help text it also says that '-a' is the default, but when
> adding '-a' to the above command, ipcs now produces three texts:
>
> $ ./ipcs -a -i 111111
>
> Shared memory Segment shmid=111111
> [...]
>
> Semaphore Array semid=111111
> [...]
>
> ipcs: id 111111 not found
>
> (The latter error message could be clearer, mentioning that it
> refers to a message queue.)
>
> Whereas older ipcs would in this case just print an error message:
>
> $ /usr/bin/ipcs -a -i 111111
> ipcs: shmctl failed: Invalid argument
>
> (Not good either, but at least it's shorter.)
>
> Attached first patch is an attempt to fix this.  With the patch,
> ipcs now prints a clear errror message instead of outputting the
> entire help text:
>
> $ ./ipcs -a -i 111111
> ipcs: when using an ID, a single resource must be specified
>
> The second patch improves the formatting and wording of the man
> page -- it also mentions that the -a option is not as in POSIX.

Hi Benno,

Both patches look pretty good. I just wonder would .SS make sense for
second level option headers?

diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index fd7d452..7c4f3fd 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -25,7 +25,7 @@ Display a help text and exit.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
-.SH "RESOURCE OPTIONS"
+.SS "RESOURCE OPTIONS"
 .TP
 \fB\-q\fR, \fB\-\-queues\fR
 Write information about active message queues.
@@ -38,7 +38,7 @@ Write information about active semaphore sets.
 .TP
 \fB\-a\fR, \fB\-\-all\fR
 Write information about all three resources (default).
-.SH "OUTPUT FORMATS"
+.SS "OUTPUT FORMATS"
 Of the options
 .BR \-c ,
 .BR \-l ,

Either way, SH or SS,

Reviewed-by: Sami Kerola <kerolasa@iki.fi>

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
