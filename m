Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22806 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbaD1JrD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Apr 2014 05:47:03 -0400
Date: Mon, 28 Apr 2014 11:00:03 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 08/12] swapon: swaps with legacy version label are not
 supported
Message-ID: <20140428090003.GM2405@x2.net.home>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
 <1398629138-31718-9-git-send-email-kerolasa@iki.fi>
 <1398674252.3689.111120501.427ACD73@webmail.messagingengine.com>
 <CAG27Bk15aE5t7zDUg=LONmZ8q9ZgwvEauwXstEV6HA5xE3eCJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk15aE5t7zDUg=LONmZ8q9ZgwvEauwXstEV6HA5xE3eCJg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 28, 2014 at 09:44:01AM +0100, Sami Kerola wrote:
> On 28 April 2014 09:37, Benno Schulenberg <bensberg@justemail.net> wrote:
> >
> > On Sun, Apr 27, 2014, at 22:05, Sami Kerola wrote:
> >> -     if (memcmp(buf, "SWAP-SPACE", 10) == 0 ||
> >> -            memcmp(buf, "SWAPSPACE2", 10) == 0)
> >> +     if (memcmp(buf, SWAP_SIGNATURE, 10) == 0)
> >
> > s/10/SWAP_SIGNATURE_SZ/  ?
> 
> Hi Benno,
> 
> Yes, that would be better. Karel, can you amend & add Benno as reviewer?

 Sure, what about to add macro is_swap_magic() to include/ to hide all the
 details? BTW, there is also libblkid/src/superblocks/swap.c :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
