Return-Path: util-linux-owner@vger.kernel.org
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50258 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdBQAMk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 16 Feb 2017 19:12:40 -0500
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
To: Benno Schulenberg <bensberg@justemail.net>,
        Karel Zak <kzak@redhat.com>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
 <20170216103352.rxt4jyxry6zpuxrb@ws.net.home>
 <1487247307.2341564.882965648.11DC77E0@webmail.messagingengine.com>
Cc: Shaun Tancheff <shaun@tancheff.com>,
        Util-Linux <util-linux@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <ea1698c4-b055-e498-b154-d8931817bc36@wdc.com>
Date: Fri, 17 Feb 2017 09:12:29 +0900
MIME-Version: 1.0
In-Reply-To: <1487247307.2341564.882965648.11DC77E0@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Benno,

On 2/16/17 21:15, Benno Schulenberg wrote:
> 
> On Thu, Feb 16, 2017, at 11:33, Karel Zak wrote:
>>   blkzone report [--zone <offset>] [--count <length>]
>>   blkzone reset  [--zone <offset>] [--count <length>]
> 
> "blkzone --zone" feels a bit strange.  I would suggest:
> 
>   blkzone <command> [--offset <sector>] [--count <number>]

Indeed, it is a little awkward. And to be consistent with other tools
such as blkdiscard, I would also suggest --length instead of --count.

So:

blkzone report [--offset <offset>] [--length <length>]
blkzone reset  [--offset <offset>] [--length <length>]

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
