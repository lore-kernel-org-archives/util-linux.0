Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385117166F
	for <util-linux@vger.kernel.org>; Wed, 17 Apr 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375246; cv=none; b=BgEMPqdpWurjqUo3wXxYCW24ig45gUCObfDD9FaqX+8SHhOGJS48lcPfegpwMWVpdzHfKF2IKvqpRH+F/lp6bcGXikLNignUzK1xy4bZ5d0ODxp/HCfhBpC6EjFVDUy5JEhIicgxrcbp0jZfa9GGwS8N182dT+dOpp4tUURNibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375246; c=relaxed/simple;
	bh=mTa7LnxLXJVdkPwy+6pXm1OTZu6WKLnF8sujdf1b3pY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dAixNt0u3NEXeOcJ0IORVm1sZOiDmraRp2aEB9UhT9gaPrUWyFhepXmUe5bBmlnewOl5n8RPYOmRHCCSHRD9yz5EEL8j2eUayvnM7DSLTTEkM+iRGV5rvU3bcHZXoW6ZopYkD9MNMrzUJL39HhvaHR0DTqzjH26lVgGVwEq1gVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtJQNhoJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtJQNhoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713375242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLW9u1vV9X8xjGYiFh/I4ziO/GRnn1sDeNrNqxpxfNQ=;
	b=OtJQNhoJTB5KbQNuNuyrvOQ3rGLtPVGHQQgaz6HaNJLSiz7MdxVDq2WfsmSsTJ/l71z+eV
	Kw4FCrmgSn1PSZWPeqAML7RYr33m/DOVuMHvTlwH3S5euWV68TuBD2/hp/VkNntlZ1RvYR
	APgdZrFnjFROrQDyUOpYwdte2eSYKEQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-A8Z_t2KROMWj8-G5tA60tQ-1; Wed,
 17 Apr 2024 13:33:57 -0400
X-MC-Unique: A8Z_t2KROMWj8-G5tA60tQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6B903830083;
	Wed, 17 Apr 2024 17:33:56 +0000 (UTC)
Received: from localhost (unknown [10.64.240.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C85E420128EF;
	Wed, 17 Apr 2024 17:33:55 +0000 (UTC)
Date: Thu, 18 Apr 2024 02:33:54 +0900 (JST)
Message-Id: <20240418.023354.1867217317145795622.yamato@redhat.com>
To: rasmus.villemoes@prevas.dk
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: [PATCH] flock: add support for using fcntl() with open file
 description locks
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
References: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

> Currently, there is no way for shell scripts to safely access
> resources protected by POSIX locking (fcntl with the F_SETLK/F_SETLKW
> commands). For example, the glibc function lckpwdf(), used to
> protect access to the /etc/shadow database, works by taking a
> F_SETLKW on /etc/.pwd.lock .
> 
> Due to the odd semantics of POSIX locking (e.g. released when any file
> descriptor associated to the inode is closed), we cannot usefully
> directly expose the POSIX F_SETLK/F_SETLKW commands. However, linux
> 3.15 introduced F_OFD_SETLK[W], with semantics wrt. ownership and
> release better matching those of flock(2), and crucially they do
> conflict with locks obtained via F_SETLK[W]. With this, a shell script
> can do
> 
>   exec 4> /etc/.pwd.lock
>   flock --fcntl-ofd 4
>   <access/modify /etc/shadow ...>
>   flock --fcntl-ofd --unlock 4 # or just exit
> 
> without conflicting with passwd(1) or other utilities that
> access/modify /etc/shadow.
> 
> The option name is a bit verbose, and no single-letter shorthand is
> defined, because this is somewhat low-level and the user really needs
> to know what he is doing.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 
> ---
> 
> Both my autotools and meson fu are weak to non-existing, so I don't
> know if I've written the "test if the header exposes this macro"
> correctly.
> 
> I'm not at all married to the option name. I also considered just
> making it --fcntl, with the possiblity of making that grow an optional
> argument (for example --fcntl=posix with plain --fcntl being an alias
> for --fcntl=ofd) should anyone ever figure out a use for the plain
> F_SETLK, perhaps just for testing.
> 
> 
>  configure.ac      |  6 +++++
>  meson.build       |  3 +++
>  sys-utils/flock.c | 60 +++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 67 insertions(+), 2 deletions(-)

You may have to update sys-utils/flock.1.adoc and the completion rule bash-completion/flock
when adding a new optoin.

> diff --git a/configure.ac b/configure.ac
> index c302732e7..441b09440 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -434,6 +434,12 @@ AC_CHECK_DECLS([PR_REP_CAPACITY], [], [], [
>  	#include <linux/pr.h>
>  ])
>  
> +AC_CHECK_DECL([F_OFD_SETLK],
> +	[AC_DEFINE([HAVE_FCNTL_OFD_LOCKS], [1],
> +	[Define to 1 if fcntl.h defines F_OFD_ constants])], [], [
> +#include <fcntl.h>
> +])
> +
>  AC_CHECK_HEADERS([security/openpam.h], [], [], [
>  #ifdef HAVE_SECURITY_PAM_APPL_H
>  #include <security/pam_appl.h>
> diff --git a/meson.build b/meson.build
> index 99126f7aa..004c849f1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -704,6 +704,9 @@ conf.set('HAVE_DECL_BLK_ZONE_REP_CAPACITY', have ? 1 : false)
>  have = cc.has_header_symbol('linux/pr.h', 'PR_REP_CAPACITY')
>  conf.set('HAVE_DECL_PR_REP_CAPACITY', have ? 1 : false)
>  
> +have = cc.has_header_symbol('fcntl.h', 'F_OFD_SETLK', args: '-D_GNU_SOURCE')
> +conf.set('HAVE_FCNTL_OFD_LOCKS', have ? 1 : false)
> +
>  code = '''
>  #include <time.h>
>  #if !@0@
> diff --git a/sys-utils/flock.c b/sys-utils/flock.c
> index 7d878ff81..40751517d 100644
> --- a/sys-utils/flock.c
> +++ b/sys-utils/flock.c
> @@ -70,6 +70,9 @@ static void __attribute__((__noreturn__)) usage(void)
>  	fputs(_(  " -o, --close              close file descriptor before running command\n"), stdout);
>  	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stdout);
>  	fputs(_(  " -F, --no-fork            execute command without forking\n"), stdout);
> +#ifdef HAVE_FCNTL_OFD_LOCKS
> +	fputs(_(  "     --fcntl-ofd          use fcntl(F_OFD_SETLK) rather than flock()\n"), stdout);
> +#endif
>  	fputs(_(  "     --verbose            increase verbosity\n"), stdout);
>  	fputs(USAGE_SEPARATOR, stdout);
>  	fprintf(stdout, USAGE_HELP_OPTIONS(26));
> @@ -126,6 +129,38 @@ static void __attribute__((__noreturn__)) run_program(char **cmd_argv)
>  	_exit((errno == ENOMEM) ? EX_OSERR : EX_UNAVAILABLE);
>  }
>  
> +static int flock_to_fcntl_type(int op)
> +{
> +        switch (op) {
> +                case LOCK_EX:
> +                        return F_WRLCK;
> +                case LOCK_SH:
> +                        return F_RDLCK;
> +                case LOCK_UN:
> +                        return F_UNLCK;
> +                default:
> +			errx(EX_SOFTWARE, _("internal error, unknown operation %d"), op);
> +        }
> +}

Don't you need wrap flock_to_fcntl_type with #ifdef HAVE_FCNTL_OFD_LOCKS/#endif?

> +static int do_fcntl_lock(int fd, int op, int block)
> +{
> +#ifdef HAVE_FCNTL_OFD_LOCKS
> +	struct flock arg = {
> +		.l_type = flock_to_fcntl_type(op),
> +		.l_whence = SEEK_SET,
> +		.l_start = 0,
> +		.l_len = 0,
> +	};
> +	int cmd = (block == LOCK_NB) ? F_OFD_SETLK : F_OFD_SETLKW;
> +	return fcntl(fd, cmd, &arg);
> +#else
> +	/* Should never happen, nothing can ever set use_fcntl_ofd when !HAVE_FCNTL_OFD_LOCKS. */
> +	errno = ENOSYS;
> +	return -1;
> +#endif
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	struct ul_timer timer;
> @@ -140,6 +175,7 @@ int main(int argc, char *argv[])
>  	int no_fork = 0;
>  	int status;
>  	int verbose = 0;
> +	int use_fcntl_ofd = 0;
>  	struct timeval time_start = { 0 }, time_done = { 0 };
>  	/*
>  	 * The default exit code for lock conflict or timeout
> @@ -149,7 +185,8 @@ int main(int argc, char *argv[])
>  	char **cmd_argv = NULL, *sh_c_argv[4];
>  	const char *filename = NULL;
>  	enum {
> -		OPT_VERBOSE = CHAR_MAX + 1
> +		OPT_VERBOSE = CHAR_MAX + 1,
> +		OPT_FCNTL_OFD,
>  	};
>  	static const struct option long_options[] = {
>  		{"shared", no_argument, NULL, 's'},
> @@ -163,6 +200,7 @@ int main(int argc, char *argv[])
>  		{"close", no_argument, NULL, 'o'},
>  		{"no-fork", no_argument, NULL, 'F'},
>  		{"verbose", no_argument, NULL, OPT_VERBOSE},
> +		{"fcntl-ofd", no_argument, NULL, OPT_FCNTL_OFD},
>  		{"help", no_argument, NULL, 'h'},
>  		{"version", no_argument, NULL, 'V'},
>  		{NULL, 0, NULL, 0}
> @@ -217,6 +255,11 @@ int main(int argc, char *argv[])
>  			if (conflict_exit_code < 0 || conflict_exit_code > 255)
>  				errx(EX_USAGE, _("exit code out of range (expected 0 to 255)"));
>  			break;
> +#ifdef HAVE_FCNTL_OFD_LOCKS
> +		case OPT_FCNTL_OFD:
> +			use_fcntl_ofd = 1;
> +			break;
> +#endif
>  		case OPT_VERBOSE:
>  			verbose = 1;
>  			break;
> @@ -234,6 +277,13 @@ int main(int argc, char *argv[])
>  		errx(EX_USAGE,
>  			_("the --no-fork and --close options are incompatible"));
>  
> +	/*
> +	 * For fcntl(F_OFD_SETLK), an exclusive lock requires that the
> +	 * file is open for write.
> +	 */
> +	if (use_fcntl_ofd && type == LOCK_EX)
> +		open_flags = O_WRONLY;
> +
>  	if (argc > optind + 1) {
>  		/* Run command */
>  		if (!strcmp(argv[optind + 1], "-c") ||
> @@ -280,9 +330,15 @@ int main(int argc, char *argv[])
>  
>  	if (verbose)
>  		gettime_monotonic(&time_start);
> -	while (flock(fd, type | block)) {
> +	while (use_fcntl_ofd ? do_fcntl_lock(fd, type, block) : flock(fd, type | block)) {
>  		switch (errno) {
>  		case EWOULDBLOCK:
> +			/*
> +			 * Per the man page, for fcntl(), EACCES may
> +			 * be returned and means the same as
> +			 * EAGAIN/EWOULDBLOCK.
> +			 */
> +		case EACCES:
>  			/* -n option set and failed to lock. */
>  			if (verbose)
>  				warnx(_("failed to get lock"));
> -- 
> 2.40.1.1.g1c60b9335d
> 
> 

Masatake YAMATO

