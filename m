Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45508 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806AbaGaTrS (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Jul 2014 15:47:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway1.nyi.internal (Postfix) with ESMTP id E796E227E5
	for <util-linux@vger.kernel.org>; Thu, 31 Jul 2014 15:47:17 -0400 (EDT)
Message-Id: <1406836037.1169899.147822646.1A465393@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140730072639.GY8533@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
 <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
 <53CD86FC.7000808@bernhard-voelker.de>
 <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
 <20140721234936.GH17373@x2.net.home>
 <1406487424.22794.146193409.16E8F3E3@webmail.messagingengine.com>
 <20140729102122.GU8533@x2.net.home>
 <1406662890.522051.146931049.1CA56A43@webmail.messagingengine.com>
 <20140730072639.GY8533@x2.net.home>
Subject: Re: helper= and uhelper=
Date: Thu, 31 Jul 2014 21:47:17 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Wed, Jul 30, 2014, at 09:26, Karel Zak wrote:
>  If you want to umount any filesystem and you have no root permissions
>  then the filesystem has to be in fstab (and in mtab with 'user'
>  option).

To be more precise, when wanting to unmount while not having
superuser permissions, and there is no uhelper=somethingvalid
marker in the mtab file, then the filesystem has to be in /etc/fstab
with the option 'users' (and no marker needs to be present in mtab,
and even if it is, it will be ignored), or the /etc/fstab file contains
the option 'user' and the /etc/mtab file contains 'user=yourname'.
Right?

Benno

-- 
http://www.fastmail.fm - A fast, anti-spam email service.

