Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61566 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdFLT2A (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 15:28:00 -0400
Received: from [10.0.0.104] ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2Glc-1e9zj82ks8-00s3YL for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 21:27:58 +0200
Subject: Re: [PATCH 5/6] misc: fix gcc-7 snprintf warnings -Wformat-truncation
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
 <20170612084958.22054-6-sweet_f_a@gmx.de>
Message-ID: <64d3bf7c-84b8-1f5b-663f-82860b3d2d56@gmx.de>
Date: Mon, 12 Jun 2017 21:27:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170612084958.22054-6-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

BTW there is another of these warnings left, see below. I'm not sure here what
to do. Note, it's pssible to silent this warning also by _using_ snprintf's
return value.

../libblkid/src/partitions/partitions.c:1371:45: warning: '%02x' directive output may be truncated writing between 2 and 8 bytes into a region of size between 0 and 36 [-Wformat-truncation=]
   snprintf(par->uuid, sizeof(par->uuid), "%s-%02x",
                                              ^~~~
../libblkid/src/partitions/partitions.c:1371:41: note: using the range [0, 4294967295] for directive argument
   snprintf(par->uuid, sizeof(par->uuid), "%s-%02x",
                                          ^~~~~~~~~
../libblkid/src/partitions/partitions.c:1371:2: note: 'snprintf' output between 4 and 46 bytes into a destination of size 37
   snprintf(par->uuid, sizeof(par->uuid), "%s-%02x",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     par->tab->id, par->partno);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~

