Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44674 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236Ab1HPMdR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2011 08:33:17 -0400
Date: Tue, 16 Aug 2011 14:33:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] small fixes to some help texts and man pages
Message-ID: <20110816123313.GB14535@nb.net.home>
References: <1313434832.3403.140258129904445@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313434832.3403.140258129904445@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2011 at 09:00:32PM +0200, Benno Schulenberg wrote:
> Attached bunch of patches correct some small mistakes in some
> help texts and man pages, and additionally make several small
> improvements in wording and formatting.  They also slice up some
> help texts into small chunks, to make things easier to handle for
> translators.

 Good idea. Thanks.

> In the source tree there are two mount.c files: mount/mount.c
> and libmount/samples/mount.c.  Is the latter a future replacement
> of the first?  Or is it a version that can already be used instead of
> the former one?  If both are valid versions, then the sixth patch
> should not be applied and the seventh yes.  If the mount.c in
> libmount/ is just sample code or a future replacement, then
> please apply the sixth patch (although you may want to change
> the actual mechanism of the exclusion).

 All applied :-) The libmount/sample/mount.c is a future replacement.
 It's good idea to ignore */samples/* directories.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
