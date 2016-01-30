Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:45685 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203AbcA3Dwt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jan 2016 22:52:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aPMab-0006i2-Hr
	for util-linux@vger.kernel.org; Sat, 30 Jan 2016 04:52:45 +0100
Received: from ppp37-190-56-5.pppoe.spdop.ru ([37.190.56.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 30 Jan 2016 04:52:45 +0100
Received: from yumkam by ppp37-190-56-5.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 30 Jan 2016 04:52:45 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 2/2] unshare: allow persisting mount namespaces
Date: Sat, 30 Jan 2016 06:52:36 +0300
Message-ID: <m31t8zhgfv.fsf@gmail.com>
References: <1428578536-31603-1-git-send-email-kzak@redhat.com>
	<1428578536-31603-2-git-send-email-kzak@redhat.com>
	<87bnix6xj6.fsf@x220.int.ebiederm.org>
	<20150410081733.GM3923@ws.net.home>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

(this was commited as c84f2590dfdb8570beeb731e0105f8fe597443d1)

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

Racing? Suppose, parent died (e.g. unshare(2) failed), (parent) process
was reaped, new (unrelated) process was created with same pid, as a
result this function will bind namespaces from wrong process. (That
said, pretty unlikely, and no idea how to properly fix it).

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
> @@ -316,12 +359,35 @@ int main(int argc, char *argv[])
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
> +			int rc;
> +
> +			do {
> +				rc = waitpid(pid, &status, 0);
> +				if (rc < 0) {
> +					if (errno == EINTR)
> +						continue;
> +					err(EXIT_FAILURE, _("waitpid failed"));
> +				}
> +				if (WIFEXITED(status) &&
> +				    WEXITSTATUS(status) != EXIT_SUCCESS)
> +					return WEXITSTATUS(status);
> +			} while (rc < 0);
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
> @@ -339,8 +405,6 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (npersists)
> -		bind_ns_files(getpid());
>  
>  	if (maproot) {
>  		if (setgrpcmd == SETGROUPS_ALLOW)

