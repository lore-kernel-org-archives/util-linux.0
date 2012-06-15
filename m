Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58387 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab2FOJN7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 05:13:59 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 00DB990983
	for <util-linux@vger.kernel.org>; Fri, 15 Jun 2012 11:13:58 +0200 (CEST)
Message-ID: <4FDAFCD4.7010205@suse.de>
Date: Fri, 15 Jun 2012 11:13:56 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: remove encryption options from mount and losetup?
References: <4FD8A950.5000906@suse.de> <20120613150144.GE10561@x2.net.home> <4FD9CF44.8090800@suse.de> <20120615084753.GA2566@x2.net.home>
In-Reply-To: <20120615084753.GA2566@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Jun 14, 2012 at 01:47:16PM +0200, Ludwig Nussel wrote:
>> Karel Zak wrote:
>>> On Wed, Jun 13, 2012 at 04:53:04PM +0200, Ludwig Nussel wrote:
>>>> Is there any reason to still keep the encryption options in losetup and
>>>> mount around? They look entirely useless to me. Even when using passfd
>>>> and an external key generation function it's still broken as the key
>>>> size is fixed at 32 byte and the last byte is always set to '\0'.
>>>> So would a patch that removes encryption support completely be
>>>> acceptable?
>>>
>>> Our goal is to follow kernel, so it would be better to remove this
>>> feature from kernel loopdev first.
>>
>> Well, someone could come up with another tool to support cryptoloop, or
>> rather 'transfer functions'.
>> If losetup has the philosophy to provide the canonical implementation
>> for all loop features then losetup isn't complete anyways. It needs
> 
>  I don't know what was original idea, but the current '--encryption'
>  works somehow. Yes, it's not perfect, it's maybe almost useless,
>  but it's still have some users and we cannot remove it without a
>  prior warning.
> 
>  Fortunately, cryptoloop is in our deprecated.txt for years, so I think
>  it's should be enough to add a fat warning to the next v2.22 release
>  and remove this feature in v2.23.

>From a distribution PoV it doesn't really matter. I just need to know
the direction :-) I'm currently struggling between porting our old patch
that adds password hashing to losetup once again or to remove encryption
support from losetup completely. I think we cannot ship 12.2 with the
current upstream state as that would add a third and even more broken
way than what we had before.

>  Anyway, I like Milan's idea with libcryptsetup, and we will try to
>  prepare any solution. BTW, the current cryptsetup also support loop-aes ;-)

Sure but setting up the block device is probably not what mount
should do.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
