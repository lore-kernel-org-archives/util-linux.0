Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55032 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbbG0KmQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jul 2015 06:42:16 -0400
Date: Mon, 27 Jul 2015 12:42:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/5] cfdisk: bring the hint line closer to the menu line
Message-ID: <20150727104214.GD6865@ws.net.home>
References: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
 <1437837498-23833-3-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437837498-23833-3-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 25, 2015 at 05:18:16PM +0200, Benno Schulenberg wrote:
> To make it clearer that they belong together.

Please, don't treat with users as idiots. This is (c)fdisk, no gnome
project...

> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  disk-utils/cfdisk.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
> index 5e46136..ddec7f4 100644
> --- a/disk-utils/cfdisk.c
> +++ b/disk-utils/cfdisk.c
> @@ -94,7 +94,7 @@
>  #define MENU_H_POSTSTR_SZ	(sizeof(MENU_H_POSTSTR) - 1)
>  
>  #define TABLE_START_LINE	4
> -#define MENU_START_LINE		(ui_lines - 5)
> +#define MENU_START_LINE		(ui_lines - 3)
>  #define INFO_LINE		(ui_lines - 2)
>  #define WARN_LINE		INFO_LINE
>  #define HINT_LINE		(ui_lines - 1)

I don't like it, on small terminal the menu uses two lines. It
introduces a new problem which you want to fix in another patch.
Unnecessary.

I have moved the menu to (ui_lines - 4), it's enough.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
