Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48839 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTn0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:26 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so843907wgh.25
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/13] setarch: add option to list settable architectures
Date: Tue,  2 Apr 2013 20:42:53 +0100
Message-Id: <1364931777-2645-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.8 |  3 +++
 sys-utils/setarch.c | 18 +++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index d206f2c..c5a5368 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -35,6 +35,9 @@ Output version information and exit.
 .I "\-\-uname\-2.6"
 Causes the program to see a kernel version number beginning with 2.6.
 .TP
+.I "\-\-list"
+List architectures that can be set.
+.TP
 .I "\-3," "\-\-3gb"
 Specifies that processes should use a maximum of 3GB of address space on systems where it is supported (ADDR_LIMIT_3GB).
 .TP
diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index afa2d1b..f6c0e20 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -110,6 +110,8 @@ show_help(void)
    " -3, --3gb                limits the used address space to a maximum of 3 GB\n"
    "     --4gb                ignored (for backward compatibility only)\n"
    "     --uname-2.6          turns on UNAME26\n"));
+   printf(_(
+   "     --list               list settable architectures, and exit\n"));
 
   printf(USAGE_SEPARATOR);
   printf(USAGE_HELP);
@@ -136,7 +138,7 @@ show_version(void)
 }
 
 static int
-set_arch(const char *pers, unsigned long options)
+set_arch(const char *pers, unsigned long options, int list)
 {
   struct utsname un;
   int i;
@@ -198,6 +200,12 @@ set_arch(const char *pers, unsigned long options)
     {-1, NULL, NULL}
   };
 
+  if (list) {
+    for(i = 0; transitions[i].target_arch != NULL; i++)
+      printf("%s\n", transitions[i].target_arch);
+    return 0;
+  }
+
   for(i = 0; transitions[i].perval >= 0; i++)
       if(!strcmp(pers, transitions[i].target_arch))
 	break;
@@ -273,10 +281,14 @@ int main(int argc, char *argv[])
       show_help();
     else if (!strcmp(p, "-V") || !strcmp(p, "--version"))
       show_version();
+    else if (!strcmp(p, "--list")) {
+      set_arch(argv[0], 0L, 1);
+      return EXIT_SUCCESS;
+    }
   }
   #if defined(__sparc64__) || defined(__sparc__)
    if (!strcmp(p, "sparc32bash")) {
-       if (set_arch(p, 0L))
+       if (set_arch(p, 0L, 0))
            err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
        execl("/bin/bash", NULL);
        err(EXIT_FAILURE, _("failed to execute %s"), "/bin/bash");
@@ -337,7 +349,7 @@ int main(int argc, char *argv[])
   argc -= optind;
   argv += optind;
 
-  if (set_arch(p, options))
+  if (set_arch(p, options, 0))
     err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
 
   if (!argc) {
-- 
1.8.2

