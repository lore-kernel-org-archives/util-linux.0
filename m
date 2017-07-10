Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbdGJLId (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Jul 2017 07:08:33 -0400
Date: Mon, 10 Jul 2017 13:08:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: ID_FS_VERSION
Message-ID: <20170710110828.r6dr6buolw4xtgpm@ws.net.home>
References: <201707051349.26662@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201707051349.26662@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 05, 2017 at 01:49:26PM +0200, Pali Rohár wrote:
> Hi! What is the meaning of the ID_FS_VERSION attribute? I'm trying to 
> find documentation about libblkid attributes, but seems there is none.

libblkid/src/superblocks/superblocks.c

   * @VERSION: filesystem version

:-)

Well, the field is to provide more details about the filesystem, for
example we have VERSION="FAT16" TYPE="vfat", and so on. Note that TYPE
is usually name used by kernel (to be usable for "mount -t <type>").

I guess the VERSION is used by some userspace stuff (udisks?) to get
more information (or provide more details to end-users). It's probably
nothing critical.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
