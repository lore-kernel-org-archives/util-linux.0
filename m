Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:53822 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbeBQGrB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 17 Feb 2018 01:47:01 -0500
Date: Sat, 17 Feb 2018 01:46:53 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Karel Zak <kzak@redhat.com>
Cc: Peter Cordes <peter@cordes.ca>, util-linux@vger.kernel.org,
        Hornseth_Brenan@bah.com
Subject: Re: [PATCH] fsck: use xasprintf to avoid buffer overruns with an
 insane fs type
Message-ID: <20180217064653.GH12890@thunk.org>
References: <20180215200508.1466-1-tytso@mit.edu>
 <20180216155505.GL9479@cordes.ca>
 <20180216180820.ay7plq2du5xjwqms@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216180820.ay7plq2du5xjwqms@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 16, 2018 at 07:08:20PM +0100, Karel Zak wrote:
> 
> Maybe all we need is to check -t argument and reject non-senses
> already in main() ;-)

I also thought about rejecting any file system type larger than, say,
16 characters.  Then I looked at the kernel code, and in theory
there's nothing stopping someone from creating an out-of-tree kernel
file system with a file system type of, say, for example:

	supercalifragilisticexpialidocious

:-)

					- Ted
