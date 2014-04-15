Return-Path: util-linux-owner@vger.kernel.org
Received: from cn.fujitsu.com ([59.151.112.132]:40140 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751278AbaDOCOD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Apr 2014 22:14:03 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3F2DseI018108
	for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 10:13:54 +0800
Message-ID: <534C9625.8030906@cn.fujitsu.com>
Date: Tue, 15 Apr 2014 10:15:01 +0800
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
To: <util-linux@vger.kernel.org>
Subject: libblkid: Idea to force given cached entry to be invalidated?
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

When using the blkid_get_cache(), things will be cached to reduce the 
probe frequency.

But filesystem which supports device management like btrfs can remove 
device and
if fast enough, libblkid will not invalidate the old cache and cause to 
get the wrong filesystem type.

The bug is describe in the following btrfs patch:
https://patchwork.kernel.org/patch/3960191/

Though the above patch try to avoid the whole cache, it's not good 
enough since it break the pricible not
to probe the devices too frequently.

After some searching, it seems that libblkid does not provide such API, 
or am I missing something?

So is there any idea about forcing given cached entry invalidated?

Thanks,
Qu
