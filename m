Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbcBLJic (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 04:38:32 -0500
Date: Fri, 12 Feb 2016 10:38:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] tests: add btrfs mount tests
Message-ID: <20160212093830.jd5vzetkqwsrsp3m@ws.net.home>
References: <56B0EEB2.1060707@suse.cz>
 <56B10E38.7040407@suse.cz>
 <20160211094352.6ncnnirhyd4jjd34@ws.net.home>
 <56BC9101.60908@suse.cz>
 <56BCB813.5090300@suse.cz>
 <56BCCDDA.6040300@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BCCDDA.6040300@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 11, 2016 at 07:07:22PM +0100, Stanislav Brabec wrote:
>  tests/expected/mount/fstab-btrfs       |   1 +
>  tests/expected/mount/fstab-btrfs-auto  |   1 +
>  tests/expected/mount/fstab-btrfs-btrfs |   1 +
>  tests/ts/mount/fstab-btrfs             | 128 +++++++++++++++++++++++++++++++++
>  4 files changed, 131 insertions(+)
>  create mode 100644 tests/expected/mount/fstab-btrfs
>  create mode 100644 tests/expected/mount/fstab-btrfs-auto
>  create mode 100644 tests/expected/mount/fstab-btrfs-btrfs
>  create mode 100755 tests/ts/mount/fstab-btrfs

 Applied, thanks!
 
 (Seems you're familiar with our test suite now, let's hope we will
 see more tests from you;-)
    
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
