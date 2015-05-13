Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:44779
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbbEMGgM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 May 2015 02:36:12 -0400
Date: Wed, 13 May 2015 08:36:04 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Ron <ron@debian.org>, 785116@bugs.debian.org
Cc: util-linux@vger.kernel.org
Subject: Re: Bug#785116: util-linux: blkid -s returns too much information
Message-ID: <20150513063604.GA466@fatal.se>
References: <20150512132634.1127.8640.reportbug@hex.shelbyville.oz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150512132634.1127.8640.reportbug@hex.shelbyville.oz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Ron!

On Tue, May 12, 2015 at 10:56:34PM +0930, Ron wrote:
> Package: util-linux
> Version: 2.25.2-6
> Severity: important
> 
> Hi, 
> 
> Sometime between wheezy and jessie, it appears blkid -s got broken.
> In jessie it now does this:
> 
>  # blkid -s UUID -o export /dev/sdb1
>  DEVNAME=/dev/sdb1
>  UUID=fb936a62-4a21-4cc5-a55e-da21aa3f6685

The reason DEVNAME is printed is because you're using the export
output format.

This behaviour was introduced in:

commit dab33573876270fec7550252bcc29c34e9ad3889
Author: Karel Zak <kzak@redhat.com>
Date:   Fri Mar 2 14:05:26 2012 +0100

    blkid: add DEVNAME= to export output format
    
    Reported-by: Balamurugan Arumugam <barumuga@redhat.com>
    Signed-off-by: Karel Zak <kzak@redhat.com>

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index b0524ca..dfdb8b9 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -310,6 +310,8 @@ static void print_value(int output, int num, const char *devname,
                print_udev_format(name, value);
 
        } else if (output & OUTPUT_EXPORT_LIST) {
+               if (num == 1 && devname)
+                       printf("DEVNAME=%s\n", devname);
                fputs(name, stdout);
                fputs("=", stdout);
                safe_print(value, valsz);

Apparently this behaviour is established since a very long time:
$ git describe dab33573876270fec7550252bcc29c34e9ad3889
v2.21-40-gdab3357
Possibly changing the output format now could be risky.
It's very unfortunate that Debian has lagged so long with updating
util-linux which means we notice these things so long after they
appeared.

> 
> Which is a bit unfortunate when the reason for doing that was to get
> the UUID for an fstab entry in an installer preseed file :)

Lets ask upstream if DEVNAME is considered a tag which should
be included in the tag filtering.... CCed.

Regards,
Andreas Henriksson
