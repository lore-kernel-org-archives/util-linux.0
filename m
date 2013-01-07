Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34258 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3AGOw3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jan 2013 09:52:29 -0500
Received: by mail-ob0-f169.google.com with SMTP id v19so17653010obq.0
        for <util-linux@vger.kernel.org>; Mon, 07 Jan 2013 06:52:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130107124206.GF28963@x2.redhat.com>
References: <CAGbmdnVWDifpsPvKUkdP+qX0m4GL7VYky5NyB-XYNGS19aXsvA@mail.gmail.com>
	<20130107124206.GF28963@x2.redhat.com>
Date: Mon, 7 Jan 2013 17:52:28 +0300
Message-ID: <CAGbmdnUTicf7VYrPW3_UmpX=BM80K25=uWjgc=u1=nyGPHzCtQ@mail.gmail.com>
Subject: Re: fstab zram swap integration idea
From: Maksim Melnikau <maxposedon@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 7, 2013 at 3:42 PM, Karel Zak <kzak@redhat.com> wrote:
>  Is it designed for anything other than swaparea?
Yes, zram is kind-of "compressed" block device in memory, any block
device operations could be done on top of it. Some people initialize
ext4 partitions "in memory" for temporary operations.
So, I still think fstab is correct place for describing fs/swap even
for zram. Questions are: 1) what is correct place for mkfs/mkswap zram
devices, at startup? 2) What is correct place for setting size for
zram block device? (right now I use systemd's tmpfiles.d)
