Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 12/13] sfdisk: fix --unhide segfault
Date: Tue, 22 Jul 2014 16:44:56 -0700
Message-Id: <1406072697-20912-13-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

There's currently a NULL ptr dereference bug when calling asc_to_index()
via set_unhidden(). Fix this bug by checking the optarg value for null.
This is similar to how other options handle such calls.

Before:
Segmentation fault (core dumped)

After:
sfdisk: Done: Success

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 86ed112..f730504 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -2909,12 +2909,13 @@ static int do_activate(char **av, int ac, char *arg)
 	return ret;
 }
 
-static void
-set_unhidden(struct disk_desc *z, char *pnam) {
+static void set_unhidden(struct disk_desc *z, char *pnam)
+{
 	int pno;
 	unsigned char id;
 
 	pno = asc_to_index(pnam, z);
+	printf("\t%s\n", pnam);
 	id = z->partitions[pno].p.sys_type;
 	if (id == 0x11 || id == 0x14 || id == 0x16 || id == 0x17 ||
 	    id == 0x17 || id == 0x1b || id == 0x1c || id == 0x1e)
@@ -2943,7 +2944,7 @@ static int do_unhide(char **av, int ac, char *arg)
 	get_partitions(dev, fd, z);
 
 	/* unhide where desired */
-	if (ac == 1)
+	if (ac == 1 && arg)
 		set_unhidden(z, arg);
 	else
 		for (i = 1; i < ac; i++)
-- 
1.8.1.4
