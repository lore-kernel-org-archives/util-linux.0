Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55261 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497AbaK3R17 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 30 Nov 2014 12:27:59 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 4CB8B20399
	for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 12:27:59 -0500 (EST)
Message-ID: <547B539E.9020902@dasyatidae.net>
Date: Sun, 30 Nov 2014 11:27:58 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Sami Kerola <kerolasa@iki.fi>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 09/10] lscpu: blacklist vmware_bdoor() AddressSanitizer
 check
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi> <1417355862-16935-10-git-send-email-kerolasa@iki.fi> <1417365287.1296747.196968317.62A1BE41@webmail.messagingengine.com>
In-Reply-To: <1417365287.1296747.196968317.62A1BE41@webmail.messagingengine.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Benno Schulenberg wrote:
> Hmm...  How come that it doesn't flag the very similar segment in
> static inline void cpuid(...) as suspicious?  Is it the 'inl' command?
> (What does this do anyway?  It isn't an x86 assembly that I can find.)

The IN does a read from I/O port space; the "l" suffix in AT&T syntax means
32-bit operand size.  I'm guessing AddressSanitizer sees what looks like a
memory reference with 16-bit address size coming from nowhere that should
have a pointer in it and complains.  It's not a "real" memory reference,
so ignoring the whole function seems reasonable.  (It's very unusual to use
that instruction from userspace, so it's not surprising it wouldn't be
recognized.)

   ---> Drake Wilson

