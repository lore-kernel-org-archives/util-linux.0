Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64138 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab1ECOPD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 3 May 2011 10:15:03 -0400
Received: by fxm17 with SMTP id 17so116158fxm.19
        for <util-linux@vger.kernel.org>; Tue, 03 May 2011 07:15:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110503125322.GK29492@nb.net.home>
References: <BANLkTin=y5oaEU0913dOnjWhosiyXe3Zwg@mail.gmail.com> <20110503125322.GK29492@nb.net.home>
From: Austen Dicken <cvpcsm@gmail.com>
Date: Tue, 3 May 2011 09:14:41 -0500
Message-ID: <BANLkTikGoXaYdwvY3fZPGVmvBkGzT23xtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dmesg: adds the ability to "follow" the klog ring buffer
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 3, 2011 at 07:53, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Apr 29, 2011 at 11:42:00AM -0500, Austen Dicken wrote:
>> adds the "-f" option to dmesg, which allows an underpriviledged
>> user to "follow" the kernel ring buffer, outputting new messages as they
>
> I like the "follow the kernel ring buffer" idea, but ...
>
>> appear.  this is done non-destructively so that the current buffer remains
>> after execution.
>>
>> this also changes the log output to be by-line instead of by-character,
>> and saves the last line printed on each read of the buffer.  if looping,
>> it will then read the buffer again, but not output until it finds the last
>> line that it printed.
>
> ... this seems like a problem to me.
>
>  [...]
>
>> -     for (i = 0; i < n; i++) {
>> -             if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
>> -                     i++;
>> -                     while (isdigit(buf[i]))
>> -                             i++;
>> -                     if (buf[i] == '>')
>> +             this_line = xmalloc(n * sizeof(char));
>> +             for (i = 0, j = 0; i < n; i++) {
>> +                     if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
>>                               i++;
>> +                             while (isdigit(buf[i]))
>> +                                     i++;
>> +                             if (buf[i] == '>')
>> +                                     i++;
>> +                     }
>> +                     this_line[j] = buf[i];
>> +
>> +                     if (this_line[j] == '\n') {
>> +                             this_line[j] = '\0';
>> +                             if (last_line) {
>> +                                     if (!strcmp(last_line, this_line)) {
>> +                                             free(last_line);
>> +                                             last_line = NULL;
>> +                                     }
>> +                             } else
>> +                                     printf("%s\n", this_line);
>
> It expects that the kernel log does not contain duplicate messages.
> Is it correct? I don't think so, I see:
>
>   ata1.00: configured for UDMA/100
>   ata1.00: configured for UDMA/100
>
> You have to compile kernel with CONFIG_PRINTK_TIME, otherwise your
> heuristic will not work properly.

I see what you mean.  Yes my heuristic would not be able to function properly
in that way, so there's no reason to complicate things by going to line-by-line
output.

>
>> +             usleep(200);
>> +
>> +     } while (follow_loop);
>
> Hmm... sleep() in code usually means a poor design or API.

I was using sleep at the time since klogctl(3,...) doesn't block so
when no new data
was available the code was essentially busy-looping, but I agree it is
quite messy.

>
> What about to support -f (follow) for privileged users only?
>
> Then you can use klogctl(2, ...). It waits until the kernel log buffer
> is non-empty, so the last_line and usleep() will be unnecessary, and
> the implementation will be pretty simple.

Agreed.  I have decided to change the patch to function this way,
which simplifies things
immensely.

>
>> +             if (prev_sighandler)
>> +                     signal(SIGINT, prev_sighandler);
>> +             else
>> +                     signal(SIGINT, SIG_DFL);
>
> Why do you need to restore the handler before return (exit)? It seems
> unnecessary.

I was restoring the old signal handler just for completeness, in the
same way that someone
might free() memory even though they are about to exit.  The main
reason for that is mostly
so that in the future if more were to be added to this program then
there wouldn't be bugs
caused by incomplete closure of such things.

Regardless, the use of signal handlers is obsolete in my latest patch,
shown below.

>
>    Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

So I have changed the implementation to use klogctl(2, ...) and remove
the signal handlers,
so one simply interrupts the program for the sake of interrupting the
program, no cleanup should
be required, so the signal handling is just extra.

"dmesg -f" now essentially would do the same as "cat /proc/kmsg" but
with the addition of
some of the nice formatting options that dmesg already provides
(removal of log levels for instance).

I was playing with the idea of having follow run klogctl(3, ...) first
to dump the current buffer, then
call klogctl(2, ...) after that to append new information (essentially
producing the originally intended
output), but decided against it as if an underprivileged user attempts
to use the option that would result
in the log dumping and then failing when switching to klogctl(2, ...),
which seemed confusing and messy.
It could have been modified to run a privileged command first, but
that seemed messy as well, so I'll leave
it at this for now.

~ Austen

--
 sys-utils/dmesg.1 |    4 +++
 sys-utils/dmesg.c |   73 +++++++++++++++++++++++++++++------------------------
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index d7af1da..bbdd462 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -6,6 +6,7 @@ dmesg \- print or control the kernel ring buffer
 .SH SYNOPSIS
 .B dmesg
 .RB [ \-c ]
+.RB [ \-f ]
 .RB [ \-r ]
 .RB [ \-n
 .IR level ]
@@ -28,6 +29,9 @@ file to whoever can debug their problem.
 .B \-c
 Clear the ring buffer contents after printing.
 .TP
+.B \-f
+Output ring buffer contents as they are added.
+.TP
 .B \-r
 Print the raw message buffer, i.e., don't strip the log level prefixes.
 .TP
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index c3e5659..e2f5933 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -44,7 +44,7 @@
 static void __attribute__ ((noreturn)) usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-c] [-n level] [-r] [-s bufsize]\n"),
+		_("Usage: %s [-c] [-f] [-n level] [-r] [-s bufsize]\n"),
 		program_invocation_short_name);
 	exit(EXIT_FAILURE);

@@ -62,16 +62,21 @@ int main(int argc, char *argv[])
 	int  lastc;
 	int  cmd = 3;		/* Read all messages in the ring buffer */
 	int  raw = 0;
+	int  follow = 0;

 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);

-	while ((c = getopt(argc, argv, "crn:s:")) != -1) {
+	while ((c = getopt(argc, argv, "cfrn:s:")) != -1) {
 		switch (c) {
 		case 'c':
 			cmd = 4;	/* Read and clear all messages */
 			break;
+		case 'f':
+			cmd = 2;
+			follow = 1;
+			break;
 		case 'n':
 			cmd = 8;	/* Set level of messages */
 			level = strtol_or_err(optarg, _("failed to parse level"));
@@ -109,43 +114,45 @@ int main(int argc, char *argv[])
 			bufsize = n;
 	}

-	if (bufsize) {
-		sz = bufsize + 8;
-		buf = xmalloc(sz * sizeof(char));
-		n = klogctl(cmd, buf, sz);
-	} else {
-		sz = 16392;
-		while (1) {
+	do {
+		if (bufsize) {
+			sz = bufsize + 8;
 			buf = xmalloc(sz * sizeof(char));
-			n = klogctl(3, buf, sz);	/* read only */
-			if (n != sz || sz > (1 << 28))
-				break;
-			free(buf);
-			sz *= 4;
+			n = klogctl(cmd, buf, sz);
+		} else {
+			sz = 16392;
+			while (1) {
+				buf = xmalloc(sz * sizeof(char));
+				n = klogctl(3, buf, sz);	/* read only */
+				if (n != sz || sz > (1 << 28))
+					break;
+				free(buf);
+				sz *= 4;
+			}
+
+			if (n > 0 && cmd == 4)
+				n = klogctl(cmd, buf, sz);	/* read and clear */
 		}

-		if (n > 0 && cmd == 4)
-			n = klogctl(cmd, buf, sz);	/* read and clear */
-	}
-
-	if (n < 0)
-		err(EXIT_FAILURE, _("klogctl failed"));
+		if (n < 0)
+			err(EXIT_FAILURE, _("klogctl failed"));

-	lastc = '\n';
-	for (i = 0; i < n; i++) {
-		if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
-			i++;
-			while (isdigit(buf[i]))
-				i++;
-			if (buf[i] == '>')
+		lastc = '\n';
+		for (i = 0; i < n; i++) {
+			if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
 				i++;
+				while (isdigit(buf[i]))
+					i++;
+				if (buf[i] == '>')
+					i++;
+			}
+			lastc = buf[i];
+			putchar(lastc);
 		}
-		lastc = buf[i];
-		putchar(lastc);
-	}
-	if (lastc != '\n')
-		putchar('\n');
-	free(buf);
+		if (lastc != '\n')
+			putchar('\n');
+		free(buf);
+	} while (follow);

 	return EXIT_SUCCESS;
 }
