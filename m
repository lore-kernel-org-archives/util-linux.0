Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290Ab3A3STb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Jan 2013 13:19:31 -0500
Date: Wed, 30 Jan 2013 19:19:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] adding accents, fixing encodings, and more textual
 stuff
Message-ID: <20130130181927.GH3741@x2.net.home>
References: <1359477853.14228.140661184045573.44739122@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359477853.14228.140661184045573.44739122@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 29, 2013 at 05:44:13PM +0100, Benno Schulenberg wrote:
> The first patch adds accents to a few names in the NEWS file;
> since this file is now UTF-8 it will support accented letters.

I have applied last two patches only. It seems like a problem with
email encoding, my mutt see the attachments as

 0001-docs-NEWS-add-some-missing-accents-    [text/x-patch, base64, us-ascii, 6.3K]

What about to send the patches by git-send? ..or use tar ball if canot
use git-send.

    Karel

$ git am -i -3 ~/00*.patch
Commit Body is:
--------------------------
docs: NEWS: add some missing accents, since this is now UTF-8

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all y
Applying: docs: NEWS: add some missing accents, since this is now
UTF-8
Using index info to reconstruct a base tree...
error: patch failed: NEWS:347
error: NEWS: patch does not apply
Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Cannot fall back to three-way merge.
Patch failed at 0001 docs: NEWS: add some missing accents, since this
is now UTF-8
The copy of the patch that failed is found in:
   /home/projects/util-linux/util-linux/.git/rebase-apply/patch
   When you have resolved this problem, run "git am --resolved".
   If you prefer to skip this patch, run "git am --skip" instead.
   To restore the original branch and stop patching, run "git am
   --abort".



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
