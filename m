Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdF2LIU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 07:08:20 -0400
Date: Thu, 29 Jun 2017 13:08:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: exit() vs _exit()
Message-ID: <20170629110816.ed3yiuvrg5hslysa@ws.net.home>
References: <201706290331.04310.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706290331.04310.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 29, 2017 at 03:31:04AM +0200, Ruediger Meier wrote:
>   libmount/src/context_mount.c
>   libmount/src/context_umount.c
> 
> Is this really ok or shouldn't we use _exit() there?

Fixed, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
