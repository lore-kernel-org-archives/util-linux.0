Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdFZI1s (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 04:27:48 -0400
Date: Mon, 26 Jun 2017 10:27:44 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] pull request
Message-ID: <20170626082744.fx4zzuq4sgpzdkk6@ws.net.home>
References: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 25, 2017 at 05:45:56PM -0400, J William Piggott wrote:
> 
> * Rudi didn't like cluttering boilerplate.c with seldom used USAGE_*
>   constants and I don't disagree with that point. I do think they should
>   be in the file for new contributor discovery purposes. As a compromise
>   I added the missing ones as a comment.
> 
> * the newly added USAGE_COLUMNS could be used in disk-utils/fdisk-list.c:432
>   if Karel wants to drop the ' (for -o)'. I did not change it.

I think USAGE_COLUMNS should be good enough everywhere and the
additional notes (like ' (for -o)') are unnecessary.

Maybe we can change the text to "Available output columns:" to make it
more specific for readers.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
