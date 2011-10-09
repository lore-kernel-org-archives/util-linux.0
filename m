Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33495 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab1JIVXN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Oct 2011 17:23:13 -0400
Received: by vcbgb30 with SMTP id gb30so284487vcb.19
        for <util-linux@vger.kernel.org>; Sun, 09 Oct 2011 14:23:12 -0700 (PDT)
Date: Sun, 9 Oct 2011 17:23:26 -0400
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mountpoint: return dev_t from dir_to_device
Message-ID: <20111009212326.GP782@rampage>
References: <1318131111-30395-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318131111-30395-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 08, 2011 at 11:31:50PM -0400, Dave Reisner wrote:
> The string returned from this function was never of much use other than
> to stat the path when the user requested a major:minor pair beyond the
> true/false exit. Save some processing and directly returning the dev_t
> on success, and an impossible value on failure.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  sys-utils/mountpoint.c |   15 +++++++--------
>  1 files changed, 7 insertions(+), 8 deletions(-)
> 

I'll also mention that this fixes an issue with mountpoint that causes
it to throw a false negative when /proc is mounted with a source of
"none". This value is treated specially in libmount and sets the source
to NULL, which makes dir_to_device() incorrectly claim that the directory
is not in fact a mountpoint.

Regards,
dave
