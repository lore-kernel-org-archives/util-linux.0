Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.nue.novell.com ([195.135.221.5]:55525 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbbDPJ7G (ORCPT
	<rfc822;groupwise-util-linux@vger.kernel.org:0:0>);
	Thu, 16 Apr 2015 05:59:06 -0400
Message-ID: <552F87E5.5010507@suse.com>
Date: Thu, 16 Apr 2015 11:59:01 +0200
From: Thomas Bechtold <tbechtold@suse.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: sfdisk input parsing broken with 2.26.1
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[please CC me - I'm not subscribed to the list]

Hi,

the following worked fine with 2.20 (tested on Ubuntu):

sfdisk $IMAGE_BLOCK_DEVICE << EOF
1 - - *
0 0;
0 0;
0 0;
EOF


Same code doesn't work with 2.26.1 (tested on openSUSE Tumbleweed).
First line can't be parsed:

line 1: unsupported command


I recognized that while testing OpenStack's diskimage-builder[1]. Seems
there is also a bugreport from an Arch user[2].

Tom


[1] https://bugs.launchpad.net/diskimage-builder/+bug/1444496
[2] https://bugs.archlinux.org/task/44349

