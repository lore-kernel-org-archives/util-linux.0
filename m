Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50746 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab2FOHDx (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 15 Jun 2012 03:03:53 -0400
Message-ID: <4FDADE55.9040208@suse.de>
Date: Fri, 15 Jun 2012 09:03:49 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: Re: remove encryption options from mount and losetup?
References: <4FD8A950.5000906@suse.de> <20120613150144.GE10561@x2.net.home> <4FD9CF44.8090800@suse.de> <4FDA3ECF.9060607@redhat.com>
In-Reply-To: <4FDA3ECF.9060607@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Milan Broz wrote:
> On 06/14/2012 01:47 PM, Ludwig Nussel wrote:
>> Karel Zak wrote:
> 
>> Well, someone could come up with another tool to support cryptoloop, or
>> rather 'transfer functions'.
> 
> cryptsetup can map all compatible mappings with cryptoloop using dmcrypt
> (and it can automatically alloc loop device as well) so providing something
> compatible is just question of simple wrapper.
> 
> IMHO cryptoloop should be removed from kernel... The only usable (and secure)
> solution using this interface is out-of-mainline-tree loop-aes extension.

Sure. Who is going to send the patch?

I don't think this needs to be the precondition to remove the incomplete
encryption support from losetup. On the contrary, the current losetup
support makes cryptoloop even worse as there's no support for hashing
the passphrase nor a way to e.g. pipe a random key into losetup.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
