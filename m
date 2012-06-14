Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48553 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab2FNLrZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jun 2012 07:47:25 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 655D290B96
	for <util-linux@vger.kernel.org>; Thu, 14 Jun 2012 13:47:24 +0200 (CEST)
Message-ID: <4FD9CF44.8090800@suse.de>
Date: Thu, 14 Jun 2012 13:47:16 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: remove encryption options from mount and losetup?
References: <4FD8A950.5000906@suse.de> <20120613150144.GE10561@x2.net.home>
In-Reply-To: <20120613150144.GE10561@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Jun 13, 2012 at 04:53:04PM +0200, Ludwig Nussel wrote:
>> Is there any reason to still keep the encryption options in losetup and
>> mount around? They look entirely useless to me. Even when using passfd
>> and an external key generation function it's still broken as the key
>> size is fixed at 32 byte and the last byte is always set to '\0'.
>> So would a patch that removes encryption support completely be
>> acceptable?
> 
> Our goal is to follow kernel, so it would be better to remove this
> feature from kernel loopdev first.

Well, someone could come up with another tool to support cryptoloop, or
rather 'transfer functions'.
If losetup has the philosophy to provide the canonical implementation
for all loop features then losetup isn't complete anyways. It needs
options to set lo_encrypt_type, lo_crypt_name and lo_encrypt_key_size
independent of each other then. Also, overwriting the last 8 bits of the
key with zeroes certainly defeats the purpose. Those transfer functions
are dynamic so it's possible to have others than cryptoloop with different
semantics on the lo_encrypt_* fields.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
