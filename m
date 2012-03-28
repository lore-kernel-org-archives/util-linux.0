Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45952 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860Ab2C1HeN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 Mar 2012 03:34:13 -0400
Date: Wed, 28 Mar 2012 09:34:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Michael Conrad <mconrad@intellitree.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid -o value
Message-ID: <20120328073409.GA2045@x2.net.home>
References: <4F71F836.4000103@intellitree.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F71F836.4000103@intellitree.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 27, 2012 at 01:26:14PM -0400, Michael Conrad wrote:
> which caused my script to mount a ext3 partition as ext2, killing the
> journal.

 BTW, why do you need to call blkid before mount? The command mount(8)
 is able to detect FS type by libblkid.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
