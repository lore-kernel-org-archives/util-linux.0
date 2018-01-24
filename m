Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932953AbeAXMQ6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 07:16:58 -0500
Date: Wed, 24 Jan 2018 13:16:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] fixes for fsck.cramfs and other things
Message-ID: <20180124121655.v5pr5wetsezlsa77@ws.net.home>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 23, 2018 at 04:59:21PM +0100, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Ruediger Meier (6):
>   Revert "fsck.cramfs: Fix bus error on broken file system."
>   fsck.cramfs: fix crash when superblock size is too small
>   tests: rewrite fsck-bad-header

Nice.

>   fsck.cramfs: fix error message
>   tests: fix fincore/count KNOWN_FAIL
>   rfkill: provide RFKILL_TYPE_FM if undefined

Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
