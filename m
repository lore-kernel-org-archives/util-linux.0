Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61288 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbdDCBN1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 2 Apr 2017 21:13:27 -0400
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170402081436.861-1-kerolasa@iki.fi>
 <20170402081436.861-3-kerolasa@iki.fi>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
Date: Sun, 2 Apr 2017 21:13:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170402081436.861-3-kerolasa@iki.fi>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 04/02/2017 04:14 AM, Sami Kerola wrote:
> Without this change an attempt to remove hostname printing required following
> rather clumsy agetty invocation.
> 
>   /sbin/agetty --nohostname --login-options '/bin/login -H -- \u'
> 
> After the change --nohostname behaves similar way with --host option, that
> is when combined with --remote the effect is passed to login(1).
> 
> In same go improve manual page a little bit.  This includes small mistake in
> commit 01095ae33c that claimed option -r is added to command line when
> passing hostname login while it should have been -h.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/agetty.8 | 27 +++++++++++++++++----------
>  term-utils/agetty.c |  9 ++++++---
>  2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
> index 40be8b46c..bdb1a7d35 100644
> --- a/term-utils/agetty.8
> +++ b/term-utils/agetty.8
> @@ -90,18 +90,22 @@ Assume that the tty is 8-bit clean, hence disable parity detection.
>  .TP
>  \-a, \-\-autologin \fIusername\fP
>  Log the specified user automatically in without asking for a login name and

Hey Sami, since you're here you might want to fix this too?

Log in the specified user automatically without asking for a name and
 OR
Automatically log in the specified user without asking for a name and

I think the second is better.

> -password.  The \-f \fIusername\fP option is added to the \fB/bin/login\fP
> -command line by default.  The \-\-login\-options option changes this default
> -behavior and then only \\u is replaced by the \fIusername\fP and no other
> -option is added to the login command line.
> +password.  The \-f \fIusername\fP option and argument are added to the

The \-f should be bold.

> +\fB/bin/login\fP command line by default.  The \-\-login\-options option

That reads a bit awkward (and it's not in bold), how about just:

.RB Using \ \-\-login\-options

> +changes this default behavior and then only \\u is replaced by the
> +\fIusername\fP and no other option is added to the login command line.
>  .TP
>  \-c, \-\-noreset
>  Don't reset terminal cflags (control modes).  See \fBtermios\fP(3) for more
>  details.
>  .TP
>  \-E, \-\-remote
> -If an \fB\-H\fP \fIfakehost\fP option is given, then an \fB\-r\fP
> -\fIfakehost\fP option is added to the \fB/bin/login\fP command line.
> +If an \fB\-\-host\fP \fIfakehost\fP option is given, then an \fB\-h\fP

If a \fB\-\-host\fP

> +\fIfakehost\fP option and argument are added to the \fB/bin/login\fP
> +command line.
> +.IP
> +If an \fB\-\-nohost\fR option is given, then an \fB\-H\fP option

If a \fB\-\-nohost\fR

Actually, they all should be using 'the'. Although it is common for
util-linux man-pages' to use the a/an indefinite article for command and
option names; they are specific nouns that require using the definite
article 'the'.

https://owl.english.purdue.edu/owl/resource/540/01/

> +is added to the \fB/bin/login\fP command line.
>  .TP
>  \-f, \-\-issue\-file \fIissue_file\fP
>  Display the contents of \fIissue_file\fP instead of \fI/etc/issue\fP.
> @@ -184,9 +188,11 @@ Do not print a newline before writing out /etc/issue.
>  .TP
>  \-o, \-\-login\-options "\fIlogin_options\fP"
>  Options  that  are passed to the login program.  \\u is replaced
> -by the login name.  The default \fB/bin/login\fP command line
> -is "/bin/login -- <username>".
> -
> +by the login name.  The default login options string is
> +"/bin/login -- \\u".

by the login name.  The default login command is
.BR "/bin/login -- \\u" .

> +.IP
> +See also \fB\-\-autologin\fR and \fB\-\-remote\fR options.

Also see the \fB\-\-autologin\fR and \fB\-\-remote\fR options.

> +.IP
>  Please read the SECURITY NOTICE below if you want to use this.

Please read the SECURITY NOTICE below before using this option.

>  .TP
>  \-p, \-\-login\-pause
> @@ -217,7 +223,8 @@ Note that this has no support for any Unicode characters.
>  \-w, \-\-wait\-cr
>  Wait for the user or the modem to send a carriage-return or a
>  linefeed character before sending the \fI/etc/issue\fP (or other) file
> -and the login prompt.  Very useful in connection with the \-I option.
> +and the login prompt.  Very useful in connection with the \-\-init\-string

This is useful with the \-\-init\-string

> +option.
>  .TP
>  \-\-nohints
>  Do not print hints about Num, Caps and Scroll Locks.
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 6a2085a3c..93a3843c7 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -493,9 +493,12 @@ int main(int argc, char **argv)
>  		login_options_to_argv(login_argv, &login_argc,
>  				      options.logopt, username);
>  	} else {
> -		if (fakehost && (options.flags & F_REMOTE)) {
> -			login_argv[login_argc++] = "-h";
> -			login_argv[login_argc++] = fakehost;
> +		if (options.flags & F_REMOTE) {
> +			if (fakehost) {
> +				login_argv[login_argc++] = "-h";
> +				login_argv[login_argc++] = fakehost;
> +			} else if (options.flags & F_NOHOSTNAME)
> +				login_argv[login_argc++] = "-H";
>  		}
>  		if (username) {
>  			if (options.autolog)
> 
