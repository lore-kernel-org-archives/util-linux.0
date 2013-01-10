Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3AJJr6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Jan 2013 04:47:58 -0500
Date: Thu, 10 Jan 2013 10:47:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Maksim Melnikau <maxposedon@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fstab zram swap integration idea
Message-ID: <20130110094755.GA19166@x2.net.home>
References: <CAGbmdnVWDifpsPvKUkdP+qX0m4GL7VYky5NyB-XYNGS19aXsvA@mail.gmail.com>
 <20130107124206.GF28963@x2.redhat.com>
 <CAGbmdnUTicf7VYrPW3_UmpX=BM80K25=uWjgc=u1=nyGPHzCtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGbmdnUTicf7VYrPW3_UmpX=BM80K25=uWjgc=u1=nyGPHzCtQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 07, 2013 at 05:52:28PM +0300, Maksim Melnikau wrote:
> On Mon, Jan 7, 2013 at 3:42 PM, Karel Zak <kzak@redhat.com> wrote:
> >  Is it designed for anything other than swaparea?
> Yes, zram is kind-of "compressed" block device in memory, any block
> device operations could be done on top of it. Some people initialize
> ext4 partitions "in memory" for temporary operations.
> So, I still think fstab is correct place for describing fs/swap even
> for zram. Questions are: 1) what is correct place for mkfs/mkswap zram
> devices, at startup? 2) What is correct place for setting size for
> zram block device? (right now I use systemd's tmpfiles.d)

I see two independent operations

  1/ initialize zram device
  2/ create on-device filesystem/swap

in our previous emails we have talked about 2/ for swap (call mkswap).

I'm not sure if 1/ belongs to swapon/mount. It seems better to create
a special udev rule for this purpose (we use the same solution for
example for raw devices) or systemd unit.

Note that the ideal solution is to have a special daemon for block
devices management where you can configure complex scenarios and ask
for usable device/filesystem.... but something like this is not
implemented yet. These things are too complicated to hide it into
mount/swapon.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
