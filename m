Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbdF2IDT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 04:03:19 -0400
Date: Thu, 29 Jun 2017 10:03:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: exit() vs _exit()
Message-ID: <20170629080315.pjkzfmafatabq5kl@ws.net.home>
References: <201706290331.04310.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706290331.04310.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 29, 2017 at 03:31:04AM +0200, Ruediger Meier wrote:
> Hi,
> 
> I've noticed we have some exit() calls in the libs,
> 
> e.g. in exec_helper()
> 
>   libmount/src/context_mount.c
>   libmount/src/context_umount.c
> 
> Is this really ok or shouldn't we use _exit() there?

I think _exit() is better in this case.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
