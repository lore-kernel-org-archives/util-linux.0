Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48502 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031001Ab2K3P5a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Nov 2012 10:57:30 -0500
Date: Fri, 30 Nov 2012 16:57:26 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: [util-linux] [PATCH 00/13] Initial import of sulogin
Message-ID: <20121130155726.GA30517@boole.suse.de>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
 <20120228164840.GH21406@rampage>
 <20121012125309.GA20273@boole.suse.de>
 <20121012132336.GC23945@x2.net.home>
 <20121012140757.GA10101@boole.suse.de>
 <20121109120919.GC26857@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <20121109120919.GC26857@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Fri, Nov 09, 2012 at 01:09:19PM +0100, Karel Zak wrote:
> On Fri, Oct 12, 2012 at 04:07:57PM +0200, Dr. Werner Fink wrote:
> > >  Time... (the patch is one huge rewrite, I'd like to split it to more
> > >  patches). I'm busy with some others things, so next week.
> > 
> > Yep, this missing feature is also known here ;)
> > Maybe the attached patch help as it only adds the /proc/consoles and
> > /sys/class/tty/ scanner into common lib and leave sulogin untouched.
> > 
> > The integration into sulogin.c could then be done later
> 
>  Good idea. I have merged the lib/consoles.c with some changes:
> 
>     - removed all global variables
>     - refactoring (one separate function for each detection method)
>     - add debug messages
>     - fix some disadvantages
>     - add small test program
> 
>  Now we need a patch(s) for sulogin.c. It should be relatively simple
>  task as we already have Philipp's prototype.
> 
>  http://www.spinics.net/lists/util-linux-ng/msg06916.html
> 
>  Any suggestion how to test the code?

For such things a VirtualBox or KVM client is usefull, if a serial
console is used then you can see both of the consoles.  In the meanwhile
I've tried to move from single linked lists to double linked list as
found in include/list.h.  Now the usage of posix_memalign() makes sense
as with this the area for the structure as well as for the string in the
structure can be allocated in one step (and also freed in one step).

During debugging I've found that the usleep() inline in include/c.h
is broken as the default type is missed and semi colon as well.

   Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--82I3+IH0IqGh5yIs
Content-Type: text/x-patch; charset=iso-8859-1
Content-Description: util-linux-consoles.patch
Content-Disposition: attachment; filename="util-linux-consoles.patch"

>From 93015b7d4b6884d8ca68694c7bffeae9ea7c6726 Mon Sep 17 00:00:00 2001
From: Werner Fink <werner@suse.de>
Date: Fri, 30 Nov 2012 16:38:09 +0100
Subject: [PATCH] Use the linked lists from list.h for consoles list

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/consoles.h |    6 +++-
 lib/consoles.c     |   77 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/include/consoles.h b/include/consoles.h
index 2283d02..2544263 100644
--- a/include/consoles.h
+++ b/include/consoles.h
@@ -2,6 +2,7 @@
  * consoles.h	    Header file for routines to detect the system consoles
  *
  * Copyright (c) 2011 SuSE LINUX Products GmbH, All rights reserved.
+ * Copyright (c) 2012 Werner Fink <werner@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,6 +26,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <termios.h>
+#include <list.h>
 
 struct chardata {
 	uint8_t	erase;
@@ -33,6 +35,7 @@ struct chardata {
 	uint8_t parity;
 };
 struct console {
+	struct list_head entry;
 	char *tty;
 	FILE *file;
 	uint32_t flags;
@@ -42,8 +45,7 @@ struct console {
 	pid_t pid;
 	struct chardata cp;
 	struct termios tio;
-	struct console *next;
 };
 
 extern int detect_consoles(const char *device, int fallback,
-			   struct console **consoles);
+			   struct list_head *consoles);
diff --git a/lib/consoles.c b/lib/consoles.c
index 7bc21b6..38c8208 100644
--- a/lib/consoles.c
+++ b/lib/consoles.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2011 SuSE LINUX Products GmbH, All rights reserved.
  * Copyright (C) 2012 Karel Zak <kzak@redhat.com>
+ * Copyright (C) 2012 Werner Fink <werner@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -56,6 +57,7 @@
 #endif
 
 #define alignof(type)		((sizeof(type)+(sizeof(void*)-1)) & ~(sizeof(void*)-1))
+#define	strsize(string)		(strlen((string))+1)
 
 static int consoles_debug;
 #define DBG(x)	do { \
@@ -200,7 +202,7 @@ static
 #ifdef __GNUC__
 __attribute__((__nonnull__,__hot__))
 #endif
-int append_console(struct console **list, char * name)
+int append_console(struct list_head *consoles, const char *name)
 {
 	static const struct chardata initcp = {
 		.erase	= CERASE,
@@ -210,16 +212,21 @@ int append_console(struct console **list, char * name)
 	};
 	struct console *restrict tail;
 	struct console *last;
+	
+	if (list_empty(consoles))
+		last = NULL;
+	else
+		last = list_entry(consoles->prev, struct console, entry);
 
 	DBG(dbgprint("appenging %s", name));
 
-	if (posix_memalign((void*)&tail, sizeof(void*), alignof(typeof(struct console))) != 0)
+	if (posix_memalign((void*)&tail, sizeof(void*),
+			   alignof(struct console)+strsize(name)) != 0)
 		return -ENOMEM;
 
-	for (last = *list; last && last->next; last = last->next);
-
-	tail->next = NULL;
-	tail->tty = name;
+	list_add_tail(&tail->entry, consoles);
+	tail->tty = ((char*)tail)+alignof(struct console);
+	strcpy(tail->tty, name);
 
 	tail->file = (FILE*)0;
 	tail->flags = 0;
@@ -229,11 +236,6 @@ int append_console(struct console **list, char * name)
 	memset(&tail->tio, 0, sizeof(tail->tio));
 	memcpy(&tail->cp, &initcp, sizeof(struct chardata));
 
-	if (!last)
-		*list = tail;
-	else
-		last->next = tail;
-
 	return 0;
 }
 
@@ -245,7 +247,7 @@ int append_console(struct console **list, char * name)
  *	  1	- recoverable error
  *	  2	- detection not available
  */
-static int detect_consoles_from_proc(struct console **consoles)
+static int detect_consoles_from_proc(struct list_head *consoles)
 {
 	char fbuf[16 + 1];
 	DIR *dir = NULL;
@@ -274,11 +276,12 @@ static int detect_consoles_from_proc(struct console **consoles)
 		if (!name)
 			continue;
 		rc = append_console(consoles, name);
+		free(name);
 		if (rc < 0)
 			goto done;
 	}
 
-	rc = *consoles ? 0 : 1;
+	rc = list_empty(consoles) ? 1 : 0;
 done:
 	if (dir)
 		closedir(dir);
@@ -295,7 +298,7 @@ done:
  *	  1	- recoverable error
  *	  2	- detection not available
  */
-static int detect_consoles_from_sysfs(struct console **consoles)
+static int detect_consoles_from_sysfs(struct list_head *consoles)
 {
 	char *attrib = NULL, *words, *token;
 	DIR *dir = NULL;
@@ -335,11 +338,12 @@ static int detect_consoles_from_sysfs(struct console **consoles)
 		if (!name)
 			continue;
 		rc = append_console(consoles, name);
+		free(name);
 		if (rc < 0)
 			goto done;
 	}
 
-	rc = *consoles ? 0 : 1;
+	rc = list_empty(consoles) ? 1 : 0;
 done:
 	free(attrib);
 	if (dir)
@@ -349,7 +353,7 @@ done:
 }
 
 
-static int detect_consoles_from_cmdline(struct console **consoles)
+static int detect_consoles_from_cmdline(struct list_head *consoles)
 {
 	char *cmdline, *words, *token;
 	dev_t comparedev;
@@ -422,11 +426,12 @@ static int detect_consoles_from_cmdline(struct console **consoles)
 		if (!name)
 			continue;
 		rc = append_console(consoles, name);
+		free(name);
 		if (rc < 0)
 			goto done;
 	}
 
-	rc = *consoles ? 0 : 1;
+	rc = list_empty(consoles) ? 1 : 0;
 done:
 	if (dir)
 		closedir(dir);
@@ -435,7 +440,7 @@ done:
 	return rc;
 }
 
-static int detect_consoles_from_tiocgdev(struct console **consoles,
+static int detect_consoles_from_tiocgdev(struct list_head *consoles,
 					int fallback,
 					const char *device)
 {
@@ -445,6 +450,7 @@ static int detect_consoles_from_tiocgdev(struct console **consoles,
 	int rc = 1, fd = -1;
 	dev_t comparedev;
 	DIR *dir = NULL;
+	struct console *console;
 
 	DBG(dbgprint("trying tiocgdev"));
 
@@ -478,12 +484,16 @@ static int detect_consoles_from_tiocgdev(struct console **consoles,
 		}
 	}
 	rc = append_console(consoles, name);
+	free(name);
 	if (rc < 0)
 		goto done;
-	if (*consoles &&  (!device || !*device))
-		(*consoles)->fd = fallback;
-
-	rc = *consoles ? 0 : 1;
+	if (list_empty(consoles)) {
+		rc = 1;
+		goto done;
+	}
+	console = list_entry(consoles->prev, struct console, entry);
+	if (console &&  (!device || !*device))
+		console->fd = fallback;
 done:
 	if (fd >= 0)
 		close(fd);
@@ -503,7 +513,7 @@ done:
  * Returns 1 if stdout and stderr should be reconnected and 0
  * otherwise or less than zero on error.
  */
-int detect_consoles(const char *device, int fallback, struct console **consoles)
+int detect_consoles(const char *device, int fallback, struct list_head *consoles)
 {
 	int fd, reconnect = 0, rc;
 	dev_t comparedev = 0;
@@ -581,10 +591,11 @@ int detect_consoles(const char *device, int fallback, struct console **consoles)
 
 		if (name) {
 			rc = append_console(consoles, name);
+			free(name);
 			if (rc < 0)
 				return rc;
 		}
-		if (!*consoles)
+		if (list_empty(consoles))
 			goto fallback;
 
 		DBG(dbgprint("detection success [rc=%d]", reconnect));
@@ -632,7 +643,7 @@ console:
 	if (rc < 0)
 		return rc;		/* fatal error */
 
-	if (*consoles) {
+	if (!list_empty(consoles)) {
 		DBG(dbgprint("detection success [rc=%d]", reconnect));
 		return reconnect;
 	}
@@ -642,6 +653,7 @@ console:
 fallback:
 	if (fallback >= 0) {
 		const char *name;
+		struct console *console;
 
 		if (device && *device != '\0')
 			name = device;
@@ -653,8 +665,11 @@ fallback:
 		rc = append_console(consoles, strdup(name));
 		if (rc < 0)
 			return rc;
-		if (*consoles)
-			(*consoles)->fd = fallback;
+		if (list_empty(consoles))
+			return 1;
+		console = list_entry(consoles->prev, struct console, entry);
+		if (console)
+			console->fd = fallback;
 	}
 
 	DBG(dbgprint("detection done by fallback [rc=%d]", reconnect));
@@ -667,7 +682,7 @@ int main(int argc, char *argv[])
 {
 	char *name = NULL;
 	int fd, re;
-	struct console *p, *consoles = NULL;
+	struct list_head *p, consoles = {&consoles, &consoles};
 
 	if (argc == 2) {
 		name = argv[1];
@@ -682,8 +697,10 @@ int main(int argc, char *argv[])
 
 	re = detect_consoles(name, fd, &consoles);
 
-	for (p = consoles; p; p = p->next)
-		printf("%s: id=%d %s\n", p->tty, p->id, re ? "(reconnect) " : "");
+	list_for_each(p, &consoles) {
+		struct console *c = list_entry(p, struct console, entry);
+		printf("%s: id=%d %s\n", c->tty, c->id, re ? "(reconnect) " : "");
+	}
 
 	return 0;
 }
-- 
1.7.7


--82I3+IH0IqGh5yIs
Content-Type: text/x-patch; charset=iso-8859-1
Content-Description: util-linux-usleep.patch
Content-Disposition: attachment; filename="util-linux-usleep.patch"

>From 0f259c192a6b9e6710e4f4576abe28dd6f5c982a Mon Sep 17 00:00:00 2001
From: Werner Fink <werner@suse.de>
Date: Fri, 30 Nov 2012 16:52:37 +0100
Subject: [PATCH] Make usleep() workaround work

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/c.h |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/c.h b/include/c.h
index 1107287..ec1020e 100644
--- a/include/c.h
+++ b/include/c.h
@@ -19,6 +19,10 @@
 # include <err.h>
 #endif
 
+#ifndef HAVE_USLEEP
+# include <time.h>
+#endif
+
 /*
  * Compiler specific stuff
  */
@@ -246,13 +250,13 @@ static inline size_t get_hostname_max(void)
  * This function is marked obsolete in POSIX.1-2001 and removed in
  * POSIX.1-2008. It is replaced with nanosleep().
  */
-static inline usleep(useconds_t usec)
+static inline int usleep(useconds_t usec)
 {
 	struct timespec waittime = {
 		.tv_sec   =  usec / 1000000L,
 		.tv_nsec  = (usec % 1000000L) * 1000
-	}
-	nanosleep(&waittime, NULL);
+	};
+	return nanosleep(&waittime, NULL);
 }
 #endif
 
-- 
1.7.9.2


--82I3+IH0IqGh5yIs--
