Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:56938 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab3AHKxT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Jan 2013 05:53:19 -0500
Date: Tue, 8 Jan 2013 10:44:43 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: util-linux@vger.kernel.org
Subject: Preservation of non-kernel mount options
Message-ID: <20130108104443.GF3739@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Apologies if this is already implemented in git and I didn't notice.

Options like _netdev, comment= etc. are currently just ignored by
mount AFAICS.  It would however be quite useful if they could be
preserved in e.g. utab if possible so that you can use this to
label mounts so that you can query for the information later using
e.g. mount or findmnt.  Is this something which might be possible
to add if it's not already possible?

It turned out (at least in Debian) that some users were using the
"bind" option to track which filesystems were to be e.g. backed up,
space usage checked etc. (or not).  With the switch to /proc/mounts
this information has been lost.  While using the bind option to do
this is debatable, I was looking for a better and more robust
solution to their problem, and being able to attach comments to
the mounts seemed like it would fit in with the existing tools
if they could be stored.


Thanks,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux    http://people.debian.org/~rleigh/
 `. `'   schroot and sbuild  http://alioth.debian.org/projects/buildd-tools
   `-    GPG Public Key      F33D 281D 470A B443 6756 147C 07B3 C8BC 4083 E800
