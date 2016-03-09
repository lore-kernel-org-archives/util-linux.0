Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42994 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167AbcCIK6W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Mar 2016 05:58:22 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 38FF720ED6
	for <util-linux@vger.kernel.org>; Wed,  9 Mar 2016 05:58:21 -0500 (EST)
Message-Id: <1457521100.3212166.544009746.0578A459@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 2/3] mount: further improve formatting of the man page
Date: Wed, 09 Mar 2016 11:58:20 +0100
In-Reply-To: <1457520901-4133-2-git-send-email-bensberg@justemail.net>
References: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
 <1457520901-4133-2-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> -Checking files on NFS filesystem referenced by file descriptors (i.e.\& the
> +Checking files on NFS filesystems referenced by file descriptors (i.e.\& the
>  .B fcntl
>  and
>  .B ioctl
> -families of functions) may lead to inconsistent result due to the lack of
> -consistency check in kernel even if noac is used.
> +families of functions) may lead to inconsistent results due to the lack of
> +a consistency check in the kernel even if noac is used.
> +.\"  What is "noac"?

I can't figure out what noac is supposed to mean.

Direct current?  :)

Benno

-- 
http://www.fastmail.com - IMAP accessible web-mail

