Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:52596 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757610Ab2JQTX7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Oct 2012 15:23:59 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so4577496wey.19
        for <util-linux@vger.kernel.org>; Wed, 17 Oct 2012 12:23:58 -0700 (PDT)
Message-ID: <507F05C3.5070300@gmail.com>
Date: Wed, 17 Oct 2012 21:23:47 +0200
From: Milan Broz <gmazyland@gmail.com>
MIME-Version: 1.0
To: Andreas Hartmann <andihartmann@01019freenet.de>
CC: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>,
        util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: Questions concerning fstrim and online discard.
References: <20121004064736.64caef77@dualc.maya.org> <alpine.LFD.2.00.1210151649540.15261@dhcp-1-104.brq.redhat.com> <507D8B15.5050004@01019freenet.de> <alpine.LFD.2.00.1210162056290.18184@localhost> <507EEAB0.7060900@01019freenet.de>
In-Reply-To: <507EEAB0.7060900@01019freenet.de>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/17/2012 07:28 PM, Andreas Hartmann wrote:
> I read a few articles about encryption with SSD. With linux / dm-crypt /
> cryptseup luks, plausible deniability isn't given at all because of the
> architecture of cryptsetup luks and the not completely crypted disk.

You can have separated LUKS header (with recent cryptetup) and if you
have filled device with random, you can map another device with different
offset into it. So you get the same arch like "plausible" deniability
in truecrypt, just it need some script magic.
But not possible with TRIM obviously... (hidden disk, possibly mapped
to unused outer disk space, could be discarded).

> Are there any known successfully carried out attacks (= partition /
> filesystem was decryptable by the attacker) on crypted partitions on
> SSDs which would have been not successful without TRIM enabled or is it
> (as of today :-)) more of theory?

I don't think so.

Discarded blocks are kind of side channel, you get more info about
device (like I tried to show it here - I can detect filesystem
from cipherdevice pattern here
http://asalor.blogspot.cz/2011/08/trim-dm-crypt-problems.html

Also read FAQ
http://code.google.com/p/cryptsetup/wiki/FrequentlyAskedQuestions#5._Security_Aspects

But without another weakness it should not lead to decryption
of data (and if attacker can repeatedly get snapshots of ciphertext
device, it can be problem even today).

I would like people to tink about the problem, assess the risks and
if discard is acceptable for their particular use case, no problem
switch TRIM on.

And the most common case - encrypted laptop to secure data against
random thief - should still work even with TRIM.
But targeted attack is something different. Really, you need
particular threat model to say if it is a problem.

Milan
