Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbcBLKHm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 05:07:42 -0500
Date: Fri, 12 Feb 2016 11:07:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
Message-ID: <20160212100740.7lsjokq727klamz2@ws.net.home>
References: <56B0EEB2.1060707@suse.cz>
 <56B10E38.7040407@suse.cz>
 <20160211094352.6ncnnirhyd4jjd34@ws.net.home>
 <56BC9101.60908@suse.cz>
 <56BCB813.5090300@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BCB813.5090300@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 11, 2016 at 05:34:27PM +0100, Stanislav Brabec wrote:
> Stanislav Brabec wrote:
> >I am working on a subtest that will trigger it inside the test suite.
> >
> >I already have a possible fix for it, but I want to confirm that it is
> >correct before sending it upstream.
> >
> I just have a reproducer of the new problem.
> 
> The newly found problem is not btrfs speficic:
> 
> echo "/ext4.img /ext4_mnt1 auto loop 0 0" >>/etc/fstab
> mount -a
> echo "/ext4.img /ext4_mnt2 auto loop 0 0" >>/etc/fstab
> mount -a
> mount
> umount /ext4_mnt1 /ext4_mnt2
> sed -i /ext4.img/d /etc/fstab
> 
> Result:
> Nothing was mounted into /ext4_mnt2
> 
> (This is the problem with loop files in fstab, which I mentioned in my past
> mails, but was not able to reproduce.)

Fixed. There was "break" rather than "continue" in the mnt_table_is_fs_mounted().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
