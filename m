Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab1IBNJk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Sep 2011 09:09:40 -0400
Date: Fri, 2 Sep 2011 15:09:31 +0200
From: Karel Zak <kzak@redhat.com>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: dmesg(1) bug
Message-ID: <20110902130931.GA4117@nb.redhat.com>
References: <20110831104859.GB1547@nb.net.home> <x6zkiopqua@gzp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <x6zkiopqua@gzp>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 01, 2011 at 11:14:05AM +0200, Gabor Z. Papp wrote:
> After patching dmesg, there is still difference between the old 2.19.x
> and the new 2.20 output.
> -  Intel GenuineIntel
> + Intel GenuineIntel

This is small bug, kernel uses extra space after [...] time stamp.
The new dmesg(1) removes this space at the begin of the message, but
always and everywhere. The patch below fixes this issue
(unfortunately, kernel.org is still down, so I can't push it..).

> -generic-usb 0003:045E:001E.0001: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1/input0
> +input: Microsoft Microsoft IntelliMouse\xffffffc2\xffffffae Explorer as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0/input/input1

Do you have enabled widechar support? (See HAVE_WIDECHAR in config.h).

The new dmesg(1) does not blindly print all unprintable chars
(iswprint(), isprint()).

  Karel


>From 31c9099a81d3a9c70fdceb198eebed678173d954 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Fri, 2 Sep 2011 14:42:04 +0200
Subject: [PATCH] dmesg: remove extra space only after time stamp

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/dmesg.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 8e7bb4b..b3713a0 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -480,11 +480,10 @@ static int get_next_record(struct dmesg_control *ctl, struct dmesg_record *rec)
 						break;
 				}
 			}
+			if (begin < end && *begin == ' ')
+				begin++;
 		}
 
-		if (begin < end && *begin == ' ')
-			begin++;
-
 		rec->mesg = begin;
 		rec->mesg_size = end - begin;
 
-- 
1.7.6

