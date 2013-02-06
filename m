Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab3BFKgX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Feb 2013 05:36:23 -0500
Date: Wed, 6 Feb 2013 11:36:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] adding accents, fixing encodings, and more textual
 stuff
Message-ID: <20130206103620.GD17190@x2.net.home>
References: <1359477853.14228.140661184045573.44739122@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1359477853.14228.140661184045573.44739122@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 29, 2013 at 05:44:13PM +0100, Benno Schulenberg wrote:
> The first patch adds accents to a few names in the NEWS file;
> since this file is now UTF-8 it will support accented letters.
> The second patch does this for one name in the AUTHORS file,
> but mainly removes four duplicates from that file.  That these
> names are duplicates is evidenced by their contributions being
> claimed by a single person on Ohloh.net, or the email address
> being identical.  The third patch spells and encodes the name
> of Arkadiusz Miśkiewicz correctly in fifty odd files -- it has
> annoyed me for quite a while to see this strange question mark
> and the note "converted" when opening any of those files with
> vim.  The fourth patch fixes two more misencodings in two files
> -- as far as I can tell no more improper codes between hex 80
> and hex ff remain in the repo.
> 
> The fifth patch gettextizes an overlooked string, and the sixth
> patch improves an error message and the help text of isosize,
> mainly adding the standard angular brackets around arguments.

 All applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
