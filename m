Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbbAFNDw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Jan 2015 08:03:52 -0500
Date: Tue, 6 Jan 2015 14:03:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: util-linux@vger.kernel.org, Mikhail Gusarov <dottedmag@dottedmag.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/2] unshare: allow persisting namespaces
Message-ID: <20150106130343.GG18528@x2.net.home>
References: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
 <1419798218-3174-2-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419798218-3174-2-git-send-email-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 28, 2014 at 09:23:38PM +0100, Lubomir Rintel wrote:
> Bind mount the namespace file to a given location after creating it if
> requested (analogously to what "ip netns" and other tools do). This makes
> it possible for a namespace to survive with no processes running while
> processes can enter it with nsenter(1):
> 
>   # unshare --uts=utsns hostname behemoth
>   # nsenter --uts=utsns hostname
>   behemoth

Nice, especially when we already supports the same concept in nsenter.

But I guess that "empty namespace" (without any running process) is
impossible for PID namespaces, right? It would be nice to add a note
about it to the man page.

It would be also nice to add example with --mount-proc, because in
this case you need to specify --mount=<file> too

 # unshare --pid=ns-bind-pid --mount=ns-bind-mnt --mount-proc 

another session:

 # nsenter --pid=ns-bind-pid --mount=ns-bind-mnt

> The ugly bit about this patch is the clone(2) call, arguably not our

Please, can you a little elaborate why need clone() and what's wrong
with fork()+unshare()? I'd like to have some comment in code.

> +static void persist_ns(pid_t pid)
> +{
> +	struct namespace_file *nsfile;
> +
> +	for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
> +		char pathbuf[PATH_MAX];
> +
> +		if (!nsfile->target_name)
> +			continue;
> +
> +		snprintf(pathbuf, sizeof(pathbuf), "/proc/%u/%s", pid,
> +			nsfile->proc_name);
> +
> +		umount(nsfile->target_name);
> +		unlink(nsfile->target_name);
> +
> +		if (-1 == mknod(nsfile->target_name, 0666, 0)) {
> +			warn(_("failed to create %s"), nsfile->target_name);
> +			continue;
> +		}
> +
> +		if (-1 == mount(pathbuf, nsfile->target_name, NULL, MS_BIND, NULL)) {
> +			warn(_("mount %s failed"), nsfile->target_name);
> +			unlink(nsfile->target_name);
> +		}
> +	}
> +}

 would be better to use err() that warn()? It's strange to continue
 and ignore errors in this case. The current result on errors is mess.

    Karel

> +static int in_child (void *arg)
> +{
> +	jmp_buf *child = arg;
> +
> +	longjmp(*child, 1);
> +}
> +
> +#define STACK_SIZE 0x100000
> +static pid_t unshare_fork(int unshare_flags)
> +{
> +	/* Twice the size, as we might be running of parisc
> +	 * or metag where stack grows the other way. *sigh* */
> +	static char stack[2*STACK_SIZE];
> +	static jmp_buf child;
> +	pid_t pid;
> +
> +	if (setjmp (child))
> +		return 0;
> +
> +	pid = clone(in_child, &stack[STACK_SIZE],
> +		SIGCHLD | unshare_flags, &child);
> +	if (pid != -1)
> +		persist_ns(pid);
> +
> +	return pid;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	enum {
> @@ -90,12 +183,12 @@ int main(int argc, char *argv[])
>  	static const struct option longopts[] = {
>  		{ "help", no_argument, 0, 'h' },
>  		{ "version", no_argument, 0, 'V'},
> -		{ "mount", no_argument, 0, 'm' },
> -		{ "uts", no_argument, 0, 'u' },
> -		{ "ipc", no_argument, 0, 'i' },
> -		{ "net", no_argument, 0, 'n' },
> -		{ "pid", no_argument, 0, 'p' },
> -		{ "user", no_argument, 0, 'U' },
> +		{ "mount", optional_argument, 0, 'm' },
> +		{ "uts", optional_argument, 0, 'u' },
> +		{ "ipc", optional_argument, 0, 'i' },
> +		{ "net", optional_argument, 0, 'n' },
> +		{ "pid", optional_argument, 0, 'p' },
> +		{ "user", optional_argument, 0, 'U' },
>  		{ "fork", no_argument, 0, 'f' },
>  		{ "mount-proc", optional_argument, 0, OPT_MOUNTPROC },
>  		{ "map-root-user", no_argument, 0, 'r' },
> @@ -103,8 +196,6 @@ int main(int argc, char *argv[])
>  	};
>  
>  	int unshare_flags = 0;
> -	int c, forkit = 0, maproot = 0;
> -	const char *procmnt = NULL;
>  	uid_t real_euid = geteuid();
>  	gid_t real_egid = getegid();;
>  
> @@ -125,21 +216,28 @@ int main(int argc, char *argv[])
>  			return EXIT_SUCCESS;
>  		case 'm':
>  			unshare_flags |= CLONE_NEWNS;
> +			if (ns_path(CLONE_NEWNS, optarg))
> +				forkit = 1;
>  			break;
>  		case 'u':
>  			unshare_flags |= CLONE_NEWUTS;
> +			ns_path(CLONE_NEWUTS, optarg);
>  			break;
>  		case 'i':
>  			unshare_flags |= CLONE_NEWIPC;
> +			ns_path(CLONE_NEWIPC, optarg);
>  			break;
>  		case 'n':
>  			unshare_flags |= CLONE_NEWNET;
> +			ns_path(CLONE_NEWNET, optarg);
>  			break;
>  		case 'p':
>  			unshare_flags |= CLONE_NEWPID;
> +			ns_path(CLONE_NEWPID, optarg);
>  			break;
>  		case 'U':
>  			unshare_flags |= CLONE_NEWUSER;
> +			ns_path(CLONE_NEWUSER, optarg);
>  			break;
>  		case OPT_MOUNTPROC:
>  			unshare_flags |= CLONE_NEWNS;
> @@ -154,12 +252,9 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (-1 == unshare(unshare_flags))
> -		err(EXIT_FAILURE, _("unshare failed"));
> -
>  	if (forkit) {
>  		int status;
> -		pid_t pid = fork();
> +		pid_t pid = unshare_fork(unshare_flags);
>  
>  		switch(pid) {
>  		case -1:
> @@ -175,6 +270,10 @@ int main(int argc, char *argv[])
>  				kill(getpid(), WTERMSIG(status));
>  			err(EXIT_FAILURE, _("child exit failed"));
>  		}
> +	} else {
> +		if (-1 == unshare(unshare_flags))
> +			err(EXIT_FAILURE, _("unshare failed"));
> +		persist_ns(getpid());
>  	}
>  
>  	if (maproot) {
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
