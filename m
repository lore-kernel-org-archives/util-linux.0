Return-Path: util-linux-owner@vger.kernel.org
Received: from out02.mta.xmission.com ([166.70.13.232]:58714 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbbDIRLT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 Apr 2015 13:11:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <1428578536-31603-1-git-send-email-kzak@redhat.com>
	<1428578536-31603-2-git-send-email-kzak@redhat.com>
Date: Thu, 09 Apr 2015 12:07:09 -0500
In-Reply-To: <1428578536-31603-2-git-send-email-kzak@redhat.com> (Karel Zak's
	message of "Thu, 9 Apr 2015 13:22:16 +0200")
Message-ID: <87bnix6xj6.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 2/2] unshare: allow persisting mount namespaces
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> We can create a reference (bind mount) to the new namespace after
> unshare(2), but it does not make sense to do it within unshared
> namespace. (And if I read kernel fs/namespace.c: do_loopback()
> correctly than copy mount bind mounts of /proc/<pid>/ns/mnt between
> namespaces is unsupported.)

The support is limited.  mount namespaces are only allowed to be bound
into older mount namespaces.

But yes it is much more interesting to have the namespaces visible in
the parent than in the newly created mount namespace.

Your do { } while(0); loop below concerns me.  I think continue and
break are equivalent in that construct.

> This patch bypass this problem by fork() where parent continue as
> usually (call unshare(2), setup another things, etc.), but child
> waits for /proc/[ppid]/ns/mnt inode number change (the ino is
> changed after parent's unshare(2)) and then it bind mounts the new
> namespaces and exit.
>
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  sys-utils/unshare.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
> index 65d3e61..4ed9ad3 100644
> --- a/sys-utils/unshare.c
> +++ b/sys-utils/unshare.c
> @@ -27,6 +27,10 @@
>  #include <sys/wait.h>
>  #include <sys/mount.h>
>  
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
>  /* we only need some defines missing in sys/mount.h, no libmount linkage */
>  #include <libmount.h>
>  
> @@ -185,6 +189,43 @@ static int bind_ns_files(pid_t pid)
>  	return 0;
>  }
>  
> +static ino_t get_mnt_ino(pid_t pid)
> +{
> +	struct stat st;
> +	char path[PATH_MAX];
> +
> +	snprintf(path, sizeof(path), "/proc/%u/ns/mnt", (unsigned) pid);
> +
> +	if (stat(path, &st) != 0)
> +		err(EXIT_FAILURE, _("cannot stat %s"), path);
> +	return st.st_ino;
> +}
> +
> +static void bind_ns_files_from_child(pid_t *child)
> +{
> +	pid_t ppid = getpid();
> +	ino_t ino = get_mnt_ino(ppid);
> +
> +	*child = fork();
> +
> +	switch(*child) {
> +	case -1:
> +		err(EXIT_FAILURE, _("fork failed"));
> +	case 0:	/* child */
> +		do {
> +			/* wait until parent unshare() */
> +			ino_t new_ino = get_mnt_ino(ppid);
> +			if (ino != new_ino)
> +				break;
> +		} while (1);
> +		bind_ns_files(ppid);
> +		exit(EXIT_SUCCESS);
> +		break;
> +	default: /* parent */
> +		break;
> +	}
> +}
> +
>  static void usage(int status)
>  {
>  	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
> @@ -248,6 +289,8 @@ int main(int argc, char *argv[])
>  	int unshare_flags = 0;
>  	int c, forkit = 0, maproot = 0;
>  	const char *procmnt = NULL;
> +	pid_t pid = 0;
> +	int status;
>  	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
>  	uid_t real_euid = geteuid();
>  	gid_t real_egid = getegid();;
> @@ -316,12 +359,32 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (npersists && (unshare_flags & CLONE_NEWNS))
> +		bind_ns_files_from_child(&pid);
> +
>  	if (-1 == unshare(unshare_flags))
>  		err(EXIT_FAILURE, _("unshare failed"));
>  
> +	if (npersists) {
> +		if (pid && (unshare_flags & CLONE_NEWNS)) {
> +			/* wait for bind_ns_files_from_child() */
> +			do {
> +				int rc = waitpid(pid, &status, 0);
> +				if (rc < 0 && errno == EINTR)
> +					continue;
> +				else if (rc < 0)
> +					err(EXIT_FAILURE, _("waitpid failed"));
> +			} while (0);
> +
> +			if (WIFEXITED(status) && WEXITSTATUS(status) != EXIT_SUCCESS)
> +				return WEXITSTATUS(status);
> +		} else
> +			/* simple way, just bind */
> +			bind_ns_files(getpid());
> +	}
> +
>  	if (forkit) {
> -		int status;
> -		pid_t pid = fork();
> +		pid = fork();
>  
>  		switch(pid) {
>  		case -1:
> @@ -339,8 +402,6 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (npersists)
> -		bind_ns_files(getpid());
>  
>  	if (maproot) {
>  		if (setgrpcmd == SETGROUPS_ALLOW)
