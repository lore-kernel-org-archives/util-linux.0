Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911AbbCRLNR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Mar 2015 07:13:17 -0400
Date: Wed, 18 Mar 2015 12:13:13 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?J=F6rg?= Thalheim <joerg@higgsboson.tk>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] nsenter: add support for pty
Message-ID: <20150318111313.GC28925@ws.net.home>
References: <20150318105319.2c6bab99@turingmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150318105319.2c6bab99@turingmachine>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On Wed, Mar 18, 2015 at 10:53:19AM +0100, Jörg Thalheim wrote:
> If mount namespaces are used, the issued command, will not have access to the
> tty device attached to its stdin/stdout/stderr. This patch adds an option to
> allocate a new pseudo tty in the entered mount namespace and bridge between the
> origin standard file descriptors and the standard file descriptors of the
> executed command.

The original nsenter(1) purpose is to have command line interface to
setns(2) syscall. Your patch is trying to push us to something more
complex. Not sure if we really want it. Eric, any comment?


Wouldn't be possible to use (or implement) on nsenter(1) independent
command to create a bridge between ttys? Something like:

 nsenter --mount ttybridge <command>

(maybe socat(1) is able to create a bridge, not sure)

Do you have any use-case? I'd like to try it.

    Karel

>  sys-utils/nsenter.1 |   6 ++
>  sys-utils/nsenter.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 202 insertions(+), 7 deletions(-)
> 
> diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
> index 8a3b25e..15218cb 100644
> --- a/sys-utils/nsenter.1
> +++ b/sys-utils/nsenter.1
> @@ -140,6 +140,12 @@ always sets UID for user namespaces, the default is 0.
>  Don't modify UID and GID when enter user namespace. The default is to
>  drops supplementary groups and sets GID and UID to 0.
>  .TP
> +\fB\-P\fR, \fB\-\-pty\fR\fR
> +Allocate a pseudo-tty and attach the standart input/output of the command.  This
> +option can be used for interactive programs, which requires access to its tty
> +device, if mount namespaces are in use. If this option is set, nsenter will always
> +fork, before execu'ing the command.
> +.TP
>  \fB\-r\fR, \fB\-\-root\fR[=\fIdirectory\fR]
>  Set the root directory.  If no directory is specified, set the root directory to
>  the root directory of the target process.  If directory is specified, set the
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index b029f80..c6e899b 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c
> @@ -2,6 +2,7 @@
>   * nsenter(1) - command-line interface for setns(2)
>   *
>   * Copyright (C) 2012-2013 Eric Biederman <ebiederm@xmission.com>
> + * Copyright (C) 2015 Jörg Thalheim <joerg@higgsboson.tk>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
> @@ -28,6 +29,9 @@
>  #include <assert.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> +#include <sys/ioctl.h>
> +#include <sys/select.h>
> +#include <term.h>
>  #include <grp.h>
>  
>  #include "strutils.h"
> @@ -79,6 +83,7 @@ static void usage(int status)
>  	fputs(_(" -S, --setuid <uid>     set uid in entered namespace\n"), out);
>  	fputs(_(" -G, --setgid <gid>     set gid in entered namespace\n"), out);
>  	fputs(_("     --preserve-credentials do not touch uids or gids\n"), out);
> +	fputs(_(" -P, --pty              allocate a pseudo-TTY (this implies forking)\n"), out);
>  	fputs(_(" -r, --root[=<dir>]     set the root directory\n"), out);
>  	fputs(_(" -w, --wd[=<dir>]       set the working directory\n"), out);
>  	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"), out);
> @@ -94,6 +99,8 @@ static void usage(int status)
>  static pid_t namespace_target_pid = 0;
>  static int root_fd = -1;
>  static int wd_fd = -1;
> +static struct termios stdin_termios, stdout_termios;
> +static int tty_master_fd;
>  
>  static void open_target_fd(int *fd, const char *type, const char *path)
>  {
> @@ -132,20 +139,198 @@ static void open_namespace_fd(int nstype, const char *path)
>  	assert(nsfile->nstype);
>  }
>  
> -static void continue_as_child(void)
> +static void resize_on_signal(int signo __attribute__((__unused__)))
>  {
> -	pid_t child = fork();
> +	struct winsize winsize;
> +
> +	if (ioctl(STDIN_FILENO, TIOCGWINSZ, &winsize) != -1)
> +		ioctl(tty_master_fd, TIOCSWINSZ, &winsize);
> +}
> +
> +static void restore_stdin(void)
> +{
> +	if (tcsetattr(STDIN_FILENO, TCSANOW, &stdin_termios) == -1)
> +		errx(EXIT_FAILURE,
> +				_("failed to restore stdin terminal attributes"));
> +}
> +
> +static void restore_stdout(void)
> +{
> +	if (tcsetattr(STDOUT_FILENO, TCSANOW, &stdout_termios) == -1)
> +		errx(EXIT_FAILURE,
> +				_("failed to restore stdout terminal attributes"));
> +}
> +
> +
> +static int set_tty_raw(int fd, struct termios *origin_attr)
> +{
> +	struct termios attr[1];
> +
> +	if (tcgetattr(fd, attr) == -1)
> +		return -1;
> +
> +	memcpy(origin_attr, attr, sizeof(struct termios));
> +
> +	cfmakeraw(attr);
> +
> +	return tcsetattr(fd, TCSANOW, attr);
> +}
> +
> +static void shovel_tty(int master_fd, int in_fd) {
> +	fd_set read_fds[1];
> +	int max_fd;
> +	char buf[BUFSIZ];
> +	ssize_t bytes;
> +	int n;
> +	while (master_fd != -1) {
> +
> +		FD_ZERO(read_fds);
> +
> +		if (in_fd != -1)
> +			FD_SET(in_fd, read_fds);
> +
> +		if (master_fd != -1)
> +			FD_SET(master_fd, read_fds);
> +
> +		max_fd = (master_fd > in_fd) ? master_fd : in_fd;
> +
> +		if ((n = select(max_fd + 1, read_fds, NULL, NULL, NULL)) == -1 && errno != EINTR)
> +			break;
> +
> +		if (n == -1 && errno == EINTR)
> +			continue;
> +
> +		if (in_fd != -1 && FD_ISSET(in_fd, read_fds)) {
> +			if ((bytes = read(in_fd, buf, BUFSIZ)) > 0) {
> +				if (master_fd != -1 && write(master_fd, buf, bytes) == -1)
> +					break;
> +			} else if (n == -1 && errno == EINTR) {
> +				continue;
> +			} else {
> +				in_fd = -1;
> +				continue;
> +			}
> +		}
> +
> +		if (master_fd != -1 && FD_ISSET(master_fd, read_fds)) {
> +			if ((bytes = read(master_fd, buf, BUFSIZ)) > 0) {
> +				if (write(STDOUT_FILENO, buf, bytes) == -1)
> +					break;
> +			} else if (n == -1 && errno == EINTR) {
> +				continue;
> +			} else {
> +				close(master_fd);
> +				master_fd = -1;
> +				continue;
> +			}
> +		}
> +	}
> +}
> +
> +static void setup_pty_parent(int master_fd)
> +{
> +	struct sigaction sa;
> +	struct winsize ws;
> +
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_flags = 0;
> +	sa.sa_handler = resize_on_signal;
> +	sigaction(SIGWINCH, &sa, NULL);
> +
> +	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) >= 0)
> +		(void) ioctl(master_fd, TIOCSWINSZ, &ws);
> +
> +	if (set_tty_raw(STDIN_FILENO, &stdin_termios) != -1) {
> +		atexit((void (*)(void))restore_stdin);
> +	}
> +
> +	if (set_tty_raw(STDOUT_FILENO, &stdout_termios) != -1) {
> +		atexit((void (*)(void))restore_stdout);
> +	}
> +}
> +
> +static int setup_pty_child(int master_fd)
> +{
> +	pid_t pid;
> +	int slave_fd;
> +
> +	char* slave_name = ptsname(master_fd);
> +	if (slave_name == NULL)
> +		return -errno;
> +
> +	slave_fd = open(slave_name, O_RDWR | O_NOCTTY | O_CLOEXEC);
> +	if (slave_fd < -1)
> +		return -errno;
> +
> +	pid = setsid();
> +	if (pid < 0 && errno != EPERM)
> +		return -errno;
> +
> +	if (ioctl(slave_fd, TIOCSCTTY, 0) < 0)
> +		return -errno;
> +
> +	if (dup2(slave_fd, STDIN_FILENO) != STDIN_FILENO ||
> +			dup2(slave_fd, STDOUT_FILENO) != STDOUT_FILENO ||
> +			dup2(slave_fd, STDERR_FILENO) != STDERR_FILENO)
> +		return -errno;
> +
> +	/*only close, if slave_fd is not std-fd*/
> +	if (slave_fd > 2)
> +		close(slave_fd);
> +
> +	return 0;
> +}
> +
> +static int new_pty(void)
> +{
> +	int fd = posix_openpt(O_RDWR | O_NOCTTY);
> +
> +	if (fd < 0)
> +		return -errno;
> +
> +	if (grantpt(fd) < 0)
> +		return -errno;
> +
> +	if (unlockpt(fd) < 0)
> +		return -errno;
> +
> +	return fd;
> +}
> +
> +static void continue_as_child(bool open_pty)
> +{
> +	pid_t child;
>  	int status;
>  	pid_t ret;
> +	int master_fd = -1;
> +
> +	if (open_pty) {
> +		master_fd = new_pty();
> +		if (master_fd < 0)
> +			err(EXIT_FAILURE, _("open pseudo tty failed"));
> +	}
> +
> +	child = fork();
>  
>  	if (child < 0)
>  		err(EXIT_FAILURE, _("fork failed"));
>  
>  	/* Only the child returns */
> -	if (child == 0)
> +	if (child == 0) {
> +		if (open_pty && setup_pty_child(master_fd) < 0)
> +			err(EXIT_FAILURE, _("failed to setup slave of pseudo tty"));
> +		close(master_fd);
>  		return;
> +	}
> +
> +	if (open_pty) {
> +		tty_master_fd = master_fd;
> +		setup_pty_parent(master_fd);
> +	}
>  
>  	for (;;) {
> +		if (open_pty)
> +			shovel_tty(master_fd, STDIN_FILENO);
>  		ret = waitpid(child, &status, WUNTRACED);
>  		if ((ret == child) && (WIFSTOPPED(status))) {
>  			/* The child suspended so suspend us as well */
> @@ -171,6 +356,7 @@ int main(int argc, char *argv[])
>  	};
>  	static const struct option longopts[] = {
>  		{ "help", no_argument, NULL, 'h' },
> +		{ "pty", no_argument, NULL, 'P' },
>  		{ "version", no_argument, NULL, 'V'},
>  		{ "target", required_argument, NULL, 't' },
>  		{ "mount", optional_argument, NULL, 'm' },
> @@ -190,7 +376,7 @@ int main(int argc, char *argv[])
>  
>  	struct namespace_file *nsfile;
>  	int c, namespaces = 0, setgroups_nerrs = 0, preserve_cred = 0;
> -	bool do_rd = false, do_wd = false, force_uid = false, force_gid = false;
> +	bool do_rd = false, do_wd = false, force_uid = false, force_gid = false, open_pty = false;
>  	int do_fork = -1; /* unknown yet */
>  	uid_t uid = 0;
>  	gid_t gid = 0;
> @@ -201,7 +387,7 @@ int main(int argc, char *argv[])
>  	atexit(close_stdout);
>  
>  	while ((c =
> -		getopt_long(argc, argv, "+hVt:m::u::i::n::p::U::S:G:r::w::F",
> +		getopt_long(argc, argv, "+hPVt:m::u::i::n::p::U::S:G:r::w::F",
>  			    longopts, NULL)) != -1) {
>  		switch (c) {
>  		case 'h':
> @@ -243,6 +429,9 @@ int main(int argc, char *argv[])
>  			else
>  				namespaces |= CLONE_NEWPID;
>  			break;
> +		case 'P':
> +			open_pty = true;
> +			break;
>  		case 'U':
>  			if (optarg)
>  				open_namespace_fd(CLONE_NEWUSER, optarg);
> @@ -358,8 +547,8 @@ int main(int argc, char *argv[])
>  		wd_fd = -1;
>  	}
>  
> -	if (do_fork == 1)
> -		continue_as_child();
> +	if (do_fork == 1 || open_pty)
> +		continue_as_child(open_pty);
>  
>  	if (force_uid || force_gid) {
>  		if (force_gid && setgroups(0, NULL) != 0 && setgroups_nerrs)	/* drop supplementary groups */
> -- 
> 2.3.3



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
