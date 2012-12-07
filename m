Return-Path: util-linux-owner@vger.kernel.org
Received: from charybdis-ext.suse.de ([195.135.221.2]:57588 "EHLO g231.suse.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753895Ab2LGIWL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Dec 2012 03:22:11 -0500
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Werner Fink <werner@suse.de>
Subject: [PATCH 1/5] sulogin: use the linked lists from list.h for consoles list
Date: Fri,  7 Dec 2012 09:00:54 +0100
Message-Id: <1354867258-14206-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

with this the double linked list feature from util-linux is used
instead of the single linked list.

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/consoles.h |    6 ++--
 lib/consoles.c     |   77 ++++++++++++++++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 32 deletions(-)

diff --git include/consoles.h include/consoles.h
index 2283d02..2544263 100644
--- include/consoles.h
+++ include/consoles.h
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
diff --git lib/consoles.c lib/consoles.c
index 7bc21b6..38c8208 100644
--- lib/consoles.c
+++ lib/consoles.c
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
1.7.10.4

