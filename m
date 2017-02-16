Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55285 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754211AbdBPMPJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 16 Feb 2017 07:15:09 -0500
Message-Id: <1487247307.2341564.882965648.11DC77E0@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Shaun Tancheff <shaun@tancheff.com>,
        "Util-Linux" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Date: Thu, 16 Feb 2017 13:15:07 +0100
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
In-Reply-To: <20170216103352.rxt4jyxry6zpuxrb@ws.net.home>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
 <20170216103352.rxt4jyxry6zpuxrb@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Feb 16, 2017, at 11:33, Karel Zak wrote:
>   blkzone report [--zone <offset>] [--count <length>]
>   blkzone reset  [--zone <offset>] [--count <length>]

"blkzone --zone" feels a bit strange.  I would suggest:

  blkzone <command> [--offset <sector>] [--count <number>]

Benno

-- 
http://www.fastmail.com - Same, same, but different...

