Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47741 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934618AbaGXUbO (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jul 2014 16:31:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway1.nyi.internal (Postfix) with ESMTP id 6AB8F219A5
	for <util-linux@vger.kernel.org>; Thu, 24 Jul 2014 16:31:12 -0400 (EDT)
Message-Id: <1406233871.13212.145356397.0035B2A9@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: when specifying multiple types, mount will mount
Date: Thu, 24 Jul 2014 22:31:11 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

Current mount (2.25) will always mount a device when more
than one type is given in a comma-separated list.  Older mount
(2.17.2 for example) would not not do that but error out.

For example, /dev/sda2 is of type ext4, but we are playing dumb,
to see what mount will say:

$ sudo ./mount /dev/sda2 /place -t btrfs
lt-mount: /dev/sda2: can't read superblock

$ sudo ./mount /dev/sda2 /place -t msdos
lt-mount: wrong fs type, bad option, bad superblock on /dev/sda2,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.

$ sudo ./mount /dev/sda2 /place -t btrfs,msdos

$ ./mount | grep sda2
/dev/sda2 on /place type ext4 (rw)

I find this surprising.  If -t does not support a comma-separated
list, it should report an error.  If it does, it should, IMO, only
try the specified types and not any others.

Benno

-- 
http://www.fastmail.fm - Accessible with your email software
                          or over the web

