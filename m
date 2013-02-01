Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577Ab3BAPLn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Feb 2013 10:11:43 -0500
Date: Fri, 1 Feb 2013 16:11:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Andreas Hofmeister <andi@collax.com>
Cc: util-linux@vger.kernel.org
Subject: Re: output from "blkid" unstable (util-linux 2.22.2)
Message-ID: <20130201151131.GA14089@x2.net.home>
References: <5106F0FB.8020907@collax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5106F0FB.8020907@collax.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 28, 2013 at 10:43:23PM +0100, Andreas Hofmeister wrote:
> ---8<---
> root@ai:~# blkid /dev/sdc
> root@ai:~# blkid /dev/sdc
> /dev/sdc: UUID=",,," TYPE="LVM2_member"
> root@ai:~# blkid /dev/sdc
> /dev/sdc: UUID="..." TYPE="LVM2_member"
> root@ai:~# blkid /dev/sdc
> root@ai:~# blkid /dev/sdc
> /dev/sdc: UUID="..." TYPE="LVM2_member"
> ,,,
> --->8---
> 

 Probably fixed in our git three.

 Andreas, please try:

  git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
  cd util-linux
  ./autogen.sh
  ./configure
  make blkid

  # ./blkid /dev/sdc

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
