Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab2DCNRw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Apr 2012 09:17:52 -0400
Date: Tue, 3 Apr 2012 15:03:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/20] uuidd: implement --socket-activation option
Message-ID: <20120403130319.GH1084@x2.net.home>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-8-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333039528-24784-8-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2012 at 06:45:15PM +0200, Petr Uzel wrote:
> Implement --socket-activatoin option, which is supposed to be used
> with systemd (or equivalent init system) socket activation mechanism.
> With this option, the UUID daemon does not create the socket on its own,
> but instead expect the connection fd to be provided by the calling
> process.
> 
> This option is only available if util-linux is configured with
> --enable-uuidd-socket-activation option. With this configure
> option, the uuidd is compiled with sd-daemon.c.
> 
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  configure.ac           |   12 +
>  misc-utils/Makefile.am |    6 +
>  misc-utils/sd-daemon.c |  530 ++++++++++++++++++++++++++++++++++++++++++++++++
>  misc-utils/sd-daemon.h |  282 +++++++++++++++++++++++++
>  misc-utils/uuidd.8     |    6 +
>  misc-utils/uuidd.c     |   89 ++++++--
>  6 files changed, 903 insertions(+), 22 deletions(-)
>  create mode 100644 misc-utils/sd-daemon.c
>  create mode 100644 misc-utils/sd-daemon.h
> 
> diff --git a/configure.ac b/configure.ac
> index 2140bc5..bb56948 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1101,6 +1101,18 @@ if test "x$enable_login_chown_vcs" = xyes; then
>  fi
>  
>  
> +AC_ARG_ENABLE([uuidd-socket-activation],
> +  AS_HELP_STRING([--enable-uuidd-socket-activation], [build uuidd with support for systemd socket activation]),
> +  [], enable_uuidd_socket_activation=no
> +)

 What about --enable-socket-activation (without -uuidd-)?

 If you have distro with systemd then all your stuff should compatible
 with the initd (it's detail that currently we have one daemon only).

> +AM_CONDITIONAL(UUIDD_SOCKET_ACTIVATION, test "x$enable_uuidd_socket_activation" = xyes)

 USE_SOCKET_ACTIVATION

> +if test "x$enable_uuidd_socket_activation" = xyes; then
> +  AC_DEFINE(UUIDD_SOCKET_ACTIVATION, 1, [Should uuidd support socket activation?])

 USE_SOCKET_ACTIVATION

 [...]

>  static void server_loop(const char *socket_path, const char *pidfile_path,
> -			int debug, int timeout, int quiet, int no_fork)
> +			int debug, int timeout, int quiet, int no_fork,
> +			int no_sock)

 hmm... pretty long argument lists :-)

 Maybe use struct uuidd_cxt with bit array for all the arguments. If
 yes, then use a separate patch for this change.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
