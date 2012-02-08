Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12854 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab2BHQWg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Feb 2012 11:22:36 -0500
Date: Wed, 8 Feb 2012 17:22:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Frank Mayhar <fmayhar@google.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] fsck: Add support for "completion" scripts.
Message-ID: <20120208162231.GA19725@x2.net.home>
References: <1328649055.11787.31.camel@peace.lax.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328649055.11787.31.camel@peace.lax.corp.google.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 07, 2012 at 01:10:55PM -0800, Frank Mayhar wrote:
> Add support for scripts that are run when each individual fsck
> completes.  This allows certain general or file- or device-specific
> actions to be taken when each fsck finishes.
> 
> Signed-off-by: Frank Mayhar <fmayhar@google.com>
> 
>  fsck/fsck.8 |   60
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fsck/fsck.c |   62
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fsck/fsck.h |    4 ++-
>  3 files changed, 125 insertions(+), 1 deletions(-)
> 
> diff --git a/fsck/fsck.8 b/fsck/fsck.8
> index d56b0d7..7e5b55b 100644
> --- a/fsck/fsck.8
> +++ b/fsck/fsck.8
> @@ -413,6 +413,60 @@ and
>  do not support the
>  .B -y
>  option as of this writing.
> +.SH COMPLETION SCRIPTS
> +.B fsck
> +has a mechanism available by which to run a script when each check
> completes.
> +If when
> +.B fsck
> +starts the directory
> +.IR /etc/fsck.d
> +(or see FSCK_COMPLETION_PATH below) exists and is readable,
> +.B fsck
> +will use it to find such scripts.  Scripts there must be named one of
> +.IR /etc/fsck.d/device/name ", " /etc/fsck.d/fstype/name ,

 The problem is that "device name" is whatever from fsck command line
 or from first fstab column.

 Unfortunately the current fsck code does not canonicalize the device
 name -- this is bug because in the function ignore() we stat() the
 device... I'll fix this problem ASAP.

 Maybe it would be better to somehow standardize the names used for
 fsck-log and the completion scripts.

 What about to use

    /etc/fsck.d/uuid/<uuid>
    /var/log/fsck/fsck-<uuid>

 rather than devname? I guess that all usable filesystems provides
 UUIDs now and fsck is already linked with libblkid.

 If you agree than ignore this problem for now, I'll implement it.

> +.I system(3)

 Why we need to execute the scripts by system(3)? Why not classic execv?

> +function, passing the following set of parameters on the command line:
> +.br
> +\	device\	\-\ Device path of the device checked
> +.br
> +\	type\	\	\-\ File system type
> +.br
> +\	status\	\-\ Exit status
> +.br
> +\	elapsed\	\-\ Elapsed wall-clock time
> +.br
> +\	utime\	\-\ User CPU time
> +.br
> +\	stime\	\-\ System CPU time
> +.br
> +\	maxrss\	\-\ Maximum run-set-size
> +.br
> +\	logpath\	\-\ Path to logfile if the \-L option was specified
> +.PP
> +For example:
> +.br
> +  /etc/fsck.d/device/hdc1 /dev/hdc1 ext4 0 1.60470 0.41193 0.76588 9828

 I don't like the fixed set of parameters, it will be difficult to extend
 such solution in the future.

 What about to set environment variables FSCK_{DEVICE,FSTYPE,UTIME,...}
 for the script or use regular command line options, so:

    /etc/fsck.d/completion --device=/dev/hda1 --fstype=ext4 ...


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
