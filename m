Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60081 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965137AbbD0V1O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Apr 2015 17:27:14 -0400
Message-ID: <553EA9AB.1000608@gmx.com>
Date: Mon, 27 Apr 2015 17:27:07 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Alexey Galakhov <agalakhov@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com> <20150427082729.GK27969@ws.net.home>
In-Reply-To: <20150427082729.GK27969@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I do not understand what this patch accomplishes. stdout is line
buffered. All of hwclock -c output ends with \n, which flushes
the buffer. Then we flush it again with fflush? What am I missing?

On 04/27/2015 04:27 AM, Karel Zak wrote:
> On Thu, Apr 16, 2015 at 05:26:27PM +0200, Alexey Galakhov wrote:
>> This allows using hwclock -c in automated test scripts that parse
>> its output line-by-line. The standard output is flushed before
>> each 10 second delay.
>>
>> Signed-off-by: Alexey Galakhov <agalakhov@gmail.com>
>> ---
>>  sys-utils/hwclock.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
>  Applied, thanks. We will see shat happen in future...
> 
>     Karel
> 
