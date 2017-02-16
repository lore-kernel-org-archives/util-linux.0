Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753946AbdBPKdz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 16 Feb 2017 05:33:55 -0500
Date: Thu, 16 Feb 2017 11:33:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Shaun Tancheff <shaun@tancheff.com>
Cc: util-linux@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
Message-ID: <20170216103352.rxt4jyxry6zpuxrb@ws.net.home>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

On Mon, Jan 23, 2017 at 08:32:42PM +0700, Shaun Tancheff wrote:
>  - blkreset to issue Reset (Write Pointer) zone commands
>  - blkreport to retrieve drive zone information

Shaun and Damien, what about to merge all to the 'blkzone'
command? Something like:

  blkzone report [--zone <offset>] [--count <length>]
  blkzone reset  [--zone <offset>] [--count <length>]

if there is no objection I'll do it today or tomorrow.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
