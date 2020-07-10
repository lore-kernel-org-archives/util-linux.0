Return-Path: <SRS0=rKDH=AV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F0C433DF
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 03:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC920708
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 03:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGGcrPzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJDFx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDFw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 23:05:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C696C08C5CE
        for <util-linux@vger.kernel.org>; Thu,  9 Jul 2020 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=6Zo8FiCHj6A1VRqONU66icahTicT7SuJ/vp+7ddtbV8=; b=rGGcrPzjdybk7IZeDRihJ7bP/F
        554ozmL9mwBpoMLIxLAXIl6FmxXo41kzTIROrop6rRwHkmXys5ZGc5VYkpqQwa1ClF27K63kaXGLl
        TrzRLWFHc2xmze+ANJaW2UcjpIXIVR8bGr1cCGiN7zyELfMdw96v3XR5/N0jYvQ9WWOGniK2s7mlW
        BrPGiL0gQBPbPdZbhHY4RzPwpTL5P625utedccg7PNcGieLIGf8xKVkiVzUms4/qdFuNIGnMjU41f
        6baVhn43ISxISUKscK9W0xht1IkLQ2/q0VHvr5iBX0+DrkgOXv0KPVet/VVT4SF6JHxqwAvzqqf/R
        PLuVs3pw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtjME-0000Pp-6Y; Fri, 10 Jul 2020 03:05:50 +0000
Subject: Re: [PATCH] Subject: docs: disk-utils: change "allows to <verb>" to
 "allows <verb>ing"
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>,
        util-linux@vger.kernel.org
References: <20200710013909.GA2922@rhi.hi.is>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <326fa9c2-81d1-61af-bf1a-87725342fae8@infradead.org>
Date:   Thu, 9 Jul 2020 20:05:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710013909.GA2922@rhi.hi.is>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 7/9/20 6:39 PM, Bjarni Ingi Gislason wrote:
>   The web site "lintian.debian.org" shows some examples of "allows to",
> which are changed to "allows one to".
> 
>   I chose here to use gerund.
> 
> Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>

LGTM.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  disk-utils/fdisk.8     | 2 +-
>  disk-utils/sfdisk.8    | 6 +++---
>  disk-utils/swaplabel.8 | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
> index f683bcaaa..8780a7419 100644
> --- a/disk-utils/fdisk.8
> +++ b/disk-utils/fdisk.8
> @@ -200,7 +200,7 @@ are deprecated.
>  
>  .SH SCRIPT FILES
>  .B fdisk
> -allows to read (by 'I' command) sfdisk compatible script files. The script is
> +allows reading (by 'I' command) sfdisk compatible script files. The script is
>  applied to in-memory partition table, and then it is possible to modify the
>  partition table before you write it to the device.
>  .PP
> diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
> index 6c278afb6..38a674853 100644
> --- a/disk-utils/sfdisk.8
> +++ b/disk-utils/sfdisk.8
> @@ -295,7 +295,7 @@ disk label (see the \fBEMPTY DISK LABEL\fR section below).
>  .TP
>  .BR \-Y , " \-\-label\-nested " \fItype
>  Force editing of a nested disk label.  The primary disk label has to exist already.
> -This option allows to edit for example a hybrid/protective MBR on devices with GPT.
> +This option allows editing for example a hybrid/protective MBR on devices with GPT.
>  
>  .TP
>  .BR \-w , " \-\-wipe "\fIwhen
> @@ -469,7 +469,7 @@ loaders and for other operating systems.
>  
>  .B Named-fields format
>  .RS
> -This format is more readable, robust, extensible and allows to specify additional
> +This format is more readable, robust, extensible and allows specifying additional
>  information (e.g., a UUID).  It is recommended to use this format to keep your scripts
>  more readable.
>  .RS
> @@ -480,7 +480,7 @@ more readable.
>  The
>  .I device
>  field is optional.  \fBsfdisk\fR extracts the partition number from the
> -device name.  It allows to specify the partitions in random order.
> +device name.  It allows specifying the partitions in random order.
>  This functionality is mostly used by \fB\-\-dump\fR.
>  Don't use it if you are not sure.
>  
> diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
> index b623a5020..c92de00a5 100644
> --- a/disk-utils/swaplabel.8
> +++ b/disk-utils/swaplabel.8
> @@ -35,7 +35,7 @@ These values can also be set during swap creation using
>  .BR mkswap (8).
>  The
>  .B swaplabel
> -utility allows to change the label or UUID on an actively used swap device.
> +utility allows changing the label or UUID on an actively used swap device.
>  .SH OPTIONS
>  .TP
>  .BR \-h , " \-\-help"
> 


-- 
~Randy
