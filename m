Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51297 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758551AbaGOJCJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 05:02:09 -0400
Message-Id: <1405414924.13201.141769101.02687AE4@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140715080234.GP30288@x2.net.home>
References: <1405331864.10850.141333833.2F92BBFD@webmail.messagingengine.com>
 <20140714145759.GM30288@x2.net.home>
 <1405351467.26224.141460601.7C1F0818@webmail.messagingengine.com>
 <20140715080234.GP30288@x2.net.home>
Subject: umount: --types does not limit
Date: Tue, 15 Jul 2014 11:02:04 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Jul 15, 2014, at 10:02, Karel Zak wrote:
>    umount -t <type>
> 
>  the <type> is filesystem type (so you can force umount to use for
>  example /sbin/umount.<type>).

Hmm.  But it's not working for me, the --types option does not limit
umount in any way.  In the man page it says: "Indicate  that the
actions should *only* be taken on filesystems of the specified type."

But, for example, here Suse is of type ext4 and gets mounted:

# ./mount -t ext4 /suse
# ./mount | grep suse
/dev/sda2 on /suse type ext4 (rw,noatime,noexec,nosuid,nodev,user)

Now I want to unmount all btrfs systems:

# ./umount -t btrfs /suse /zero /other
# ./mount | grep suse

It just unmounts everything that is mentioned, the -t has no
limiting effect.  So it is useful only with -a.

Benno

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow

