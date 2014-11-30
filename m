Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33395 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917AbaK3Qes (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 30 Nov 2014 11:34:48 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id E416820750
	for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 11:34:47 -0500 (EST)
Message-Id: <1417365287.1296747.196968317.62A1BE41@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1417355862-16935-10-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
 <1417355862-16935-10-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 09/10] lscpu: blacklist vmware_bdoor() AddressSanitizer check
Date: Sun, 30 Nov 2014 17:34:47 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Nov 30, 2014, at 14:57, Sami Kerola wrote:
> AddressSanitizer is identifying the __asm__ segment as suspicious.

Hmm...  How come that it doesn't flag the very similar segment in
static inline void cpuid(...) as suspicious?  Is it the 'inl' command?
(What does this do anyway?  It isn't an x86 assembly that I can find.)

> -static inline
> +static inline UL_ASAN_BLACKLIST
>  void vmware_bdoor(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)

While here, maybe move the 'void' to the previous line?

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin

