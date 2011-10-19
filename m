Return-Path: dave@gnu.org
Date: Wed, 19 Oct 2011 16:04:11 -0400
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 3/3] prlimit: add manpage documentation
In-reply-to: <20111017151837.GB9767@nb.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1319054651.2170.5.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <1318893793.5289.11.camel@offworld>
 <20111017151837.GB9767@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-10-17 at 17:18 +0200, Karel Zak wrote:
> On Mon, Oct 17, 2011 at 07:23:13PM -0400, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  sys-utils/prlimit.1 |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 83 insertions(+), 0 deletions(-)
> >  create mode 100644 sys-utils/prlimit.1
> > 
> > diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
> > new file mode 100644
> > index 0000000..2f1e666
> > --- /dev/null
> > +++ b/sys-utils/prlimit.1
> > @@ -0,0 +1,83 @@
> > +.\" prlimit.1 --
> > +.\" Copyright 2011 Davidlohr Bueso <dave@gnu.org>
> > +.\" May be distributed under the GNU General Public License
> > +
> > +.TH PRLIMIT 1 "October 2011" "util-linux" "User Commands"
> > +.SH NAME
> > +prlimit \-
> > +get and set a process resource limits.
> > +.SH SYNOPSIS
> > +.B prlimit
> > +.RB [ \--{resource_name}
> > +.IR soft:hard ]
> 
> This synopsis is incorrect. Should be:
> 
>    prlimit [options] [--{resource_name}[=limits]]
> 
> and in the DESCRIPTION should be documented <limits> format. It means
> 
>     <soft>:<hard>
>     <soft>
>     :<hard>
> 
> .. etc.
> 
> > +.SH DESCRIPTION
> > +Given a process id and one or more resources, \fBprlimit\fP tries to retrieve and/or modify it's limits. Below is a complete list of resources.
> > +
> > +.SH GENERAL OPTIONS
> > +.IP "\fB\-p, \-\-pid\fP"
> > +Specify the process id, if none is given, it will use the running process.
> > +.IP "\fB\-o, \-\-output \fIlist\fP"
> > +Define the output columns to use. If no output arrangement is specified, then a default set is used.
> > +Use \fB\-\-help\fP to  get list of all supported columns.
> > +.IP "\fB\-V, \-\-version\fP"
> > +Output version information and exit.
> > +.IP "\fB\-h, \-\-help\fP"
> > +Print a help text and exit.
> > +
> > +.SH RESOURCE OPTIONS
> > +.IP "\fB\-a, \-\-as\fP"
> 
>   .IP "\fB\-a, \-\-as\fP"[=limits]
> 
> [...]
> 
> > +Note that all of these options allow a parameter soft:high to set
> > the soft and high values for the resource's limits. If nothing is
> > passed, then prlimit will only display them. The soft value must be
> > lower or equal to the high value, as this is the maximum value the
> > limit can go to. If one of the values is not passed, then the
> > already existing one will be used. See the examples below.
> 
>  It would be better to have this test in DESCRIPTION.
> 
>  Thanks!
> 
>     Karel

Like with patch 2/3, below is the new patch with corrections. Not
resending the build patch, unless you want me to.

- Davidlohr

>From 55c929758695afea52c4ddf8816b4d76a66fd914 Mon Sep 17 00:00:00 2001
From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 19 Oct 2011 15:59:10 -0400
Subject: [PATCH 2/2] prlimit: add manpage documentation

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.1 |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/prlimit.1

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
new file mode 100644
index 0000000..cc48e88
--- /dev/null
+++ b/sys-utils/prlimit.1
@@ -0,0 +1,99 @@
+.\" prlimit.1 --
+.\" Copyright 2011 Davidlohr Bueso <dave@gnu.org>
+.\" May be distributed under the GNU General Public License
+
+.TH PRLIMIT 1 "October 2011" "util-linux" "User Commands"
+.SH NAME
+prlimit \-
+get and set a process resource limits.
+.SH SYNOPSIS
+.B prlimit
+.RB [options]  [ \--{resource_name}[=limits]]
+
+
+.SH DESCRIPTION
+Given a process id and one or more resources, \fBprlimit\fP tries to retrieve and/or modify the limits.
+
+The limits format is composed by a soft and a hard (ceiling) value, separated by a semicolon (:), in order to modify the existing value(s). If no limits are used, \fBprlimit\fP will only display the current values. If one of the values is not used, then the existing one will be used. To specify the unlimited or infinity limit (RLIM_INFINITY), the -1 or 'unlimited' string can be passed.
+
+Because of the nature of limits, the soft value must be lower or equal to the high limit. To see all the available resource limits, refer to the RESOURCE OPTIONS section. 
+
+
+.IP "\fB<soft>:<hard>\fP  Specify both limits"
+.IP "\fB<soft>:\fP        Specify only the soft limit"
+.IP "\fB:<hard>\fP        Specify only the hard limit"
+.IP "\fB<value>\fP        Specify both soft and hard limits to the same value"
+
+.SH GENERAL OPTIONS
+.IP "\fB\-p, \-\-pid\fP"
+Specify the process id, if none is given, it will use the running process.
+.IP "\fB\-o, \-\-output \fIlist\fP"
+Define the output columns to use. If no output arrangement is specified, then a default set is used.
+Use \fB\-\-help\fP to  get list of all supported columns.
+.IP "\fB\-V, \-\-version\fP"
+Output version information and exit.
+.IP "\fB\-h, \-\-help\fP"
+Print a help text and exit.
+
+.SH RESOURCE OPTIONS
+.IP "\fB\-a, \-\-as\fP[=limits]"
+Address space limit.
+.IP "\fB\-c, \-\-core\fP[=limits]"
+Maximum size of a core file.
+.IP "\fB\-C, \-\-cpu\fP[=limits]"
+CPU time, in seconds.
+.IP "\fB\-d, \-\-data\fP[=limits]"
+Maximum data size.
+.IP "\fB\-f, \-\-fsize\fP[=limits]"
+Maximum file size.
+.IP "\fB\-l, \-\-locks\fP[=limits]"
+Maximum amount of file locks held.
+.IP "\fB\-m, \-\-memlock\fP[=limits]"
+Maximum locked-in-memory address space.
+.IP "\fB\-M, \-\-msgqueue\fP[=limits]"
+Maximum amount of bytes in POSIX message queues.
+.IP "\fB\-n, \-\-nice\fP[=limits]"
+Maximum nice priority allowed to raise.
+.IP "\fB\-N, \-\-nofile\fP[=limits]"
+Maximum amount of open files.
+.IP "\fB\-P, \-\-nproc\fP[=limits]"
+Maximum amount of processes.
+.IP "\fB\-r, \-\-rss\fP[=limits]"
+Maximum Resident Set Size (RSS).
+.IP "\fB\-R, \-\-rtprio\fP[=limits]"
+Maximum real-time priority.
+.IP "\fB\-t, \-\-rttime\fP[=limits]"
+Timeout for real-time tasks.
+.IP "\fB\-s, \-\-sigpending\fP[=limits]"
+Maximum amount of pending signals.
+.IP "\fB\-S, \-\-stack\fP[=limits]"
+Maximum size of the stack.
+
+
+.RE
+.SH EXAMPLES
+.IP "\fBprlimit \-\-pid 13134\fP"
+Display limit values for all current resources.
+.IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
+Display the limits of the RSS and set the soft and hard limits for the amount of open files to 1024 and 4095, respectively.
+.IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
+Modify only the soft limit for the amount of processes.
+.IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
+Set the amount of processes for both soft and ceiling values to unlimited.
+
+.SH "SEE ALSO"
+.BR prlimit (2),
+.BR ulimit (1)
+
+.SH NOTES
+.nf
+The prlimit system call is supported since Linux 2.6.36, previous kernels will break this program.
+.fi
+
+.SH AUTHORS
+.nf
+Davidlohr Bueso <dave@gnu.org> - In memory of Dennis M. Ritchie.
+.fi
+.SH AVAILABILITY
+The prlimit command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.7
