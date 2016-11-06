Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.73]:49539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbcKFU5F (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 6 Nov 2016 15:57:05 -0500
Subject: Re: [PATCH 3/3] tests: always quote $LODEV
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
 <1478358489-18103-3-git-send-email-sweet_f_a@gmx.de>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <6d62a61c-6dcf-e7a5-bfa3-5df4f93723a4@bernhard-voelker.de>
Date: Sun, 6 Nov 2016 21:57:01 +0100
MIME-Version: 1.0
In-Reply-To: <1478358489-18103-3-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/05/2016 04:08 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Since there is no error handling in this test $LODEV
> may be empty.
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tests/ts/losetup/losetup-loop | 46 +++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/ts/losetup/losetup-loop b/tests/ts/losetup/losetup-loop
> index cff12c9..13ccc65 100755
> --- a/tests/ts/losetup/losetup-loop
> +++ b/tests/ts/losetup/losetup-loop
> @@ -42,15 +42,15 @@ BACKFILE="$TS_DEVICE"
>  
>  ts_init_subtest "find-race-condition"
>  LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
> -$TS_CMD_LOSETUP -d $LODEV
> +$TS_CMD_LOSETUP -d "$LODEV"

So what happens now when losetup is fed with ""?
Wouldn't it be better to handle the error instead?

Have a nice day,
Berny
