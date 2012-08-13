Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab2HMNtF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Aug 2012 09:49:05 -0400
Date: Mon, 13 Aug 2012 15:48:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] eject: return proper 0/1 from eject_cdrom()
Message-ID: <20120813134858.GC21956@x2.net.home>
References: <1344266172-8818-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344266172-8818-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 06, 2012 at 11:16:12AM -0400, Dave Reisner wrote:
> main() expects this method to return 0 for failure and 1 for success, as
> the other eject_*() methods do. Add the missing comparison of ioctl() >= 0
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  sys-utils/eject.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sys-utils/eject.c b/sys-utils/eject.c
> index 08af08e..84bd342 100644
> --- a/sys-utils/eject.c
> +++ b/sys-utils/eject.c
> @@ -398,9 +398,9 @@ static void close_tray(int fd)
>  static int eject_cdrom(int fd)
>  {
>  #if defined(CDROMEJECT)
> -	return ioctl(fd, CDROMEJECT);
> +	return ioctl(fd, CDROMEJECT) >= 0;
>  #elif defined(CDIOCEJECT)
> -	return ioctl(fd, CDIOCEJECT);
> +	return ioctl(fd, CDIOCEJECT) >= 0;
>  #else
>  	warnx(_("CD-ROM eject unsupported"));
>  	errno = ENOSYS;

 Good idea, but did you read the code where eject_cdrom() is called
 (e.g. toggle_tray()) ?  I have applied the patch below.

    Karel


commit 3514cc3a8f14cc39589fee3edefaa161ac1bd0a6
Author: Dave Reisner <dreisner@archlinux.org>
Date:   Mon Aug 6 11:16:12 2012 -0400

    eject: return proper 0/1 from eject_cdrom()
    
    main() expects this method to return 0 for failure and 1 for success, as
    the other eject_*() methods do. Add the missing comparison of ioctl() >= 0
    
    Signed-off-by: Dave Reisner <dreisner@archlinux.org>
    Signed-off-by: Karel Zak <kzak@redhat.com>

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 08af08e..2097961 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -398,13 +398,13 @@ static void close_tray(int fd)
 static int eject_cdrom(int fd)
 {
 #if defined(CDROMEJECT)
-	return ioctl(fd, CDROMEJECT);
+	return ioctl(fd, CDROMEJECT) >= 0;
 #elif defined(CDIOCEJECT)
-	return ioctl(fd, CDIOCEJECT);
+	return ioctl(fd, CDIOCEJECT) >= 0;
 #else
 	warnx(_("CD-ROM eject unsupported"));
 	errno = ENOSYS;
-	return -1;
+	return 0;
 #endif
 }
 
@@ -432,7 +432,7 @@ static void toggle_tray(int fd)
 
 	case CDS_NO_DISC:
 	case CDS_DISC_OK:
-		if (eject_cdrom(fd))
+		if (!eject_cdrom(fd))
 			err(EXIT_FAILURE, _("CD-ROM eject command failed"));
 		return;
 	case CDS_NO_INFO:
@@ -453,7 +453,7 @@ static void toggle_tray(int fd)
 	gettimeofday(&time_start, NULL);
 
 	/* Send the CDROMEJECT command to the device. */
-	if (eject_cdrom(fd) < 0)
+	if (!eject_cdrom(fd))
 		err(EXIT_FAILURE, _("CD-ROM eject command failed"));
 
 	/* Get the second timestamp, to measure the time needed to open



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
