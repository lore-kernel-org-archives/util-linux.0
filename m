Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59878 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726AbaLTOmz (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 20 Dec 2014 09:42:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 796E8207CE
	for <util-linux@vger.kernel.org>; Sat, 20 Dec 2014 09:42:54 -0500 (EST)
Message-Id: <1419086574.2592978.205177769.60905F6A@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20141219090925.GI19904@x2.net.home>
References: <1418847631-8317-1-git-send-email-bensberg@justemail.net>
 <20141219090925.GI19904@x2.net.home>
Subject: Re: RFC [patch] adding docstrings
Date: Sat, 20 Dec 2014 15:42:54 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Dec 19, 2014, at 10:09, Karel Zak wrote:
> On Wed, Dec 17, 2014 at 09:20:31PM +0100, Benno Schulenberg wrote:
> > For mkfs.cramfs, mkfs.minix, blkid and chrt I've had to
> > improvise -- putting the docstring before the synopis -- in order to
> > avoid making extensive changes to the usage text; those changes will
> > come later.)
> 
> hmm.. it would be better to be consistent and add the docstring to the
> same position in all utils.

Certainly.  These improvisations were meant as temporary measures.
A later patch would slice up and standardize the usage texts of the
mentioned utils and put the docstring into its proper place -- I just
wanted to avoid burdening this patch with such extensive and fairly
unrelated changes.

Probably it is better not to make temporary changes, so I will drop
the docstrings for the mentioned tools from the next version of the
patch.

By the way, there was some talk of obsoleting / scrapping / deleting
some of the utils.  Are there still such plans?  If so, it is maybe
better not to add docstrings for the tools that are going to be zapped
in the next cycle or so?

> you forgot _() NLS macro:
> 
> > +	fputs("Tell the kernel about the existence of a specified partition.\n", out);

Thanks.

Benno

-- 
http://www.fastmail.com - Or how I learned to stop worrying and
                          love email again

