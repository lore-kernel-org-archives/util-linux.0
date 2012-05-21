Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:47505 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753290Ab2EUTXg (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 21 May 2012 15:23:36 -0400
Subject: Re: [PATCH 3/6] fdisk: refactor -s option
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120521092705.GA14390@x2.net.home>
References: <1337530289.2677.14.camel@offbook>
	 <20120521092705.GA14390@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 May 2012 21:23:27 +0200
Message-ID: <1337628207.2596.0.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-05-21 at 11:27 +0200, Karel Zak wrote:
> On Sun, May 20, 2012 at 06:11:29PM +0200, Davidlohr Bueso wrote:
> > +static unsigned long long get_dev_sz(char *dev)
> 
> It's number of blocks (1024-bytes) rather than size, what about
> 
>     get_dev_blocks()
> 
> or so...

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 21 May 2012 21:22:37 +0200
Subject: [PATCH] fdisk: refactor -s option

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 9387795..9788e5c 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2095,10 +2095,22 @@ static void command_prompt(void)
 	}
 }
 
+static unsigned long long get_dev_blocks(char *dev)
+{
+	int fd;
+	unsigned long long size;
+	
+	if ((fd = open(dev, O_RDONLY)) < 0)
+		err(EXIT_FAILURE, _("unable to open %s"), dev);
+	if (blkdev_get_sectors(fd, &size) == -1)
+		fatal(ioctl_error);
+	close(fd);
+	return size/2;
+}
+
 int main(int argc, char **argv)
 {
-	int j, c;
-	int optl = 0, opts = 0;
+	int c, optl = 0, opts = 0;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -2182,27 +2194,18 @@ int main(int argc, char **argv)
 	}
 
 	if (opts) {
-		unsigned long long size;
-
-		nowarn = 1;
-
-		opts = argc - optind;
-		if (opts <= 0)
+		/* print partition size for one or more devices */
+		int i, ndevs = argc - optind;
+		if (ndevs <= 0)
 			usage(stderr);
 
-		for (j = optind; j < argc; j++) {
-			disk_device = argv[j];
-			if ((fd = open(disk_device, O_RDONLY)) < 0)
-				err(EXIT_FAILURE, _("unable to open %s"), disk_device);
-			if (blkdev_get_sectors(fd, &size) == -1)
-				fatal(ioctl_error);
-			close(fd);
-			if (opts == 1)
-				printf("%llu\n", size/2);
+		for (i = optind; i < argc; i++) {
+			if (ndevs == 1)
+				printf("%llu\n", get_dev_blocks(argv[i]));
 			else
-				printf("%s: %llu\n", argv[j], size/2);
+				printf("%s: %llu\n", argv[i], get_dev_blocks(argv[i]));
 		}
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	if (argc-optind == 1)
-- 
1.7.4.1



