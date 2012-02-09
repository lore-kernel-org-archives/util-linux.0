Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42199 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab2BIOcg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Feb 2012 09:32:36 -0500
Date: Thu, 9 Feb 2012 15:32:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] lslocks: new command
Message-ID: <20120209143231.GB27081@x2.net.home>
References: <1328654520.3500.12.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328654520.3500.12.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 07, 2012 at 11:42:00PM +0100, Davidlohr Bueso wrote:
> +struct lock {
> +	struct list_head locks;
> +
> +	char *cmdname;
> +	pid_t pid;
> +	char *path;
> +	char *type;
> +	long start;
> +	long end;

 off_t rather than long

> +	int mandatory;
> +	char *size;
> +};
> +
> +/*
> + * Return a PID's command name
> + */
> +static char *get_cmdname(pid_t pid)
> +{
> +	FILE *fp;
> +	char path[PATH_MAX], *cmd = NULL;
> +
> +	sprintf(path, "/proc/%d/status", pid);
> +	if (!(fp = fopen(path, "r")))
> +		return NULL;

 /proc/<pid>/comm contains only the command name, you don't have to
 parse anything.

> +	/* just need the first line */
> +	if (!fgets(path, sizeof(path), fp))
> +		goto out;
> +
> +	(void)strtok_r(path, "\t", &cmd);
> +	cmd[strlen(cmd) - 1] = '\0';
> +out:
> +	fclose(fp);
> +	return xstrdup(cmd);
> +}
> +
> +/*
> + * Associate the device's mountpoint for a filename
> + */
> +static char *get_fallback_filename(size_t dev)
> +{
> +	char buf[PATH_MAX], *ret = NULL;
> +	char *key = NULL, *tmp = NULL, *tok = NULL;
> +	int i;
> +	struct stat sb;
> +	FILE *fp;
> +
> +	if (!(fp = fopen(_PATH_PROC_MOUNTS, "r")))
> +		return NULL;
> +
> +	while (fgets(buf, sizeof(buf), fp)) {
> +		for (i = 0, tmp = buf; ; tmp = NULL, i++) {
> +			if (!(tok = strtok_r(tmp, " ", &key)))
> +				break;
> +
> +			if (i == 1)
> +				if (!stat(tok, &sb) && dev == sb.st_dev) {

  - you call stat() for all mountpoint, it's not too elegant...

  - stat->st_dev is completely useless on btrfs, because it
    returns a different devno than kernel uses in /proc.

    See https://bugzilla.redhat.com/show_bug.cgi?id=711881

    Try "flock -x /mnt lslk", where /mnt is btrfs mountpoint, the
    tools is not able to convert /proc/locks information to mountpoint
    path...

 It seems that more robust solution is to use /proc/self/mountinfo
 where in 3rd column is maj:min and this devno is the same as devno in
 /proc/locks.

 Note that /proc/locks uses %02x:%02x format, mountinfo uses decimal
 numbers.

 Please, use scanf() for parsing rather than strtok(), especially for
 simple things like "maj:min:ino".

> +					ret = xstrdup(tok);
> +					goto out;
> +				}
> +		}
> +	}
> +
> +out:
> +	fclose(fp);
> +	return ret;
> +}
> +
> +/*
> + * Return the absolute path of a file from
> + * a given inode number (and its size)
> + */
> +static char *get_filename_sz(long inode, pid_t pid, size_t *size)
> +{
> +	struct stat sb;
> +	struct dirent *dp;
> +	DIR *dirp;
> +	size_t len;
> +	char path[PATH_MAX], sym[PATH_MAX], *ret = NULL;
> +
> +	*size = 0;
> +	memset(path, 0, sizeof(path));
> +	memset(sym, 0, sizeof(sym));
> +
> +	/*
> +	 * We know the pid so we don't have to
> +	 * iterate the *entire* filesystem searching
> +	 * for the damn file.
> +	 */
> +	sprintf(path, "/proc/%d/fd/", pid);
> +	if (!(dirp = opendir(path)))
> +		return NULL;
> +
> +	if ((len = strlen(path)) >= (sizeof(path) - 2))
> +		goto out;
> +
> +	while ((dp = readdir(dirp))) {
> +		if (!strcmp(dp->d_name, ".") ||
> +		    !strcmp(dp->d_name, ".."))
> +			continue;
> +
> +		/* care only for numerical descriptors */
> +		if (!strtol(dp->d_name, (char **) NULL, 10))
> +			continue;
> +
> +		(void) strcpy(&path[len], dp->d_name);
> +		if (!stat(path, &sb) && inode != sb.st_ino)
> +			continue;
> +
> +		if ((len = readlink(path, sym, sizeof(path))) < 1)
> +			goto out;

 Please use statat() and readlinkat(), in lib/at.c are portable
 versions.

> +		*size = sb.st_size;

  sym[len] = '\0';

> +		ret = xstrdup(sym);
> +		break;
> +	}
> +out:
> +	closedir(dirp);
> +	return ret;
> +}
> +
> +/*
> + * Return the inode number from a string
> + */
> +static long get_dev_inode(char *str, dev_t *dev)
> +{
> +	char *tmp = NULL, *tok = NULL, *key = NULL;
> +	int i, maj = 0, min = 0;
> +	long inum = 0;
> +
> +	for (i = 0, tmp = str; ; tmp = NULL, i++) {
> +		if (!(tok = strtok_r(tmp, ":", &key)))
> +			break;
> +
> +		/*
> +		 * traditional format '<major>:<minor>:<inode>' - note that this

 sscanf(str, "%02x:02x:%ul", ....), this whole function will have 5
 lines... :-)

> +		 * might change and the kernel would export '<name>:<inode>'.
> +		 */
> +		switch (i) {
> +		case 0:
> +			maj = strtol(tok, (char **) NULL, 16);
> +			break;
> +		case 1:
> +			min = strtol(tok, (char **) NULL, 16);
> +			break;
> +		case 2:
> +			inum = strtol_or_err(tok, _("failed to parse inode number"));
> +		default:
> +			break;
> +		}
> +	}
> +
> +	*dev = (dev_t) makedev(maj, min);
> +	return inum;
> +}
> +
> +static int get_local_locks(struct list_head *locks)
> +{
> +	int i;
> +	long inode;
> +	FILE *fp;
> +	char buf[PATH_MAX], *key = NULL, *tmp = NULL, *tok = NULL;
> +	size_t sz;
> +	struct lock *l;
> +	dev_t dev;
> +	pid_t p;
> +
> +	if (!(fp = fopen(_PATH_PROC_LOCKS, "r")))
> +		return 0;
> +
> +	while (fgets(buf, sizeof(buf), fp)) {
> +		l = xcalloc(1, sizeof(*l));
> +		INIT_LIST_HEAD(&l->locks);
> +
> +		for (i = 0, tmp = buf; ; tmp = NULL, i++) {
> +			if (!(tok = strtok_r(tmp, " ", &key)))
> +				break;

  for (i = 0, tok = strtok(buf, " ");
       tok = strtok(NULL, " ");
       i++)

 key and tmp are unnecessary

> +
> +			/*
> +			 * /proc/locks as *exactly* 8 "blocks" of text
> +			 * separated by ' ' - check <kernel>/fs/locks.c
> +			 */
> +			switch (i) {
> +			case 0: /* not intereted! */
> +			case 1: /* not intereted! */
> +				break;
> +
> +			case 2: /* is this a mandatory lock? other values are advisory or noinode */
> +				l->mandatory = *tok == 'M' ? TRUE : FALSE;
> +				break;
> +			case 3: /* lock type */
> +				l->type = xstrdup(tok);
> +				break;
> +
> +			case 4: /* PID */
> +				/*
> +				 * If user passed a pid we filter it later when adding
> +				 * to the list, no need to worry now.
> +				 */
> +				l->pid = strtol_or_err(tok, _("failed to parse pid"));
> +				l->cmdname = get_cmdname(l->pid);
> +				break;
> +
> +			case 5: /* device major:minor and inode number */
> +				inode = get_dev_inode(tok, &dev);
> +				break;
> +
> +			case 6: /* start */
> +				l->start = !strcmp(tok, "EOF") ? 0 :
> +					   strtol_or_err(tok, _("failed to parse start"));
> +				break;
> +
> +			case 7: /* end */
> +				/* replace '\n' character */
> +				tok[strlen(tok)-1] = '\0';
> +				l->end = !strcmp(tok, "EOF") ? 0 :
> +					 strtol_or_err(tok, _("failed to parse end"));
> +				break;
> +			default:
> +				break;
> +			}
> +
> +			l->path = get_filename_sz(inode, l->pid, &sz);
> +			/* probably no permission to peek into l->pid's path */
> +			if (!l->path)
> +				l->path = get_fallback_filename(dev);
> +
> +			/* avoid leaking */
> +			l->size = xstrdup(size_to_human_string(SIZE_SUFFIX_1LETTER, sz));

 I see leak, size_to_human_string() returns allocated string.

 [...]

> +int main(int argc, char *argv[])
> +{
> +	int c, tt_flags = 0;
> +	struct list_head locks;
> +	enum {
> +		RAW_OPTION = CHAR_MAX + 1,
> +		NOHEADINGS_OPTION
> +	};
> +	static const struct option long_opts[] = {
> +		{ "pid",	required_argument, NULL, 'p' },
> +		{ "help",	no_argument,       NULL, 'h' },
> +		{ "version",    no_argument,       NULL, 'V' },
> +		{ "noheadings", no_argument,       NULL, NOHEADINGS_OPTION },
> +		{ "raw",        no_argument,       NULL, RAW_OPTION },

 why not -r and -n for raw and noheadings?

> +		{ NULL, 0, NULL, 0 }
> +	};

 [...]

> +
> +	return EXIT_SUCCESS;
> +}

 always EXIT_SUCCESS? Don't be so optimistic :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
