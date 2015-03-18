Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:64746 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbbCRAfH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 20:35:07 -0400
Message-ID: <5508C836.1070702@gmx.com>
Date: Tue, 17 Mar 2015 20:35:02 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] hwclock: remove unneeded stuff from the man-page
 header
References: <1426624493-2464-1-git-send-email-bensberg@justemail.net> <1426624493-2464-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1426624493-2464-2-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


First, you have no right to assign my name to anything, let alone a
legal notice.

Second, we've already been through this. The decision was left to Karel
and he accepted it as is. There is nothing wrong with a man-page having
some top comments.

On 03/17/2015 04:34 PM, Benno Schulenberg wrote:
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  sys-utils/hwclock.8.in |   21 +++------------------
>  1 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index 9682244..145e089 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -1,24 +1,9 @@
>  .\" hwclock.8.in -- man page for util-linux' hwclock
>  .\"
> -.\" 2015-01-07 J William Piggott
> -.\" Authored new section: DATE-TIME CONFIGURATION.
> -.\" Subsections: Keeping Time..., LOCAL vs UTC, POSIX vs 'RIGHT'.
> -.\" Errata and drop outdated language.
> -.\" Updates for v2.26
> -.\"
> -.\"
> -.\" -------------------------------
> -.\" Included for troff portability.
> -.\" Continuation line for .TP header.
> -.de TQ
> -.  br
> -.  ns
> -.  TP \\$1\" no doublequotes around argument!
> -..
> -.
> -.\" -------------------------------
> +.\" Copyright 1996 Bryan Henderson <bryanh@giraffe-data.com>
> +.\" Copyright 2015 J. William Piggott <elseifthen@gmx.com>
>  .
> -.TH HWCLOCK 8 "January 2015" "util-linux" "System Administration"
> +.TH HWCLOCK 8 "March 2015" "util-linux" "System Administration"
>  .SH NAME
>  hwclock \- read or set the hardware clock (RTC)
>  .SH SYNOPSIS
> 
