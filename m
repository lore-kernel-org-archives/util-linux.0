Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265Ab1JQPSl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Oct 2011 11:18:41 -0400
Date: Mon, 17 Oct 2011 17:18:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] prlimit: add manpage documentation
Message-ID: <20111017151837.GB9767@nb.net.home>
References: <1318893793.5289.11.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318893793.5289.11.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 17, 2011 at 07:23:13PM -0400, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  sys-utils/prlimit.1 |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 83 insertions(+), 0 deletions(-)
>  create mode 100644 sys-utils/prlimit.1
> 
> diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
> new file mode 100644
> index 0000000..2f1e666
> --- /dev/null
> +++ b/sys-utils/prlimit.1
> @@ -0,0 +1,83 @@
> +.\" prlimit.1 --
> +.\" Copyright 2011 Davidlohr Bueso <dave@gnu.org>
> +.\" May be distributed under the GNU General Public License
> +
> +.TH PRLIMIT 1 "October 2011" "util-linux" "User Commands"
> +.SH NAME
> +prlimit \-
> +get and set a process resource limits.
> +.SH SYNOPSIS
> +.B prlimit
> +.RB [ \--{resource_name}
> +.IR soft:hard ]

This synopsis is incorrect. Should be:

   prlimit [options] [--{resource_name}[=limits]]

and in the DESCRIPTION should be documented <limits> format. It means

    <soft>:<hard>
    <soft>
    :<hard>

.. etc.

> +.SH DESCRIPTION
> +Given a process id and one or more resources, \fBprlimit\fP tries to retrieve and/or modify it's limits. Below is a complete list of resources.
> +
> +.SH GENERAL OPTIONS
> +.IP "\fB\-p, \-\-pid\fP"
> +Specify the process id, if none is given, it will use the running process.
> +.IP "\fB\-o, \-\-output \fIlist\fP"
> +Define the output columns to use. If no output arrangement is specified, then a default set is used.
> +Use \fB\-\-help\fP to  get list of all supported columns.
> +.IP "\fB\-V, \-\-version\fP"
> +Output version information and exit.
> +.IP "\fB\-h, \-\-help\fP"
> +Print a help text and exit.
> +
> +.SH RESOURCE OPTIONS
> +.IP "\fB\-a, \-\-as\fP"

  .IP "\fB\-a, \-\-as\fP"[=limits]

[...]

> +Note that all of these options allow a parameter soft:high to set
> the soft and high values for the resource's limits. If nothing is
> passed, then prlimit will only display them. The soft value must be
> lower or equal to the high value, as this is the maximum value the
> limit can go to. If one of the values is not passed, then the
> already existing one will be used. See the examples below.

 It would be better to have this test in DESCRIPTION.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
