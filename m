Return-Path: util-linux-owner@vger.kernel.org
Received: from cn.fujitsu.com ([59.151.112.132]:28207 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750881AbaGGEIx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 00:08:53 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6748mKu002595
	for <util-linux@vger.kernel.org>; Mon, 7 Jul 2014 12:08:48 +0800
Message-ID: <53BA1D8F.9060907@cn.fujitsu.com>
Date: Mon, 7 Jul 2014 12:09:51 +0800
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
To: <util-linux@vger.kernel.org>
Subject: udev + libbklid: synchronized uevent handling between kernel and
 ueventd?
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

If I understand right, when kernel sends a KOBJ_CHANGE uevent, udevd 
catches it and
update the ctime/mtime of the device file in /dev according to the uevent.
Do I understand the procedure right?

Then a problem occurs to me that, the above procedure is asynchronized,
so sometimes concurreny may happen when kernel send the uevent but udev has
not yet updated the ctime/mtime of device file, making libblkid cache 
still valid and gives wrong result.
(bringing the old thread again: 
http://www.spinics.net/lists/util-linux-ng/msg09154.html)

So i'm wondering is there some synchronized method to send uevent and 
wait for it completed?
Currently I use a method that opens and updates ctime/mtime in kernel 
spaces, but it's somewhat
ugly.
Hope there will be some elegent method.

Thanks,
Qu
